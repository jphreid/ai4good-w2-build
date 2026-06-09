#!/usr/bin/env bash
# ralph.sh — the AUTONOMOUS harness loop on RUN++ ("Ralph loop"; community / G. Huntley).
#
# This is the whole red→green discipline, run by the machine, in two phases:
#
#   PHASE A — TEXT EVALS (pytest + Opus judge)
#     loop: pytest → read the failure → claude -p edits agent.py's SYSTEM prompt
#           → re-run → stop when green.   (the harness is this bash loop)
#
#   PHASE B — UI EVALS (Playwright MCP, live browser)
#     start the app → claude -p drives http://localhost:8504 with Playwright,
#     verifies the design requirements in evals/ui_checks.md, edits ui.py to fix
#     the missing safety banner, and re-verifies in the real browser → UI-GREEN.
#
# Everything it does is printed as it happens, so it reads on camera (Clip A9+A10).
#
# Usage:    ./ralph.sh [MAX_TEXT_ITERS]      (default 6)
# Reset:    ./reset.sh                       (restore the planted bugs first)
# Needs:    ANTHROPIC_API_KEY in ../.env · `claude` CLI · `npx` (for Playwright MCP)
#
# Run from the run-plus/ directory.

set -uo pipefail
cd "$(dirname "$0")" || exit 1
HERE="$PWD"                     # absolute run-plus/ dir — for locating narrate.py after subshell cds
ROOT="$(cd .. && pwd)"          # symptomscout-versions/ — where uv + .env + knowledge live
PORT=8504
# Mode: default = Phase A (text loop) then Phase B (UI loop). Each phase is also a
# stand-alone clip — A9 is the text loop, A10 is the design loop — so either runs solo:
#   ./ralph.sh        full run (A + B)
#   ./ralph.sh a      Phase A only — the A9 text loop  (self-priming; no reset.sh needed)
#   ./ralph.sh b      Phase B only — the A10 design loop  (self-priming; no reset.sh needed)
MODE="full"
case "${1:-}" in
  a|A|--phase-a|phase-a) MODE="a"; shift ;;
  b|B|--phase-b|phase-b) MODE="b"; shift ;;
esac
MAX="${1:-6}"
SHOT_DIR="/tmp/ralph-shots"     # Playwright MCP writes screenshots here (--output-dir, user-scope config)

# ── pretty printing ──────────────────────────────────────────────────────────
b()  { printf '\n\033[1;36m%s\033[0m\n' "$*"; }      # cyan bold — section banner
ok() { printf '\033[1;32m%s\033[0m\n' "$*"; }        # green
red(){ printf '\033[1;31m%s\033[0m\n' "$*"; }        # red
dim(){ printf '\033[2m%s\033[0m\n' "$*"; }           # dim
say(){ printf '\033[0;33m   %s\033[0m\n' "$*"; }     # yellow — narration

PYLOG="$(mktemp)"
APP_PID=""
cleanup(){
  # stop the demo app QUIETLY — no job-control "Terminated" line on screen at the end
  [ -n "$APP_PID" ] && kill "$APP_PID" 2>/dev/null
  lsof -ti tcp:"${PORT}" 2>/dev/null | while read -r p; do kill "$p" 2>/dev/null; done
  rm -f "$PYLOG"
}
trap cleanup EXIT INT

# one yellow narration line for an actor in the loop
role(){ printf '   \033[1;33m%s\033[0m\n' "$*"; }

cat <<'BANNER'

  ╔══════════════════════════════════════════════════════════════╗
  ║   RALPH LOOP · RUN++                                          ║
  ║   harness = this loop   generator = claude -p                 ║
  ║   evaluator = pytest (text) + Playwright MCP (UI)             ║
  ╚══════════════════════════════════════════════════════════════╝
BANNER
say "The agent fixes its own red evals. I am not typing. Watch the terminal."
printf '\n'
dim "  WHO'S WHO in this loop:"
role "🔁 HARNESS    = this bash loop — picks the next red, decides red vs green"
role "✍️  GENERATOR  = claude — reads the failure and makes ONE small fix"
role "🧪 EVALUATOR  = pytest + Opus judge (text)  ·  a real browser (UI) — the judge"

# ══════════════════════════════════════════════════════════════════════════════
# PHASE A — TEXT EVALS   (skipped in Phase-B-only mode — A9 is the text loop)
# ══════════════════════════════════════════════════════════════════════════════
if [ "$MODE" = "b" ]; then
  b "PHASE-B-ONLY · the text loop is the A9 clip — opening straight into the design loop"
  cp .pristine/agent-green.py agent.py   # proven text-GREEN baseline → polished responses
  cp .pristine/ui.py          ui.py      # the safety-banner bug — the one thing B fixes
  rm -rf __pycache__ evals/__pycache__
  ok "  primed: text evals already green · only the safety-banner bug remains for the UI loop"
else
if [ "$MODE" = "a" ]; then
  cp .pristine/agent.py agent.py         # plant the text bugs so the loop has red to close
  rm -rf __pycache__ evals/__pycache__
  ok "  primed: citation + severity rules removed → 2 red text evals for the loop to close"
