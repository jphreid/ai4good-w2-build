"""WALK UI — the structured prep sheet.

Run from the versions root:  uv run streamlit run walk/ui.py --server.port 8502
"""
import os
import sys
sys.path.insert(0, os.path.dirname(__file__))

import streamlit as st
from agent import respond

st.set_page_config(page_title="SymptomScout — Walk", page_icon="🚶")
st.title("SymptomScout 🚶 Walk")
st.caption(
    "**v1 — a fixed workflow:** retrieve curated docs → structured prep sheet → citations. "
    "Not a diagnosis. Emergencies: call 911."
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
        with st.spinner("Retrieving curated docs + drafting your prep sheet..."):
            reply = respond(user_input)
        st.markdown(reply)
    st.session_state.messages.append({"role": "assistant", "content": reply})
