# Bank Graph Demo

This demo creates a property graph from bank account and transfer data in Oracle AI Database 26ai. It shows how to create the graph, inspect graph metadata, and run pattern-matching queries such as multi-hop transfers and circular payment chains.

## What's Included

| Path | Purpose |
| --- | --- |
| [`../../../../shared/datasets/bank_graph/data/BANK_ACCOUNTS.csv`](../../../../shared/datasets/bank_graph/data/BANK_ACCOUNTS.csv) | Sample bank account data. |
| [`../../../../shared/datasets/bank_graph/data/BANK_TRANSFERS.csv`](../../../../shared/datasets/bank_graph/data/BANK_TRANSFERS.csv) | Sample transfer data between accounts. |
| [`../../../../shared/datasets/bank_graph/setup/oracle-graph-26ai-sqldeveloper.sql`](../../../../shared/datasets/bank_graph/setup/oracle-graph-26ai-sqldeveloper.sql) | SQL Developer setup script for creating the Bank Graph tables and graph objects. |
| [`notebooks/jupyter-notebooks/oracle-graph-sample-26ai.ipynb`](notebooks/jupyter-notebooks/oracle-graph-sample-26ai.ipynb) | Jupyter notebook version of the Bank Graph walkthrough. |
| [`../../../../shared/datasets/bank_graph/data/LICENSE.txt`](../../../../shared/datasets/bank_graph/data/LICENSE.txt) | Dataset license information. |

## Prerequisites

- Oracle AI Database 26ai or Autonomous AI Database 26ai.
- A database user with privileges to create tables and property graphs.
- SQL Developer or another SQL client for the SQL script.
- Python and Jupyter for the notebook path.

For the Jupyter path, install the Python dependencies from this folder:

```bash
python -m pip install -r requirements.txt
```

## Run With SQL Developer

1. Open [`../../../../shared/datasets/bank_graph/setup/oracle-graph-26ai-sqldeveloper.sql`](../../../../shared/datasets/bank_graph/setup/oracle-graph-26ai-sqldeveloper.sql) in SQL Developer.
2. Run the table creation statements.
3. Load [`../../../../shared/datasets/bank_graph/data/BANK_ACCOUNTS.csv`](../../../../shared/datasets/bank_graph/data/BANK_ACCOUNTS.csv) into `BANK_ACCOUNTS`.
4. Load [`../../../../shared/datasets/bank_graph/data/BANK_TRANSFERS.csv`](../../../../shared/datasets/bank_graph/data/BANK_TRANSFERS.csv) into `BANK_TRANSFERS`.
5. Continue running the script to create `BANK_GRAPH` and execute the sample graph queries.

### Load The CSV Files In SQL Developer

1. In the Connections pane, expand your schema and open the `Tables` node.
2. Right-click `BANK_ACCOUNTS`, choose `Import Data`, and select [`../../../../shared/datasets/bank_graph/data/BANK_ACCOUNTS.csv`](../../../../shared/datasets/bank_graph/data/BANK_ACCOUNTS.csv).
3. Confirm the column mapping: `ID`, `NAME`, `BALANCE`.
4. Right-click `BANK_TRANSFERS`, choose `Import Data`, and select [`../../../../shared/datasets/bank_graph/data/BANK_TRANSFERS.csv`](../../../../shared/datasets/bank_graph/data/BANK_TRANSFERS.csv).
5. Confirm the column mapping: `TXN_ID`, `SRC_ACCT_ID`, `DST_ACCT_ID`, `DESCRIPTION`, `AMOUNT`.
6. Commit the imported rows before creating `BANK_GRAPH`.

## Run With Jupyter

From this demo folder, start Jupyter and open the notebook:

```bash
jupyter lab notebooks/jupyter-notebooks/oracle-graph-sample-26ai.ipynb
```

The notebook looks for the CSV files in [`../../../../shared/datasets/bank_graph/data/`](../../../../shared/datasets/bank_graph/data/).

## Expected Output

After the graph is created, `USER_PROPERTY_GRAPHS` should include `BANK_GRAPH`. The first graph query for incoming transfers should return rows like these:

| ACCT_ID | NUM_TRANSFERS |
| --- | --- |
| 387 | 39 |
| 934 | 39 |
| 135 | 36 |

Exact ordering after tied counts may vary by database version or query plan.

## Reset The Demo

Run these statements if you want to remove the Bank Graph objects and rerun the demo from the beginning:

```sql
DROP PROPERTY GRAPH BANK_GRAPH;
DROP TABLE BANK_TRANSFERS PURGE;
DROP TABLE BANK_ACCOUNTS PURGE;
```

If an object does not exist yet, your SQL client may show an expected drop error. Continue with the remaining cleanup statements.

## Next Steps

- Try the GraphRAG demo: [`../../../../knowledge-graph/demo/graph-rag/`](../../../../knowledge-graph/demo/graph-rag/)
- Browse graph algorithms: [`../../../algorithms/`](../../../algorithms/)
- Return to 26ai demos: [`../`](../)
