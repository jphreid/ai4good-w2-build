# Workshop 2 — everything Rohan (and his Claude) need

**Read this first.** This is the single grounding doc for co-leading **AI4Good Lab 2026 · Workshop 2 — "Building ML Apps" (Wed June 10, 90 min)**. It tells you the goal, how W2 builds on W1, exactly what JP presents (so your half lands as the *next move*, not a separate talk), both demos end-to-end, and where every file lives in this repo. If you're driving with Claude Code, point it here.

---

## 0 · TL;DR

- **The audience:** ~100 women & gender-diverse university trainees, **4 weeks into supervised ML**. Curious, not expert. Treat ML basics (CNNs, generative AI, RAG) as **known**; treat PM, evals, MLOps, agentic systems, and *design-for-AI* as **new**. Default stack is Colab + PyTorch + Hugging Face — **don't assume terminal / Git / pytest fluency.** Say **"trainees,"** never "students."
- **The running example:** **SymptomScout** — helps a person *prepare for a doctor's visit*. It does **NOT** diagnose. (Teams later adapt the pattern to their own AI4Good projects; SymptomScout is just the worked example.)
- **The one-sentence spine of both days:** **requirement → eval → green (JP) → surfaced (you).**
- **Your half is the second half of one story**, not a separate design talk. JP makes a requirement *true* (a test goes green); you make it *usable* (a scared person can actually act on it).
- **Format:** co-led — JP ~30 min, you ~30 min, **~25 min Q&A** woven in and protected at the end. You join **remotely from Toronto**.

---

## 1 · The goal of this presentation

W1 ("Product Management for AI", June 1) taught trainees to **specify a requirement by saying what good and bad look like — a rubric — and then turn that into an eval.** The thesis it landed: *"if you can't define good and bad, you haven't specified it."*

**W2 is the literal second half of that sentence.** We take the evals written on June 1 and:

1. **(JP)** drive an app from **red → green** against them — building the harness *by hand*, one failing requirement at a time.
2. **(You)** show that **green in a test ≠ usable by a person** — and that *surfacing* a requirement so a frightened human can trust it (or correct it) is a **design** decision, with its own rubric.

The payoff the whole 90 minutes serves: **a requirement isn't done when a test passes — it's done when a person can use it.** Design is not decoration here; it's the part of the requirement an eval can't see. Your `/design-critic` close proves design is *checkable too*, mirroring JP's eval loop.

**What this is NOT:** it's not "look, Claude can build an app." It's **the harness run by hand** — pick a red eval → generate a fix → a separate evaluator validates → green advances; then the same discipline pointed at the *interface*.

---

## 2 · How W2 builds on W1 — and what you must NOT re-teach

W1's full deck + speaker notes are in **`w1/`** (`workshop1-slides.html`, `storyboard.md`, `speaker-say.md`) so you can see exactly what the room already heard. The relevant part for you is W1 slides 12–21, which already taught:

- **Confidence as framing** (how the UI signals certainty)
- **Graceful degradation** — the three bail-outs
- **Augment vs automate**
- The **SEES / DOES** wrong-answer review
- **"AI failures look like successes"**

W1 also **previewed `/design-critic`** and told trainees they would *run it* in W2.

> **⛔ Do not re-teach these.** Name them as known ("you saw this June 1") and move past them. Your section is the **layer beyond** W1 — the failures that live in the *interface*, not the model. If you re-explain confidence display or graceful degradation, you lose the room and your time.

**Your new ground** (seeded by research, not in W1): over-reliance / automation bias, *satisfaction ≠ decision quality*, onboarding & mental-models, honest feedback loops, humane refusal. Evidence anchor you can use: wrong AI advice makes a wrong human decision **~26% more likely** — so good interface design is harm reduction, not taste.

---

## 3 · What JP presents (W2, 0:00–0:30) — detailed, so your half connects

JP drives Acts 0–2; the deck is **blue** for his half and flips **violet** at the baton (slide 15) — the colour *is* the handoff. Full deck: `w2/workshop2-slides.html`. Beat-by-beat spoken script: `w2/speaker-say.md`. Per-slide build/layout notes: `w2/storyboard.md`.

### Act 0 — Open (0:00–0:03, slides 1–3)
- **Slide 1 Title** — co-led from frame one (two facilitator cards: JP + you).
- **Slide 2 "Where we left off"** — the W1→W2 hinge: *requirement → rubric → eval (June 1)* → *eval → green → surfaced (today)*. "The eval set is the contract carried across both days."
- **Slide 3 "Green isn't done"** — the thesis of the co-lead, on screen. JP makes it work; you make it usable. Agenda + protected Q&A.

