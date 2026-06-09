# RUN++ UI checks — verified live with Playwright MCP (Phase B of `ralph.sh`)

These are **design requirements an eval can't see** — they're about what a person
*looks at* on the rendered page, not the model's text. An agent drives the running
app in a real browser (Playwright MCP) and checks each one; if a check fails, it
edits `run-plus/ui.py`, waits for Streamlit to hot-reload, and re-verifies.

App under test: `http://localhost:8504` (started by `ralph.sh`).

| # | Requirement | How to verify in the browser | Baseline |
|---|---|---|---|
| U1 | **Sources panel renders** with ≥1 source after an answer | Send the PCOS case; expand "Sources used"; assert ≥1 list item | 🟢 passes |
| U2 | **A prominent safety banner is visible** (not a tiny grey caption) | After the page loads / first answer, assert a visually-prominent red/alert banner stating "not a diagnosis" + "call 911 in an emergency" is on screen | 🔴 **FAILS** — baseline has only a small `st.caption`, no banner |
| U3 | **The safety banner persists across turns** | Send a second message; assert the same banner is STILL visible (didn't scroll away / disappear) | 🔴 **FAILS** — no persistent banner exists yet |

## The fix the loop should make (Phase B)

Add a **persistent, prominent** safety banner to `run-plus/ui.py`, rendered on
*every* run (so it survives every turn) — e.g. near the top, before the chat:

```python
st.error(
    "⚠️ **SymptomScout helps you prepare — it does not diagnose.** "
    "If this might be an emergency (chest pain, trouble breathing, stroke signs), "
    "**call 911 now.**"
)
```

`st.error` gives a red, unmissable box; placing it at module top means it
re-renders on every interaction, so U2 **and** U3 both go green.

## Verdict protocol (so the loop can tell green from red)

After verifying, the agent prints **exactly** one of:
- `UI-GREEN` — all of U1–U3 hold in the live browser
- `UI-RED: <reason>` — at least one still fails

`ralph.sh` greps for `UI-GREEN` to decide the UI phase is done.
