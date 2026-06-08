"""RUN UI — the polished hero. Agent loop + confidence framing + sources panel
+ printable prep sheet.

Run from the versions root:  uv run streamlit run run/ui.py --server.port 8503
"""
import os
import sys
sys.path.insert(0, os.path.dirname(__file__))

import streamlit as st
from agent import respond

st.set_page_config(page_title="SymptomScout — Run", page_icon="🏃")
st.title("SymptomScout 🏃 Run")
st.caption(
    "**v2 — an agent.** It may ask a clarifying question and decides on its own when to "
    "look up current studies (PubMed). Not a diagnosis. Emergencies: call 911."
)

# Confidence framing — tell the user what they're looking at.
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

        # Sources panel — what grounded this answer.
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

        # Printable prep sheet.
        st.download_button(
            "⬇️ Download prep sheet",
            data=reply,
            file_name="doctor-visit-prep-sheet.md",
            mime="text/markdown",
        )

    st.session_state.messages.append({"role": "assistant", "content": reply})
