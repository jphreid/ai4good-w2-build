"""RUN CLI — the agent in the terminal.  Run: uv run python run/main.py "your symptoms" """
import os
import sys
sys.path.insert(0, os.path.dirname(__file__))

from agent import respond

if __name__ == "__main__":
    query = " ".join(sys.argv[1:]) or "I'm 28. Irregular periods for 3 years, weight gain, and adult acne."
    print(f"\n[query] {query}\n")
    result = respond([{"role": "user", "content": query}])
    print(result["text"])
    print("\n--- sources ---")
    print("knowledge:", ", ".join(result["retrieved"]) or "(none)")
    print("pubmed:", "used" if result["pubmed_used"] else "not used")