fi
b "PHASE A · TEXT EVALS  —  pytest → fix SYSTEM prompt → repeat until green"

PROMPT_A='The SymptomScout RUN++ text-eval suite has failing tests. Below is the latest
`uv run pytest run-plus/evals/ -v` output.

Read the failure(s) and the judge questions, then make the SMALLEST change to the
SYSTEM prompt in run-plus/agent.py that makes ONE failing test pass. Change one rule
at a time. Do NOT edit anything under run-plus/evals/ (that is the contract). Make the
edit and stop; do not run any commands.

--- pytest output ---'

for n in $(seq 1 "$MAX"); do
  printf '\n'; b "  text iteration ${n} ── running the contract"
  say "🧪 EVALUATOR runs the contract — pytest asks the Opus judge if each rule holds (~40s)"
  dim "  \$ uv run pytest run-plus/evals/ -q -n auto"
  # -n auto (pytest-xdist) runs the 5 text evals concurrently; combined with the
  # parallel judge votes in evals/test_evals.py this cuts a Phase-A pass from
  # ~2 min to ~40s. Recording-only — the env's plain serial command is unchanged.
  if ( cd "$ROOT" && uv run pytest run-plus/evals/ -q -n auto ) >"$PYLOG" 2>&1; then
    tail -n 1 "$PYLOG"
    ok "  ✅ TEXT GREEN — all text evals pass after $((n-1)) fix(es). The ratchet holds."
    break
  fi
  grep -E "passed|failed|PASSED|FAILED" "$PYLOG" | tail -n 6
  red "  🔴 red. 🔁 HARNESS hands the failure to the GENERATOR to fix ONE rule…"
  say "✍️  GENERATOR (claude) reads the judge's reason and edits agent.py's SYSTEM prompt"
  ( cd "$ROOT" && claude -p "${PROMPT_A}
$(cat "$PYLOG")" \
      --permission-mode acceptEdits \
      --allowedTools "Read" "Edit" ) \
    || red "  ⚠️ claude -p exited non-zero (iteration ${n})"
  if [ "$n" -eq "$MAX" ]; then red "  ⚠️ hit the ${MAX}-iteration cap on text evals."; fi
done
fi

if [ "$MODE" = "a" ]; then
  printf '\n'; b "DONE"
  say "Text evals driven red→green by the agent — the requirement is now TRUE."
  say "Making it USABLE in the UI is the A10 clip:   ./run-plus/ralph.sh b"
  say "Reset:  ./reset.sh"
  exit 0
fi

# ══════════════════════════════════════════════════════════════════════════════
# PHASE B — UI EVALS (Playwright MCP, live browser)
# ══════════════════════════════════════════════════════════════════════════════
b "PHASE B · UI EVALS  —  design is checkable too"
say "A text eval can't SEE the rendered page. So the agent opens a REAL browser and"
say "verifies what a PERSON actually sees — and when a design property is wrong, it"
say "FIXES the UI and re-checks live. Three properties are on trial here:"
say "   U1 · the sources are visible      → people can verify, not just trust"
say "   U2 · a safety banner is on screen  → it helps prepare, it does NOT diagnose"
say "   U3 · that banner PERSISTS          → still there after the next turn"
printf '\n'

say "starting the app headless on :${PORT}"
dim "  \$ uv run streamlit run run-plus/ui.py --server.port ${PORT} --server.headless true"
( cd "$ROOT" && uv run streamlit run run-plus/ui.py --server.port "$PORT" --server.headless true >/tmp/runplus_app.log 2>&1 ) &
APP_PID=$!
disown 2>/dev/null || true   # keep bash from printing "Terminated" when we kill it at the end
# wait for the server to answer
for _ in $(seq 1 30); do
  if curl -sf "http://localhost:${PORT}/_stcore/health" >/dev/null 2>&1; then break; fi
  sleep 1
done
ok "  app up → http://localhost:${PORT}"

printf '\n'
b "  👀 NOW WATCH THE BROWSER — the evaluator is a real person now"
say "Below: every move the agent makes, and every screenshot it judges, live."
dim "  🧠 = what it concludes   🖱⌨️🌐✏️ = what it does   📸 = what it sees"

PROMPT_B="The SymptomScout RUN++ app is running at http://localhost:${PORT}.

You are checking what a REAL USER SEES on the rendered page — design requirements a text
eval can't catch. Verify run-plus/evals/ui_checks.md against the LIVE page with the
Playwright tools, and fix anything that fails.

Work in DELIBERATE, VISIBLE steps so a person watching the browser can follow you — do ONE
step at a time. After EACH step, call the browser_take_screenshot tool to save a PNG — this
is your visible evidence and it is REQUIRED. Do NOT use the page/accessibility snapshot in
place of it: the snapshot is how you navigate, the screenshot (browser_take_screenshot) is
the proof a human reviews afterward. Every numbered step below ends in a screenshot.

CRITICAL — every screenshot filename MUST be an ABSOLUTE path under /tmp/ralph-shots/ , and
must read as a CONCLUSION. Pass the 'filename' argument to browser_take_screenshot in the
form /tmp/ralph-shots/NN-what-this-shows-and-what-it-means.png , where NN is the step number
(01, 02, …) and the rest is a short kebab-case sentence stating what the screenshot reveals
and the decision it drives — i.e. the information YOU are acting on. (A bare or relative
filename is saved to the wrong directory and will NOT be shown — the absolute path is required.)
Examples: /tmp/ralph-shots/03-sources-panel-lists-3-citations-U1-passes.png ,
/tmp/ralph-shots/04-top-of-page-has-no-safety-banner-this-is-the-red.png ,
/tmp/ralph-shots/06-banner-still-visible-after-second-turn-U3-passes.png .
The filename IS the caption shown under the image, so make it specific and true.

NARRATE as you go: before each action say in ONE short sentence what you are about to do,
and right AFTER each screenshot say in ONE sentence what you SEE in it and what it means for
the check (pass/fail) — a person is watching this stream live and reading your reasoning.

SCROLLING — do NOT try to scroll with window.scrollTo or browser_evaluate. This app scrolls
inside an inner Streamlit container, so JS window-scrolling does nothing and just wastes time.
To inspect the TOP of the page (the safety banner), take a FULL-PAGE screenshot instead: call
browser_take_screenshot with fullPage set to true. Never use browser_evaluate.

1. Open http://localhost:${PORT}. Take a screenshot.
2. Click the chat input, type, and send:
   I'm 28. Irregular periods for 3 years, weight gain, and adult acne.
   Wait for the full answer to render, then take a FULL-PAGE screenshot (fullPage: true).
3. U1 — find and click 'Sources used' to expand it; confirm at least one source is listed. Screenshot.
4. U2/U3 — take a FULL-PAGE screenshot (fullPage: true) and look at the TOP of the page for a
   PROMINENT safety banner (a red/alert box, NOT a small grey caption) that says it does not
   diagnose and to call 911 in an emergency. On the baseline there is NONE — confirm it is missing.
5. Fix it: edit run-plus/ui.py to add a persistent, prominent banner near the top, rendered on
   EVERY run, e.g.
   st.error(\"⚠️ SymptomScout helps you prepare — it does not diagnose. If this might be an
   emergency, call 911 now.\").
6. Wait ~3s for Streamlit to hot-reload, then reload the page and take a FULL-PAGE screenshot
   (fullPage: true). Confirm the banner is now visible at the top.
7. U3 — send a SECOND message: What questions should I ask my doctor at the appointment?
   Wait for the answer, then take a FULL-PAGE screenshot (fullPage: true) and confirm the SAME
   banner is STILL visible at the top.
8. When U1, U2 and U3 all hold in the live browser, print exactly:  UI-GREEN
   Otherwise print:  UI-RED: <what still fails>"

rm -rf "$SHOT_DIR" && mkdir -p "$SHOT_DIR"   # start clean so we only show this run's screenshots
# --model pins Sonnet for the browser-driving: it's mechanical step-by-step work
# over large accessibility snapshots, where the default (heavier) model spends
# minutes per click. Sonnet drives Playwright reliably and far faster.
# Stream the agent's run LIVE through narrate.py: it reads claude's event stream
# (--output-format stream-json) and prints, as they happen, claude's reasoning,
# each action, and each screenshot rendered inline (chafa) with its caption — so
# the terminal is never silent. narrate.py writes the final report to
# /tmp/ralph-ui-result.txt for the UI-GREEN check below. --strict-mcp-config +
# run-plus/.mcp.json pin the Playwright config (window position, output dir).
rm -f /tmp/ralph-ui-result.txt
( cd "$ROOT" && claude -p "$PROMPT_B" \
    --output-format stream-json --verbose \
    --model claude-sonnet-4-6 \
    --permission-mode bypassPermissions \
    --mcp-config run-plus/.mcp.json --strict-mcp-config \
    --allowedTools "Read" "Edit" "mcp__playwright" 2>/dev/null ) \
  | python3 "$HERE/narrate.py"
UIOUT="$(cat /tmp/ralph-ui-result.txt 2>/dev/null)"

printf '\n'; dim "  $(ls "$SHOT_DIR"/*.png 2>/dev/null | wc -l | tr -d ' ') screenshots saved to $SHOT_DIR (shown live above)."

if printf '%s' "$UIOUT" | grep -q "UI-GREEN"; then
  ok "  ✅ UI GREEN — verified in a real browser: sources visible · safety banner present · banner persists."
  say "Same red→green loop as the text evals — now on what the USER actually sees."
  say "That's the point: design is checkable too. A requirement isn't done when a test"
  say "passes; it's done when a person can act on it — and that's a checkable property."
else
  red "  🔴 UI still red — see the agent's notes above."
fi

# ══════════════════════════════════════════════════════════════════════════════
b "DONE"
if [ "$MODE" = "b" ]; then
  say "The text loop made the requirement TRUE (that was the A9 clip); this made it USABLE."
else
  say "One loop, two evaluators: pytest judged the TEXT, a real browser judged the DESIGN."
fi
say "Reset everything with:  ./reset.sh"
