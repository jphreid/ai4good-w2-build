# Workshop 2 — led-demo run-sheet (single source of truth)

> **Note for this bundle:** paths below like `Building ML Apps/symptomscout-versions/` and `Building ML Apps/scaffold/` are from JP's authoring monorepo. In **your** clone of this repo, the `symptomscout-versions/` part **is the repo root** — drop that prefix (e.g. `run-plus/`, `walk/ui.py`, `run/ui.py` are all at the root). The `scaffold/` is JP's separate eval-side repo; you don't need it (the `/design-critic` skill it uses is bundled here in `.claude/skills/`). Repo-relative commands are in **[`../ROHAN-BRIEF.md`](../ROHAN-BRIEF.md) §6**.

**What this is.** The beat-by-beat for the **led demo** in Workshop 2 ("Building ML Apps", June 10). Co-led: **JP** drives the generator/eval side (crawl→walk), **Rohan D'Souza** (senior UI designer, Microsoft; remote from Toronto) drives the design side (walk→run UI). 90 min = ~65 content + ~25 Q&A. This file is what you rehearse against and what you run on the day. Mirrors the W1 sheet (`../demo-sandbox/README.md`).

**Two repos are in play:**
- `Building ML Apps/scaffold/` — the eval side JP drives. The citation eval fails by design; JP fixes it live. Reset with `./reset-demo.sh`.
- `Building ML Apps/symptomscout-versions/` — the crawl/walk/run playground Rohan drives (the UI build). Reset live UI edits with `git checkout`.

---

## What the demo proves

The thread from W1 continues and then extends into design:

**requirement → eval → green (JP) → UI surface (Rohan).**

W1 landed "requirements become checkable through rubrics and evals." W2 shows the next link: a requirement that's *green in a test* is not yet *usable by a person* — surfacing it is a design decision. The citation requirement is the worked example: JP makes the model cite (green), Rohan makes the citation **visible and trustworthy** (sources panel).

The point is **not** "Claude can build an app." The point is **the harness run by hand**: pick a red eval → generate a fix → the evaluator (Opus, 3× majority) checks it → green advances. One feature at a time.

---

## Pre-flight (run before every rehearsal and on the day)

### Scaffold (JP's side)
```bash
cd "Building ML Apps/scaffold"
cp .env.example .env          # paste ANTHROPIC_API_KEY (skip if .env already present)
uv sync
./reset-demo.sh               # restores the citation bug, clears caches
uv run pytest evals/ -v       # CONFIRM: 4 passed, 1 failed (test_conditions_have_citations) — ~75s
```
Confirm the bug is present: open `app/agent.py`; the `SYSTEM` prompt has **no** citation rule.

### Versions (Rohan's side)
```bash
cd "Building ML Apps/symptomscout-versions"
cp .env.example .env          # paste ANTHROPIC_API_KEY (skip if present)
uv sync
# functional check without browsers (exercises retrieval + agent loop + PubMed):
uv run python crawl/main.py "I'm 28, irregular periods 3 years, weight gain, adult acne"
uv run python walk/main.py  "I'm 28, irregular periods 3 years, weight gain, adult acne"
uv run python run/main.py   "I'm 28, irregular periods 3 years, weight gain, adult acne"
```
Then launch the three apps (three terminals or background), so you can flip browser tabs:
```bash
uv run streamlit run crawl/ui.py --server.port 8501   # 🐢 http://localhost:8501
uv run streamlit run walk/ui.py  --server.port 8502   # 🚶 http://localhost:8502
uv run streamlit run run/ui.py   --server.port 8503   # 🏃 http://localhost:8503
```

### Remote-delivery (Rohan in Toronto)
- Rohan **shares his own screen** for his 30 min — he runs the `symptomscout-versions` apps locally on his machine (same pre-flight). Decide this in the 4-hr meeting; if his local env isn't set up, fallback is **JP screen-shares and Rohan narrates** over JP's running apps.
- Have the two ports (8502 walk, 8503 run) already running before his segment so the handoff is instant.
- Clips A9/A10 are **local MP4s** played from the presenting machine — not screen-share-dependent.

---

## Run-of-show

| Time | Owner | Beat |
|---|---|---|
| 0:00 | JP | Recap W1 + what today is + intro Rohan (3m) |
| 0:03 | JP | **Harness theory — 15m**, covered properly. Incl. **Clip A9** (~90s autonomous loop). |
| 0:18 | JP | Live crawl→walk: pytest → 4 green/1 red → fix citation eval → green → **baton** (12m) |
| 0:30 | Rohan | Design for uncertainty → live walk→run UI build → `/design-critic`. Incl. **Clip A10** (~90s Playwright UI-check). New material beyond W1. (30m) |
| 1:00 | both | Wrap + self-serve takeaway (5m) |
| — | — | ~25 min Q&A woven in + protected at the end |

---

## JP's beats (0:03–0:30)

