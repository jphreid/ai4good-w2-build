# `workshop/` — co-leading AI4Good Lab W2

Everything needed to co-lead **Workshop 2 — "Building ML Apps" (June 10)**, bundled with the runnable apps in this repo.

## Start here

➡️ **[`ROHAN-BRIEF.md`](ROHAN-BRIEF.md)** — the single grounding doc: the goal, how W2 builds on W1, exactly what JP presents, both demos end-to-end, and how to run everything. **If you're driving with Claude Code, point it at that file first.**

## What's in here

- **`w2/`** — the Workshop 2 presentation
  - `workshop2-slides.html` — the deck (open in a browser; the A9 clip plays inline on slide 10)
  - `storyboard.md` — per-slide layout + build cues *(this deck's "side notes")*
  - `speaker-say.md` — the spoken script, beat by beat
  - `demo-runsheet.md` — live mechanics: code blocks, resets, fallbacks, clip shot-lists
- **`w1/`** — the Workshop 1 presentation (June 1), so you can see **what not to repeat**
  - `workshop1-slides.html`, `storyboard.md`, `speaker-say.md`
- **`recordings/`** — `Clip A9.mov` (the autonomous-loop clip). *A10 is not yet recorded — see the brief.*
- **`bento-design-system.md`** — the deck's design system (only needed if you edit slides)

## The runnable parts live one level up, in the repo root

- `../crawl` `../walk` `../run` — the three live SymptomScout tiers
- `../run-plus` — the autonomous loop engine behind both clips (`./reset.sh && ./ralph.sh`)
- `../.claude/skills/design-critic` — the `/design-critic` skill for your closing beat
- `../SETUP.md` · `../scenarios.md` · `../start.sh` — setup, try-these prompts, launcher
