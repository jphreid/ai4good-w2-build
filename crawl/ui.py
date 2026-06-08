"""CRAWL UI — a plain chat. The human assembles the prep sheet.

Run from the versions root:  uv run streamlit run crawl/ui.py --server.port 8501
"""
import os
import sys
sys.path.insert(0, os.path.dirname(__file__))

import streamlit as st
from agent import respond

st.set_page_config(page_title="SymptomScout — Crawl", page_icon="🐢")
st.title("SymptomScout 🐢 Crawl")
st.caption(
    "**v0 — the AI just helps you think.** No lookups, no structured report — "
    "you write the prep sheet yourself. Not medical advice. Emergencies: call 911."
)

if "messages" not in st.session_state:
    st.session_state.messages = []

for m in st.session_state.messages:
    with st.chat_message(m["role"]):
        st.markdown(m["content"])

if user_input := st.chat_input("Tell me what's going on..."):
    st.session_state.messages.append({"role": "user", "content": user_input})
    with st.chat_message("user"):
        st.markdown(user_input)
    with st.chat_message("assistant"):
        with st.spinner("Thinking..."):
            reply = respond(st.session_state.messages)
        st.markdown(reply)
    st.session_state.messages.append({"role": "assistant", "content": reply})
