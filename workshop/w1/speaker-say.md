# Workshop 1 — Speaker "Say" notes

Use these as spoken beats: each bullet should sound natural if said out loud, but short enough to glance at without reading a script.

---

### 1 · Title — Product Management for AI

- Welcome. This is *Product Management for AI*, the first of two connected sessions.
- The promise today is simple: how do you know your idea is good before you ask an LLM to build it?
- In the LLM era, the hard part is not writing code; it is knowing what to build and how to tell if it works.

### 2 · About me — JP Reid

- Quickly about me: I'm a Principal Product Manager at Microsoft, and I productize agentic harnesses for enterprise.
- I became a PM by accident; I'm here for innovation, and what I came to realize is that PM is how you do it without wandering.
- I've had many false starts, which is why this session starts before code.
- By the end, you should have one artifact: a working first app, the artifacts that built it, and the human plus Claude skills to do it again.

### 3 · The dead end

- Most AI products do not die because the model cannot produce text. They die much earlier, at the starting line.
- The wrong question is: can we build this?
- The better questions are: should this exist, for whom, and how would we know it works?
- So we start there: not with the model, not with the code, but with the question.

### 4 · Five stages. One story.

- Here is the map for the next 90 minutes: Discovery, UX-first scoping, Eval as spec, MVP, and Execution.
- The big one is Stage 3, Eval as spec, because that is where the idea becomes checkable.
- The order matters: you cannot manage the work until you know what done means.
- Right now we are in Discovery, so we start with the problem before we touch tools.

### 5 · The review board — five critics

- Across the two workshops, you will use five Claude Code critics.
- Think of them as a review board for the product: a PM critic, an eval critic, an engineering critic, a design critic, and a safety critic.
- Today we use the PM critic and the eval critic. You will see both in the live demo, then run both yourself in the sprint.
- In Workshop 2 on June 10, we add engineering, design, and safety. The point is simple: use the right critic for the decision in front of you.

### 6 · Stage 1 — Discovery

- Stage 1 is Discovery.
- The question is: who is the user, and what do they actually need to do?
- Not what would be cool to build with AI. Not what the model can do.
- The real human job comes first, because a useful AI product starts with a workflow, not with a model capability.

### 7 · The problem — meet SymptomScout

- Our running example is SymptomScout.
- The problem is not diagnosis; the problem is the explanation someone brings into the appointment.
- ==It is to help people prepare for a better doctor's visit.==
- ==People arrive with symptoms that are messy, timelines that are weak, and questions that are unclear.==
- SymptomScout helps them organize what they already know before the visit. It does not diagnose.
- The leverage is improving the conversation between the person and the MD, not replacing the MD.

### 8 · Worth solving?

- So, is this worth solving? The bet is that small preparation can create big capacity.
- I only need a conservative floor: one prepared visit per physician per day.
- At Quebec scale, saving five minutes on those visits is about 1,900 physician-hours per day.
- That is roughly 300 to 600 thousand dollars of physician time, plus more room for patients.
- So yes, this is worth solving.
- But worth solving does not mean AI is the right fit.

### 9 · The AI-fit test

- The question is: what decision is being made, and is prediction the bottleneck?
- For SymptomScout, the task is building a patient-history brief for the doctor.
- The hard part is deciding which details matter and how to organize them. That is a prediction problem, so AI is a reasonable fit here.
- The key is not to default to AI just because the problem matters.

### 10 · AI-fit checklist

- Before you build, ask three questions.
- First, is there a clear decision or prediction? If you cannot say it in one sentence, keep scoping.
- For SymptomScout, the prediction is what to include in the prep sheet.
- Second, is there one metric you can measure offline? No metric means no progress signal.
- For SymptomScout, the metric is simple: on sample patient stories, does it help someone prepare for the visit without pretending to diagnose?
- Third, is the cost of failure acceptable? A weak explanation is one kind of risk; pretending to diagnose is a very different one.
- For SymptomScout, the acceptable failure is a weak prep sheet that the person can ignore or correct. The unacceptable failure is sounding like a doctor.
- If all three are yes, proceed. If any answer is no, the idea needs more scoping before implementation.

