# Oracle Graph Jupyter Notebooks

This folder contains standalone Jupyter notebooks for Oracle Graph features, algorithms, and integrations. These notebooks are shared assets, not the main getting-started path.

For the recommended 26ai beginner flow, start here: [`../../property-graph/26ai/get-started/`](../../property-graph/26ai/get-started/).

## Notebooks

| Notebook | What It Covers |
| --- | --- |
| [`adb-client-on-jupyter-notebook.ipynb`](adb-client-on-jupyter-notebook.ipynb) | Accessing Oracle Graph from a Jupyter notebook connected to Autonomous Database. |
| [`examples/1_sql_graph.ipynb`](examples/1_sql_graph.ipynb) | SQL graph example. |
| [`examples/2_pgx_graph.ipynb`](examples/2_pgx_graph.ipynb) | PGX graph example. |
| [`examples/3_pgql_graph.ipynb`](examples/3_pgql_graph.ipynb) | PGQL graph example. |
| [`examples/4_standalone.ipynb`](examples/4_standalone.ipynb) | Standalone graph notebook example. |

## Running A Notebook

```bash
python -m pip install -r requirements.txt
jupyter lab
```

Then open a notebook from this folder in the Jupyter file browser and update any database connection placeholders before running cells.

## Prerequisites

- Oracle Database 19c or Oracle AI Database 26ai, depending on the notebook.
- Python 3.8+ and pip.
- Oracle Graph Client for notebook examples that use the Python client.

## Related Links

- Shared assets: [`../`](../)
- 26ai getting started: [`../../property-graph/26ai/get-started/`](../../property-graph/26ai/get-started/)
- Graph algorithms: [`../../property-graph/algorithms/`](../../property-graph/algorithms/)
