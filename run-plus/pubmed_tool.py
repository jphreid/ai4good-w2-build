"""PubMed search exposed as an Anthropic SDK tool for the Run agent.

Same NCBI E-utilities call as the scaffold's MCP server, but wired directly into
the SDK tool-use loop (no separate MCP process) so the agent can call it inline.
"""
import httpx

PUBMED_BASE = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils"


def search_pubmed(query: str, max_results: int = 3) -> list[dict]:
    """Search PubMed; return [{pmid, title, source, url}]. Degrades gracefully."""
    try:
        s = httpx.get(
            f"{PUBMED_BASE}/esearch.fcgi",
            params={"db": "pubmed", "term": query, "retmax": max_results, "retmode": "json"},
            timeout=10,
        )
        s.raise_for_status()
        pmids = s.json().get("esearchresult", {}).get("idlist", [])
        if not pmids:
            return []
        d = httpx.get(
            f"{PUBMED_BASE}/esummary.fcgi",
            params={"db": "pubmed", "id": ",".join(pmids), "retmode": "json"},
            timeout=10,
        )
        d.raise_for_status()
        res = d.json().get("result", {})
        return [
            {
                "pmid": p,
                "title": res.get(p, {}).get("title", ""),
                "source": res.get(p, {}).get("source", ""),
                "url": f"https://pubmed.ncbi.nlm.nih.gov/{p}/",
            }
            for p in pmids
        ]
    except Exception as e:  # network/throttle — the agent should carry on without it
        return [{"error": f"PubMed lookup failed: {e}"}]


# The tool definition the model sees.
PUBMED_TOOL = {
    "name": "search_pubmed",
    "description": (
        "Search PubMed for recent biomedical literature. Call this when a current, "
        "citable study would strengthen a suggestion. Returns a few titles with URLs."
    ),
    "input_schema": {
        "type": "object",
        "properties": {
            "query": {"type": "string", "description": "A focused search query."},
            "max_results": {"type": "integer", "description": "How many results (default 3)."},
        },
        "required": ["query"],
    },
}
