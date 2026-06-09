# Workshop 2 — Speaker notes (what to say, per slide)

Natural spoken beats for `workshop2-slides.html`, one block per slide (18 total). **Co-led:** **[JP]** drives slides 1–15, **[Rohan]** drives 16–18 (his own failure/demo slides run live between 16 and 17; slide 18 is an optional A10 clip placeholder); JP & Rohan close verbally. Say it like a person — these are beats, not a script. Companion files: storyboard `slides-with-notes.md` (UI/Build cues), live detail `demo-runsheet.md`. One deliberate pause is marked ⏸; one clip cue is marked ▶.

**House style:** warm, plain, encouraging — the room is ~100 trainees four weeks into ML. Treat ML basics as known; PM/evals/agents/harness as new. "Trainees," never "students." Don't re-teach W1 (confidence display, graceful degradation, augment-vs-automate, SEES/DOES, "failures look like successes") — name them as known.

---

## ACT 0 — Open (JP, 0:00–0:03)

### 1 · Title  **[JP]**
"Welcome back. June first was Product Management *for* AI — we scoped a product and wrote the evals. Today is the other half: we take those evals and build an app until they go green, and then — the harder part — we make the result something a real person can actually use. And I'm not doing the second half alone. Rohan D'Souza, a senior UI designer I work with at Microsoft, joins us from Toronto for the design block. Quick agenda, then we're hands-on-the-keyboard fast."

### 2 · Where we left off  **[JP]**
"One sentence carries across both days. June first: *a requirement becomes checkable through a rubric and an eval* — if you can't say what good and bad look like, you haven't actually specified it. Today is the literal next clause of that sentence. We drive an app from red to green against those evals — and then we ask the question evals alone don't answer: it passes the test, fine, but can a frightened person in a waiting room *use* it? *(beat on the strip)* The eval set is the contract we carry across both days. We don't invent new requirements today."

### 3 · What today is  **[JP]**
"The shape — and the thesis on the slide: *green isn't done*. I take the first half — about fifteen minutes on the harness, which is just the structure around the model, then twelve minutes turning a failing test green, live. But the moment that test goes green, Rohan takes over — because a passing test and an app a frightened person can actually use are two different things. He takes the next thirty: designing for the fact that the model is sometimes wrong, with a live UI build of his own. We close together in five. Questions the whole way through, time protected at the end. This is a *led* demo: watch us drive it, then you fork the repo and drive it yourself."

---

## ACT 1 — Harness theory (JP, 0:03–0:18)

### 4 · Theory divider  **[JP]**
"Fifteen minutes of theory — and I promise we use every bit of it in the demo right after. Five ideas, and one picture to hold them together: we're going to build a *kitchen*. Last workshop's punchline was *evals are the spec*; this is the machine that runs on that spec. Here they are *(gesture at the five)* — chef versus kitchen, durable state and the ratchet, the generator-evaluator split, workflow versus agent, and evals as the contract."

### 5 · Chef vs kitchen  **[JP]** · *kitchen anchor*
"Idea one — the picture that holds the next fifteen minutes together. Your model — Claude — is the *chef*. Genuinely brilliant. But you rent it by the hour, it cooks only what's in front of it, and it forgets the whole kitchen between shifts — stateless, and out of the box it knows nothing about *your* project. The *kitchen* is everything around the chef: the pantry of tools, the prep counter where today's context sits, the expediter that runs the loop, the **tasting station** — those are your evals — and the plating, the UI the patient actually sees. *(point at the small lines)* And see the little line on each card? That's where it shows up in the apps you'll fork — most of this *turns on* as you go crawl, walk, run; the chef's there from the start, the loop only shows up at run. The chef you already have; this whole workshop is about building the *kitchen*. So: **those are the kitchen's parts — the next four ideas are the *principles* for running it well.**"

### 6 · Why the harness matters  **[JP]**
"To make that concrete: open Claude, type 'build me SymptomScout.' It'll try — and you'll get something smart and completely unusable. Why? It doesn't know what *good* means for this app, where files belong, which tools exist, or what you decided last week. *(walk the rows)* Each of those gaps has a home in the harness — and a place in the kitchen. *Good* means the evals — that's the tasting station. File conventions live in CLAUDE-dot-md — the **house rules**, how this kitchen runs and where everything goes. Tools are declared in mcp-dot-json — that's the pantry. Decisions live in the repo — the recipe box. The harness is just *where you write all of that down* so the model can act on it."

