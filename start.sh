#!/usr/bin/env bash
# Start all three SymptomScout versions at once.
# Usage:  ./start.sh        (then open the three URLs it prints; Ctrl-C stops all)
set -euo pipefail
cd "$(dirname "$0")"

# 1. Check the key is in place — with a specific message for each failure.
if [ ! -f .env ]; then
  echo "❌ No .env file yet."
  echo "   1. cp .env.example .env"
  echo "   2. open .env and paste the key JP sent you (it starts with sk-ant-)"
  echo "   Then run ./start.sh again."
  exit 1
fi
KEYLINE="$(grep '^ANTHROPIC_API_KEY=' .env || true)"
if [ -z "$KEYLINE" ] || echo "$KEYLINE" | grep -q 'sk-ant-\.\.\.'; then
  echo "❌ No key in .env yet (it's still the placeholder)."
  echo "   Open .env, replace  sk-ant-...  with the real key JP sent you, and save."
  echo "   Then run ./start.sh again."
  exit 1
fi
if ! echo "$KEYLINE" | grep -q '^ANTHROPIC_API_KEY=sk-ant-'; then
  echo "❌ That looks like the wrong kind of key."
  echo "   This app needs an ANTHROPIC key, which starts with  sk-ant-"
  if echo "$KEYLINE" | grep -q 'sk-proj-'; then
    echo "   The key in .env starts with  sk-proj-  — that's an OpenAI key, not Anthropic."
  fi
  echo "   Open .env, paste your Anthropic key (sk-ant-...), and save. Then run ./start.sh again."
  exit 1
fi

# 2. Install dependencies (instant after the first run).
echo "📦 Installing dependencies (first run can take a minute)..."
uv sync -q

# 3. Launch all three, headless (no auto-opened tabs).
echo "🚀 Starting all three versions..."
uv run streamlit run crawl/ui.py --server.port 8501 --server.headless true >/dev/null 2>&1 &
uv run streamlit run walk/ui.py  --server.port 8502 --server.headless true >/dev/null 2>&1 &
uv run streamlit run run/ui.py   --server.port 8503 --server.headless true >/dev/null 2>&1 &

# Stop all three on Ctrl-C.
trap 'echo; echo "🛑 Stopping all three..."; kill 0' INT

echo ""
echo "✅ Open these in your browser:"
echo "   🐢 Crawl → http://localhost:8501"
echo "   🚶 Walk  → http://localhost:8502"
echo "   🏃 Run   → http://localhost:8503"
echo ""
echo "Try the same line in all three:"
echo '   "I'\''m 28. Irregular periods for 3 years, weight gain, and adult acne."'
echo ""
echo "Press Ctrl-C here to stop all three."
wait