### 11 · /pm-critic

- This is where `/pm-critic` enters.
- It challenges the problem, the value proposition, the AI fit, and the MVP boundary before you fall in love with the solution.
- That matters because scope mistakes get more expensive after the first demo starts to work.
- We preview it now, you will use it in today's sprint, and the same scoping move carries into Workshop 2.

### 12 · Stage 2 — UX-first

- Stage 2 is UX-first.
- Steve Jobs' line is the thesis: design is how it works.
- For AI, UX is not decoration. It defines what the AI is allowed to do, what the user sees, and what happens when the model is wrong.
- In a probabilistic system, UX is part of the safety layer.

### 13 · UX matters more for AI

- Traditional bugs often look broken. AI bugs often look fluent.
- That is the problem: traditional software is mostly deterministic; AI software is non-deterministic, and its failures can look exactly like successes.
- If users cannot tell when the system is wrong, the product is unusable no matter how impressive the model sounds.
- So UX has to do two jobs: set the boundary, and handle uncertainty.

### 14 · UX has to do two jobs

- This is an oversimplification — AI design is a rabbit hole.
- For today, I want two moves.
- First, set the boundary: augment versus automate. Where does the human stay in control?
- Second, handle uncertainty: what happens when the AI is unsure or wrong?
- These are not polish. They become requirements, and later they become evals.

### 15 · Augment vs Automate

- This is the boundary decision.
- In an augment product, the AI assists and the human decides.
- Example: a tutor explains, but the student still learns.
- In an automate product, the AI decides routine cases, but the human still controls the rules, thresholds, and exceptions.
- Example: a spam filter routes email so the inbox stays clean.
- Used wrong, automate creates ungrounded decisions.
- Automate often sounds more impressive, but augment is usually safer, especially in social-good contexts.
- Human judgment is not an implementation detail here; it is the point.
- Augment can be harder to demo, but it is easier to ship responsibly.

### 16 · SymptomScout — augment, not automate

- For SymptomScout, augment is not a compromise. It is the product.
- It does not diagnose. It helps someone walk into the appointment with a clearer history, stronger questions, and less cognitive load.
- That boundary matters because diagnosis is regulated, automation creates false confidence, and the leverage is at the visit.
- In this case, the UX choice is the safety choice.

### 17 · The AI Canvas — SymptomScout

- Set the boundaries: AI drafts, humans decide.
- The AI predicts which patient-history details matter and drafts the brief.
- The MD and patient decide what those details mean.
- The MD diagnoses. The outcome is clearer intake, not automated diagnosis.
- The canvas matters because it prevents the dangerous slide from "AI helps organize intake" to "AI makes the medical decision."

### 18 · Confidence display

- Confidence display is not just putting a probability on the screen. Most users cannot calibrate that.
- The product should not make a guess look like a fact.
- The bad version says, "You probably have anemia. Take iron."
- The better version shows the evidence and frames the next step: "These symptoms are worth asking about bloodwork."
- For SymptomScout, the safe language is "ask about," not "you have."

### 19 · Graceful degradation

- Every AI product needs an exit ramp. Really, it needs three.
- It can bail to a human, like a clinician or support person.
- It can bail to a trusted resource, like a hotline or official document.
- Or it can bail to clarity by asking one more question instead of guessing.
- The rule is simple: never silently make it up. A good AI product knows when to stop.

### 20 · The wrong-answer review

- For every feature, ask the wrong-answer review.
- When the AI is wrong, what does the user see, and what can the user do?
- "Sees" is how the failure appears. "Does" is the recovery path.
- If the answer is nothing, you do not have an MVP; you have a liability.
- This is the bridge from UX promises to evals.

### 21 · /design-critic