### 7 · Durable state + context-reset  **[JP]**
"Idea two — first of the four principles: every session starts *blank* — the model does not remember yesterday. Remember the chef forgets the kitchen between shifts? This is that. So if your app's reality lives only in the chat, you'll re-explain it forever — and worse, it'll happily rebuild what you already built. The fix is boring and powerful: the kitchen keeps *books*. Push everything that matters to disk — conventions, tests, tools, decisions. Then a brand-new *build session* opens the repo, reads the books, and is caught up. In all three apps it's the *same repo* — crawl, walk, and run all read it; run just adds the eval suite. That's durable state — and notice it's *context resets*, not compaction. Fresh start, every shift, by design."

### 8 · The ratchet  **[JP]**
"Second half of idea two: the ratchet — and it's about how you *build*. A green eval stays green. Every new feature has to pass the *whole* suite, not just its own test — so you never win a new requirement by quietly breaking an old one. That's exactly why the *same* evals gate crawl, walk, and run: a new phase only ships if it still passes everything the last one did. *(then the kitchen)* Like a dish that's cleared the tasting station — cleared for good. *(beat)* Here's the test: if a new change can break a passing eval without anyone noticing, you don't have a ratchet — the suite is what notices. In about ten minutes you'll watch it happen: I turn one eval green, and the other four don't move."

### 9 · Generator / evaluator split  **[JP]**
"Idea three — the single strongest move, and back to the kitchen: the chef doesn't taste their own plate. There's a separate taster on the pass. Don't let the thing that *builds* also be the thing that *grades*. The generator — Sonnet — *cooks* SymptomScout's answer. The evaluator — Opus, a different and stronger model — is the *taster*: it decides if it's good, and votes several times so the verdict is stable. A model grading its own homework always gives itself an A; a separate taster doesn't. In your scaffold that taster is the `judge()` function — Opus, grading the Sonnet it's checking; that's the run version, where the evals live. *(note: generator's in blue, evaluator's in violet — that's not an accident, that's the two halves of today.)*"

### 10 · ▶ Clip A9 — autonomous loop  **[JP]**
▶ *Play the clip; narrate over it.* "Watch — this is the loop you're about to see me run by hand, except I'm not typing. It picks the red eval, reads the judge's reason, edits the prompt, re-runs, and stops when it's green. That's the harness running *itself*. The community calls it the Ralph loop — run the agent in a loop until it's done — and credit there goes to Geoffrey Huntley, not Anthropic. We'll do the slow, manual version in a minute so you see every step."

### 11 · Workflow vs agent  **[JP]**
"Idea four, and it's the choice that defines your app — in kitchen terms, a fixed *prix-fixe menu* versus a chef who *improvises* off whatever's in the pantry. A *workflow* runs the model down a path *you* fixed in advance — predictable, cheap, easy to test. An *agent* decides its own steps and which tools to call — flexible and powerful, but harder to debug and to evaluate. The rule: use the simplest thing that works. Most production AI is a workflow with one or two agent escape hatches. And this is exactly crawl-walk-run: crawl and walk are one-shot workflows; run is where it becomes an agent — the loop that *chooses* to reach into the pantry for PubMed."

### 12 · Evals are the contract  **[JP]**
"Idea five ties the other four together — and it's the tasting station one more time. A taster is useless without a *standard*: what does a good plate actually taste like? You agree that *before service*, not mid-rush. That standard is `evals-slash-evals.py`, the same shape you wrote June first — and the *same five evals* gate all three apps, crawl through run; the term for it, *sprint contract*, is Anthropic's. The discipline that matters: we invent *no new requirements* today. The evals are the spec; we build until they're green — and the citation eval is the one I'm about to turn green live. That's the contract carried across both workshops."