### Act 1 — Harness theory (0:03–0:18, slides 4–13) — *the 5 ideas, covered properly*
JP teaches the **kitchen metaphor**: the model is the **chef** (rented, brilliant, forgets between shifts); everything else is the **kitchen** you build. The five ideas:
1. **Chef vs kitchen** (slide 5) — model vs harness; the 8 kitchen parts (pantry=tools, prep counter=context, recipe cards=durable state, expediter=agent loop, **tasting station=evals**, health inspector=guardrails, **plating=the UI — your half**).
2. **Durable state + the ratchet** (slides 7–8) — the kitchen keeps *books* on disk (context **resets**, not compaction); a green eval **stays** green.
3. **Generator / evaluator split** (slide 9) — *the chef doesn't taste their own plate.* Sonnet generates; **Opus judges**, voting 3–5×. This is **Anthropic's** lever (*Harness Design for Long-Running Apps*). The columns are **blue (generator) / violet (evaluator)** — previewing the two halves of the day: builder = JP, judge-of-design = you.
4. **Workflow vs agent** (slide 11) — fixed steps vs the model choosing its own. Crawl/walk = workflow; run = agent.
5. **Evals are the contract** (slide 12) — the tasting station needs a *standard*, agreed before service = `evals/evals.py` from June 1. **No new requirements are invented on Day 2.**
- **Slide 10 = Clip A9** plays mid-act (see §5). **Slide 13** ties it together: "the harness is the loop around the model — you build the kitchen."

### Act 2 — Live crawl→walk: red eval → green (0:18–0:30, slides 14–15)
- **Slide 14 (LIVE):** JP runs the eval suite on the **scaffold** repo (JP's side): `pytest` → **4 green, 1 red** (the model doesn't cite sources). He reads the failure, adds **one line** to the system prompt, re-runs → **5 green**, and it *stays* green (the ratchet).
- **Slide 15 — THE BATON (the hinge, hands to you):** JP shows a real "walk" answer where the citation is **buried mid-paragraph**, then:
  > *"It cites sources now — the test is green. But the citation is buried in a wall of text; a scared person in a waiting room will never find it. Passing the test made it true; it didn't make it usable. That's a **design** problem now. Rohan —"*

  The slide's accent flips blue→violet as he says your name. **This is your cue.** The requirement JP just turned green is the *same* requirement you now surface — you are the next move on one problem, not a new topic.

---

## 4 · Your half (0:30–1:00) — design for uncertainty

This deck carries only **two framing slides** for your 30 minutes (16 = section divider, 17 = `/design-critic`); **your own failure/demo slides run live between them.** Full spoken beats: `w2/speaker-say.md` (slides 16–18); live mechanics: `w2/demo-runsheet.md` ("Rohan's beats").

- **Slide 16 — "We made it work. Now make it *work better*."** Reframe from *works* (passes the evals) to *works better* (a scared person can use it). Name W1 foundations as known, then go past them. *(Steve Jobs "design is how it works" is in your spoken notes — verbal only, not on the slide.)*
- **Your live build (walk → run):** evolve the **walk** UI (buried citation) into the **run** UI. The one moment to **type live** is the **~8-line sources panel** — the baton made visible: the buried citation becomes a checkable list. Two more affordances (already in `run/ui.py`, show as diff): a **"How to read this"** expander (onboarding / mental-model = W1 confidence display made real) and a **"Download prep sheet"** button (take-it-to-a-human / manual fallback). Each maps to a research finding — sources panel ↔ over-reliance; "how to read this" ↔ onboarding; download ↔ honest hand-off. Exact code + reset commands are in `w2/demo-runsheet.md`.
- **Slide 17 — `/design-critic`:** the close. Design has a **rubric too** — 5 checks (confidence display · graceful degradation · plain language · accessibility · humane refusal), citing **Google PAIR + Microsoft HAX**. The first two are W1 (name-check); spend your airtime on the new three. Run it on the bare UI and watch it **fail** the checks the run UI passes. *This is the W1 promise, now kept.* Symmetry with JP's eval loop: **design is checkable, just like evals.**
- **Slide 18 — Clip A10** (optional close, see §5).

**The framing to hold:** present everything as *application*, not new theory. "How to read this" is W1's confidence display made real; crawl/walk/run was introduced in W1 — you're making the ideas **runnable**.

---

## 5 · The two demos, end-to-end

Both clips are the **same autonomous loop** — the harness running *itself* — recorded from a real, runnable engine in **`../run-plus/`** (one level up from `workshop/`, inside this repo). One script, **`run-plus/ralph.sh`**, runs both phases: **Phase A = Clip A9** (text evals), **Phase B = Clip A10** (UI evals via a real browser). `run-plus/README.md` is the full operator's guide.