### Beat — harness theory (0:03–0:18, 15m)
Five ideas, covered well (not skimmed): **engine vs harness · durable state + ratchet + context-reset · generator/evaluator split · workflow vs agent · evals-as-contract.** MCP/security → quick mention + appendix. Detail lives in the storyboard/speaker-say (Phase 3/4); this sheet only flags the **Clip A9** drop.

> **Clip A9 plays here** (~90s) right after the generator/evaluator + ratchet idea: *"You're about to watch me run this loop by hand. Here's the same loop running itself."* See the shot-list below.

### Beat — live crawl→walk: fix the citation eval (0:18–0:30, 12m)

Terminal in `Building ML Apps/scaffold/`.

**1. Run the contract.**
```bash
uv run pytest evals/ -v
```
Narrate the wait (~75s — this is real; consider running it during the last line of the theory beat so it's finishing as you arrive):
> "Some checks are fuzzy — 'does every condition cite a source?' isn't a substring match. So a second model judges it. That's the generator/evaluator split: Sonnet wrote the answer, Opus grades it, three times, majority vote."

Expected:
```text
4 passed, 1 failed
test_evals.py::test_conditions_have_citations FAILED
```
> "Four green, one red. It suggests the right conditions, escalates a real emergency, refuses to prescribe, answers fast. But it doesn't cite sources. I'd have shipped this — it *reads* fine. The eval caught it."

**2. Read the failure, then fix it.** Open `app/agent.py`. Add ONE line to the CRITICAL rules in `SYSTEM`:
```text
- Every condition you mention must include a source the user could look up —
  an organization, URL, study, or specialty-society guidance.
```
> "Read the failure first. The judge said: no source. So I add the requirement to the contract the *generator* reads — the system prompt. One line."

**3. Re-run, land it.**
```bash
uv run pytest evals/ -v
```
Expected: `5 passed`.
> "Green. And it stays green — that's the ratchet. We never let a green eval go red again. That's the whole build loop: pick a red, generate a fix, let the evaluator check, advance."

### The baton (A6) — hand to Rohan
> "So it cites sources now. The test is green. But look at the *answer* —" *(show a walk response: the citation is buried mid-paragraph)* "— a citation buried in a wall of text is invisible to a scared person in a waiting room. Green in a test isn't the same as usable by a human. That's not an engineering problem anymore. It's a **design** problem. Rohan —"

---

## Rohan's beats (0:30–1:00) — walk → run UI build

Rohan opens with **design for uncertainty** (new material, seeded by `research/ai-ux-fails-and-best-practices.md` — over-reliance, satisfaction≠decision-quality, error recovery, onboarding/mental-model, honest feedback loops). Then he makes the baton concrete by evolving the **walk** UI into the **run** UI.

### The walk→run guided diff (A4)

**Before/after is already running:** walk on **8502**, run on **8503**. Same PCOS prompt in both. Walk buries the citation in prose; run surfaces it. The live build adds three affordances to the walk UI. (The `run/agent.py` already returns the metadata dict the UI needs — `{text, retrieved, pubmed_used, pubmed_results}` — so these are UI-layer changes.)

**Minimum live moment (the one to type live):** the **sources panel**. It's the baton made visible.
```python
# after st.markdown(reply), inside the assistant chat_message block:
with st.expander("Sources used"):
    if result["retrieved"]:
        st.markdown("**Curated knowledge base:**")
        for name in result["retrieved"]:
            st.markdown(f"- `{name}`")
    if result["pubmed_used"]:
        st.markdown("**PubMed (live):**")
        for r in result["pubmed_results"]:
            if "error" in r:
                st.markdown(f"- _{r['error']}_")
            else:
                st.markdown(f"- [{r['title']}]({r['url']}) — {r.get('source', '')}")
    else:
        st.caption("The agent didn't need a live PubMed search this time.")
```
Save → Streamlit hot-reloads → re-send the prompt → the citation is now a **checkable list**, not buried prose. That's the baton landing: requirement → green → *surfaced*.

**The other two deltas (show as diff / already built in run):**
```python
# (1) onboarding / mental-model — set expectations before first use
with st.expander("How to read this", expanded=False):
    st.markdown(
        "- These are **conditions worth asking about**, not a diagnosis.\n"
        "- Each one is **cited** so you can check the source.\n"
        "- The agent may ask you a question before it has enough to go on.\n"
        "- It pulls from a curated knowledge base and, when useful, recent PubMed studies."
    )

# (2) take-it-with-you — printable prep sheet
st.download_button(
    "⬇️ Download prep sheet",
    data=reply,
    file_name="doctor-visit-prep-sheet.md",
    mime="text/markdown",
)
```
Tie each to the research: the sources panel counters **over-reliance** (the user can verify, not just trust); "how to read this" is **onboarding / mental-model setting**; the download is the **manual fallback / take-it-to-a-human** path. None of this repeats W1.

> **Reset Rohan's live edit between rehearsals:** `cd "Building ML Apps/symptomscout-versions" && git checkout run/ui.py` (or whichever file he typed into).

### `/design-critic` live (A7)
In Claude Code, run the design critic on the **bare** scaffold UI to show "design is checkable too":
```text
/design-critic
Review Building ML Apps/scaffold/app/ui.py
```
Expected: the 5-check review (confidence display · graceful degradation · plain language · accessibility · humane refusal), citing Google PAIR + Microsoft HAX. Use it to show the bare UI *fails* several checks that the run UI passes — closing the loop on "design has a rubric, just like evals."

> **Clip A10 plays in this section** (~90s): an agent driving the *rendered* run app via Playwright MCP to verify design properties hold (sources panel renders, disclaimer persists across turns, emergency escalation is unmissable). See shot-list. **Raise with Rohan** whether he'd rather do one live Playwright moment instead of the clip.

---

## Clip shot-lists (pre-recorded, ~90s each)

> **There is now a REAL, runnable autonomous loop** — not just a shot-list. Two scripts:
> - **`scaffold/scripts/ralph.sh`** — text-only: pytest → `claude -p` edits the prompt → green. (Simplest A9.)
> - **`symptomscout-versions/run-plus/ralph.sh`** — the headline: **run++** app with 3 planted reds, driven green by an agent in **two phases** — Phase A (text evals, pytest) **and Phase B (UI evals via Playwright MCP, live browser)**. This single run *is* A9 **and** A10. See `run-plus/README.md`.

### Clip A9 — the autonomous loop (JP's harness beat)
**Goal:** show the self-running version of the loop JP just did by hand.
- **Easiest:** record **`scaffold/scripts/ralph.sh`** after `./reset-demo.sh` — bash loop + `claude -p` editing `app/agent.py`, pytest going red→green. Headless (no browser).
- **Or** record **Phase A** of `run-plus/ralph.sh` (same idea, on run++; prints each iteration).
- **Narration (live, over the clip):** "Same loop. I'm not typing — it picks the red eval, reads the judge's reason, edits the prompt, re-runs, and stops when green. The harness running itself; what you watched me do by hand is the manual version."
- **Length:** trim to ~90s (speed up the pytest/judge waits). Keep the red→green flip full-speed.

### Clip A10 — Playwright UI-check (Rohan's section)
**Goal:** "design is checkable" — verify *rendered* UI properties an eval can't see. Reinforces `/design-critic`.
- **This is now Phase B of `run-plus/ralph.sh`** — record it directly: the agent starts the app on :8504, drives Chromium via **Playwright MCP**, finds the missing safety banner, **edits `ui.py`**, reloads, and re-verifies until it prints `UI-GREEN`. Put both the terminal *and* the Chromium window on screen.
- **The planted red it fixes:** no prominent/persistent safety banner (U2/U3 in `run-plus/evals/ui_checks.md`). U1 (sources panel) is already green.
- **Narration:** "An eval checks the text. This checks what the *person actually sees* — and when it's wrong, it fixes the UI and checks again in a real browser. Design properties, verified automatically."
- **Length:** ~90s. **Decision pending with Rohan:** play the clip, or run `run-plus/ralph.sh` Phase B live (it's hands-free). Clip is the safe default.

---

## If it breaks

Don't debug live for more than a minute.

| Symptom | What to do |
|---|---|
| Citation eval doesn't fail | `./reset-demo.sh` wasn't run, or the model over-delivered. Show the expected red from rehearsal, or play Clip A9. |
| pytest is slow / hangs | It's ~75s normally (LLM judge, 3×). Start it during the prior line. If it hangs >2min, Ctrl-C and show rehearsal output. |
| The live fix over-edits | Keep only the one citation line in `SYSTEM`. Don't rewrite the app. |
| Rohan's local env fails | JP screen-shares the running 8502/8503 apps; Rohan narrates over them. |
| Streamlit port in use | `--server.port 8512/8522/8532` and note the new tabs. |
| API / network down | Play the clips (A9, A10) and narrate the rehearsed run; the *concepts* still land. |
| `/design-critic` not found | The 5 critics live in `scaffold/.claude/skills/` locally. If demoing from a clean clone, they must be pushed first (open dependency — see W2-rebuild-plan.md). |

---

## Reset between rehearsals
```bash
cd "Building ML Apps/scaffold" && ./reset-demo.sh
cd "Building ML Apps/symptomscout-versions" && git checkout .   # undo any live UI edits
```

## Files touched live
- `scaffold/app/agent.py` — JP adds the one citation line to `SYSTEM` (reset restores it).
- `symptomscout-versions/run/ui.py` (or walk/ui.py) — Rohan types the sources-panel block (git-restore after).
- `scaffold/app/ui.py` — read-only target of `/design-critic` (not edited).

Do not pre-edit these; the changes should happen live.
