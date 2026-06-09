# SymptomScout — the AI4Good Lab Workshop 2 build kit

The same product (**SymptomScout** — prepares someone for a doctor's visit; it does **not** diagnose) at four levels of autonomy, **plus** the full Workshop 2 presentation, speaker notes, and the autonomous-loop demo engine. Built to run the apps side by side and *feel the difference*, and to co-lead the workshop end to end.

> **Co-leading Workshop 2?** → start in **[`workshop/ROHAN-BRIEF.md`](workshop/ROHAN-BRIEF.md)**. It has the goal, how W2 builds on W1, what JP presents, and both demos end-to-end. The deck + side notes + spoken script + recordings all live under **[`workshop/`](workshop/)**.

## The tiers

| Tier | What the AI does | Design | What's different |
|---|---|---|---|
| 🐢 **Crawl** | assists; you decide | prompt only | Plain chat. No retrieval, no report, no citations. *You* write the prep sheet. |
| 🚶 **Walk** | decides within rails | **workflow** | Fixed path: retrieve curated docs → structured prep sheet → citations. Predictable. |
| 🏃 **Run** | decides its own next step | **agent** | Asks a clarifying question when needed; calls PubMed when useful; polished UI (sources panel, printable sheet). |
| 🤖 **Run++** | **fixes its own red evals** | **agentic harness** | The "run" app wired so an agent drives failing evals → green by itself — text (pytest) *and* UI (Playwright). This **is** the two W2 clips. See `run-plus/`. |

## Setup (once)

```bash
cp .env.example .env          # paste your ANTHROPIC_API_KEY
uv sync
```

## Run the tiers side by side

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

## Run the autonomous loop (the demo engine behind both clips)

```bash
cd run-plus && ./reset.sh && ./ralph.sh   # Phase A = Clip A9 (text) · Phase B = Clip A10 (UI/Playwright)
```

See `run-plus/README.md` for the full operator's guide.

## Layout

- `workshop/` — **the W2 co-lead bundle**: brief, W1 + W2 decks, speaker notes, recordings (start at `workshop/ROHAN-BRIEF.md`)
- `crawl/`, `walk/`, `run/` — each self-contained (`agent.py` + `ui.py` + `main.py`); edit one without touching the others
- `run-plus/` — the run app + planted reds + `ralph.sh`, the two-phase agent loop that drives them green
- `knowledge/` — shared curated condition docs (12), used by Walk and Run (Crawl ignores them)
- `.claude/skills/design-critic/` — the `/design-critic` skill (Rohan's closing beat; runs from this repo)
- Models: `claude-sonnet-4-6` throughout (set in each `claude_client.py`)

**Not the teaching scaffold.** Teams fork the separate `../scaffold/` repo. This is the reference/playground + the co-lead kit; `run` is the "all bells & whistles" final app.
