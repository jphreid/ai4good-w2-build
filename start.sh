#!/usr/bin/env bash
# Start all three SymptomScout versions at once.
# Usage:  ./start.sh        (then open the three URLs it prints; Ctrl-C stops all)
set -euo pipefail
cd "$(dirname "$0")"

# 1. Check the key is in place.
if [ ! -f .env ] || ! grep -q "^ANTHROPIC_API_KEY=sk-ant-" .env; then
  echo "❌ No API key found."
  echo "   Do this first:"
  echo "     1. cp .env.example .env"
  echo "     2. open .env and paste the key JP sent you (it starts with sk-ant-)"
  echo "   Then run ./start.sh again."
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
