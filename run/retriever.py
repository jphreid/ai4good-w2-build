"""Keyword-based retrieval over knowledge/*.md.

Deliberately dumb. No embeddings, no vector store. The point of the
workshop is to teach the harness, not to teach retrieval. If you want
to upgrade later, swap this with sentence-transformers + FAISS.
"""
from pathlib import Path

KNOWLEDGE_DIR = Path(__file__).parent.parent / "knowledge"


def load_all_docs() -> dict[str, str]:
    """Return a dict mapping filename → file contents."""
    return {p.name: p.read_text() for p in KNOWLEDGE_DIR.glob("*.md")}


def retrieve(query: str, top_k: int = 3) -> list[tuple[str, str]]:
    """Return [(filename, content)] for the top_k docs most matching the query.

    Scoring: count of query-word occurrences in the doc (case-insensitive).
    Cheap and works well enough for a small curated corpus.
    """
    docs = load_all_docs()
    query_words = [w.lower() for w in query.split() if len(w) > 2]

    scored = []
    for name, content in docs.items():
        lower = content.lower()
        score = sum(lower.count(w) for w in query_words)
        scored.append((score, name, content))

    scored.sort(reverse=True)
    hits = [(name, content) for score, name, content in scored[:top_k] if score > 0]

    # Fallback: if nothing matched (common when you swap in your own domain's
    # docs but your query words don't overlap their wording), return the top_k
    # docs anyway so the model always has *some* context to work from — and so
    # "the model is dumb" is never secretly "retrieval returned nothing."
    if not hits:
        return [(name, content) for _, name, content in scored[:top_k]]
    return hits
