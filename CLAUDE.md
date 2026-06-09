# Repo guide — AI4Good Lab 2026, Workshop 2 build kit

This repo is **Rohan's co-lead kit for Workshop 2 — "Building ML Apps" (AI4Good Lab 2026, Mila, Wed June 10)**. It holds the SymptomScout apps (crawl/walk/run/run++), the workshop presentation, and the demo engine. If you're Claude helping Rohan prep or run his half, this is your context.

## Read this first

➡️ **`workshop/ROHAN-BRIEF.md`** is the single grounding doc — the goal, how W2 builds on W1, exactly what JP presents, both demos end-to-end, and how to run everything. Read it before doing anything substantive. The W1 + W2 decks, speaker notes, and the A9 recording all live under `workshop/`.

## The one thing to hold

The spine of both workshops is **requirement → eval → green (JP) → surfaced (Rohan)**. JP makes a requirement *true* (a test goes green); Rohan makes it *usable* (a scared person can act on it). Rohan's half is the **second half of one story, not a separate design talk.** The thesis: *green in a test ≠ usable by a person* — surfacing a requirement so a human can trust it (or correct it) is a design decision, with its own rubric.

## Guardrails — get these right

- **Audience:** ~100 women & gender-diverse university trainees, **4 weeks into supervised ML**. Curious, not expert. ML basics (CNNs, generative AI, RAG) are **known**; PM, evals, agentic systems, and design-for-AI are **new**. Default stack is Colab + PyTorch + Hugging Face — **don't assume terminal / Git / pytest fluency.** Say **"trainees,"** never "students."
- **SymptomScout helps someone prepare for a doctor's visit. It does NOT diagnose.** Never let copy or UI drift into diagnosis.
- **Don't re-teach Workshop 1.** W1 already taught confidence-as-framing, graceful degradation, augment-vs-automate, "AI failures look like successes." Name them as known; Rohan's section is the layer *beyond* them (over-reliance, satisfaction≠decision-quality, onboarding/mental-models, humane refusal). W1's deck is in `workshop/w1/` so you can see exactly what was covered.
- **Attribution discipline (if you edit slides):** the generator/evaluator split + "sprint contract" → **Anthropic**. The "Ralph loop" (run the agent in a loop until done) → **community / Geoffrey Huntley**, *not* Anthropic. Crawl/walk/run phasing + evals-as-contract → **JP's synthesis** — never credit it to Anthropic.
- **Verify before it's spoken publicly:** model IDs, package versions, citations, stats. Don't invent them.

## Slides

The W2 deck is **`workshop/w2/workshop2-slides.html`** — a self-contained Bento HTML deck (edit the HTML directly). Keep it in sync with its storyboard (`workshop/w2/storyboard.md`) and spoken script (`workshop/w2/speaker-say.md`). The design system is `workshop/bento-design-system.md` — follow it. The A9 clip plays inline on slide 10.

## Running things (from the repo root)

```bash
cp .env.example .env && uv sync                         # setup (paste ANTHROPIC_API_KEY)
uv run streamlit run walk/ui.py --server.port 8502      # 🚶 the "before" (buried citation)
uv run streamlit run run/ui.py  --server.port 8503      # 🏃 the "after" (sources panel)
cd run-plus && ./reset.sh && ./ralph.sh                 # the autonomous loop (Phase A=A9, Phase B=A10)
# /design-critic  → Review run/ui.py   (Rohan's closing beat; skill is in .claude/skills/)
```

Reset a live UI edit with `git checkout run/ui.py`. Models: `claude-sonnet-4-6` (set in each `claude_client.py`).

## Voice & tone

Concise, accessible, encouraging — the audience is *entering* AI, not expert. Practical over theoretical. Bilingual context (Montreal / Mila) — English primary, French welcome.
