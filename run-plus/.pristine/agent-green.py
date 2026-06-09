"""RUN++ — the agent, with extra features (and intentional gaps the loop will close).

Same agent loop as `run/` (clarifying question + PubMed tool), but this is the
target for the AUTONOMOUS harness loop (`./ralph.sh`). The SYSTEM prompt below is
the PRISTINE/BUGGY baseline: it is MISSING two rules on purpose, so two text evals
start RED:

  * test_conditions_have_citations  — no "cite a source" rule
  * test_conditions_are_severity_tagged — no "tag each condition 🟢/🟡/🔴" rule

The Ralph loop reads those failures and adds the two missing rules to SYSTEM, one
at a time, until pytest is green. (A third, UI-level eval is closed in Phase B by
editing ui.py, verified live with Playwright MCP.)

Reset to this baseline any time with:  ./reset.sh
"""
from claude_client import client, MODEL
from retriever import retrieve
from pubmed_tool import search_pubmed, PUBMED_TOOL

SYSTEM = """You are SymptomScout, an agent that helps a user prepare for a doctor's visit.

You decide how to proceed:
- If the symptoms are too vague to act on, ask ONE focused clarifying question first
  (when did it start? constant or intermittent? what worries you most?). Otherwise proceed.
- You MAY call search_pubmed when a current, citable study would strengthen a suggestion.
  Don't call it more than twice.

CRITICAL rules:
- You do NOT diagnose. You suggest conditions to ask about.
- For EACH condition you suggest, cite a source the user could look up — a named
  organization, clinical guideline, study, or URL (e.g. from the reference material).
- Tag EACH condition you suggest with a severity marker so the reader can tell how
  concerning it is: 🟢 routine, 🟡 worth checking soon, or 🔴 urgent.
- Respond in the same language as the user.
- Medical emergency (chest pain, stroke signs, severe injury, allergic reaction) →
  stop and tell them to seek emergency care now (call 911).
- Refuse to recommend a specific medication or dose.
- When you give the final prep sheet, format it as:
  1. Brief acknowledgment
  2. Conditions worth asking about
  3. Tests / referrals to request
  4. Questions to ask the doctor
"""


def respond(messages: list[dict], max_turns: int = 5) -> dict:
    """messages: running conversation [{role, content:str}].

    Returns {text, retrieved, pubmed_used, pubmed_results}.
    """
    last_user = next((m["content"] for m in reversed(messages) if m["role"] == "user"), "")
    retrieved = retrieve(last_user)
    context = "\n\n---\n\n".join(f"# {name}\n{content}" for name, content in retrieved)
    system = SYSTEM + (f"\n\nReference material:\n\n{context}" if context else "")

    work = [{"role": m["role"], "content": m["content"]} for m in messages]
    pubmed_results: list[dict] = []

    for _ in range(max_turns):
        resp = client.messages.create(
            model=MODEL,
            max_tokens=1024,
            system=system,
            tools=[PUBMED_TOOL],
            messages=work,
        )
        if resp.stop_reason == "tool_use":
            work.append({"role": "assistant", "content": resp.content})
            results = []
            for block in resp.content:
                if block.type == "tool_use":
                    hits = search_pubmed(**block.input)
                    pubmed_results.extend(hits)
                    results.append({
                        "type": "tool_result",
                        "tool_use_id": block.id,
                        "content": str(hits),
                    })
            work.append({"role": "user", "content": results})
            continue
        text = "".join(b.text for b in resp.content if b.type == "text")
        return {
            "text": text,
            "retrieved": [name for name, _ in retrieved],
            "pubmed_used": bool(pubmed_results),
            "pubmed_results": pubmed_results,
        }

    return {
        "text": "".join(b.text for b in resp.content if getattr(b, "type", None) == "text"),
        "retrieved": [name for name, _ in retrieved],
        "pubmed_used": bool(pubmed_results),
        "pubmed_results": pubmed_results,
    }


def reply_text(query: str) -> str:
    """Convenience for the evals: one user turn in, the agent's text out."""
    return respond([{"role": "user", "content": query}])["text"]