- Everything we just covered is what `/design-critic` audits.
- It looks at augment versus automate, confidence display, graceful degradation, and the wrong-answer review.
- Design choices only matter if they survive contact with real output.
- We preview this critic today, but you run it in Workshop 2 once SymptomScout has behavior to inspect.

### 22 · Stage 3 — Eval as spec

- Stage 3 is the heart of the workshop: eval as spec.
- The thesis is that requirements become useful only when they define good and bad.
- If you cannot define good and bad, you have not specified the requirement.
- This is how product judgment becomes buildable.

### 23 · One requirement. Three builds.

- Take a requirement that sounds clear: "The bot should be empathetic with users in distress."
- Three engineers could build three reasonable versions: one validates feelings, one redirects to crisis support, and one softens the tone.
- Nobody is obviously wrong.
- The requirement failed because there was no shared rubric.
- Another paragraph in the PRD does not fix that. You need to define what good, bad, and auto-fail mean.

### 24 · The requirement becomes an eval

- This is the artifact: requirement, rubric, eval cases, check.
- One requirement gets one rubric: good, bad, and auto-fail.
- Then you create many cases that test that requirement from different angles.
- Every case is judged against the same rubric, and the requirement's score is how many cases pass.
- The rubric is the standard. The cases make it hard to fool yourself.
- For example: requirement, "prepare for the visit without diagnosing." Same rubric, different cases: clear symptoms, vague symptoms, "what disease do I have?", too-long output, or output a patient cannot use.

### 25 · Cover the failure modes

- This is the last framing slide before the demo.
- Do not ask, "How many tests do we need?" Ask, "How can this break?"
- Start with five failure-mode buckets: happy path, edge case, values and safety, behavior, and UX.
- Those five examples from the last slide map directly to the buckets.
- For each bucket, write one eval case: the request, the rubric, and the pass/fail check.
- Five types are the floor, not the target. Add a case every time you find a new way the product breaks.

### 26 · One requirement, five eval cases

- Here is the combined example.
- One requirement: help the user prepare for the visit without diagnosing.
- One rubric: useful prep, no diagnosis; bad is guessing or giving medical certainty.
- Then five eval cases across the buckets.
- Clear symptoms should produce a useful prep sheet. Vague symptoms should ask a clarifying question. "What disease do I have?" should not diagnose.
- Any story should stay concise and structured. Plain-language need should produce usable output.
- Same requirement, same rubric, many eval cases.

### 27 · Live demo — /pm-critic + /eval-critic

- Now watch the loop happen.
- `/pm-critic` scopes SymptomScout into a checkable metric, and `/eval-critic` turns that spec into runnable tests.
- We will generate five evals, and one fails on purpose: citations.
- That failure is the point. It proves the eval set is not documentation; it catches a bug before users do.
- Now I am going to switch to the demo repo.

### 28 · What you just saw

- Three things happened in the demo.
- First, `/pm-critic` did not invent the product; it forced messy material into one clear metric.
- Second, `/eval-critic` turned that metric into runnable tests.
- Third, a red eval caught a bug I would have shipped.
- That is the move: product judgment became a checkable contract.
- Hold onto the judge piece too, because in Workshop 2 that becomes part of the build engine.

### 29 · Run the loop yourself

- Now it is your turn. You have 20 minutes on Untangle, a shared official-letter explainer.
- The loop is the same: `/pm-critic` scopes the spec, `/eval-critic` writes one eval, pytest goes red, and then you fix `app/agent.py` until it goes green.
- The reason we use a shared app is that you should not have to invent a project and learn evals at the same time.
- The goal is the loop.
- The clone command is on screen, the full steps are in the README, and help is in the chat.
- Keep the starter example green while you add your own red-to-green case.

### 30 · 20-minute sprint

- The timer is running. Work on Untangle.
- Pick one synthetic letter from `data/`, write one eval, watch it fail, fix the app, and re-run until it passes.
- The lesson is not the specific letter. The lesson is requirement, rubric, eval, red, green.
- Use both critics, and if you are stuck, drop it in the chat.

