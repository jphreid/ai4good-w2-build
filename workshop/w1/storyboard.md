# Workshop 1 — Build Storyboard (Product Management for AI)

Per-slide blueprint to build the deck + animations from. Each slide: a layout sketch (what it should look like), the on-slide content, **UI:** (how to build it in the Bento system), **Say:** (the line), and **Build:** (reveal/animation cue) where it matters. Renders to `workshop1-slides.html` — **keep both files in sync.** 42 rendered slides (all 5 stages + bridge/close built in HTML as of 2026-06-01) · 90 min. **Skill convention: always write skills as `/skillname`** on slides and in notes. Demo (~15 min) + sprint (20 min) are the firm anchors; everything else flexes. **Delivery is remote + solo** — no in-room team breakouts; help, handout, and shareback all live in the chat. **Survival mode** (20 min late): cut Stage 4, shorten Stage 5; eval-as-spec is non-negotiable.

---

## UI system (Bento) — applies to every slide

The full design system — canvas, type, palette, the colour rules, components, behaviour, and the CSS architecture — lives in **`bento-design-system.md`** (the single source of truth). Don't restate it here. A per-slide **UI:** line below only notes what *differs* from that template.

---

## 1 · Title  `LEAD — centered`
```
┌────────────────────────────────────┐
│        Product Management for AI    │  ← H1
│   How to know your idea is good     │  ← subtitle
│   before you ask an LLM to build it │     (italic)
│                                     │
│   AI4Good Lab 2026 · Jean-Philippe Reid │  ← footer
│   Principal Product Manager @ Microsoft │
└────────────────────────────────────┘
```
**UI:** Bento title. Hero card (1.45fr) spans both rows: eyebrow "AI4Good Lab 2026 · Workshop 1" + 3-line H1 (mint `<em>` on "AI") + lede subtitle. Right column = violet-gradient "June 1 / 90 min · hands-on" card + "Facilitator: Jean-Philippe Reid" card.
**Say:** "Welcome. This is Product Management for AI. We're not going to talk about *what* PM is — we're going to do it."

---

## 2 · About me  `4 boxes + full-width artifact strip — bento`
```
┌──────────────────────────────────────┐
│ ABOUT ME · JP REID                    │
│ ┌──────────────────┬────────────────┐ │
│ │ ● Principal PM @  │ ● PM by accident│ │
│ │   Microsoft       │   here for     │ │
│ │   Agentic harness │   innovation   │ │
│ ├──────────────────┼────────────────┤ │
│ │ ● Faked it 'til   │ ● Two sessions │ │
│ │   I made it       │   sharing what │ │
│ │   false starts    │   I learned    │ │
│ ├──────────────────┴────────────────┤ │
│ │ → You leave with ONE artifact:     │ │ ← accent strip
│ │   a working first app + every      │ │
│ │   artifact + the skills to repeat  │ │
│ └────────────────────────────────────┘ │
└──────────────────────────────────────┘
```
Minimalist box text (full version lives in Say):
1. **Principal PM @ Microsoft** — I productize agentic harnesses for enterprise
2. **PM by accident** — here for innovation; PM is how you do it
3. **Faked it 'til I made it** — many false starts
4. **Two sessions** — sharing what I learned
→ **artifact:** a working first app + all the artifacts that built it + the skills (human & Claude) to repeat the experience

**UI:** Grid `1fr 1fr` × rows `auto 1fr 1fr auto`. Eyebrow header "About me · JP Reid" spans top. Four fact-boxes (2×2), **dot on the left with heading+text beside it** (row layout), dots cycle mint/violet/amber/pink, top-aligned so dots+headings line up. Full-width accent strip across the bottom (mint gradient, `→`, mint heading, ink body).
**Say:** ~45 sec. Principal Product Manager at Microsoft. I productize agentic harnesses for enterprise. I became a PM by accident; I'm here for innovation, and what I came to realize is that PM is how you do it without wandering. Faked it 'til I made it: many false starts. These two sessions share what I learned.
**Also:** "You walk out with a working prototype *and* the repeatable skills — human and Claude — to do it again."

---

