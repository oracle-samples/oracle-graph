# Get Started with Oracle Graph — 26ai

This guide walks you through your first Oracle Graph experience on Oracle AI Database 26ai (or Autonomous AI Database 26ai). You will create a property graph from relational data, run pattern-matching queries, apply graph algorithms, and visualize the results — all without leaving the database.

✅  These samples use Oracle AI Database 26ai or Autonomous AI Database 26ai. For Oracle Database 19c, see the get-started-19c/ folder.

## What you'll build

A bank transaction graph (the 'Bank Graph') — a classic fraud detection dataset where accounts are nodes and transfers are edges. By the end you'll be able to:

- Find circular payment patterns in a single SQL/PGQL query
- Rank accounts by influence using PageRank
- Detect communities of connected accounts
- Visualize the graph in Graph Studio or the graphviz-demo app

## Prerequisites

- Oracle AI Database 26ai or Oracle AI Autonomous Database 26ai
- Python 3.9+ (for notebook path)
- A browser (for Graph Studio path — no Python needed)

### Option A — Graph Studio (Recommended for ADB users)

Graph Studio is a browser-based IDE built into Autonomous AI Database. No local install required.

- Log in to your ADB instance and open Graph Studio from the Tools tab
- Click Notebooks → Import → upload bank-graph-26ai.dsnb from this folder
- Run the notebook cells top-to-bottom

### Option B — Python + Jupyter (Local)

```python
pip install oracle-graph-client jupyterlab
cp .env.example .env        # fill in your DB connection details
jupyter lab bank-graph-26ai.ipynb
```

### Option C — SQL Developer / SQL*Plus

SQL scripts are provided for users who prefer to work directly in SQL. Run them in order:

01_create_graph.sql         -- CREATE PROPERTY GRAPH statement
02_queries.sql              -- Pattern matching queries (SQL:2023 syntax)
03_algorithms.sql           -- PageRank, community detection via DBMS_GRAPH

## What's in this folder

- bank-graph-26ai.ipynb / .dsnb — main guided notebook
- data/ — CSV files for accounts and transactions
- sql/ — standalone SQL scripts
- .env.example — connection string template

## Next steps

- Explore AI + graph demos → ../26ai-graph-demos/
- Browse all built-in algorithms → ../built-in-algorithms/
- Build a visualization UI → ../graphviz-demo/