### 31 · Stage 4 — MVP

- You now have a spec, so the next question is: what do you build?
- The answer is not "everything." The answer is crawl, walk, run.
- Start with the simplest thing that works, because the impressive thing you cannot validate is not useful yet.

### 32 · Minimum valuable product

- Here, MVP means minimum valuable product, not minimum demo.
- Crawl is v0: the must-have requirements that create real user value now.
- Walk makes that same value more reliable and repeatable.
- Run is the North Star after trust is earned.
- Each phase proves enough value and trust to earn the next.
- For a three-week project, the win is choosing the right must-haves and proving them with evals.

### 33 · SymptomScout — crawl, walk, run

- For SymptomScout, the same promise has three phases.
- Crawl is plain chat: the human drafts, and you ship when it is faster than before.
- Walk adds retrieval and citations: the human edits, and you ship when evals beat v0.
- Run is an agentic workflow: the human monitors, and you ship when failures are boring.
- The important part is that the same evals carry across all three phases.
- That is how you know the product got better, not just fancier.

### 34 · Stage 5 — Execution

- The last stage is execution.
- You have a spec and a phasing plan.
- Now the question is who does what, when.
- The operating rule is to keep the commitment fixed enough that the team can finish, and keep the build iterative enough that the team can learn.

### 35 · Two modes. Use both.

- Most PM talks pretend waterfall versus agile is settled. It is not.
- They are both tools.
- Waterfall locks commitments, which is useful for grants, compliance, deadlines, and deliverables.
- Agile absorbs discovery, which is useful for model behavior, feedback, and unknowns.
- AI4Good needs both. Fix the promise, and iterate the build.

### 36 · The honest take for AI4Good

- For AI4Good, some things are fixed: the deadline, the scoped promise, and the fact that judges need to understand what you built.
- Other things must stay flexible: which eval improves first, which feature gets cut, and how you respond when the model surprises you.
- Fixed commitments are not the enemy. They are why you ship.
- Fix what you owe; iterate how you get there.

### 37 · Ceremonies don't change. The artifact does.

- The rituals still exist. The artifact changed.
- The thing on the table is now the eval.
- Planning asks which evals must pass to ship.
- Standup asks which eval moved and which way.
- Retro asks which eval surprised us.
- Scope asks whether the feature is in the eval set.
- That is the shift: PM work moves from status theatre to evidence.

### 38 · A Gantt that survives reality

- Here is what that looks like in a short project.
- This is what a Gantt is useful for: tasks start at different moments, and some overlap.
- Week 1 freezes the eval set and the MVP boundary: what is Crawl, and what is out.
- Then one chain controls whether you ship: evals plus MVP boundary, build slice, pass rate, recording.
- Feedback and polish can run in parallel, but they are not the critical path.
- If you are behind, descope polish first, then tuning, then run, and only then fall back to a retrieval-only demo. Preserve the proof.

### 39 · Ceremonies for a 3-week project

- On Monday, pick the eval target.
- Daily, unblock that target.
- Midweek, review what regressed.
- Friday, demo one thing working and one thing still broken.
- At the end, run a retro on what the evals revealed.
- Small rituals are enough if they surface the blockers without eating the project.

### 40 · Bridge to Workshop 2

- Today, you practiced the contract on Untangle: requirement, rubric, eval signal.
- In Workshop 2, the app is SymptomScout and the task is red to green.
- The loop stays the same, but now it becomes a build exercise.
- If red to green is new language: the tests fail first, and then the code earns green.

### 41 · Questions

- Let's pause for questions.
- If the room is quiet, the question I want to leave you with is: what feels uncomfortable about writing the eval before the code?
- That discomfort is useful, because it points at the habit we are trying to change: building first and specifying later.

### 42 · Thank you

- Thank you.
- Workshop 2 is June 10.
- We take SymptomScout through the same loop and turn red into green.
- We turn the contract into a working build.
- You can reach me at jreid@microsoft.com.
