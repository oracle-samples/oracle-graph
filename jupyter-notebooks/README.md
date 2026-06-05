# Oracle Graph — Jupyter Notebooks

A library of standalone Jupyter notebooks covering specific Oracle Graph features, algorithms, and integrations. Unlike the get-started guides (which walk through a complete workflow end-to-end), these notebooks are focused deep-dives into individual topics you can run independently.

## Notebooks

| Notebook | What it covers |
| ----------- | ----------- |
| adb-client-on-jupyter-notebook.ipynb | |
| examples\1_sql_graph.ipynb | |
| examples\2_pgx_graph.ipynb | |
| examples\3_pgql_graph.ipynb | |
| examples\4_standalone_graph.ipynb | |

## Running a notebook

```cmd
# Install dependencies
pip install oracle-graph-client jupyterlab oracledb

# Set your connection details
export DB_HOST=your-db-host
export DB_SERVICE=your-service-name
export DB_USER=graphuser

# Launch
jupyter lab
```

Then open any .ipynb file from the file browser.

## Prerequisites

- Oracle Database 19c+ (property graph notebooks), or ADB 26ai (SQL:2023 notebooks)
- Python 3.8+ and pip
- Oracle Graph Client: pip install oracle-graph-client

💡 Tip: Each notebook includes a 'Prerequisites' cell at the top that checks your environment and prints a helpful error if something is missing. Run that cell first.
