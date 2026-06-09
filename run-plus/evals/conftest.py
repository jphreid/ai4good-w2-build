"""Make the run-plus app importable from the evals (`from agent import ...`)."""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent))
