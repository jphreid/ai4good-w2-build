# Workshop 2 — Build Storyboard (Building ML Apps)

Per-slide blueprint to build the W2 deck from, in the **W1 bento structure**. Each slide: a layout sketch (what it looks like), the on-slide content, **UI:** (how to build it in the Bento system), **Say:** (the line), **Build:** (reveal cue) where it matters, and **Owner/Time** since this deck is **co-led**. Renders to `workshop2-slides.html` — **keep both files in sync.** 17 slides (no wrap / appendix) · **90 min = ~65 content + ~25 Q&A woven in**. **Skill convention: always write skills as `/skillname`.** This is a **led demo**, not a hands-on — the live beats (crawl→walk, `/design-critic`) are driven from `demo-runsheet.md` (A5); this storyboard does **not** re-transcribe terminal commands, it points to that sheet.

**Co-lead & two-act colour.** JP drives Acts 0–2 (open · harness theory · live crawl→walk); **Rohan D'Souza** (remote, Toronto) drives Act 3 (design for uncertainty — his own slides, plus the `/design-critic` payoff this deck carries); both close. For W1 visual continuity, carry the **stage palette** from the review-board map: **JP's half = blue accent (Build/Eng)**, **Rohan's half = violet accent (Design)**. The act-divider is where the accent flips — a visible "we're handing over" signal that mirrors the spoken baton.

**The spine the whole deck serves:** **requirement → eval → green (JP) → surfaced (Rohan).** Don't let any slide drift from it. The worked example is the **citation requirement**: JP makes the model cite (green in a test); Rohan makes the citation *visible and trustworthy* (sources panel). W1 landed "requirements become checkable through rubrics and evals"; W2 adds the next link — *green in a test ≠ usable by a person.*

**Do NOT re-teach W1** (slides 12–21 of W1): confidence-as-framing, graceful degradation (three bail-outs), augment-vs-automate, the SEES/DOES wrong-answer review, "AI failures look like successes." Name them as known; Rohan's section is the layer *beyond* them.

---

## UI system (Bento) — applies to every slide

The full design system — canvas, type, palette, colour rules, components, behaviour, CSS architecture — lives in **`../Product Management for AI/bento-design-system.md`** (single source of truth). Don't restate it. A per-slide **UI:** line below only notes what *differs*. Skill colours and stage palette follow that file.

---

# ACT 0 — Open  *(JP · 0:00–0:03 · 3 min)*

## 1 · Title  `LEAD — centered`  *(JP)*
```
┌────────────────────────────────────┐
│   AI4GOOD LAB 2026 · WORKSHOP 2     │ ← eyebrow
│        Building ML Apps            │ ← H1
│  From an eval spec to a working,    │ ← subtitle
│  usable app — with Claude as the    │   (italic; mint on "harness")
│  harness                            │
│                                     │
│  JP Reid · Principal PM · MSFT      │ ← right card (blue)
│  Rohan D'Souza · Sr UI Designer     │ ← right card (violet)
│  · MSFT                             │
└────────────────────────────────────┘
```
**UI:** Bento title, mirrors W1 slide 1. Hero card (1.45fr) spans both rows: eyebrow "AI4Good Lab 2026 · Workshop 2" + 3-line H1 (mint `<em>` on "harness") + lede. Right column = **two facilitator cards** (this is the co-led signal from frame one): a blue-gradient "JP Reid · Principal PM · Microsoft" card and a violet-gradient "Rohan D'Souza · Senior UI Designer · Microsoft" card.
**Say:** "Welcome back. June 1 was Product Management for AI — scoping the product and writing the evals. Today we build against those evals until they go green, and then we make the result *usable*. And I'm not alone — Rohan D'Souza joins us from Toronto for the design half."
**Build:** the two facilitator cards fade in together — set the co-lead expectation immediately.

---

## 2 · Where we left off  `TWO-COLUMN bridge — bento`  *(JP)*
```
┌────────────────────────────────────┐
│ WHERE WE LEFT OFF                   │ ← eyebrow
│ One story, two halves.             │ ← H1 (mint on "one story")
│ ┌─────────────────┬───────────────┐ │
│ │ JUNE 1          │ TODAY         │ │
│ │ requirement →   │ eval → green  │ │
│ │ rubric → eval   │ → surfaced    │ │
│ │ "you specified  │ "you build it │ │
│ │  it when you can│  AND make it  │ │
│ │  check it"      │  usable"      │ │
│ └─────────────────┴───────────────┘ │
│ → The eval set is the contract     │ ← accent strip
│   carried across both days.        │
└────────────────────────────────────┘
```
**UI:** Two `.wcard` columns (June 1 mint / Today blue). Full-width mint→blue accent strip at the bottom carrying the spine sentence. This is the W1→W2 hinge slide — keep it to one screen.
**Say:** "On June 1 you learned the move: a requirement becomes checkable through a rubric and an eval. *If you can't say what good and bad look like, you haven't specified it.* Today is the second half of that exact sentence — we take those evals and drive an app from red to green, then ask the harder question: green in a test, sure — but can a scared person in a waiting room actually *use* it?"
**Build:** the accent strip ("the eval set is the contract carried across both days") slides in last — it's the thesis.

