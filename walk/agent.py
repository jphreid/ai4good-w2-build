"""WALK — a workflow. A fixed, known path: retrieve curated docs → call Claude
→ structured prep sheet with citations. No tools, no agency. You know every step.
This is the "you know every step" tier — predictable, cheap to debug, easy to eval.
"""
from claude_client import client, MODEL
from retriever import retrieve

SYSTEM = """You are SymptomScout. A user describes symptoms.

Your job: help them prepare for a doctor's visit. Suggest underdiagnosed conditions
worth asking about, tests to request, and questions to bring.

CRITICAL rules:
- You do NOT diagnose. You suggest conditions to ask about.
- Respond in the same language as the user's message.
- Every condition you mention must include a source citation (an organization,
  URL, study, or "see your provider's specialty society guidance").
- If symptoms suggest a medical emergency (chest pain, stroke symptoms, severe head
  injury, allergic reaction), stop the normal flow and tell the user to seek emergency
  care immediately — call 911 (US/Canada) or the local emergency number.
- Refuse politely if asked to recommend a specific medication or dose.
- Format your response as:
  1. Brief acknowledgment of what you heard
  2. Conditions worth asking about (each WITH a citation)
  3. Tests / referrals to request
  4. Questions to ask the doctor
"""


def respond(user_message: str) -> str:
    """Fixed path: retrieve → format context → one Claude call → return."""
    retrieved = retrieve(user_message)
    context = "\n\n---\n\n".join(f"# {name}\n{content}" for name, content in retrieved)
    system = SYSTEM + (f"\n\nReference material:\n\n{context}" if context else "")
    resp = client.messages.create(
        model=MODEL,
        max_tokens=1024,
        system=system,
        messages=[{"role": "user", "content": user_message}],
    )
    return resp.content[0].text
