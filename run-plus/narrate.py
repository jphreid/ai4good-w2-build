#!/usr/bin/env python3
"""narrate.py — turn `claude -p --output-format stream-json` into a LIVE, readable
play-by-play for the A10 recording.

The message A10 has to land: DESIGN IS CHECKABLE. A text eval can't see the
rendered page; here the agent drives a REAL browser to verify what a PERSON sees
(U1 sources visible · U2 safety banner present · U3 banner persists), and when a
property fails it FIXES the UI and re-checks live.

So this reader keeps the SIGNAL and drops the noise. Per agent step it prints:

  🧠  what claude concludes / intends   (its own words — this carries the message)
  🌐 🖱 ⌨️ ✏️  the action it takes        (the meaningful tool calls)
  📸  a screenshot, rendered INLINE       (what claude actually saw)

It HIDES the plumbing — re-reading its own screenshots, JS scroll probing
(browser_evaluate), accessibility snapshots, tool lookups — so the teaching beat
isn't buried. It also de-dupes repeated shots (the agent sometimes retakes one
while fighting a scroll). Writes the final report to RESULT_FILE for ralph.sh.
Reads stream-json on stdin; narration on stdout.
"""
import json
import os
import shutil
import subprocess
import sys
import textwrap

SHOT_DIR = "/tmp/ralph-shots"
RESULT_FILE = "/tmp/ralph-ui-result.txt"
HAVE_CHAFA = shutil.which("chafa") is not None

DIM = "\033[2m"; B = "\033[1m"; CY = "\033[1;36m"; YE = "\033[0;33m"
GR = "\033[1;32m"; RD = "\033[1;31m"; MG = "\033[1;35m"; RST = "\033[0m"

# Tools that are pure plumbing — hidden so the message reads clean.
HIDE = {"browser_evaluate", "browser_run_code_unsafe", "browser_snapshot",
        "Bash", "ToolSearch", "TodoWrite"}


def out(s=""):
    print(s); sys.stdout.flush()


def wrap(text, indent="      "):
    text = " ".join(text.split())
    return textwrap.fill(text, width=96, initial_indent=indent,
                         subsequent_indent=indent)


def caption_from(path):
    name = os.path.splitext(os.path.basename(path))[0]
    parts = name.split("-", 1)
    if parts[0].isdigit() and len(parts) == 2:
        return parts[0], parts[1].replace("-", " ").replace("_", " ")
    return "•", name.replace("-", " ").replace("_", " ")


def render_shot(path):
    if not path:
        return
    if not os.path.isabs(path):
        path = os.path.join(SHOT_DIR, os.path.basename(path))
    if not os.path.exists(path):
        out(f"{DIM}      (screenshot {os.path.basename(path)} not on disk yet){RST}")
        return
    step, desc = caption_from(path)
    out()
    out(f"{CY}   📸 shot {step} — what claude saw:{RST}  {B}{desc}{RST}")
    if HAVE_CHAFA:
        try:
            subprocess.run(["chafa", "--size=70x28", path], check=False)
        except Exception as e:
            out(f"{DIM}      (chafa failed: {e}){RST}")
    else:
        out(f"{DIM}      (install chafa for inline images — saved at {path}){RST}")
    out()
    sys.stdout.flush()


def describe_tool(name, inp):
    """Return (emoji, summary) for a meaningful action, or (None, None) to hide."""
    short = name.split("__")[-1]
    if short in HIDE:
        return None, None
    if short == "browser_navigate":
        return "🌐", f"open the page  {inp.get('url','')}"
    if short == "browser_click":
        return "🖱 ", f"click  {inp.get('element', inp.get('ref',''))}"
    if short == "browser_type":
        return "⌨️ ", f"type  \"{inp.get('text','')}\""
    if short in ("browser_wait_for",):
        return "⏳", "wait for the page to settle"
    if short == "browser_press_key":
        return "⌨️ ", f"press  {inp.get('key','')}"
    if short == "Edit":
        return "✏️ ", f"edit the UI  ({os.path.basename(inp.get('file_path',''))})"
    if short == "Read":
        p = inp.get("file_path", "")
        # hide the agent re-reading its own screenshots — the image is shown inline
        if p.endswith((".png", ".jpg", ".jpeg")) or "/ralph-shots/" in p:
            return None, None
        return "📖", f"read  {os.path.basename(p)}"
    return None, None  # unknown / internal → hide to keep the beat clean


def main():
    pending = {}          # tool_use_id -> screenshot path (None = duplicate, skip)
    seen_shots = set()    # basenames already announced/rendered — de-dupe retakes
    final = ""
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        try:
            e = json.loads(line)
        except json.JSONDecodeError:
            continue
        t = e.get("type")

        if t == "assistant":
            for c in e.get("message", {}).get("content", []):
                if c.get("type") == "text" and c.get("text", "").strip():
                    out(f"{YE}   🧠 claude{RST}")
                    out(wrap(c["text"]))
                elif c.get("type") == "tool_use":
                    if c["name"].endswith("browser_take_screenshot"):
                        fn = c.get("input", {}).get("filename")
                        bn = os.path.basename(fn or "")
                        if bn and bn in seen_shots:
                            pending[c.get("id")] = None      # retake → skip
                            continue
                        seen_shots.add(bn)
                        pending[c.get("id")] = fn
                        out(f"      {MG}📸{RST} capture  {bn}")
                        continue
                    emoji, summ = describe_tool(c["name"], c.get("input", {}))
                    if emoji is None:
                        continue
                    out(f"      {MG}{emoji}{RST} {summ}")

        elif t == "user":
            for c in e.get("message", {}).get("content", []):
                if isinstance(c, dict) and c.get("type") == "tool_result":
                    tid = c.get("tool_use_id")
                    if tid in pending:
                        render_shot(pending.pop(tid))

        elif t == "result":
            final = e.get("result", "") or ""

    if final:
        out()
        out(f"{B}   ✍️  claude's verdict:{RST}")
        out(wrap(final, indent="      "))
    try:
        with open(RESULT_FILE, "w") as f:
            f.write(final)
    except OSError:
        pass


if __name__ == "__main__":
    main()
