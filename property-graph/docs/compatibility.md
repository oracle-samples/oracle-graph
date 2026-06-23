# Property Graph Compatibility

This page explains how the property graph examples in this repository are organized across Oracle AI Database 26ai and Oracle Database 19c.

## Which Path Should I Use?

| Environment | Use This Path | Notes |
| --- | --- | --- |
| Oracle AI Database 26ai or Autonomous AI Database 26ai | [`../26ai/get-started/`](../26ai/get-started/) | Recommended path for new users and current SQL property graph workflows. |
| Oracle Database 19c | [`../19c/get-started/`](../19c/get-started/) | Use for PGQL and Oracle Graph Server and Client workflows. |
| Algorithm reference | [`../algorithms/`](../algorithms/) | Built-in graph algorithm reference pages. |
| Shared data | [`../../shared/datasets/`](../../shared/datasets/) | Reusable datasets used by examples. |

## Main Differences

| Area | 26ai | 19c |
| --- | --- | --- |
| Primary query style | SQL property graph syntax | PGQL |
| Tools | Oracle Graph Studio, any SQL tool and SQL IDE such as VS Code with SQL Developer Extension | Oracle Graph Studio, SQL Developer desktop |
| Algorithms | PageRank, WCC, Bellman-Ford in the database, additional algorithms in Graph Server (PGX)  | algorithms in Graph Server (PGX) |
| Recommended first example | [`../26ai/demos/bank_graph/`](../26ai/demos/bank_graph/) | [`../19c/demos/graph-studio-notebooks/bank-graph-pgql`](../19c/demos/graph-studio-notebooks/bank-graph-pgql) |
| Shared dataset | [`../../shared/datasets/bank_graph/`](../../shared/datasets/bank_graph/) | [`../../shared/datasets/bank_graph/`](../../shared/datasets/bank_graph/) |

## Repository Layout

| Folder | Purpose |
| --- | --- |
| [`../26ai/`](../26ai/) | 26ai property graph examples. |
| [`../19c/`](../19c/) | 19c property graph examples. |
| [`../algorithms/`](../algorithms/) | Algorithm examples and reference material. |
| [`../../knowledge-graph/demo/`](../../knowledge-graph/demo/) | Knowledge graph and GraphRAG demos. |
| [`../../shared/`](../../shared/) | Reusable datasets, notebooks, and assets. |

## Related Links

- Migration guidance: [`migration-19c-to-26ai.md`](migration-19c-to-26ai.md)
- Root README: [`../../README.md`](../../README.md)