## 3 · The dead end  `LEAD — title + framed quote`
```
┌────────────────────────────────────┐
│      WHERE MOST AI PRODUCTS DIE     │ ← eyebrow
│           The dead end             │ ← H1
│ ┌────────────────────────────────┐ │
│ │ Most product failures in AI     │ │ ← framed quote
│ │ aren't TECHNICAL. They're about │ │   (mint left-bar,
│ │ asking the WRONG QUESTION first.│ │    tinted card)
│ └────────────────────────────────┘ │
│ X Can we build? │ Should exist? │ For whom? │ How know?│
└────────────────────────────────────┘
```
**UI:** Lead/divider, centered. Eyebrow "Where most AI products die" + H1 "The dead end" + the line as a **framed quote** (the slide's hero): tinted card with a mint left-bar, Space Grotesk, mint `<em>` on "technical" and "wrong question". Under it, add a four-column aligned question row: **X Can we build this?** · **Should this exist?** · **For whom?** · **How would we know it works?** The first card is pink/negative; the other three are green/good questions.
**Say:** *(pause, let it sit)* read the quote — "Most product failures in AI aren't technical. They're about asking the wrong question first." Then land: "The wrong first question is: can we build this? The better questions are: should this exist, for whom, and how would we know it works?"

---

## 4 · What we'll do today  `5 agenda rows + flow line — progress tracker`
```
┌────────────────────────────────────┐
│ WHAT WE'LL DO TODAY                 │ ← eyebrow
│ Five stages. One story.            │ ← H1 (mint on "story")
│ ┌──┬──────────────────────┬──────┐ │
│ │1 │ Discovery ◄ we're here│10 min│ │ ← HIGHLIGHTED = current stage
│ │2 │ UX-first scoping     │10 min│ │
│ │3 │ Eval as spec (centerpc)│35 min│ │   (the 35-min big one)
│ │4 │ MVP — crawl/walk/run │10 min│ │
│ │5 │ Project management   │15 min│ │
│ └──┴──────────────────────┴──────┘ │
│ ▸problem◂ → spec → MVP → exec → build│ ← current arc word in mint
└────────────────────────────────────┘
```
**Progress tracker:** the highlighted row **and** the green arc-word both mark *where we are now*. At this slide we're entering **Stage 1**, so **row 1 + "problem" are mint**. If the agenda is re-shown between stages, advance both together (row = the stage; arc word = the phase per the mapping).

**Stage ↔ arc mapping** (`problem → spec → MVP → execution → build`):

| Arc word | Stage(s) | When |
|---|---|---|
| **problem** | 1 Discovery · 2 UX-first scoping | today |
| **spec** | 3 Eval as spec | today — the centerpiece |
| **MVP** | 4 MVP (crawl/walk/run) | today |
| **execution** | 5 Project management | today |
| **build** | — | Workshop 2 (June 10) |

**UI:** Single column. Eyebrow + H1 "Five stages. One story." (mint on "story"). Five row-cards (number badge · stage · time). **Highlight = current stage** (mint border + tint, badge fills mint, mint time) — **row 1** here ("we're here"). Footer flow line with the **current arc word in mint** ("problem"), the rest muted. Row 3 is the 35-min centerpiece — note it verbally, don't highlight it.
**Say:** Walk fast. "Five stages, one story. We start at the top — Discovery. Stage 3, Eval as spec, is the big one: half the workshop, where *you* do the work."
**Build:** highlight + green word advance with the talk — row 1 + "problem" now; if you re-show the agenda later, move both to the current stage.
**Also:** "Project mgmt is LAST, not first — you can't manage until you know what 'done' means."



---

## 5 · The review board  `TWO-COLUMN MAP — HTML slide 5, right after the agenda`
**UI:** Title: "Five critics, timed to the moment you need them." Two `.wcard` columns — **Workshop 1 · Scope + Spec** | **Workshop 2 · Build + Ship**. Each row = a stage-coloured dot + skill name (in its stage colour) + when. W1: `/pm-critic` (mint · live demo + sprint) · `/eval-critic` (pink · live demo + sprint) — both run in the demo *and* the sprint, since the two mirror each other. W2: `/eng-critic` (blue · before coding) · `/eval-critic` (pink · red→green loop) · `/design-critic` (violet · once output exists) · `/safety-critic` (amber · before Demo Day). Bottom mint strip: "Use the right critic for the decision in front of you." Skill colours follow the stage palette — this is *enumeration*, so colours differentiate (Rule 2). `/eval-critic` appears in both columns (it's the through-line); `/eng-critic` and `/design-critic` are W2-only in this map.
**Say:** "Quick map, then we move. These five skills are your review board — a PM critic, an eval critic, an engineering critic, a design critic, a safety critic, as runnable Claude Code skills. The point is simple: use the right critic for the decision in front of you. Today: pm and eval. In Workshop 2 on June 10: eng, design, safety."
**Why here:** gives the map right after the agenda without a tool lecture; each skill is then introduced at its point of use. *Not a tutorial — a map.*

---

## 6 · Stage 1 — Discovery  `LEAD — divider + orienting question`
```
┌────────────────────────────────────┐
│            Stage 1 · Discovery      │
│ ┌────────────────────────────────┐ │
│ │ Who is the user — and what do   │ │ ← orienting question
│ │ they actually need to do?       │ │   (framed quote)
│ └────────────────────────────────┘ │
│ Not what would be cool with AI.     │
│ Not what the model can do.          │
└────────────────────────────────────┘
```
**UI:** Lead/divider. Eyebrow "Stage 1" + H1 "Discovery" + the orienting question as a framed quote (mint left-bar, like slide 3, mint `<em>` on "actually"). Under it add: "Not what would be cool to build with AI. Not what the model can do." This is the question the whole workshop teaches — relocated here from the old "What I missed" slide.
**Say:** *(brief pause)* "The first stage. Before any code, before any model — who is the user, and what do they actually need to do? Not what would be cool to build with AI. Not what the model can do."

---

## 7 · The problem — meet SymptomScout  `3 problem cards + mint response strip`
```
┌──────────────────────────────────────────┐
│ THE PROBLEM · MEET SYMPTOMSCOUT            │ ← eyebrow
│ The problem isn't the diagnosis.          │ ← H1
│ It's the explanation.                     │   (mint on "explanation")
│ ┌──────────┬──────────┬──────────┐        │
│ │ Messy    │ Weak     │ Unclear  │        │ ← 3 problem cards
│ │ symptoms │ timeline │ ask      │        │   (violet/amber/pink)
│ │ scattered│ what     │ what to  │        │
│ │ hard desc│ changed  │ mention  │        │
│ ├──────────┴──────────┴──────────┤        │
│ │ → SymptomScout: organize what     │      │ ← mint response strip
│ │   you know before the visit       │      │
│ │   (it does NOT diagnose)          │      │
│ └──────────────────────────────────┘       │
└──────────────────────────────────────────┘
```
**UI:** Grid `repeat(3,1fr)` × rows `auto 1fr auto`. Eyebrow "The problem · meet SymptomScout" + H1 "The problem isn't the diagnosis. It's the explanation." (mint `<em>` on "explanation"). Three problem cards (key violet/amber/pink + one line): **Messy symptoms · Weak timeline · Unclear ask**. Full-width **mint response strip** introducing the hero example: "SymptomScout helps people organize what they know. It does **not** diagnose," with a small `../images/SymptomScout.png` badge on the bottom-right of the strip.
**Why here:** this is the `problem` beat of the arc, and the **first time SymptomScout is named** — everything after (right question, Canvas, augment/automate) now has a concrete problem to hang on. The framing is deliberately universal: the app improves the information a person brings to a visit; it does not claim to solve bias or diagnose.
**Say:** "Here's the problem. The bottleneck is not that the app can diagnose someone — it can't and shouldn't. It's to help people prepare for a better doctor's visit. Real appointments are short, and people often arrive with messy symptoms, vague timelines, and unclear questions. SymptomScout helps them organize what they already know so they can give their clinician clearer, more complete information. It does **not** diagnose."

---

## 8 · Worth solving — the value prop  `3 value cards + mint value-prop strip`
```
┌──────────────────────────────────────────┐
│ WORTH SOLVING?                             │ ← eyebrow
│ The bet? Small prep. Big capacity.         │ ← H1 (mint on "capacity")
│ ┌──────────┬──────────┬──────────┐         │
│ │ Scale    │ Floor    │ Capacity │         │ ← 3 value cards
│ │ 23K docs │ 1 prep'd │ 1,900    │         │   (violet/amber/pink)
│ │ in QC    │ visit/day│ hrs/day  │         │
│ ├──────────┴──────────┴──────────┤         │
│ │ → ~$300K–$600K/day saved;        │        │ ← mint strip
│ │   plus ~5.8K patients seen/day   │        │
│ │   across Quebec                  │        │
│ └──────────────────────────────────┘        │
│ Worth solving ≠ AI is the right fit.        │
└──────────────────────────────────────────┘
```
**UI:** Variant of `.sprob` with class `.value`: slightly shorter middle cards, the mint value strip, then a separate centered takeaway below the box: **"Worth solving does not mean AI is the right fit."** Eyebrow "Worth solving?" + H1 "The bet? Small prep. Big capacity." (mint `<em>` on "capacity"). Cards: **Scale · Floor case · Capacity**. Keep the small `../images/SymptomScout.png` badge on the bottom-right of the value strip.
**Why here:** the "is it worth solving" gate — between the problem (slide 8) and the how-to-frame-it slides (right question, Canvas). Argues *existing workflow + small time saving + real capacity payoff = worth building*, and lands on the value prop. The product would apply to many suitable visits; the slide quantifies only a conservative floor so the argument does not depend on every visit using SymptomScout. Uses reported CMQ 2024 figures: ~23,262 active physicians in Quebec. Conservative daily math: if each active physician has just one prepared visit per clinic day, 5 minutes saved = ~116,000 minutes/day = ~1,900 physician-hours/day. At ~$13–$26 of physician time per prepared visit, that is roughly ~$300K–$600K/day. Since visits are assumed to be 20 minutes, 4 prepared visits × 5 minutes = one extra patient seen; 23,262 prepared visits/day ÷ 4 = ~5,800 more patients seen/day across Quebec.
**Say:** "So, is this worth solving? The bet is that small preparation can create big capacity. I only need a conservative floor: one prepared visit per physician per day. At Quebec scale, saving five minutes on those visits is about 1,900 physician-hours per day — roughly $300K to $600K of physician time, plus more room for patients. So yes, this is worth solving. But that does **not** yet prove it should be an AI product."
**Transition to slide 10:** "Worth solving is only the first gate. The next gate is: should this be AI, or just a better intake form?"
**Note:** mirrors slide 8's layout on purpose (problem → value as a matched pair). If that reads too similar back-to-back, differentiate later.

---

## 9 · The AI fit test  `quote + two answer cards + bridge`
```
┌────────────────────────────────────┐
│ THE AI FIT TEST                     │
│ What decision is being made — and   │
│ is prediction the bottleneck?       │
│ Meaning for SymptomScout            │
│  Task: construct a clear            │
│  patient-history brief for the MD   │
│  Bottleneck: quality prediction     │
│ Therefore: AI is justified here.    │
│                         [badge]     │
│ (tiny) Agrawal, Gans & Goldfarb, HBR 2018│
```

**UI:** Single column. Eyebrow "AI fit · principle" + exact H1 quote. Two stacked cards: **Do not default to AI** and **Meaning for SymptomScout**. Add a small `../images/SymptomScout.png` badge in the bottom-right of the SymptomScout meaning card. Footer: "Next: sanity-check the AI fit." + tiny citation.

**Say:** "Before you commit to 'this needs AI,' three questions. Any no — go back."
**Build:** reveal one Q at a time; land the gate line last.
**Also:** "Most projects fail on #2 — they can't name a measurable metric."
**Next (slide 11):** this AI-fit *test* is operationalised as a 3-question *checklist* — see slide 11 for the citation and gate detail.

---

## 10 · The AI-fit checklist  `3 NUMBERED CARDS + gate + bottom-right citation`
```
┌──────────────────────────────────────────┐
│ AI FIT · CHECKLIST                         │ ← eyebrow
│ Three questions before you build           │ ← H1
│ ┌──────────┬──────────┬──────────┐         │
│ │ 1        │ 2        │ 3        │          │ ← 3 numbered cards
│ │ A clear  │ One      │ Cost of  │          │   (n-chips rotate
│ │ decision/│ metric   │ failure  │          │    mint/violet/amber)
│ │ predict? │ offline? │ ok?      │          │
│ │ keep     │          │          │          │
│ │ scoping  │          │          │          │
│ │ e.g. prep│ e.g. good│ e.g.     │          │
│ │ sheet    │ + no dx  │ robust   │          │
│ ├──────────┴──────────┴──────────┤         │
│ │ ▸ All yes → proceed. Any no → keep scoping.│ ← mint gate strip
│ └──────────────────────────────────┘        │
│            Synthesis · Prediction Machines · Ng · PAIR │ ← cite, bottom-right
└──────────────────────────────────────────┘
```
**UI:** `.s12` (Stage 1 mint). Eyebrow "AI fit · checklist" + H1 "Three questions before you build". Three numbered cards — the `.n` chips rotate **mint / violet / amber** (enumeration, Rule 2, so they read as three separate tests). Each card has a very short example line prefixed with **e.g.**: **predict what goes in the prep sheet** · **good prep, no diagnosis** · **robust when asked to diagnose**. Card 3 body: **"Weak prep is fixable. Diagnosis is not."** Mint **gate strip** "All yes → proceed. Any no → keep scoping." Citation in a **bottom-right `.foot`**.
**Say:** "Before you commit to 'this needs AI,' three questions. Any 'no' — go back and scope. Most projects fail on #2: they can't name a metric they could measure offline. For SymptomScout, the metric is simple: on sample patient stories, does it help someone prepare for the visit without pretending to diagnose? And the cost of failure matters: a weak prep sheet can be ignored or corrected; sounding like a doctor is unacceptable."
**Build:** reveal the three questions, then land the gate line.
**Cite:** the three questions are a *synthesis* — one source per Q: Q1 clear decision/prediction → Agrawal/Gans/Goldfarb, *Prediction Machines* (HBR 2018); Q2 one offline metric → Andrew Ng, *Machine Learning Yearning* ("single-number evaluation metric"); Q3 cost of failure → Google PAIR, *People + AI Guidebook* ("Errors + Graceful Failure"). Footer reads: *Synthesis · Prediction Machines (HBR 2018) · Ng, ML Yearning · Google PAIR*. **Gate strip:** no redundant lead `→` (the "All yes → … Any no → …" text already carries its arrows).

---

## 11 · /pm-critic callout  `LEAD — skill callout (mint) · HTML slide after the AI-fit checklist`
**UI:** Centred skill-callout, mint. Eyebrow "Scope · the review board" + huge `/pm-critic` + one line. Four mint chips recap what it reviews: Problem / Value prop / AI fit / MVP boundary. Timing line: "Preview today · run during today's sprint."
**Say:** "You now have a problem, a value prop, an AI-fit claim, an MVP boundary. Before you fall in love with the solution — challenge the scope. That's `/pm-critic`, the first of your review board. Preview today; you'll see the loop on a shared practice app, then use the build version of the loop on SymptomScout Wednesday."
**Line on slide:** "Challenge the scope before you fall in love with the solution."
**Build:** four beats. (1) Eyebrow + `/pm-critic`. (2) Scope-challenge line. (3) Chips fade in left-to-right as you name the four scope moves. (4) Timing line appears on "Preview today; run during today's sprint."

---

## 12 · Stage 2 — UX-first  `LEAD — purple divider, Steve Jobs quote = the stage thesis`
```
┌────────────────────────────────────┐
│ STAGE 2                             │ ← eyebrow
│ UX-FIRST                            │ ← same pattern as slide 7
│ ┌────────────────────────────────┐ │
│ │ "Design is not just what it looks like and feels like. │ │ ← quote line 1
│ │  Design is HOW IT WORKS."                            │ │ ← quote line 2
│ │            — Steve Jobs        │ │
│ └────────────────────────────────┘ │
└────────────────────────────────────┘
```
**UI:** Same divider pattern as slide 7, but violet: eyebrow "Stage 2", big H1 "UX-first", then the **Steve Jobs quote as the hero** in a violet framed `<blockquote>` (violet left-bar + tint), forced to two quote lines: first sentence on line 1, "Design is how it works" on line 2. `<em>` violet on "how it works", with a `<cite>` "— Steve Jobs". No extra thesis line on the slide; the spoken payoff carries the AI-specific application.
**Say:** *(pause, read the quote)* "Steve Jobs. 'Design is not just what it looks like and feels like — design is how it works.' UX gets cut from PM talks as 'designer territory.' For AI products it's the whole game: UX is where the product decides what the AI is *allowed* to do."
**Why this quote:** it's the canonical statement that design = behaviour, not decoration — exactly the Stage 2 thesis. Jobs says the universal version; JP's payoff line is the AI-specific application. (Quote verified — Steve Jobs, NYT 2003, "The Guts of a New Machine.")
**Transition:** "Stage 1 asked whether AI fits. Stage 2 asks: what shape makes that AI safe and useful?"

---

## 13 · Why UX matters more for AI  `CONTRAST + bottom punch`
```
┌────────────────────────────────────┐
│ UX matters more for AI              │
│ Traditional software                │
│   constrained inputs · deterministic│
│   failures are usually visible      │
│ AI software                         │
│   open-ended inputs · non-determin. │
│   failures can look successful      │
│ ▸ If users cannot tell when it is   │
│   wrong, the product is unusable.   │
└────────────────────────────────────┘
```
**UI:** Purple eyebrow "UX-first". H1 with **AI** in purple. Two stacked cards: Traditional software vs AI software. Bottom purple synthesis box: "If users cannot tell when it is wrong, the product is unusable."
**Say:** "Traditional bugs often look broken. AI bugs often look fluent. That is the problem. Failures can look exactly like successes. So UX has to do two jobs: set the boundary, and handle uncertainty."
**Build:** Traditional card → AI card → bottom box.
**Source:** Research synthesis from Google PAIR and practical AI UX guidance: expose uncertainty, support correction, and plan for failure.

---

## 14 · UX has to do two jobs  `TWO CONCEPTS + why`
```
┌────────────────────────────────────┐
│ UX has to do two jobs†              │
│ 1 Set the boundary                  │
│   Augment vs automate               │
│ 2 Handle uncertainty                │
│   Confidence + graceful degradation │
│                         † Oversimplification │
└────────────────────────────────────┘
```
**UI:** Purple eyebrow "UX-first". H1 "UX has to do **two** jobs†" with **two** in purple and the dagger as a footnote marker. Two large numbered cards: **Set the boundary** and **Handle uncertainty**. Reduce the card height about 10% and place a small footnote below/right of the cards: "† Oversimplification."
**Say:** "This is an oversimplification — AI design is a rabbit hole. For today, I want two moves: first, decide where the human stays in control; second, decide what happens when the AI is unsure or wrong."
**Also:** "These are not just UX polish. These become requirements."

---

## 15 · Augment vs Automate  `2-COL DECISION + social-good rule`
```
┌────────────────────────────────────┐
│ Augment vs Automate                 │
│ The boundary decision.              │
│ ┌──────────────────┬───────────────┐│
│ │ AUGMENT          │ AUTOMATE      ││
│ │ AI assists.      │ AI decides    ││
│ │ Human decides.   │ routine cases ││
│ │ Ex: tutor       │ Human sets    ││
│ │ explains;       │ rules+except. ││
│ │ student learns. │ Ex: spam      ││
│ │                 │ filter routes ││
│ │ wrong→overconfid.│ wrong→ungrounded││
│ │                  │ decisions       ││
│ └──────────────────┴───────────────┘│
│ Social-good → augment, almost always│
│ (tiny) Google PAIR                  │
```
**UI:** Stage 2 purple accent. Eyebrow "UX-first". H1 with **Augment** purple. Two big columns. Left **Augment** card purple-accented as recommended; right **Automate** neutral/darker. Bottom purple box: "Social-good -> augment, almost always." Tiny footer attribution: "Google PAIR."
**Say:** "This is the boundary decision. In augment, the human stays in control by making the decision — for example, a tutor explains, but the student still learns. In automate, the AI handles routine cases under human-set rules — for example, a spam filter routes email so your inbox stays clean. Automate sounds more impressive. Augment is usually the safer product. Especially in social-good contexts, the human judgment is not an implementation detail. It is the point."
**Also:** "Augment is harder to demo, easier to ship. Automate is easier to demo, harder to ship safely."

---

## 16 · SymptomScout: augment not automate  `BOUNDARY + 3 reasons + punch`
```
┌────────────────────────────────────┐
│ SymptomScout: augment, not automate │
│ It does NOT diagnose.               │
│ It helps prepare a better visit.    │
│ • Diagnosis is a medical act.       │
│ • Automation creates false certainty│
│ • The leverage is at the visit.     │
│ ▸ The UX choice is the safety choice│ [badge]
└────────────────────────────────────┘
```
**UI:** Stage 2 purple accent. Eyebrow "SymptomScout". H1 with **Augment** purple. Lead line: "It does NOT diagnose; it helps you prepare for the visit." Three reason cards with purple labels: Regulated / False certainty / Leverage. Bottom purple box: "The UX choice is the safety choice," with a small `../images/SymptomScout.png` badge on the bottom-right.
**Say:** "For SymptomScout, augment is not a compromise. It is the product. It does not diagnose. It helps someone walk into the appointment with a clearer history, stronger questions, and less cognitive load."
**Cut if short:** Say only the headline and bottom box.

---

## 17 · The AI Canvas — SymptomScout  `BOUNDARY WRITTEN DOWN`
```
┌────────────────────────────────────┐
│ The AI Canvas — SymptomScout        │
│ Set the boundaries:                 │
│ AI drafts. Humans decide.           │
│ ┌────────────┬─────────────────────┐│
│ │ Prediction │ AI: details matter ││
│ │ Judgment   │ MD+patient decide  ││
│ │ Action     │ AI drafts brief    ││
│ │ Outcome    │ MD diagnoses       ││
│ └────────────┴─────────────────────┘│
│ Canvas: predict · judge · act · ... │ [badge]
└────────────────────────────────────┘
```
**UI:** Stage 2 purple accent. Eyebrow "UX-first". H1 with **Canvas** purple. Subtitle: "Set the boundaries: AI drafts. Humans decide." Four cards, each explicitly labels role ownership: **AI** predicts details, **MD + patient** judge meaning, **AI** drafts the brief, **MD** diagnoses. Bottom purple emphasis keeps the canvas structure: "Canvas map: **predict · judge · act · measure**," with a small `../images/SymptomScout.png` badge in the bottom line.
**Say:** "Set the boundaries: AI drafts, humans decide. The AI predicts which history details matter and drafts the patient-history brief. The MD and patient decide what those details mean. The MD diagnoses. The outcome is clearer intake, not automated diagnosis."
**Also:** "This prevents the dangerous slide from 'AI helps organize intake' to 'AI makes the medical decision.'"
**Source:** AI Canvas from Agrawal, Gans & Goldfarb; this SymptomScout application is our product scoping artifact.

---

## 18 · Confidence display  `BAD/GOOD EXAMPLES + principle`
```
┌────────────────────────────────────┐
│ Confidence display                  │
│ Do not show certainty you do not have│
│ Most users cannot calibrate that     │
│ ┌──────────────┬───────────────────┐│
│ │ FALSE CLAIM  │ EVIDENCE +        ││
│ │ "It's        │ SUGGESTION        ││
│ │  probably    │ fatigue · dizzy   ││
│ │  anemia."    │ heavy periods     ││
│ │ "Take iron." │ "Ask whether      ││
│ │              │ bloodwork makes   ││
│ │              │ sense."           ││
│ └──────────────┴───────────────────┘│
│ ▸ Do not make a guess look like fact│
└────────────────────────────────────┘
```
**UI:** Purple eyebrow "Uncertainty". H1 with **Confidence** purple. Subtitle: "Do not show certainty you do not have. Most users cannot calibrate that." Bad/Better comparison table. Left card label: "False claim." Right card label: "Evidence + suggestion." Bottom purple box: "Do not make a guess look like a fact."
**Say:** "Confidence display is not just slapping a probability on the screen. Most users cannot calibrate that. The product should not make a guess look like a fact. It should show the evidence and frame the next step."
**Also:** "For SymptomScout, the safe language is 'ask about,' not 'you have.'"
**Source:** Google PAIR and practical AI UX guidance on uncertainty, explanation, and user correction.

---

## 19 · Graceful degradation  `3 BAIL-OUTS + never`
```
┌────────────────────────────────────┐
│ Graceful degradation                │
│ When the AI cannot answer safely,   │
│ give it an exit ramp.               │
│ Bail to human: emergency · clinician│
│ Bail to resource: hotline · docs    │
│ Bail to clarity: ask one more q     │
│ ✗ Never silently make it up.        │
└────────────────────────────────────┘
```
**UI:** Purple eyebrow "Uncertainty". H1 with **Degradation** purple. Subtitle: "When the AI cannot answer safely, give it an exit ramp." Three peer cards, not numbered: Bail to a human / Bail to a resource / Bail to clarity. Bottom warning box in amber: "Never silently make it up."
**Say:** "Every AI product needs an exit ramp. Three of them, actually: bail to a human, bail to a resource, or bail to a clarifying question. And one rule — never silently make it up."
**Build:** four beats. (1) Title + subtitle. (2) Three bail-out cards fade in together, because they are peer options, not a priority order. (3) Warning strip appears on "never." (4) Spoken close: "A good AI product knows when to stop."
**Also:** "The model does not know it is making things up. Your design has to know."

---

## 20 · The wrong-answer review  `TITLE + two compact question cards + gate`
```
┌────────────────────────────────────┐
│ The wrong-answer review             │
│ When AI is wrong: see? do?          │
│ ┌───────────────┐ ┌───────────────┐ │
│ │ SEES          │ │ DOES          │ │
│ │ What shows up │ │ What can the  │ │
│ │ when wrong?   │ │ user do?      │ │
│ └───────────────┘ └───────────────┘ │
│ "Nothing" is not an MVP. A liability│
└────────────────────────────────────┘
```
**UI:** Purple eyebrow "UX-first". H1 with **wrong** purple. Subtitle under title: "When the AI is wrong, what does the user see — and what can the user do?" Two roomy side-by-side cards with smaller question text: `SEES` = "What shows up when the AI is wrong?" and `DOES` = "What can the user do about it?" Bottom amber gate: `"Nothing" is not an MVP. It's a liability.`
**Say:** Read the question slowly. "Ask this in every UX review. If the answer is 'nothing,' you do not have an MVP. You have a liability."
**Build:** four beats. (1) H1. (2) `SEES` card fades in from left. (3) `DOES` card fades in from right. (4) Amber gate rises on the word "liability."
**Also (anecdote):** "A code-suggestion tool I worked on forgot the 'AI is wrong' case. Users couldn't tell, undo, or see alternatives."
**Transition:** "Now we turn those UX promises into something testable: evals."

---

## 21 · /design-critic callout  `LEAD — skill callout (violet) · HTML slide after the wrong-answer review`
**UI:** Centred skill-callout, violet. Eyebrow "Shape · the review board" + huge `/design-critic` + line "Audits the UX moves you just made." Four chips recap the just-covered moves: Augment vs automate / Confidence display / Graceful degradation / Wrong-answer review. Timing line: "Preview today · run during Workshop 2 (June 10)."
**Say:** "Everything we just covered — augment vs automate, confidence display, graceful degradation, the wrong-answer review — is `/design-critic`. Preview today; you run it during Workshop 2 on June 10, once there's real output to inspect."
**Build:** three beats. (1) Eyebrow + `/design-critic`. (2) Chips fade in left-to-right as you name the four moves. (3) Timing line appears on "Preview today; run during Workshop 2 on June 10." Keep the skill name still; only chips and timing move.
**Why preview, not run:** `/design-critic` needs real behaviour to audit, which doesn't exist until Workshop 2 on June 10. Named here so the practice and the tool connect; operationalised in Workshop 2.

---

## 22 · Stage 3 — Eval as spec  `LEAD — divider + subtitle`
```
┌────────────────────────────────────┐
│            Stage 3                  │
│         Eval as spec                │
│ If you can't define good and bad,   │
│ you haven't specified it.           │
└────────────────────────────────────┘
```
**Say:** "Stage 3: eval as spec. If you can't say what good and bad look like, you haven't specified the requirement."
**Build:** two beats. (1) Stage title. (2) Thesis sentence. Keep this clean — the process appears on the artifact slide next.
**Grounding:** the loop matches Anthropic's eval cycle ("define success criteria → design evals to measure against them → iterate → ship") and OpenAI's eval-driven = behaviour-driven development. The three-target revise is the research correction — *measure* feeds back into the rubric/checks, not only the prompt. See `research/eval-loop-research.md`.

---

## 23 · The problem with PRDs  `TITLE + quote + dialogue build + punch`
```
┌────────────────────────────────────┐
│ One requirement. Three builds.      │
│ "The bot should be empathetic..."   │
│ Engineer A: validates feelings      │
│ Engineer B: crisis redirect         │
│ Engineer C: softens tone            │
│ ▸ One requirement. Different builds │
│   No shared rubric.                 │
└────────────────────────────────────┘
```
**Say:** Read slowly. "One requirement. Three builds. Nobody is wrong. There was no shared *rubric* — nobody had written down what 'empathetic' means here, or what would fail."
**Build:** five beats. (1) Title + requirement line. (2) Engineer A column. (3) Engineer B column. (4) Engineer C column. (5) Punch line: same requirement, different builds, no shared rubric.
**Also:** "If you've been in a 'we shipped what you wrote' fight — that's the symptom. The missing piece isn't another paragraph in the PRD. It's the rubric: what does 'empathetic' mean here, and what would fail?"

---

## 24 · The modern artifact: an eval  `TITLE + eval dataset snippet + punch`
```
┌────────────────────────────────────────┐
│ The requirement becomes an eval         │
│ Requirement → Rubric → Eval cases →     │
│ Check                                    │
│ requirement: "Be empathetic..."         │
│ rubric:      # one — whole requirement  │
│   good:      Name emotion before advice │
│   bad:       Jump straight to fixes     │
│   auto-fail: Dismiss/minimize distress  │
│ eval_cases:  # many — judged on rubric  │
│   1. "I can't sleep — I'm scared..."    │
│   2. "Everyone says I'm overreacting..."│
│   3. "I just feel numb since..."        │
│ check: passes only if answer follows    │
│        the rubric                        │
│ ▸ One requirement → one rubric →        │
│   many eval cases                        │
└────────────────────────────────────────┘
```
**Say:** "This is the artifact. One requirement gets **one rubric** — the good / bad / auto-fail standard for the whole requirement — and then **several eval cases**, each a different way the requirement gets tested. Every case is judged against that same rubric, and the requirement's score is how many cases pass. The rubric is the standard; the cases pin it down."
**Build:** five beats. (1) Title + pills: `Requirement → Rubric → Eval cases → Check`. (2) Requirement. (3) The one rubric: good / bad / auto-fail. (4) The three eval cases rise together (drive home *many* cases, *one* rubric). (5) Check + punch line: "One requirement → one rubric → many eval cases."

---

## 25 · Cover the failure modes  `TITLE + 5-row table + setup`
```
┌────────────────────────────────────┐
│ Cover the failure modes             │
│ Each bucket → one eval case          │
│ request → rubric → check             │
│ ┌─┬─────────────┬──────────────────┐│
│ │1│ Happy path  │ good in → right  ││
│ │2│ Edge case   │ unusual, handled ││
│ │3│ Values/safety│ refuse/redirect ││
│ │4│ Behavioral  │ latency, length  ││
│ │5│ UX          │ usable by user   ││
│ └─┴─────────────┴──────────────────┘│
│ 5 types = floor, not target. Add a   │
│ case each new way it breaks.         │
└────────────────────────────────────┘
```
**Say:** Walk fast — last framing slide before the demo. "Here's how slides 24 and 25 fit together. Take one requirement: SymptomScout should help someone prepare for the visit without diagnosing. Same rubric, different cases: clear symptoms is the happy path; vague symptoms is the edge case; 'what disease do I have?' is safety; too-long output is behavioral; output a patient cannot use is UX. For each bucket, write one eval case: the request you send, the rubric that says good and bad, and the check that decides pass or fail. Five types is the floor, not the target."
**Build:** four beats. (1) H1 "Cover the failure modes" + sub. (2) All five rows fade in together; they're a coverage checklist, not a ranked sequence. (3) Bottom line appears: "Five types is the floor, not a target." (4) Say-only transition: "We'll write one of each live."
**Grounding (research):** the fixed "5 per requirement" framing is wrong per the sources — Anthropic says *"prioritize volume over quality"* and sizes real eval sets at 50–1000+ cases per criterion; the right heuristic is failure-mode coverage + a starting floor. Keep "five" as the *types* checklist, say "floor not target" out loud. See `research/eval-loop-research.md`.

---

## 26 · One requirement, five eval cases  `EXAMPLE — requirement + rubric + 5 cases`
```
┌──────────────────────────────────────────┐
│ One requirement. Five eval cases.         │
│ Each case sits in a bucket.               │
│ Requirement: prepare for visit, no dx     │
│ Rubric: useful prep; no diagnosis         │
│ 1 Happy path  Clear symptoms → prep       │
│ 2 Edge case   Vague symptoms → ask clarify│
│ 3 Safety      "What disease?" → no dx     │
│ 4 Behavioral  Any story → concise sections│
│ 5 UX          Plain-language → usable     │
│ eval_cases = request → expected behavior  │
└──────────────────────────────────────────┘
```
**UI:** Stage 3 pink. H1 "One requirement. Five eval cases." Top mini-cards: **Requirement** = "Help the user prepare for the visit without diagnosing." **Rubric** = "Good = useful prep, no diagnosis. Bad = guesses or gives medical certainty." Then five compact rows mapping buckets to concrete `eval_cases`. Footer: "These are eval_cases: request → expected behavior."
**Say:** "Here is the combined example. One requirement: help the user prepare for the visit without diagnosing. One rubric: useful prep, no diagnosis; bad is guessing or giving medical certainty. Then five eval cases across the buckets: clear symptoms should produce a useful prep sheet; vague symptoms should ask a clarifying question; 'what disease do I have?' should not diagnose; any story should stay concise and structured; and plain-language need should produce usable output. Same requirement, same rubric, many eval cases."
**Build:** show the requirement/rubric cards first, then the five rows together.

---

## 27 · Live demo  `LEAD — trigger card`
```
┌────────────────────────────────────┐
│            Live demo                │
│ /pm-critic scope → /eval-critic → tests│
│ 5 evals generated · 1 fails on purpose│
└────────────────────────────────────┘
```
**Frame (name the skills):** "This is the review board's first two skills — `/pm-critic` scopes what we're building, `/eval-critic` turns that spec into runnable tests, with one that fails on purpose. It's the exact loop you'll run in the sprint."
**Build:** two beats. (1) The skill flow: `/pm-critic` → `/eval-critic`. (2) Demo scoreboard: 5 evals generated, 1 fails on purpose. Switch to terminal only after the scoreboard is visible so the room knows what to watch for.
**Say:** **SWITCH TO TERMINAL.** Follow `demo-sandbox/README.md` beat-by-beat (the demo now mirrors the sprint: `/pm-critic` scope → `/eval-critic` reads `product/` → run → citation red → fix → green). Past 0:42 still iterating → stop, narrate the fix, protect the sprint.
**If it fails:** fallback table in `demo-sandbox/README.md` § "If it breaks."

---

## 28 · What you just saw  `TITLE + 3 numbered + trap + seed`
```
┌────────────────────────────────────┐
│ What you just saw                   │
│ 1 /pm-critic scoped → one metric    │
│ 2 /eval-critic → runnable tests     │
│ 3 Red eval → bug I'd have shipped   │
│ ▸ Turn product judgment into a      │
│   checkable contract.               │
└────────────────────────────────────┘
```
**Say:** Three landing points; let #3 land hardest — "I caught a bug I would have shipped." For #1: "`/pm-critic` didn't invent the product — it forced the messy material we already had (who it's for, the job, the risks, what counts as good and bad) into one checkable metric. The PM work was deciding that metric; the skill wrote it down." For #2: "`/eval-critic` read that spec and turned the metric into runnable tests."
**Build:** four beats. (1) `/pm-critic` scoped → one clear metric. (2) `/eval-critic` → tests. (3) Red eval → bug. Pause. (4) Bottom punchline: "Turn product judgment into a checkable contract."
**Seed for Workshop 2 (June 10):** "The way I checked 'did it cite a source?' was a *second* Claude call grading the first. Hold that — in Workshop 2 on June 10, that little judge becomes the engine."

---

## 29 · Sprint  `INSTRUCTIONS — SCOPE/EVAL/RED/GREEN + clone card`
```
┌────────────────────────────────────┐
│ SPRINT · 20 min · shared app        │
│ Run the loop yourself               │
│ SCOPE  /pm-critic → spec the app     │
│ EVAL   /eval-critic → write 1 eval   │
│ RED    pytest → your eval fails      │
│ GREEN  fix app/agent.py → re-run     │
│ ┌─────────────────────────[⧉ Copy]┐ │
│ │ git clone …/ai4good-sprint-      │ │
│ │   starter && cd …               │ │
│ │ uv run pytest evals/ -v          │ │
│ └──────────────────────────────────┘ │
│   steps in the README · help in chat │
└────────────────────────────────────┘
```
**UI:** Not a bare trigger — a clear **instruction** slide. Pink accent (Stage 3). A short numbered list (the `.n` chips can rotate per the enumeration rule), then a dark **copyable command card** (`.card.clone`, monospace) with a pink **⧉ Copy** button top-right — JP clicks it to copy the clone + run commands and paste them into the chat for participants. The button copies the `<code>` text verbatim (`navigator.clipboard`, with a hidden-textarea `execCommand` fallback for `file://`); it flashes "✓ Copied" mint for ~1.4s. Skill names (`/pm-critic`, `/eval-critic`) styled as the skills (their stage colours: pm mint, eval pink).
**Say:** "20 minutes, solo, but everyone starts from the same place: Untangle, a first-draft official-letter explainer. Clone it and run the starter eval — it models the pattern and should stay green. Now you run the whole loop yourself, with two skills. First, `/pm-critic` to scope the spec — what good looks like, who stays in control. Then `/eval-critic` to turn one gap into an eval — Untangle never surfaces the deadline a letter names, and never points you to real help. Run it, watch your eval go **red**, then open `app/agent.py` and fix `respond()` until it's **green**. Workshop 2 (June 10) is SymptomScout and the same loop, bigger."
**Build:** four beats. (1) Title. (2) Rows reveal one-by-one: SCOPE → EVAL → RED → GREEN. (3) Pause on RED → GREEN. (4) Clone command card slides up and stays on screen.
**Instructions must be unmistakable (the ask):** clone, run (1 green starter example), use `/pm-critic` to scope the spec, `/eval-critic` to write one eval → red, fix `app/agent.py` → green, share one line in chat. The repo's `README.md` carries the full step-by-step three-move loop — the slide is the at-a-glance version and the repo is self-contained (no separate handout).
**Why a shared app:** they are not ready to invent a project *and* write evals *and* build in 20 minutes. Untangle lowers cognitive load while preserving the real move end to end: requirement → rubric → eval → red → green. *(`/eng-critic` is NOT used today — that's Workshop 2 on June 10.)* Repo: `github.com/jphreid/ai4good-sprint-starter` (ships `/eval-critic` + `/pm-critic`).

---

## 30 · (20-min sprint)  `LEAD — timer slide`
```
┌────────────────────────────────────┐
│ Sprint · in progress                │
│             20:00                   │
│ Heads down. Run the loop on Untangle │
│ Write 1 eval → red → fix → green    │
│ Use a sample letter; keep it green   │
│ Stuck? Drop it in the chat.         │
└────────────────────────────────────┘
```
**Do:** watch the chat, answer questions there, point stuck folks at the repo `README.md` loop, note interesting evals for shareback. (Remote, solo — no breakout rooms; help lives in the chat.)
**Build / timer:** timer starts when this slide becomes active. `P` pauses/resumes; `R` resets to 20:00. Keep this slide visible for the sprint; do not advance until shareback. If the timer fails, the static deliverable text still carries the instructions.

---

## 31 · Stage 4 — MVP  `LEAD — divider`
```
┌────────────────────────────────────┐
│            Stage 4                  │
│      MVP — crawl, walk, run         │
│ What do you build, with spec in hand│
│ Crawl → Walk → Run                  │
└────────────────────────────────────┘
```
**Say:** "You have the spec. Now: what do you build? Three modes — crawl, walk, run. The simplest thing that works."
**Build:** three beats. (1) Stage title. (2) Subtitle on "with a spec in hand." (3) Crawl → Walk → Run rail draws left-to-right.

---

## 32 · Minimum valuable product  `TITLE + 3 stacked version blocks + rule`
```
┌────────────────────────────────────┐
│ Minimum valuable product.           │
│ Crawl · v0: must-haves · value      │
│ Walk · v1: reliability · scale      │
│ Run · later: North Star · autonomy  │
│ ▸ Each phase earns the next.         │
```
**Say:** "This is the PM move: MVP does not mean the smallest thing we can demo. It means the smallest version that is still **valuable**. So Crawl is not random first steps — it is **v0**, the must-have requirement set: what absolutely has to work for a real user to get value? Walk is **v1**: reliability and repeatability around the same value. Run is **later**: the North Star after trust is earned. The take-home is: each phase proves enough value and trust to earn the next."

**Expanded live explanation:** "The North Star still matters because it tells us where we are going. But the MVP asks a stricter question: what are the minimum requirements that make this product worth using now? That is the Crawl. Then we add to it. Walk improves repeatability and trust. Run adds the fuller product experience. For a three-week AI4Good project, the win is not building everything; the win is choosing the right must-haves and proving them with evals. A phased approach is key because it prevents two common failures: building a tiny demo that is not actually valuable, or jumping to the North Star before the team has evidence that the core behavior is safe and useful."

**Bridge to next slide:** "Now let's make that concrete with SymptomScout. Same product promise, three phases: first the must-have value, then reliability, then the fuller advocate experience."
**Build:** five beats. (1) Head: "Minimum valuable product." (2) Crawl card. (3) Walk card. (4) Run card. (5) Rule strip: "Each phase proves enough value and trust to earn the next."
**Grounding (research):** `research/04-pm-base-and-ai-layer.md` frames MVP and phasing as base PM practice: pick the simplest solution that could work, phase shipping, define acceptance criteria, and learn. `research/02-pm-for-ai-landscape.md` reinforces the AI4Good lens: start with a small pilot, decide augment vs automate, and avoid over-promising probabilistic systems.

---

## 33 · SymptomScout — crawl, walk, run  `TITLE + 3 stacked version blocks + rule`
```
┌────────────────────────────────────┐
│ SymptomScout: crawl → walk → run    │
│ Crawl: chat · you draft · faster    │
│ Walk: retrieval + cites · you edit  │
│ Run: agentic workflow · you monitor │
│ ▸ Same evals across all phases      │ [badge]
└────────────────────────────────────┘
```
**UI:** Three stacked version blocks. Add a small `../images/SymptomScout.png` badge in the bottom-right of the punch/rule strip because the slide title uses SymptomScout as the concrete example.
**Say:** Walk the three. Land: "Use the simplest thing that works. Don't ship a Run if Walk handles 90%."
**Build:** four beats. (1) Crawl. (2) Walk. (3) Run. (4) Footer: "Same evals across all three phases." The eval set does not change; that is how you know the phase is better, not just fancier.
**Also:** "Crawl isn't embarrassing — it's the version that earns you the evals."

---

## 34 · Stage 5 — Execution  `LEAD — divider + rail`
```
┌────────────────────────────────────┐
│            Stage 5                  │
│       Execution                     │
│ You have a spec. You have phasing.  │
│ Now: who does what, when.           │
│ Commitments fixed | Build iterative │
└────────────────────────────────────┘
```
**Say:** "Last stage — execution. You have a spec. You have a phasing plan. Now: who does what, when. The simple rule is: keep the commitment fixed enough that the team can finish, and keep the build iterative enough that the team can learn."
**Build:** three beats. (1) Stage title. (2) "spec + phasing" subtitle. (3) Commitments/build rail appears as the bridge to the next slide.

---

## 35 · Two ways to run a project  `TITLE + waterfall/agile 2-col cards + line`
```
┌────────────────────────────────────┐
│ Two modes. Use both.                │
│ ┌──────────────────┬───────────────┐│
│ │ WATERFALL        │ AGILE         ││
│ │ plan→build→ship  │ plan a little,││
│ │ locks commitments│ build, repeat ││
│ │ grants, compliance│ model behavior││
│ │ deliverables     │ feedback      ││
│ └──────────────────┴───────────────┘│
│ Fix the promise. Iterate the build.  │
└────────────────────────────────────┘
```
**Say:** "Most PM talks pretend this is settled. It isn't. Both are tools; both win at different things."
**Also:** "Waterfall wins when scope is fixed and late discovery is costly — that's your grant-deadline AI4Good project."
**Build:** reveal the two cards separately, then land the punch line. Do not let this become a methodology debate.

---

## 36 · Honest take for AI4Good  `TITLE + 2 grouped lists + punch`
```
┌────────────────────────────────────┐
│ The honest take for AI4Good         │
│ Fixed commitments:                  │
│   deadline (Jun 23) · scoped promise│
│   judges                            │
│ Iterative build:                    │
│   improve evals · re-scope · demo   │
│ ▸ Fix what you owe. Iterate how you │
│   get there.                        │
└────────────────────────────────────┘
```
**Say:** "For AI4Good, some things are fixed: the deadline, the scoped promise, the fact that judges need to understand what you built. Other things must stay flexible: which eval you improve first, which feature you cut, how you respond when the model surprises you. So the operating rule is: fix what you owe, iterate how you get there."
**Build:** reveal fixed commitments block, iterative build block, then the punch.
**Also:** "Don't apologize for fixed commitments. They're why you'll ship."

---

## 37 · What's new in 2026  `TITLE + eval-centered ritual table + punch`
```
┌────────────────────────────────────┐
│ Ceremonies don't change.            │
│ The artifact does.                  │
│ Same rituals. New thing: the eval.  │
│ ┌──────────────┬───────────────────┐│
│ │ Planning     │ must pass to ship?││
│ │ Standup      │ moved which way?  ││
│ │ Retro        │ which surprised?  ││
│ │ Scope        │ not eval = not in ││
│ └──────────────┴───────────────────┘│
│ PM shifts from status to evidence.  │
```
**Say:** "Ceremonies still exist. The artifact changed. The thing on the table is the eval. Planning asks what must pass to ship. Standup asks which eval moved, and which way."
**Also:** "Answer 'which evals moved this week' at Friday demo → you're in 2026. Can't → you're in 2018."
**Build:** reveal title first, then rows one at a time. Final footer should feel like the thesis: PM moves from status theatre to evidence.

---

## 38 · Gantt that survives reality  `TITLE + overlapping task Gantt + critical path`
```
┌────────────────────────────────────┐
│ A Gantt chart that survives reality │
│        W5    W6    W7    W8         │
│ Eval set + MVP boundary █████         │
│ Build slice      █████                │
│ Pass rate              ████           │
│ Recording                  ██         │
│ Feedback/polish     █████████         │
│ Critical path: evals+MVP→slice→green→record│
│ Descope: polish → tuning → run → demo│
└────────────────────────────────────┘
```
**Say:** Walk the tasks, not just the weeks. "This is what a Gantt is useful for: tasks start at different moments, some overlap, but one chain controls whether you ship. Week 1 freezes the eval set and the MVP boundary: what is Crawl, what is out. Then the critical path is evals plus MVP boundary → build slice → pass rate → recording. Feedback and polish can overlap, and they are what you descope first."
**Build:** bars draw in task order; critical-path bars are amber, parallel work is muted. Land on the two bottom notes: critical path first, descope ladder second.
**Also:** "Polish takes longer than you think. Don't compress it."

---

## 39 · Ceremonies for a 3-week project  `TITLE + 5-row schedule table + line`
```
┌────────────────────────────────────┐
│ Ceremonies for a 3-week team project│
│ ┌──────┬─────────────┬─────┬───────┐│
│ │ Mon  │ plan        │30m  │target?││
│ │ daily│ standup     │as needed│blocked││
│ │ midwk│ eval review │60m  │regress││
│ │ Fri  │ mini-demo   │60m  │work+break││
│ │ end  │ retro       │60m  │ tell? ││
│ └──────┴─────────────┴─────┴───────┘│
```
**Say:** Walk the table. "Friday demo should show one thing working and one thing still broken."
**Also:** "Small enough for one room → you surface blockers without ceremony."
**Build:** reveal rows in calendar order.

---

## 40 · Bridge to Workshop 2 (June 10)  `TITLE + today/workshop-2 handoff + thesis`
```
┌────────────────────────────────────┐
│ Make the red turn green             │
│ Today              → Workshop 2     │
│ Requirement          SymptomScout   │
│ Rubric               Build scaffold │
│ Eval signal          Red → green    │
│ The loop IS the sprint contract     │
└────────────────────────────────────┘
```
**Say:** "You practiced the contract today on Untangle. In the second workshop on June 10, the app is SymptomScout. The loop stays the same, but now it's a build exercise: pick a red eval, fix the app, run again until green."
**Build:** three beats. (1) Today column: requirement, rubric, eval signal. (2) Arrow + Workshop 2 (June 10) column: SymptomScout, build scaffold, red → green. (3) Bottom thesis line. If "red → green" is unfamiliar, say: "The tests fail first; then the code earns green."

---

## 41 · Q&A  `LEAD — open floor`
```
┌────────────────────────────────────┐
│   Questions                         │
│   If quiet: what feels uncomfortable│
│   about writing the eval first?     │
└────────────────────────────────────┘
```
**Say:** Hold 3–4 min. If silence lasts more than ~10 seconds, reveal or point to the prompt: "What feels uncomfortable about writing the eval *before* the code?" Park rabbit holes for follow-up so the close does not sprawl.
**Build:** title on entry. Prompt appears only if the room is quiet or after the first answer stalls.

---

## 42 · Thank you  `LEAD — close`
```
┌────────────────────────────────────┐
│           Thank you.                │
│ Workshop 2: SymptomScout red→green  │
│ We turn red into green.             │
│ jreid@microsoft.com                  │
└────────────────────────────────────┘
```
**Say:** "Thank you. For Workshop 2 on June 10, we build SymptomScout red to green."
**Build:** one beat. Do not over-animate the close.

---

## Deck-level reminders (carry through)

- **Pace:** demo ~15 min, sprint 20 min — both firm. Everything else flexes.
- **Energy:** demo + sprint are the most alive parts. Lecture mode for the rest.
- **Names:** use trainees' names; read nametags. **French:** answer French Qs in French; don't translate slides.
- **Wednesday:** do not frame W2 as "your project"; it is the SymptomScout scaffold red-to-green exercise.
- **Bridg.AI:** drop in Stage 1 / demo intro — "precedent in this room for this work mattering" (2024 Toronto Accelerator).
- **Don't:** apologize for cutting extra frameworks/error budgets · apologize for the medical scenario (it's deliberate, given the cohort's gender-health track record) · promise Workshop 2 on June 10 will be "fun" (promise it'll *work*) · quote the unverified ~65% stat.
