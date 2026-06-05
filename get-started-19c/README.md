# Get Started with Oracle Graph — 19c

This guide covers your first Oracle Graph experience on Oracle Database 19c using PGX (Parallel Graph AnalytiX), PGQL, and the Python client. You will load a graph, run traversal queries, and apply analytics using the same Bank Graph dataset used in the 26ai guide.

ℹ️  Running Oracle Database 26ai or Autonomous Database? Use get-started-26ai/ instead — it uses the newer native SQL property graph syntax and Graph Studio.

## Architecture in 19c

In 19c, Oracle Graph uses a client-server architecture: Oracle Graph Server (PGX) sits alongside Oracle Database, loads graphs into memory for fast analytics, and exposes them via a Python/Java API and a REST endpoint. Graph Studio is not available in this version.

## Prerequisites

- Oracle Database 19c (on-premises or DBCS)
- Oracle Graph Server and Client 26.x — download from [Downloads for Oracle Graph Tools](https://www.oracle.com/database/graph/downloads.html)
- Python 3.8+ and JDK 11+
- Jupyter Notebook

## Setup

```python
# Install the Python client
pip install oracle-graph-client

# Start Oracle Graph Server (after installing the RPM)
sudo systemctl start oracle-graph-server

# Connect and run the notebook
cp .env.example .env          # fill in DB host, port, service name, credentials
jupyter lab bank-graph-19c.ipynb
```

## What's in this folder

- bank-graph-19c.ipynb — guided notebook using the PGQL Python client
- data/ — Bank Graph CSV files
- config/ — Graph Server and client config templates
- .env.example — connection string template

## Key differences from 26ai

| Difference | Explanation |
| ----------- | ----------- |
| Query language | PGQL (19c)  vs  SQL:2023 property graph syntax (26ai) |
| Execution | In-memory via PGX server (19c)  vs  native in-DB (26ai) |
| IDE | Jupyter / REST API (19c)  vs  Graph Studio (26ai) |
| Setup | Separate Graph Server install needed (19c)  vs  none (26ai) |

## Upgrade path

When you're ready to move to Oracle Database 26ai, all graph algorithms and most query patterns translate directly. The main change is switching PGQL syntax to SQL:2023 MATCH clauses. See the Oracle Graph Migration Guide in the official docs.