### 13 · Where is the harness?  **[JP]**
"One picture before we go live — because the demo could *look* like 'he edited a prompt and a test passed,' and it's much more than that. Here's every piece — its name in the kitchen, and where it actually lives in the repo: the standard card is the eval file; the cook is the app prompt plus Sonnet; the taster is `judge()` on Opus; the recipe box is the files on disk; the one-way pass — the ratchet — is pytest going four to five and *staying* there; and the kitchen at work — the loop, red, fix, green — is what I'm about to run. *(land it)* You rent the chef; you *build the kitchen*. The model is the part you don't control — the harness is the part you do. And it runs at two scales: right now I'm running *one* harness — Claude Code plus the evals — to build *another*, the app's own. Same pattern both times. Let's go to the terminal."

---

## ACT 2 — Live crawl→walk (JP, 0:18–0:30) · *drive from `demo-runsheet.md`*

### 14 · Live: the harness, by hand  **[JP]** · LIVE
*Kick off `pytest` during slide 13's last line so it's finishing as you arrive. Drive the three steps; the slide rail is just the room's anchor while pytest runs (~75s).*
"Step one — run the contract. *(while it runs)* Some of these checks are fuzzy — 'does every condition cite a source?' isn't a keyword match — so a second model judges it. That's the split: Sonnet wrote the answer, Opus grades it, five times, majority vote. *(result)* Four green, one red. It suggests the right conditions, escalates a real emergency, refuses to prescribe, answers fast — but it doesn't cite sources. I'd have shipped this; it *reads* fine. The eval caught it. Step two — read the failure, then add *one line* to the contract the generator reads, the system prompt. Step three — re-run. *(green)* Green. And the other four didn't budge — that's the ratchet."

### 15 · The baton  **[JP → Rohan]** ⏸
*The hinge. Show a real walk answer with the citation buried. The slide's accent flips blue→violet as you say 'Rohan.'*
"So it cites sources now — the test is green. But look at the answer. *(point at the buried 'Source:')* The citation is right there, buried in a wall of text. A scared person in a waiting room will *never* find it. Passing the test made it *true*; it didn't make it *usable*. ⏸ *(let it sit a beat)* That's not an engineering problem anymore. It's a design problem. Rohan —"

---

## ACT 3 — Design for uncertainty (Rohan, 0:30–1:00) · *new ground, not W1 — Rohan brings his own slides; this deck keeps the framing + the `/design-critic` payoff*

### 16 · Design goal — make it work better  **[Rohan]**
"Thanks JP. The model cites a source now — that's the engineering win; we made it *work*. My half is making it *work better*: whether a frightened person actually *uses* it, doubts it in the right places, or gets misled by it. Steve Jobs put it best — *design is not just what it looks like and feels like; design is how it works.* That's the bar. You built the foundations June first — confidence as framing, graceful degradation, augment versus automate; I go one layer past those, into the failures that live in the *interface*, not the model. I name those as known and keep moving. From here my own slides take you through the failures and a live UI build — then we land on the rubric."

### 17 · /design-critic — design has a rubric too  **[Rohan]** · LIVE · his close (or hands to A10)
"One more symmetry to close the loop. JP had an eval that says what 'good' means for the *model*. Design has the same thing — a rubric. `/design-critic` audits the bare UI against five checks. Two of them — confidence display, graceful degradation — you already know from June first, so I'll just name them. I'll spend the time on the new three: plain language, accessibility, humane refusal. *(run it)* Watch it fail a bare UI on exactly these three — plain language, accessibility, humane refusal — and notice it cites PAIR and Microsoft HAX. Design isn't vibes. It's checkable, just like the evals."

### 18 · ▶ Clip A10 — Playwright UI-check  **[Rohan]** · PLACEHOLDER (optional)
▶ *Optional closing clip — JP to record; Rohan's call whether to play it. If skipped, slide 17 is the close.* "An eval checks the *text*. This checks what the *person actually sees* — sources panel renders, the safety line never scrolls away, an emergency is impossible to miss. Design properties, verified automatically — the same red-to-green discipline, pointed at the interface."

*Pause: ⏸ slide 15 (the baton, after "never find it"). Clips: ▶ slide 10 (A9, autonomous loop) · ▶ slide 18 (A10, Playwright UI-check — optional placeholder, JP to record). Live blocks (14, and `/design-critic` on 17) follow `demo-runsheet.md` exactly — these notes are the *spoken* layer over that sheet. Rohan's own design + walk→run live beats live in his deck.*
</content>
</invoke>