---

## 3 · What today is  `4 agenda rows + flow line — progress tracker`  *(JP)*
```
┌────────────────────────────────────┐
│ TWO BUILDERS · ONE APP · 90 MIN    │ ← eyebrow
│ Green isn't done.                  │ ← H1 (the thesis of the co-lead)
│ ┌──┬───────────────────────┬─────┐ │
│ │  │ Harness theory   (JP) │15min│ │
│ │  │ Live 🐢→🚶 red→green(JP)│12min│ │
│ │  │ Design for uncertainty│30min│ │ ← Rohan (violet)
│ │  │  + live 🚶→🏃  (Rohan) │     │ │
│ │  │ Wrap + take it home   │ 5min│ │
│ └──┴───────────────────────┴─────┘ │
│ ~25 min of questions, woven in     │ ← footer note
└────────────────────────────────────┘
```
**UI:** Mirrors W1 agenda (slide 4). H1 is the thesis, not a head-count: **"Green isn't done"** — an eval can pass and the thing can still be unusable for a scared patient. "Two builders · one app" lives in the eyebrow. Four row-cards; **JP's two rows blue-tinted, Rohan's row violet-tinted** — the two-act structure is legible at a glance, and it *earns* the two builders (JP makes it work, Rohan makes it usable). Footer notes the protected Q&A. No "we're here" highlight yet (we're at the top).
**Say:** "Here's the shape, and here's the thesis: *green isn't done*. I take the first half — fifteen minutes on the *harness*, the structure around the model, then a live red-to-green fix. And the moment a test goes green, Rohan takes over — because passing a test and being usable by a frightened person are two different things. He designs for the fact that the model is sometimes wrong, with a live UI build. We close together. Questions all the way through, time held at the end. It's a *led* demo — watch us drive, then you fork it and drive it yourself."
**Build:** rows reveal top-to-bottom; the violet (Rohan) row lands with "Rohan takes over" — the headline's promise made visible.

---

# ACT 1 — Harness theory  *(JP · 0:03–0:18 · 15 min · 5 ideas, covered properly)*

## 4 · Theory divider  `LEAD — divider + count`  *(JP)*
```
┌────────────────────────────────────┐
│            THE HARNESS              │
│        Five ideas. 15 minutes.     │ ← H1 (mint on "Five ideas")
│ ┌────────────────────────────────┐ │
│ │ The build that comes next       │ │ ← framed quote
│ │ depends on all five. We cover   │ │
│ │ them properly, not in passing.  │ │
│ └────────────────────────────────┘ │
│ kitchen·state·judge·workflow·evals │ ← 5-dot tracker (muted)
└────────────────────────────────────┘
```
**UI:** Lead/divider, blue accent. Add a **5-dot idea-tracker** footer (chef vs kitchen · durable state+ratchet · generator/evaluator · workflow vs agent · evals-as-contract) — like W1's arc-word line; the current idea lights blue as we move through 5–12. This gives the 15-min block a visible spine so it doesn't feel like a lecture.
**Say:** "Fifteen minutes of theory, then we use every bit of it live. Five ideas — and to hold them together, one picture: we're going to build a *kitchen*. The last workshop's payoff was *evals are the spec*; this is the machine that runs on that spec."
**Build:** five dots appear muted; dot 1 ("chef vs kitchen") lights on the next slide.
**Note:** the **kitchen analogy** runs as a thread through ACT 1 (JP's own framing): chef = model · pantry = tools · prep counter = context · expediter = the loop · **tasting station = evals** · plating = the UI. Anchored on slide 5, paid off at slide 9 (chef ≠ taster) and slide 28 ("same kitchen, different menus"). Keep it to those touchpoints — don't over-garnish.

---

## 5 · Chef vs kitchen  `COMPONENT GRID 2×4 — bento`  *(JP · idea 1 · KITCHEN ANCHOR)*
```
┌────────────────────────────────────┐
│ IDEA 1 · CHEF vs KITCHEN            │
│ The model is the chef.             │ ← H1
│ The kitchen is everything else.    │   (blue on "everything else")
│ ┌────────┬────────┬────────┬──────┐ │
│ │ Chef   │ Pantry │ Prep   │Recipe│ │ ← row 1
│ │ =model │ =tools │ counter│cards │ │
│ │        │        │ =ctx   │=state│ │
│ ├────────┼────────┼────────┼──────┤ │
│ │Expedit-│Tasting │Health  │Plat- │ │ ← row 2
│ │er=loop │station │inspect.│ing   │ │
│ │        │=EVALS◆ │=guard. │=UI   │ │ ← tasting = hero
│ └────────┴────────┴────────┴──────┘ │
└────────────────────────────────────┘
```
**On-slide (8 component cards — each = kitchen part · harness term · one line · a 🐢🚶🏃 app-anchor showing where it turns on in our apps):**
1. **Chef** · the model — *(HERO card, accent)* rented, brilliant, forgets between shifts; swappable. — `🐢🚶🏃 Sonnet · agentic in 🏃`
2. **Pantry** · the tools — what the chef can reach for. — `🚶 knowledge base → 🏃 + PubMed`
3. **Prep counter** · the context — what the model sees this turn. — `🐢 chat → 🏃 + tool results`
4. **Recipe cards** · durable state — conventions + decisions, on disk. — `🐢🚶🏃 the repo · 🏃 adds evals/`
5. **Expediter** · the agent loop — calls the next step; holds, then fires. — `🏃 only — the loop that picks PubMed`
6. **Tasting station** · the evals — a separate taster checks every plate. The heart of today. — `the same evals gate 🐢🚶🏃`
7. **Health inspector** · the guardrails — no diagnosis; emergencies escalate. — `🐢 emergency → 🚶🏃 + no-diagnosis, cite`
8. **Plating** · the UI — what the patient sees and trusts. Rohan's half. — `🐢 chat → 🏃 + sources panel`
**UI:** `.kgrid` layout — head + **8 `.kc` cards in a 4-col × 2-row grid** filling the stage. Each card is a **three-rung ladder**: kitchen part (`.kn`) · harness term (`.ka`) · one-line meaning (`.ke`) · a muted **app-anchor** (`.kapp`, divider above it, with 🐢🚶🏃 emojis that mark it as the distinct "in our apps" layer). The app-anchor is **phase-level on purpose** (which version has it), not file paths — the audience is 4 weeks into ML; file paths live on slide 13 + the live demo. The **chef** card is `.hero` (accent) — the chef (the model) is the one piece you *don't* build, so it's set apart from the kitchen you do. Verified no overflow at 1280×720.
**Say:** "Idea one — the picture that holds the next fifteen minutes together. Your model — Claude — is the *chef*: brilliant, but you rent it by the hour, it cooks only what's in front of it, and it forgets the whole kitchen between shifts. The *kitchen* is everything around the chef: the pantry of tools, the prep counter where today's context sits, the expediter that runs the loop, the **tasting station** — that's your evals — and the plating, the UI the patient sees. And see the small line on each card? That's where it shows up in the apps you'll fork — most of this *turns on* as you go from crawl to walk to run. **These are the kitchen's parts. The next four ideas are the *principles* for running the kitchen well** — and the chef, you already have; you build the kitchen."
**Build:** chef card first, then the rest reveal one by one (each previews ideas 2–5 — counter→state, tasting→evals, expediter→loop). The **parts → principles** bridge is the verbal hand-off into ideas 2–5.

---

## 6 · Why the harness matters  `STATEMENT + list — bento`  *(JP)*
```
┌────────────────────────────────────┐
│ WHY IT MATTERS                      │
│ "Build me SymptomScout." → smart   │ ← H1
│  and unusable.                     │   (pink on "unusable")
│ Because the bare model doesn't know:│
│  what "good" means → evals ≈ tasting│
│  where files go → CLAUDE.md ≈ house │
│    rules                            │
│  what tools → .mcp.json ≈ pantry    │
│  what's decided → repo ≈ recipe box │
│ The harness is how you encode all   │ ← accent strip
│ of that.                           │
└────────────────────────────────────┘
```
**UI:** Single column (`.map md kx`); the four "doesn't know → fix" rows as a tight aligned list (problem ink, fix in mono/blue), **plus a right-aligned muted-italic kitchen gloss per row** (`≈ the tasting station / house rules / pantry list / recipe box`) — the slide-5 map called back exactly where the abstract files appear. Pink `<em>` on "unusable". Bottom blue accent strip. The `≈` prefix is accent-tinted; the gloss text is muted so it reads as a quiet mapping, not a third column of content.
**Say:** "Open Claude, type 'build me SymptomScout.' It'll try — and the result is smart and unusable. Because it doesn't know what *good* means for your app, where files go, which tools exist, or what you already decided last week. Back to the kitchen: *good* is the tasting station, **CLAUDE.md is the house rules** — how this kitchen runs and where everything lives — the tools are the pantry, and the repo is the recipe box. The harness is how you write all of that down so the model can act on it."
**Build:** the four rows reveal in pairs (problem then its fix); the kitchen gloss fades in last on each row.

---

## 7 · Durable state + context-reset  `bento — two ideas, one slide`  *(JP · idea 2a)*
```
┌────────────────────────────────────┐
│ IDEA 2 · DURABLE STATE              │
│ The chef forgets.                  │ ← H1
│ The kitchen remembers.             │   (blue on "remembers")
│ ┌────────────────────────────────┐ │
│ │ Every session starts blank. If  │ │ ← framed
│ │ reality lives only in the chat, │ │
│ │ you re-explain it forever. The  │ │
│ │ kitchen keeps books: → disk.    │ │
│ └────────────────────────────────┘ │
│  conventions → CLAUDE.md            │
│  tests       → evals/               │
│  tools       → .mcp.json            │
│  decisions   → commits & code       │
│ A new build session reads the books │
│ — caught up. Resets, not compaction │
└────────────────────────────────────┘
```
**UI:** Framed quote up top (the context-reset problem), then a four-row "lives where" map (blue mono on the right). **Kitchen grounding lives in the H1 + leadq + footer, NOT the rows** — the per-file glosses (house rules / pantry / recipe box) already appeared on slide 6; repeating them here would over-garnish. Footer is split: left = the app-anchor, right = the W1 "context *resets*, not compaction" callback.
**App:** `🐢🚶🏃 every version reads the same repo — 🏃 adds evals/` (left side of the `.srcfoot`).
**Say:** "Idea two, and it shapes everything: every session starts *blank* — the model does not remember yesterday. Remember the chef forgets the kitchen between shifts? This is that. If your app's reality lives only in the chat, you re-explain it forever — and worse, it rebuilds what you already built. So the kitchen keeps *books*: push everything that matters to disk — conventions, tests, tools, decisions. A fresh *build session* opens the repo, reads the books, and is caught up. In all three apps it's the same repo — crawl, walk, run all read it; run adds the eval suite. That's durable state — and notice it's *context resets*, not compaction. Fresh start, every shift, by design."
**Build:** the four-row map reveals after the framed problem.

---

## 8 · The ratchet  `STATEMENT — bento`  *(JP · idea 2b)*
```
┌────────────────────────────────────┐
│ IDEA 2 (cont.) · THE RATCHET        │
│ A green eval stays green.           │ ← H1 (blue on "stays green")
│ ┌────────────────────────────────┐ │
│ │ Each feature ships only if the   │ │
│ │ WHOLE suite still passes — no    │ │
│ │ old requirement broken to land   │ │
│ │ a new one. Like a dish that's    │ │
│ │ cleared the pass: cleared good.  │ │
│ └────────────────────────────────┘ │
│ A change can't break a passing eval │ ← accent strip (pink)
│ unnoticed = no ratchet. The suite   │
│ is what notices.                    │
│ 🐢🚶🏃 same evals gate every version │ ← app-anchor footer
└────────────────────────────────────┘
```
**UI:** One bold statement + framed elaboration + a pink warning strip + a centered app-anchor footer. Keep it short — it's a principle slide that the live demo will *prove* in 10 minutes. **Build-first framing (per JP):** lead with the eval mechanic — a green eval stays green, each feature must pass the *whole* suite — then let the tasting station land as a one-line allusion at the end. Still one of three ideas that orbit the tasting station (with idea 3 and idea 5); keep this facet distinct: *standards only go up*.
**App:** `🐢🚶🏃 the same 5 evals gate every version — a phase ships only if it still passes the ones before` (centered `.srcfoot`). Ties the ratchet to crawl/walk/run + "each phase earns the next."
**Say:** "Second half of idea two: the ratchet — and it's about how you *build*. A green eval stays green. Every new feature has to pass the *whole* suite, not just its own test — so you never win a new requirement by quietly breaking an old one. It's why the *same* evals gate crawl, walk, and run: a new phase only ships if it still passes everything the last one did. *(then the kitchen)* Like a dish that's cleared the tasting station — cleared for good. Here's the test: if a new change can break a passing eval without anyone noticing, you don't have a ratchet — the suite is what notices. In about ten minutes you'll watch it: I turn one eval green, and the other four don't move."
**Build:** the pink strip lands last as the test; the app-anchor footer is already up.

---

## 9 · Generator / evaluator split  `bento — the key lever`  *(JP · idea 3)*
```
┌────────────────────────────────────┐
│ IDEA 3 · TWO MODELS, NOT ONE        │
│ Separate the builder from the judge.│ ← H1 (mint on "judge")
│ ┌─────────────┬────────────────────┐│
│ │ GENERATOR   │ EVALUATOR          ││
│ │ Sonnet      │ Opus — different,  ││
│ │ writes the  │ stronger. Decides  ││
│ │ app's answer│ if it's good. 3-5× ││
│ │             │ majority vote.     ││
│ └─────────────┴────────────────────┘│
│ The chef doesn't taste their OWN    │ ← accent (kitchen callback)
│  plate — a separate taster does.    │
└────────────────────────────────────┘
```
**On-slide line (kitchen callback + attribution):** *"The chef doesn't taste their own plate — there's a separate taster on the pass."* Cite under it: *"Separating the agent doing the work from the agent judging it proves to be a strong lever." — Anthropic, Harness Design for Long-Running Apps (2026); a model grading its own work always says "looks great."*
**UI:** Two-column (generator blue / evaluator violet — previews the two halves of the day, builder=JP, judge-of-design=Rohan). Kitchen-callback line as the accent; Anthropic attribution in small caps under it; centered app-anchor footer below. **Callback to the slide-5 anchor — don't re-explain the whole kitchen, just the taster. Keep the facet distinct: a *separate* taster** (vs idea 5's "the taster needs a standard"). Note the consistency fix: the generator is **the cook** (= the chef/model), the evaluator is **the taster** — never "line cook."
**App:** `🏃 the cook = the app's Sonnet · the taster = judge() on a second pass (Opus)` (centered `.srcfoot`).
**Say:** "The strongest single move in a harness — and back to the kitchen: the chef doesn't taste their own plate. There's a separate taster on the pass. The generator — Sonnet — *cooks* SymptomScout's answer. The evaluator — Opus, a different and stronger model — is the *taster*: it decides if it's good, and votes several times so the verdict is stable, not a coin flip. A model grading its own homework always gives itself an A; a separate taster doesn't. In your scaffold, that taster is `judge()` on Opus, grading the Sonnet it's checking — that's the run version, where the evals live."
**Build:** generator column, then evaluator column, then the quote.

---

## 10 · CLIP A9 — the autonomous loop  `MEDIA — full-bleed clip + caption`  *(JP)*
```
┌────────────────────────────────────┐
│ ▶  ~90s clip                        │
│ ┌────────────────────────────────┐ │
│ │  [Claude Code running the loop  │ │
│ │   itself: pytest → read red →   │ │
│ │   edit prompt → re-run → green] │ │
│ └────────────────────────────────┘ │
│ "You're about to watch me do this   │ ← caption
│  by hand. Here's the harness        │
│  running itself."                  │
└────────────────────────────────────┘
```
**UI:** Full-bleed media slide (new component vs W1 — a `.clip` card: 16:9 video well + one caption line). Clip is a local MP4 (`A9`), played from the presenting machine — see shot-list in `demo-runsheet.md`. Plays **right after** the generator/evaluator + ratchet ideas, before workflow/agent.
**Say (live, over the clip):** "Same loop you're about to see me run by hand. I'm not typing — it picks the red eval, reads the judge's reason, edits the prompt, re-runs, and stops when it's green. That's the harness running *itself*. The Ralph loop — run the agent in a loop until it's done. We'll do the manual version in a minute so you can see every step."
**Build:** clip autoplays on slide entry; caption persists after it ends.
**Note:** attribution — the autonomous "run-it-in-a-loop" framing is **community / Geoffrey Huntley** ("Ralph loop"), *not* Anthropic. Say it that way.

---

## 11 · Workflow vs agent  `TWO-COLUMN compare — bento`  *(JP · idea 4)*
```
┌────────────────────────────────────┐
│ IDEA 4 · WORKFLOW vs AGENT          │
│ The biggest design choice today.   │ ← H1
│ ┌─────────────────┬───────────────┐ │
│ │ WORKFLOW        │ AGENT         │ │
│ │ you set steps   │ it picks steps│ │
│ │ predictable     │ flexible      │ │
│ │ cheap to debug  │ hard to debug │ │
│ │ easy to eval    │ harder to eval│ │
│ └─────────────────┴───────────────┘ │
│ Prix-fixe menu vs a chef who        │ ← accent strip (kitchen)
│ improvises off the pantry.          │
│ Simplest that works. 🐢🚶=wf 🏃=agent│
└────────────────────────────────────┘
```
**UI:** Two-column compare (workflow blue / agent violet). Bottom strip carries the kitchen callback (*prix-fixe = fixed steps; improvising chef = the agent picking its own*, reaching into the pantry = choosing tools). Split `.srcfoot`: left = the app-anchor, right = the Anthropic attribution chip. **This is the strongest existing app-anchor** — crawl/walk/run *is* the workflow→agent axis.
**App:** `🐢🚶 one-shot workflows · 🏃 the loop that chooses PubMed` (left side of `.srcfoot`; `Anthropic, Building Effective Agents (Dec 2024)` on the right).
**Say:** "Idea four, and it's the choice that defines your app — in kitchen terms, a fixed *prix-fixe menu* versus a chef who *improvises* off whatever's in the pantry. A *workflow* runs the model down a path you fixed in advance — predictable, cheap, easy to test. An *agent* decides its own steps and which tools to call — flexible, but harder to debug and to evaluate. The rule: use the simplest thing that works. Most production AI is workflows with one or two agent escape hatches. And this is exactly crawl-walk-run: crawl and walk are one-shot workflows; run is where it becomes an agent — the loop that *chooses* to reach into the pantry for PubMed."
**Build:** columns reveal; the 🐢🚶/🏃 mapping lands last (sets up the demo).

---

## 12 · Evals are the contract  `bento — table`  *(JP · idea 5)*
```
┌────────────────────────────────────┐
│ IDEA 5 · EVALS ARE THE CONTRACT     │
│ Agree what good tastes like —       │ ← H1 (blue on "good tastes like")
│ before service.                    │
│ ┌──────────────┬──────────┬───────┐ │
│ │ Generator    │ Sonnet   │≈ cook │ │
│ │ Evaluator    │ judge()  │≈taster│ │
│ │ Sprint contr.│ evals.py │≈stand-│ │
│ │              │          │ ard   │ │
│ └──────────────┴──────────┴───────┘ │
│ The tasting station needs a standard│ ← accent strip
│ = the evals you wrote June 1.       │
│ 🐢🚶🏃 same evals; citation = live   │ ← app-anchor footer
└────────────────────────────────────┘
```
**UI:** Three-row `.map md kx` (key · value · right-aligned kitchen gloss: **≈ the cook / the taster / the standard card** — "cook," not "line cook," to match slide 5's chef=model). Accent strip carries the kitchen tie + the no-new-requirements rule (the cross-day spine); centered app-anchor footer below. **Third tasting-station idea** (with ratchet + gen/eval) — keep this facet distinct: *the taster needs a standard agreed first.* Attribution: the *sprint contract* framing → Anthropic.
**App:** `🐢🚶🏃 the same 5 evals gate every version — the citation one is what we turn green live` (centered `.srcfoot`).
**Say:** "Idea five ties the other four together — and it's the tasting station one more time. A taster is useless without a *standard*: what does a good plate actually taste like? You agree that before service, not mid-rush. That standard is `evals/evals.py`, the same shape you wrote on June 1 — and the *same five evals* gate all three apps, crawl through run. The discipline that matters: *we invent no new requirements today.* The evals are the spec; we build until they're green — and the citation eval is the one I'm about to turn green live. That's the contract carried across both workshops."
**Build:** rows fill top-to-bottom; the kitchen glosses fade in on the right; accent strip, then the app-anchor footer.
**Note:** MCP & security are **not** full slides here — one spoken line ("tools plug in via MCP; keys live in `.env`, never in code — both in the appendix if you want the detail") + appendix slides A-1/A-2. Keeps the 15 min honest.

---

## 13 · Where is the harness?  `MAP — the payoff callout`  *(JP · bridges theory→demo)*
```
┌────────────────────────────────────┐
│ SO — WHERE IS THE HARNESS?          │
│ Not in the model call. In the loop  │ ← H1 (mint on "the loop")
│ around it.                          │
│ ┌────────────────────────────────┐ │
│ │ spec   → evals.py ≈ standard card│ │
│ │ generator → agent.py+Sonnet ≈cook│ │
│ │ evaluator → judge()/Opus ≈ taster│ │
│ │ state  → files on disk ≈recipe bx│ │
│ │ ratchet → pytest 4→5 ≈ one-way   │ │
│ │ the loop → red→fix→green ≈ at work│ │
│ └────────────────────────────────┘ │
│  (right col = ≈ kitchen gloss)      │
│ You rent the chef. You BUILD the    │ ← accent (kitchen capstone)
│ kitchen. Model = don't control;     │
│ harness = what you DO.             │
└────────────────────────────────────┘
```
**UI:** Six-row map, three columns (`.map sm kx`): piece · where it lives in *this* repo (blue mono) · a right-aligned `≈ kitchen gloss` (muted italic, same `.kk` style as slides 6/12). The gloss column **closes the loop between the metaphor and the code** — standard card / cook / taster / recipe box / one-way pass / kitchen at work — reusing the cook/taster/standard-card glosses from slides 5 and 12 verbatim. This is the slide that inoculates the live demo against reading as "he just tweaked a prompt." Last row ("the loop") points forward into Act 2. Bottom accent strip = the **kitchen capstone** that bookends slide 5 ("you rent the chef, you build the kitchen") fused with the one-sentence definition (model = uncontrolled, harness = yours).
**Say:** "Before we go live, one picture — because the demo could look like 'he edited a prompt and a test passed.' It's more than that. Here's every piece — its name in the kitchen, and where it actually lives in the repo: the standard card is the eval file; the cook is the app prompt plus Sonnet; the taster is `judge()` on Opus; the recipe box is the files on disk; the one-way pass — the ratchet — is pytest going four-to-five and *staying* there; and the kitchen at work — the loop, red, fix, green — is what I'll run right now. *(land it)* You rent the chef; you *build the kitchen*. The model is the part you don't control — the harness is the part you do. And notice it runs at two scales: right now you're running *one* harness — Claude Code plus the evals — to build *another*, the app's own. Same pattern both times. Let's go to the terminal."
**Build:** rows reveal top-to-bottom; "the loop" row pulses, then we cut to the terminal.

---

# ACT 2 — Live crawl→walk  *(JP · 0:18–0:30 · 12 min · LIVE — driven from `demo-runsheet.md`)*

## 14 · Live: the harness, by hand  `DEMO — live terminal, minimal slide`  *(JP · LIVE)*
```
┌────────────────────────────────────┐
│ LIVE · 🐢→🚶  RED → GREEN            │ ← persistent header band
│                                     │
│   (slide is a thin frame; the       │
│    terminal is the content)         │
│                                     │
│  1  run the contract   → 4✓ 1✗      │ ← 3-step rail (lights as JP goes)
│  2  read the failure → add one line │
│  3  re-run → 5✓  (ratchet holds)    │
└────────────────────────────────────┘
```
**UI:** A **demo-frame** slide — minimal chrome so JP can screen-share the terminal over/beside it. A persistent top band ("LIVE · 🐢→🚶 red→green") and a **3-step rail** that JP advances (key press) as each step lands — gives the room a place to look while pytest runs ~75s. **All commands, prompts, expected output, and fallback live in `demo-runsheet.md` → "JP's beats" — do not duplicate here.**
**Say:** (from the run-sheet) "Some checks are fuzzy — 'does every condition cite a source?' isn't a substring match, so a second model judges it… four green, one red… read the failure, add one line to the contract the generator reads… green, and it *stays* green — that's the ratchet."
**Build:** step rail advances 1→2→3 with the live work. **Timing tip:** kick off step 1's `pytest` during slide 13's last sentence so it's finishing as you arrive (the ~75s wait is real).
**Pitfall:** if the eval doesn't go red, you skipped `./reset-demo.sh` — fall back to rehearsal output or Clip A9 (see run-sheet "If it breaks").

---

## 15 · The baton  `LEAD — handoff + accent flip`  *(JP → Rohan)*
```
┌────────────────────────────────────┐
│ IT CITES SOURCES NOW.              │ ← H1
│ ┌────────────────────────────────┐ │
│ │ > …could be PCOS, thyroid, or   │ │ ← a real walk answer,
│ │ insulin resistance. Source:     │ │   citation BURIED mid-
│ │ ACOG guidance on… and you should│ │   paragraph (highlighted)
│ │ also consider…                  │ │
│ └────────────────────────────────┘ │
│ Green in a test ≠ visible to a      │ ← accent (flips blue→violet)
│ scared person. That's design now.   │
│            → Rohan                  │
└────────────────────────────────────┘
```
**UI:** The **accent flips here** — top half blue (JP's), the bottom strip and the "→ Rohan" tag violet (Rohan's). Show a *real* walk response with the citation literally buried in prose, one phrase highlighted so the room sees the problem. This is the hinge of the whole workshop.
**Say (the baton, verbatim from run-sheet A6):** "So it cites sources now — the test is green. But look at the answer: the citation is buried in a wall of text. A scared person in a waiting room will never find it. Passing the test made it *true*; it didn't make it *usable*. That's not an engineering problem anymore — it's a design problem. Rohan —"
**Build:** the buried citation highlights; then the whole slide's accent shifts blue→violet as JP says "Rohan —". The colour *is* the handoff.

---

# ACT 3 — Design for uncertainty  *(Rohan · 0:30–1:00 · ~30 min · NEW ground beyond W1 — Rohan brings his own failure/demo slides; this deck holds the framing + the /design-critic payoff)*

## 16 · Design goal — make it work better  `LEAD — section divider (violet)`  *(Rohan)*
```
┌────────────────────────────────────┐
│ ROHAN D'SOUZA · SR UI DESIGNER · MSFT │ ← eyebrow
│   We made it work. Now make it      │ ← H1
│   work better.                     │   (violet on "work better")
│ ┌────────────────────────────────┐ │
│ │ The model now cites a source.   │ │ ← framed
│ │ My job: make a stressed person   │ │
│ │ actually trust it — or correct it.│ │
│ └────────────────────────────────┘ │
│ Builds ON June 1 — not a repeat.    │ ← footer chip
└────────────────────────────────────┘
```
**UI:** Full violet-accent section divider — the visual "Rohan's half starts." H1 reframes the section as the move from *works* (passes the evals) to *works better* (a scared person can actually use it). Footer chip flags "beyond W1" so the room stays out of re-teaching. **This is the only framing slide this deck carries for Rohan's 30 min — his own failure/demo slides run live from here; the deck rejoins at slide 17 (`/design-critic`).**
**Say:** "Thanks JP. The model cites a source now — that's the engineering win; we made it *work*. My half is making it *work better*: whether a frightened person in a waiting room actually *uses* it, doubts it correctly, or gets misled by it. Steve Jobs put it best — *'Design is not just what it looks like and feels like. Design is how it works.'* That's the bar. You learned the foundations on June 1 — confidence as framing, graceful degradation, augment vs automate; I'm going one layer past those, into the failures that live in the *interface*, not the model."
**Build:** the "builds on June 1" chip lands as Rohan name-checks W1.

---

## 17 · /design-critic — design has a rubric too  `RUBRIC + symmetry (violet)`  *(Rohan · LIVE · his close, or hands to the optional A10 clip)*
```
┌────────────────────────────────────┐
│ DESIGN HAS A RUBRIC, TOO            │
│ Just like evals. /design-critic     │ ← H1 (violet on skill)
│ ┌────────────────────────────────┐ │
│ │ Audits the bare UI · 5 checks:  │ │
│ │  confidence display ·            │ │
│ │  graceful degradation ·          │ │
│ │  plain language ·                │ │
│ │  accessibility ·                 │ │
│ │  humane refusal                  │ │
│ │ cites PAIR + Microsoft HAX       │ │
│ └────────────────────────────────┘ │
│ The bare UI FAILS several — the     │ ← landing
│ design fixes pass them. Like evals. │
└────────────────────────────────────┘
```
**UI:** 5-check list card (violet). Frame as the mirror of JP's eval loop — *design is checkable too.* The first two checks are W1 (name-check, don't re-teach); give airtime to plain language, accessibility, humane refusal. Live `/design-critic` runs on bare `scaffold/app/ui.py` — see run-sheet A7.
**Say:** "One more symmetry to close the loop. JP had an eval that says what 'good' means for the *model*. Design has the same thing — a rubric. `/design-critic` audits the bare UI against five checks. Two of them — confidence display, graceful degradation — you already know from June 1; I'll spend the time on the new three: plain language, accessibility, humane refusal. Watch it fail a bare UI on exactly these three — plain language, accessibility, humane refusal… *(run it)*. Design isn't vibes — it's checkable, just like the evals."
**Build:** the 5 checks reveal; W1 ones dimmed, new three highlighted; then cut to the live `/design-critic` run.

---

## 18 · Clip A10 — Playwright UI-check  `MEDIA — clip + caption (violet)`  *(Rohan · PLACEHOLDER — optional)*
```
┌────────────────────────────────────┐
│ ▶  ~90s clip · placeholder          │
│ ┌────────────────────────────────┐ │
│ │ [Agent driving the RENDERED app │ │
│ │  via Playwright: sources panel  │ │
│ │  renders · disclaimer persists ·│ │
│ │  emergency is unmissable]       │ │
│ └────────────────────────────────┘ │
│ "An eval checks the text. This      │ ← caption
│  checks what the person SEES."      │
│ optional · JP to record · Rohan call│
└────────────────────────────────────┘
```
**UI:** `.clip` media card (violet), re-added as a **placeholder** after `/design-critic`. The `.well` ▶ stands in for the MP4 (`A10`) — **JP to record**; shot-list in `demo-runsheet.md`. **Optional / Rohan's call:** cut it and slide 17 is the close; keep it and A10 is the closing verification. Remove the "placeholder / to record" markers once the video is wired.
**Say (over clip, if used):** "An eval checks the *text*. This checks what the *person actually sees* — sources panel renders, the safety line never scrolls away, an emergency is impossible to miss. Design properties, verified automatically — the same red-to-green discipline, pointed at the interface."
**Build:** clip autoplays; caption persists. (Skip the slide entirely if Rohan opts out.)

---

## Build notes for Phase 4 (HTML)

- **Section count to verify:** **18** `<section>`s (ends on slide 18 = the optional A10 clip placeholder, after `/design-critic`; no wrap, no appendix).
- **New components vs W1:** the `.clip` media card (slides 10, 26) and the `.demo-frame` minimal live slide (14, 23, 25) — both need CSS added to the bento system (or a W2-local override block); everything else reuses W1 components.
- **Two-act accent:** JP Acts 0–2 = blue stage accent; Rohan Act 3 = violet; the flip is animated on slide 15 (the baton).
- **Idea-tracker:** slides 5–13 carry the 5-dot harness tracker from slide 4.
- **Live slides hold no commands** — they frame the terminal; all live detail stays in `demo-runsheet.md` so there's one source of truth for the demo.
- **Speaker-say.md (also Phase 4):** expand each **Say:** into natural spoken beats, W1 parity; mark the baton (slide 15) and the two clip cues (slide 10 = A9; slide 18 = A10, optional placeholder).
</content>
</invoke>
