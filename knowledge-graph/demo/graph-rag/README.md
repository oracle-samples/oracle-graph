# GraphRAG Demo

This demo shows a graph + LLM workflow using Oracle Graph, Oracle AI Database 26ai, and LangChain. It creates a small movie recommendation graph, queries graph relationships, and sends graph query results to an LLM for natural-language responses.

## What's Included

| Path | Purpose |
| --- | --- |
| [`graph-rag-langchain-26ai.ipynb`](graph-rag-langchain-26ai.ipynb) | Jupyter notebook for the GraphRAG-style LangChain demo. |

## Prerequisites

- Oracle AI Database 26ai or Autonomous AI Database 26ai.
- Python and Jupyter.
- An LLM API key or compatible provider configuration.

Install the Python dependencies from this folder:

```bash
python -m pip install -r requirements.txt
```

## Run The Demo

Open the notebook from this folder:

```bash
jupyter lab graph-rag-langchain-26ai.ipynb
```

Before running the LLM cells, update the database connection values and LLM credential placeholders in the notebook.

The notebook reads these optional environment variables:

| Variable | Purpose |
| --- | --- |
| `OPENAI_API_KEY` | API key used by `langchain-openai`. |
| `OPENAI_MODEL` | Chat model name to use for the demo. |

## Objects Created

The notebook creates these database objects:

| Object | Type | Purpose |
| --- | --- | --- |
| `MOVIES` | Table | Movie titles, genres, and summaries. |
| `MOVIES_CUSTOMER` | Table | Sample customers. |
| `WATCHED_MOVIE` | Table | Which customer watched which movie and when. |
| `CUSTOMER_WATCHED_MOVIES` | Property graph | Graph connecting customers to watched movies. |

## Expected Output

Before the LLM cells, the graph query should print customer and movie rows such as John Doe watching `Inception`, `The Matrix`, and `The Godfather`.

After the LLM cells are configured, the notebook should produce natural-language responses about movie genres and customer viewing preferences.

## Reset The Demo

Run these statements if you want to remove the GraphRAG demo objects and rerun the notebook from the beginning:

```sql
DROP PROPERTY GRAPH CUSTOMER_WATCHED_MOVIES;
DROP TABLE WATCHED_MOVIE PURGE;
DROP TABLE MOVIES_CUSTOMER PURGE;
DROP TABLE MOVIES PURGE;
```

If an object does not exist yet, your SQL client may show an expected drop error. Continue with the remaining cleanup statements.

## Notes

This demo is separate from the Bank Graph demo. It creates its own movie/customer graph inside the notebook and does not use the Bank Graph CSV files.

## Related Links

- Knowledge graph demos: [`../`](../)
- 26ai property graph demos: [`../../../property-graph/26ai/demos/`](../../../property-graph/26ai/demos/)
- Bank Graph demo: [`../../../property-graph/26ai/demos/bank_graph/`](../../../property-graph/26ai/demos/bank_graph/)
- 26ai getting started: [`../../../property-graph/26ai/get-started/`](../../../property-graph/26ai/get-started/)