### Clip A9 — the autonomous text loop *(plays in JP's Act 1, slide 10)*
- **Status: RECORDED.** The MP4 is `recordings/Clip A9.mov` (~89s, H.264) and is already wired into slide 10 of the bundled deck — it plays inline (click ▶; JP narrates over it).
- **What it shows:** Claude Code, hands-free, runs `pytest` → reads the judge's reason on a red eval → edits the **system prompt** in `agent.py` → re-runs → **green**, and stops. The manual version of exactly what JP just did by hand.
- **To re-record / regenerate:** `cd run-plus && ./reset.sh && ./ralph.sh` — Phase A is A9. Phase A restricts the agent to Read+Edit (bash owns pytest), so it's fast and can't wander. Speed up the pytest/judge waits in edit; keep the red→green flip full-speed.
- **Attribution to say out loud:** the "run-the-agent-in-a-loop-until-done" framing is the **"Ralph loop" — community / Geoffrey Huntley, NOT Anthropic.** (The generator/evaluator split *is* Anthropic — keep the two credits distinct.)

### Clip A10 — the Playwright UI-check *(your close, slide 18 — OPTIONAL)*
- **Status: NOT YET RECORDED — placeholder.** The slide is marked placeholder; **it's your call** whether to (a) play a recorded A10, (b) run `run-plus/ralph.sh` Phase B **live** (it's hands-free), or (c) skip it and let slide 17 (`/design-critic`) be the close. The safe default is a recorded clip.
- **What it shows:** an agent starts the run++ app on `:8504`, drives **Chromium via Playwright MCP**, sends the PCOS case, **sees there's no prominent safety banner**, edits `ui.py`, reloads, and re-verifies in the real browser until it prints `UI-GREEN`. Put both the terminal *and* the Chromium window on screen.
- **The point it makes:** "An eval checks the *text*. This checks what the *person actually sees*." Design properties, verified automatically — the same red→green discipline, pointed at the interface. Reinforces `/design-critic`.
- **To record:** `cd run-plus && ./reset.sh && ./ralph.sh` — Phase B is A10 (uses `--permission-mode bypassPermissions` so Playwright + edits run hands-free against the local sandboxed app).
- **Needs:** `ANTHROPIC_API_KEY` in `../.env`, the `claude` CLI signed in, and `npx` (Playwright MCP auto-downloads Chromium on first run).

---

## 6 · Running it yourself (this repo)

Everything you drive lives in this repo. (JP's eval-side "scaffold" is a *separate* repo he drives — you don't need it; the `/design-critic` skill it uses is bundled here in `.claude/skills/`.)

```bash
# from the repo root
cp .env.example .env          # paste your ANTHROPIC_API_KEY
uv sync

# the three tiers side by side (same input in each → feel the difference)
uv run streamlit run crawl/ui.py --server.port 8501   # 🐢
uv run streamlit run walk/ui.py  --server.port 8502   # 🚶  ← your "before" (buried citation)
uv run streamlit run run/ui.py   --server.port 8503   # 🏃  ← your "after" (sources panel)

# the autonomous loop that produced both clips
cd run-plus && ./reset.sh && ./ralph.sh

# the design rubric (your closing beat) — in Claude Code, from repo root:
#   /design-critic   then: Review run/ui.py   (or walk/ui.py for the "before")
```

- **Reset your live UI edit between rehearsals:** `git checkout run/ui.py` (or whichever file you typed into).
- `SETUP.md` has the platform-specific setup (Windows notes, key errors). `scenarios.md` has try-these prompts. `start.sh` launches the trio.

---

## 7 · Decisions still open with JP (raise in the prep call)

1. **Clip A10 vs live Playwright** — recorded clip, run Phase B live, or skip and close on `/design-critic`?
2. **Remote delivery** — you share *your* screen (you run the apps locally) or JP screen-shares and you narrate? Have walk (8502) + run (8503) already running before your segment so the handoff is instant.
3. **Which research topics** you want on stage in your failure-modes talk (some leads need fact-checking before they're spoken publicly).
4. **How much of your slides** you author vs. have JP draft for you to edit.

---

## 8 · Where everything is (this `workshop/` folder)

| Path | What |
|---|---|
| `ROHAN-BRIEF.md` | **this file** — start here |
| `README.md` | the folder index / orientation |
| `w2/workshop2-slides.html` | the W2 deck (open in a browser; A9 clip plays inline on slide 10) |
| `w2/storyboard.md` | per-slide layout + build cues |
| `w2/speaker-say.md` | the spoken script, beat by beat |
| `w2/demo-runsheet.md` | the live mechanics — your code blocks, resets, fallbacks, clip shot-lists |
| `w1/workshop1-slides.html` + `storyboard.md` + `speaker-say.md` | **what June 1 covered** — so you don't repeat it |
| `bento-design-system.md` | the deck's design system (only needed to edit slides) |
| `recordings/Clip A9.mov` | the A9 clip (A10 still to record) |
| `../run-plus/` | the runnable engine behind both clips (one level up) |
| `../crawl` `../walk` `../run` | the three live apps |
| `../.claude/skills/design-critic/` | the `/design-critic` skill (so it runs from this repo) |
