# Migrating Property Graph Examples from 19c to 26ai

Use this page when moving a property graph example from the Oracle Database 19c PGQL/PGX path to the Oracle AI Database 26ai SQL property graph path.

## Start With These Folders

| Current Work | 26ai Target |
| --- | --- |
| 19c getting started: [`../19c/get-started/`](../19c/get-started/) | 26ai getting started: [`../26ai/get-started/`](../26ai/get-started/) |
| 19c demos: [`../19c/demos/`](../19c/demos/) | 26ai demos: [`../26ai/demos/`](../26ai/demos/) |
| Shared Bank Graph data: [`../../shared/datasets/bank_graph/`](../../shared/datasets/bank_graph/) | Reuse the same shared dataset when the schema matches. |

## Migration Checklist

| Check | What To Review |
| --- | --- |
| Graph creation | Replace 19c PGQL graph creation patterns with the 26ai SQL property graph syntax used by the 26ai demos. |
| Query syntax | Review PGQL `MATCH` queries and translate them to the SQL property graph form used in 26ai examples. |
| Runtime assumptions | Remove assumptions that require a separate PGX server when the example runs natively in Oracle AI Database 26ai. |
| Tooling | Prefer SQL Developer, Graph Studio, or Jupyter paths documented under [`../26ai/`](../26ai/). |
| Data paths | Keep reusable datasets under [`../../shared/datasets/`](../../shared/datasets/) and link to them from demo READMEs. |
| README links | Update links from old flat folder names to the current `property-graph/26ai/`, `property-graph/19c/`, and `shared/` layout. |

## Suggested Validation

1. Confirm every linked file or folder exists.
2. Run the graph creation script or notebook from the README entry point.
3. Verify at least one query returns expected rows.
4. Note any 19c-only behavior in the README instead of hiding it in comments.

## Related Links

- Compatibility notes: [`compatibility.md`](compatibility.md)
- 26ai Bank Graph demo: [`../26ai/demos/bank_graph/`](../26ai/demos/bank_graph/)
- 19c Bank Graph PGQL script: [`../19c/demos/graph-studio-notebooks/bank-graph-pgql`](../19c/demos/graph-studio-notebooks/bank-graph-pgql)
