# Get Started with Oracle Graph for 19c

Use this page when you are working with Oracle Database 19c property graph examples. The 19c path is centered on PGQL and Oracle Graph Server and Client.

If you are using Oracle AI Database 26ai or Autonomous AI Database 26ai, start here instead: [`../../26ai/get-started/`](../../26ai/get-started/).

## What To Use

| Resource | Purpose |
| --- | --- |
| [`../demos/graph-studio-notebooks/bank-graph-pgql`](../demos/graph-studio-notebooks/bank-graph-pgql) | Bank Graph PGQL script for creating and querying `BANK_GRAPH_PGQL`. |
| [`../../../shared/datasets/bank_graph/`](../../../shared/datasets/bank_graph/) | Shared Bank Graph account and transfer data. |
| [`../../docs/compatibility.md`](../../docs/compatibility.md) | Differences between the 19c and 26ai paths. |

## Prerequisites

- Oracle Database 19c.
- Oracle Graph Server and Client installed for your environment.
- A database user with privileges to create tables and property graphs.
- SQL Developer, SQLcl, Graph Studio, or another client that can run the PGQL script.

## Suggested Order

1. Load the Bank Graph CSV files from [`../../../shared/datasets/bank_graph/data/`](../../../shared/datasets/bank_graph/data/) into `BANK_ACCOUNTS` and `BANK_TRANSFERS`.
2. Open [`../demos/graph-studio-notebooks/bank-graph-pgql`](../demos/graph-studio-notebooks/bank-graph-pgql).
3. Run the `CREATE PROPERTY GRAPH BANK_GRAPH_PGQL` statement.
4. Run the sample PGQL queries in the same file.

## Data Loading Notes

The PGQL script expects these relational tables to exist before the graph is created:

| Table | CSV File | Columns |
| --- | --- | --- |
| `BANK_ACCOUNTS` | [`../../../shared/datasets/bank_graph/data/BANK_ACCOUNTS.csv`](../../../shared/datasets/bank_graph/data/BANK_ACCOUNTS.csv) | `ID`, `NAME`, `BALANCE` |
| `BANK_TRANSFERS` | [`../../../shared/datasets/bank_graph/data/BANK_TRANSFERS.csv`](../../../shared/datasets/bank_graph/data/BANK_TRANSFERS.csv) | `TXN_ID`, `SRC_ACCT_ID`, `DST_ACCT_ID`, `DESCRIPTION`, `AMOUNT` |

If you are using SQL Developer, create the tables first, then use `Import Data` on each table and map the CSV columns in the order shown above.

## Expected Output

After `BANK_GRAPH_PGQL` is created, the incoming transfer query should return accounts with high incoming transfer counts. The 26ai version of the same dataset returns rows such as account `387` and account `934` with `39` incoming transfers each; the 19c query should show the same shape of result when the same dataset is loaded.

## Reset The Demo

Run this statement before rerunning the graph creation script:

```sql
DROP PROPERTY GRAPH BANK_GRAPH_PGQL;
```

If you also want to reload the CSV files, drop or truncate `BANK_TRANSFERS` and `BANK_ACCOUNTS` according to your database setup.

## Key Differences From 26ai

| Area | 19c | 26ai |
| --- | --- | --- |
| Query style | PGQL | SQL property graph syntax |
| Runtime | Oracle Graph Server and Client / PGX | Native database property graph support |
| Main examples | PGQL scripts and 19c demos | SQL Developer, Jupyter, and Graph Studio demos |

## Related Links

- 19c demos: [`../demos/`](../demos/)
- 26ai getting started: [`../../26ai/get-started/`](../../26ai/get-started/)
- Migration guidance: [`../../docs/migration-19c-to-26ai.md`](../../docs/migration-19c-to-26ai.md)
