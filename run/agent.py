"""RUN — an agent. The model decides its own next step: it may ask ONE clarifying
question before producing the prep sheet, and it may call search_pubmed when a
current study would help. Adaptive, more capable, less predictable. The "run" tier.

respond() returns a dict so the UI can show *what the agent did* (retrieved docs,
whether it searched PubMed) — that's the transparency the polished UX needs.
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
- Respond in the same language as the user.
- Every condition you mention must include a source citation.
- Medical emergency (chest pain, stroke signs, severe injury, allergic reaction) →
  stop and tell them to seek emergency care now (call 911).
- Refuse to recommend a specific medication or dose.
- When you give the final prep sheet, format it as:
  1. Brief acknowledgment
  2. Conditions worth asking about (each WITH a citation)
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

    # ran out of turns — return whatever text we have
    return {
        "text": "".join(b.text for b in resp.content if getattr(b, "type", None) == "text"),
        "retrieved": [name for name, _ in retrieved],
        "pubmed_used": bool(pubmed_results),
        "pubmed_results": pubmed_results,
    }
