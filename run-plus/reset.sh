#!/usr/bin/env bash
# reset.sh — restore RUN++ to the pristine/buggy baseline so ./ralph.sh has work to do.
# Copies the planted-bug versions of agent.py + ui.py back over the live files and
# clears caches. Run before every rehearsal / recording.
set -euo pipefail
cd "$(dirname "$0")"

cp .pristine/agent.py agent.py
cp .pristine/ui.py    ui.py
rm -rf __pycache__ evals/__pycache__

echo "✅ RUN++ reset to pristine."
echo "   text evals: 3 pass / 2 fail (citations + severity-tags)"
echo "   UI checks : U1 pass · U2/U3 fail (no persistent safety banner)"
echo "   now run:  ./ralph.sh"
