# RUN++ — the autonomous harness loop (Clip A9 + A10, for real)

This is **SymptomScout's most capable tier ("run") plus extra features**, wired so an
agent fixes its own **red evals by itself** — the harness running itself, end to end.
It's the runnable version of the two W2 clips:

- **Clip A9** — the autonomous text loop (pytest → fix → green)
- **Clip A10** — Playwright verifying the *rendered* UI (design, made checkable)

…combined into one script: **`./ralph.sh`**.

## What's planted (so the loop has work)

Reset to the baseline (`./reset.sh`) and you start with **3 reds**:

| Eval | Kind | Why it's red on the baseline | The fix the loop makes |
|---|---|---|---|
| `test_conditions_have_citations` | text (pytest + Opus judge) | SYSTEM prompt has no "cite a source" rule | adds the citation rule to `agent.py` |
| `test_conditions_are_severity_tagged` | text | SYSTEM has no "tag 🟢/🟡/🔴" rule | adds the severity rule to `agent.py` |
| U2/U3 safety banner | **UI (Playwright MCP)** | `ui.py` has only a tiny grey caption — no prominent, persistent banner | adds `st.error(...)` banner to `ui.py` |

*(Severity is the guaranteed red; citations is usually red because the agent voluntarily
cites only some conditions via PubMed — the judge asks for a source for* every *suggested
condition. Either way the loop closes whatever's red.)*

## Run it

```bash
cd symptomscout-versions          # uv env, .env (ANTHROPIC_API_KEY), knowledge/ live here
./run-plus/reset.sh               # restore the planted bugs
./run-plus/ralph.sh               # watch the agent drive red → green
```

Needs: `ANTHROPIC_API_KEY` in `../.env`, the `claude` CLI signed in, and `npx`
(for Playwright MCP — auto-downloads Chromium on first run).

## What you'll see (it's printed as it happens)

```
PHASE A · TEXT EVALS   pytest → 3 passed, 2 failed
  → claude reads the failure, edits agent.py's SYSTEM prompt (one rule)
  → pytest → green. The ratchet holds.
PHASE B · UI EVALS     app starts on :8504
  → claude opens a real browser (Playwright), sends the PCOS case,
    sees no safety banner, edits ui.py, reloads, re-verifies → UI-GREEN
```

- **Phase A** restricts the agent to `Read`+`Edit` (bash owns pytest) — fast, clean, can't wander.
- **Phase B** uses `--permission-mode bypassPermissions` so the Playwright + edit calls run
  hands-free for the recording (local sandboxed app only).

## Files

- `agent.py` / `ui.py` — the run++ app (pristine baselines in `.pristine/`, restored by `reset.sh`)
- `evals/test_evals.py` — the 5 text evals (3 green / 2 red on baseline)
- `evals/ui_checks.md` — the Playwright UI requirements + the verdict protocol (`UI-GREEN`)
- `.mcp.json` — Playwright MCP (the browser the agent drives in Phase B)
- `ralph.sh` — the two-phase autonomous loop · `reset.sh` — restore the planted bugs

## Recording the clips

Run `./reset.sh` then `./ralph.sh` with the terminal (and, in Phase B, the Chromium
window) on screen. Speed up the pytest/judge waits in edit; keep the red→green flips and
the browser-driving full-speed. A9 = Phase A; A10 = Phase B. Narration is in
`../../demo-runsheet.md` (clip shot-lists). Reset after.

> Simpler text-only variant (no UI/Playwright) for the scaffold's citation eval:
> `Building ML Apps/scaffold/scripts/ralph.sh`.
</content>
</invoke>
