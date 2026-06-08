"""Thin wrapper around the Anthropic SDK.

Loads .env, exposes a configured client, and a single MODEL constant
so we can swap models in one place.
"""
import os
from anthropic import Anthropic
from dotenv import load_dotenv

load_dotenv()

# The system-under-test (the "generator"). Fast + cheap, capable enough.
MODEL = "claude-sonnet-4-6"

# The judge (the "evaluator"). A DIFFERENT, stronger model than the one being
# judged — a model grading its own work tends to praise it. Keeping the judge
# separate is the generator/evaluator split from Anthropic's harness-design work.
JUDGE_MODEL = "claude-opus-4-8"

if not os.getenv("ANTHROPIC_API_KEY"):
    raise RuntimeError(
        "ANTHROPIC_API_KEY not set. Copy .env.example to .env and paste your key."
    )

client = Anthropic(api_key=os.getenv("ANTHROPIC_API_KEY"))
