"""CRAWL CLI — a quick terminal chat.  Run: uv run python crawl/main.py"""
import os
import sys
sys.path.insert(0, os.path.dirname(__file__))

from agent import respond

if __name__ == "__main__":
    print("SymptomScout (Crawl). Describe your symptoms; Ctrl-C to quit.")
    history = []
    while True:
        try:
            u = input("\nyou> ")
        except (EOFError, KeyboardInterrupt):
            print()
            break
        history.append({"role": "user", "content": u})
        reply = respond(history)
        print("\n" + reply)
        history.append({"role": "assistant", "content": reply})
