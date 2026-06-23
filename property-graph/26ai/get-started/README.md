# Get Started with Oracle Graph for 26ai

Use this page as the fastest route into the Oracle AI Database 26ai property graph examples. The runnable files live in the demo folders so that each example stays complete and easy to maintain.

If you are new to Oracle Graph, start with the Bank Graph demo. It creates a property graph from account and transfer data, then runs graph pattern-matching queries over that graph.

## Recommended First Path

| I want to... | Start here |
| --- | --- |
| Create and query a first Bank Graph | [`../demos/bank_graph/`](../demos/bank_graph/) |
| Use SQL Developer | [`../../../shared/datasets/bank_graph/setup/oracle-graph-26ai-sqldeveloper.sql`](../../../shared/datasets/bank_graph/setup/oracle-graph-26ai-sqldeveloper.sql) |
| Use Jupyter | [`../demos/bank_graph/notebooks/jupyter-notebooks/oracle-graph-sample-26ai.ipynb`](../demos/bank_graph/notebooks/jupyter-notebooks/oracle-graph-sample-26ai.ipynb) |
| Use Graph Studio | [`../demos/sales-history/`](../demos/sales-history/) |

## Prerequisites

- Oracle AI Database 26ai or Autonomous AI Database 26ai.
- A database user with privileges to create tables and property graphs.
- SQL Developer or another SQL client for the SQL path.
- Python and Jupyter for the notebook path.
- Graph Studio access for the Graph Studio notebook path.

## Suggested Order

1. Open the Bank Graph demo README: [`../demos/bank_graph/`](../demos/bank_graph/).
2. Choose either the SQL Developer script or Jupyter notebook path.
3. Load the shared Bank Graph CSV files from [`../../../shared/datasets/bank_graph/data/`](../../../shared/datasets/bank_graph/data/).
4. Create the `BANK_GRAPH` property graph and run the sample queries.
5. Return to [`../demos/`](../demos/) for more complete 26ai demos.

## Related Links

- 26ai demos: [`../demos/`](../demos/)
- Bank Graph dataset: [`../../../shared/datasets/bank_graph/`](../../../shared/datasets/bank_graph/)
- Graph algorithms: [`../../algorithms/`](../../algorithms/)
- 19c getting started: [`../../19c/get-started/`](../../19c/get-started/)
