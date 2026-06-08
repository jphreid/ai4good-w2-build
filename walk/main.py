"""WALK CLI — one structured prep sheet.  Run: uv run python walk/main.py "your symptoms" """
import os
import sys
sys.path.insert(0, os.path.dirname(__file__))

from agent import respond

if __name__ == "__main__":
    query = " ".join(sys.argv[1:]) or "I'm 28. Irregular periods for 3 years, weight gain, and adult acne."
    print(f"\n[query] {query}\n")
    print(respond(query))
