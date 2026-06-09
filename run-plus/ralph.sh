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
ROOT="$(cd .. && pwd)"          # symptomscout-versions/ — where uv + .env + knowledge live
PORT=8504
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
# PHASE A — TEXT EVALS
# ══════════════════════════════════════════════════════════════════════════════
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

# ══════════════════════════════════════════════════════════════════════════════
# PHASE B — UI EVALS (Playwright MCP, live browser)
# ══════════════════════════════════════════════════════════════════════════════
b "PHASE B · UI EVALS  —  drive the live app with Playwright MCP → fix ui.py → re-verify"

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
b "  👀 NOW WATCH THE BROWSER WINDOW — the EVALUATOR is a real person now"
say "✍️  GENERATOR (claude) drives Chrome and checks what a USER actually SEES — step by step:"
say "   1 · open the page at :${PORT}"
say "   2 · type the PCOS symptoms and send"
say "   3 · open 'Sources used' to check the citations show          (U1)"
say "   4 · scroll up, look for a prominent safety banner — MISSING   (U2/U3 red)"
say "   5 · edit run-plus/ui.py to add a persistent banner"
say "   6 · reload, then send a SECOND message"
say "   7 · confirm the banner is STILL there after the new turn      (U3)"
say "   8 · report UI-GREEN once the page is right"
dim "  (terminal stays quiet while it works the browser; its report prints here when done)"

PROMPT_B="The SymptomScout RUN++ app is running at http://localhost:${PORT}.

You are checking what a REAL USER SEES on the rendered page — design requirements a text
eval can't catch. Verify run-plus/evals/ui_checks.md against the LIVE page with the
Playwright tools, and fix anything that fails.

Work in DELIBERATE, VISIBLE steps so a person watching the browser can follow you — do ONE
step at a time. After EACH step, call the browser_take_screenshot tool to save a PNG — this
is your visible evidence and it is REQUIRED. Do NOT use the page/accessibility snapshot in
place of it: the snapshot is how you navigate, the screenshot (browser_take_screenshot) is
the proof a human reviews afterward. Every numbered step below ends in a screenshot.

CRITICAL — name every screenshot so it reads as a CONCLUSION. Pass the `filename` argument
to browser_take_screenshot in the form `NN-what-this-shows-and-what-it-means.png`, where NN
is the step number (01, 02, …) and the rest is a short kebab-case sentence stating what the
screenshot reveals and the decision it drives — i.e. the information YOU are acting on.
Examples: `03-sources-panel-lists-3-citations-U1-passes.png`,
`04-top-of-page-has-no-safety-banner-this-is-the-red.png`,
`06-banner-still-visible-after-second-turn-U3-passes.png`. The filename IS the caption a
human will read under the image, so make it specific and true to what the shot proves.

1. Open http://localhost:${PORT}. Take a screenshot.
2. Click the chat input, type, and send:
   I'm 28. Irregular periods for 3 years, weight gain, and adult acne.
   Wait for the full answer to render, then slowly scroll down through it. Screenshot.
3. U1 — find and click 'Sources used' to expand it; confirm at least one source is listed. Screenshot.
4. U2/U3 — scroll back to the TOP and look for a PROMINENT safety banner (a red/alert box,
   NOT a small grey caption) that says it does not diagnose and to call 911 in an emergency.
   On the baseline there is NONE — confirm it is missing. Screenshot.
5. Fix it: edit run-plus/ui.py to add a persistent, prominent banner near the top, rendered on
   EVERY run, e.g.
   st.error(\"⚠️ SymptomScout helps you prepare — it does not diagnose. If this might be an
   emergency, call 911 now.\").
6. Wait ~3s for Streamlit to hot-reload, then reload the page. Scroll to the top and confirm the
   banner is now visible. Screenshot.
7. U3 — send a SECOND message: What questions should I ask my doctor at the appointment?
   Wait for the answer, scroll to the top, and confirm the SAME banner is STILL visible. Screenshot.
8. When U1, U2 and U3 all hold in the live browser, print exactly:  UI-GREEN
   Otherwise print:  UI-RED: <what still fails>"

rm -rf "$SHOT_DIR" && mkdir -p "$SHOT_DIR"   # start clean so we only show this run's screenshots
# --model pins Sonnet for the browser-driving: it's mechanical step-by-step work
# over large accessibility snapshots, where the default (heavier) model spends
# minutes per click. Sonnet drives Playwright reliably and far faster.
UIOUT="$(cd "$ROOT" && claude -p "$PROMPT_B" \
    --model claude-sonnet-4-6 \
    --permission-mode bypassPermissions \
    --allowedTools "Read" "Edit" "mcp__playwright" 2>/dev/null )"
printf '\n'; b "  ✍️  GENERATOR's report back from the browser:"
printf '%s\n' "$UIOUT" | tail -n 20

# ── filmstrip: show what claude actually SAW, inline, each with the CONCLUSION it
#    drew. The agent names every screenshot `NN-what-this-shows-and-means.png`, so
#    the filename IS the caption — we render image + that conclusion, in order, to
#    make visible what each shot told the agent to act on. ──
printf '\n'; b "  📸 What claude SAW — each shot, and the conclusion it drew from it:"
SHOTS="$(ls -1tr "$SHOT_DIR"/*.png "$SHOT_DIR"/*.jpeg "$SHOT_DIR"/*.jpg 2>/dev/null)"
if [ -z "$SHOTS" ]; then
  dim "  (no screenshots in $SHOT_DIR — did the agent skip them? checks still ran in the browser)"
elif command -v chafa >/dev/null 2>&1; then
  printf '%s\n' "$SHOTS" | while IFS= read -r f; do
    name="$(basename "$f")"; name="${name%.*}"
    case "$name" in
      [0-9]*-*) step="${name%%-*}"; rest="${name#*-}";;   # NN-conclusion → "NN" + "conclusion"
      *)        step="•";          rest="$name";;          # agent didn't number it
    esac
    caption="$(printf '%s' "$rest" | sed 's/[-_]/ /g')"
    printf '\n   \033[1;36m📸 shot %s — what this told claude:\033[0m  \033[1m%s\033[0m\n' "$step" "$caption"
    chafa --size=78x22 "$f"
    say "↳ claude read that off the page and acted on it before moving on."
  done
else
  say "chafa not installed (brew install chafa for inline images) — opening the folder instead"
  open "$SHOT_DIR"
fi

if printf '%s' "$UIOUT" | grep -q "UI-GREEN"; then
  ok "  ✅ UI GREEN — Playwright confirms the safety banner renders and persists."
else
  red "  🔴 UI still red — see the agent's notes above."
fi

# ══════════════════════════════════════════════════════════════════════════════
b "DONE"
say "Text evals + UI checks driven red→green by the agent, end to end."
say "Reset everything with:  ./reset.sh"
