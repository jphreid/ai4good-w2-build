# Run SymptomScout — Crawl / Walk / Run (≈5 min)

Three versions of the same app, side by side. Paste a key, run one command, done.

---

## 1. Install uv (one time)

`uv` runs the Python app — it's the only thing you must install.
- **Mac / Linux:** paste into a terminal:
  ```
  curl -LsSf https://astral.sh/uv/install.sh | sh
  ```
- **Windows:** see https://docs.astral.sh/uv/getting-started/installation/

---

## 2. Get the code (pick ONE)

**Option A — Download ZIP (easiest, no extra tools):**
On the GitHub repo page → green **"Code"** button → **"Download ZIP"** → unzip it → open the unzipped folder in a terminal.

**Option B — git clone** (if you have [git](https://git-scm.com/downloads)):
```
git clone https://github.com/jphreid/symptomscout-versions.git
cd symptomscout-versions
```

Either way, you should end up in the `symptomscout-versions` folder in your terminal.

---

## 3. Paste the key (the only secret step)

```
cp .env.example .env
```
Open **`.env`** in any text editor. Replace `sk-ant-...` with the key JP sent you. Save.
*(It must start with `sk-ant-`. Don't share this file or commit it — it's already git-ignored.)*

---

## 4. Start everything

**Mac / Linux:**
```
./start.sh
```
It installs dependencies, launches all three, and prints the links. Leave it running.

**Windows** (run each in its own terminal):
```
uv run streamlit run crawl/ui.py --server.port 8501
uv run streamlit run walk/ui.py  --server.port 8502
uv run streamlit run run/ui.py   --server.port 8503
```

---

## 5. Open them

- 🐢 **Crawl** → http://localhost:8501  — just chat; you write your own prep sheet
- 🚶 **Walk** → http://localhost:8502  — a cited prep sheet (citation buried in the text)
- 🏃 **Run** → http://localhost:8503  — sources panel + "how to read this" + download

Try the **same** line in all three and watch it grow:
> I'm 28. Irregular periods for 3 years, weight gain, and adult acne.

**More to try:** see **`scenarios.md`** — varied prompts, multi-turn scripts, and guardrail probes, annotated for each version.

**Stop:** press `Ctrl-C` in the terminal (Mac/Linux stops all three at once).

---

## If something breaks

| Problem | Fix |
|---|---|
| `ANTHROPIC_API_KEY` error | The key isn't in `.env`, or has a typo. It must start with `sk-ant-`. |
| "port is already in use" | Change `8501` → `8511` (etc.) in the command. |
| First run is slow | It's installing dependencies once. After that it's instant. |
| `uv: command not found` | Re-open the terminal after installing uv (step 1). |

That's it — any issues, ping JP.
