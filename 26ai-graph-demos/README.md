# Oracle Graph + AI Demos — 26ai

Advanced demos combining Oracle Graph with Oracle AI features available in Oracle AI Database 26ai: GraphRAG, vector+graph hybrid search, and AI-powered knowledge graph construction. These go beyond basic graph queries — they show how graphs make AI applications more accurate and grounded.

🔥  Requires Oracle Database 26ai or Autonomous Database 26ai. Start with get-started-26ai/ first if you haven't set up your environment yet.

## Demos at a glance

| Folder | What it covers |
| ----------- | ----------- |
| graph-rag/ | GraphRAG over a financial transactions graph — ground LLM answers in graph data |
| BankGraphDataset/ | Datasets needed to run the Bank Graph demos |

### What is GraphRAG?

Standard RAG (Retrieval-Augmented Generation) fetches relevant text chunks by vector similarity and feeds them to an LLM. GraphRAG enhances this by also traversing relationships in a knowledge graph — so the LLM receives not just similar content but also structurally connected context (e.g. 'this account transferred funds to three accounts that are also connected to known fraud rings').

Oracle AI Database 26ai lets you run both VECTOR_DISTANCE and MATCH graph traversal in a single SQL query — no ETL, no separate vector database, no separate graph engine.

## Prerequisites

- Oracle AI Database 26ai or Autonomous AI Database 26ai
- Python 3.9+ with: pip install oracledb python-dotenv openai
- An LLM API key — OpenAI, OCI Generative AI, or compatible endpoint

## Setup

```python
cd 26ai-graph-demos
pip install -r requirements.txt
cp .env.example .env
# Edit .env: add DB connection string + LLM API key
```

## Start with graph-rag

This is the recommended entry point. It uses the same Bank Graph dataset from get-started-26ai/, so you can reuse your existing environment:

```python
cd graphrag-bank
jupyter lab graphrag_bank.ipynb
```

Resources

- [Oracle AI Vector Search Developer Guide](https://docs.oracle.com/en/database/oracle/oracle-database/26/vecse/overview-ai-vector-search.html)
- [Graph Developer's Guide for Property Graph](https://docs.oracle.com/en/database/oracle/property-graph/26.2/spgdg/index.html)
- [Graph RAG: Bring the Power of Graphs to Generative AI](https://blogs.oracle.com/database/graph-rag-bring-the-power-of-graphs-to-generative-ai)