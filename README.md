# SymptomScout — three tiers: Crawl / Walk / Run

The same product at three levels of autonomy, so you can **run them side by side and feel the difference**. This is the crawl/walk/run progression from the Day-1 deck, made real — and JP's authoring playground for building the workshop content.

| Tier | What the AI does | Design | What's different |
|---|---|---|---|
| 🐢 **Crawl** | assists; you decide | prompt only | Plain chat. No retrieval, no report, no citations. *You* write the prep sheet. |
| 🚶 **Walk** | decides within rails | **workflow** | Fixed path: retrieve curated docs → structured prep sheet → citations. Predictable. |
| 🏃 **Run** | decides its own next step | **agent** | Asks a clarifying question when needed; calls PubMed when useful; polished UI (sources panel, printable sheet). |

## Setup (once)

```bash
cd "Building ML Apps/symptomscout-versions"
cp .env.example .env          # paste your ANTHROPIC_API_KEY
uv sync
```

## Run them side by side

Open three terminals (or run in the background) — each on its own port, so you can flip between browser tabs:

```bash
uv run streamlit run crawl/ui.py --server.port 8501   # 🐢 http://localhost:8501
uv run streamlit run walk/ui.py  --server.port 8502   # 🚶 http://localhost:8502
uv run streamlit run run/ui.py   --server.port 8503   # 🏃 http://localhost:8503
```

Try the **same input** in all three — e.g. *"I'm 28, irregular periods for 3 years, weight gain, adult acne"* — and watch how the output grows from "let's talk it through" → "here's a cited prep sheet" → "let me ask one thing, then here's a cited, evidence-backed sheet with sources."

Or use the CLI:

```bash
uv run python crawl/main.py
uv run python walk/main.py "I've been tired for months, I'm 32"
uv run python run/main.py  "I've been tired for months, I'm 32"
```

## Layout

- `knowledge/` — shared curated condition docs (12), used by Walk and Run (Crawl ignores them)
- `crawl/`, `walk/`, `run/` — each self-contained (`agent.py` + `ui.py` + `main.py`); edit one without touching the others
- Models: `claude-sonnet-4-6` throughout (set in each `claude_client.py`)

**Not the teaching scaffold.** Teams fork the separate `../scaffold/` repo. This trio is the reference/playground; `run` is the "all bells & whistles" final app.
