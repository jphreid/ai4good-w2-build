"""RUN++ UI — the polished hero, with one PLANTED UI GAP.

Agent loop + "how to read this" + sources panel + downloadable prep sheet — but
NO persistent, prominent safety banner. The disclaimer is a small grey caption
that's easy to miss, and there's no visible emergency banner at all.

That gap is the Phase-B target of the autonomous loop (`./ralph.sh`): an agent
drives this rendered page with Playwright MCP, sees the safety banner is missing,
edits THIS file to add a prominent `st.error` banner rendered every run (so it
persists across turns), and re-verifies in the live browser. UI design, made
checkable — the same red→green discipline as the text evals.

Run:  uv run streamlit run run-plus/ui.py --server.port 8504
Reset to this baseline:  ./reset.sh
"""
import os
import sys
sys.path.insert(0, os.path.dirname(__file__))

import streamlit as st
from agent import respond

st.set_page_config(page_title="SymptomScout — Run++", page_icon="🏃")
st.title("SymptomScout 🏃➕ Run++")

# NOTE: planted gap — only a small grey caption, no prominent/persistent safety banner.
st.caption("v3 — an agent. It may ask a question and decides when to look up studies.")

with st.expander("How to read this", expanded=False):
    st.markdown(
        "- These are **conditions worth asking about**, not a diagnosis.\n"
        "- Each one is **cited** so you can check the source.\n"
        "- The agent may ask you a question before it has enough to go on.\n"
        "- It pulls from a curated knowledge base and, when useful, recent PubMed studies."
    )

if "messages" not in st.session_state:
    st.session_state.messages = []

for m in st.session_state.messages:
    with st.chat_message(m["role"]):
        st.markdown(m["content"])

if user_input := st.chat_input("Describe your symptoms..."):
    st.session_state.messages.append({"role": "user", "content": user_input})
    with st.chat_message("user"):
        st.markdown(user_input)

    with st.chat_message("assistant"):
        with st.spinner("The agent is working (retrieving, maybe searching PubMed)..."):
            result = respond(st.session_state.messages)
        reply = result["text"]
        st.markdown(reply)

        with st.expander("Sources used"):
            if result["retrieved"]:
                st.markdown("**Curated knowledge base:**")
                for name in result["retrieved"]:
                    st.markdown(f"- `{name}`")
            if result["pubmed_used"]:
                st.markdown("**PubMed (live):**")
                for r in result["pubmed_results"]:
                    if "error" in r:
                        st.markdown(f"- _{r['error']}_")
                    else:
                        st.markdown(f"- [{r['title']}]({r['url']}) — {r.get('source', '')}")
            else:
                st.caption("The agent didn't need a live PubMed search this time.")

        st.download_button(
            "⬇️ Download prep sheet",
            data=reply,
            file_name="doctor-visit-prep-sheet.md",
            mime="text/markdown",
        )

    st.session_state.messages.append({"role": "assistant", "content": reply})
