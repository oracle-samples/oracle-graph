# Oracle Graph

Property graphs, RDF graphs, Knowledge graphs, AI-ready analytics, and 80+ built-in algorithms - all native inside Oracle Database. No separate graph engine. No data movement.

> [!NOTE]
> Oracle Graph is a native feature of Oracle AI Database 26ai and Oracle Database 19c+. If you already run Oracle Database, you already have Oracle Graph. No extra graph engine is required.

## Start Here

New to Oracle Graph? Follow the [Oracle Graph Learning Path](LEARNING_PATH.md) for a guided sequence from graph fundamentals to hands-on examples. If you already know graph concepts, jump straight to [`property-graph/26ai/get-started/`](property-graph/26ai/get-started/). Use the 19c path only when you are specifically working with Oracle Database 19c.

Or choose the path that matches what you want to do:

| I want to... | Go to | Best for |
| --- | --- | --- |
| Start with the current property graph experience | [`property-graph/26ai/get-started/`](property-graph/26ai/get-started/) | New users and anyone using Oracle AI Database 26ai |
| Use property graphs with Oracle Database 19c | [`property-graph/19c/get-started/`](property-graph/19c/get-started/) | Existing 19c users and PGQL-based workflows |
| Try property graph demos for 26ai | [`property-graph/26ai/demos/`](property-graph/26ai/demos/) | 26ai SQL property graph demos |
| Visualize SQL graph query results in VS Code | [Oracle SQL Developer Graph Visualization for VS Code](https://marketplace.visualstudio.com/items?itemName=Oracle.sql-developer-graph-visualization) | Developers working in VS Code with Oracle AI Database 26ai |
| Explore RDF graphs and ontologies | [`rdf/examples/`](rdf/examples/) | SPARQL, RDFS, and OWL examples |
| Try knowledge graph or GraphRAG demos | [`knowledge-graph/demo/`](knowledge-graph/demo/) | AI and knowledge graph examples |
| Browse graph algorithm examples | [`property-graph/algorithms/`](property-graph/algorithms/) | PageRank, shortest path, centrality, community detection, and related samples |
| Reuse shared resources or cross-domain demos | [`shared/`](shared/) | Files and examples used across multiple Oracle Graph areas |
| Check version compatibility or migrate from 19c to 26ai | [`property-graph/docs/`](property-graph/docs/) | Compatibility notes and migration guidance |

## What Oracle Graph Gives You

### Property Graph

- Query and traverse graphs using SQL with SQL:2023 property graph syntax (or PGQL for databases 19c and prior).
- Run 80+ built-in algorithms, including PageRank, Louvain, Dijkstra, betweenness centrality, and more.
- Use Graph Studio, a browser-based IDE for building, querying, and visualizing graphs.
- Visualize SQL graph query results directly in VS Code with the [Oracle SQL Developer Graph Visualization extension](https://marketplace.visualstudio.com/items?itemName=Oracle.sql-developer-graph-visualization).

### RDF Graph

- Create, query, and run entailment on RDF graphs using W3C standards.
- Use full SPARQL 1.1 support with RDF, RDFS, and OWL ontologies.
- Build semantic reasoning workflows and knowledge graphs.

### AI Integration

- Use GraphRAG to ground LLM responses with structured graph context.
- Combine `VECTOR_DISTANCE` semantic search with graph pattern matching.
- Build knowledge graphs automatically from unstructured text.

## Repository Contents

| Folder | What It Holds |
| --- | --- |
| [`property-graph/`](property-graph/) | Property graph examples, organized by database version plus algorithm samples. |
| [`knowledge-graph/`](knowledge-graph/) | Knowledge graph and GraphRAG examples. |
| [`rdf/`](rdf/) | RDF graph examples and assets. |
| [`shared/`](shared/) | Reusable datasets, utilities, assets, and cross-domain demos shared across Oracle Graph areas. |
| [`tools/`](tools/) | Development environments, notebooks, and visualization demos for working with Oracle Graph. |
| [`LEARNING_PATH.md`](LEARNING_PATH.md) | A guided learning sequence through the content in this repository. |

## Folder Guide

### [`property-graph/`](property-graph/)

Use this folder for property graph examples. It contains version-specific getting-started paths, demos, and graph algorithm samples.

Expected contents:

- [`property-graph/26ai/get-started/`](property-graph/26ai/get-started/) - the shortest path to creating tables, creating a graph, and running first graph queries in 26ai.
- [`property-graph/26ai/demos/`](property-graph/26ai/demos/) - complete 26ai property graph demo scenarios.
- [`property-graph/19c/get-started/`](property-graph/19c/get-started/) - the beginner path for 19c users.
- [`property-graph/19c/demos/`](property-graph/19c/demos/) - demos that are specifically useful for 19c environments.
- [`property-graph/algorithms/`](property-graph/algorithms/) - graph algorithm examples.

### [`knowledge-graph/`](knowledge-graph/)

Use this folder for knowledge graph, AI, and GraphRAG examples.

### [`rdf/`](rdf/)

Use this folder for RDF graph examples and related assets.

### [`shared/`](shared/)

Use this folder for reusable resources and demos that intentionally span multiple Oracle Graph areas, such as examples that combine property graph and RDF Graph. If a file belongs to one single-area demo only, keep it inside that demo folder.

### [`tools/`](tools/)

Use this folder for tool-specific and environment-specific content, such as Jupyter notebooks, Graph Studio interpreter setup, and visualization demos. For visualizing graphs in VS Code, see the [Oracle SQL Developer Graph Visualization extension](https://marketplace.visualstudio.com/items?itemName=Oracle.sql-developer-graph-visualization).

### [`property-graph/docs/`](property-graph/docs/)

Use this folder for repository-level guidance, including compatibility notes and migration guidance between Oracle Database 19c and Oracle AI Database 26ai.

## Prerequisites

The examples in this repository may require:

- Oracle AI Database 26ai or Oracle Database 19c.
- Oracle Graph components enabled for your database environment.
- SQLcl, SQL Developer, Graph Studio, or another supported SQL client.
- Python and Jupyter for notebook-based walkthroughs.
- Optional: Conda for custom Graph Studio Python interpreter setup.
- Optional: VS Code with the [Oracle SQL Developer Graph Visualization extension](https://marketplace.visualstudio.com/items?itemName=Oracle.sql-developer-graph-visualization) to visualize SQL graph query results (requires Oracle AI Database 26ai; SQL Developer for VS Code is installed automatically as a dependency).

Check the README inside each folder for version-specific setup steps and dependencies.

## Documentation

- Oracle Property Graph documentation: [Oracle Property Graph Release 26.1](https://docs.oracle.com/en/database/oracle/property-graph/26.1/index.html)
- Oracle AI Database 26ai documentation: [Oracle AI Database 26ai](https://docs.oracle.com/en/database/oracle/oracle-database/26/index.html)
- Oracle Database 19c documentation: [Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/index.html)
- Graph Visualization extension for VS Code: [Getting Started with the Graph Visualization Extension for VS Code](https://docs.oracle.com/en/database/oracle/property-graph/26.1/spgdg/getting-started-vs-code-graph-visualization-extension.html)
- Repository compatibility notes: [`property-graph/docs/compatibility.md`](property-graph/docs/compatibility.md)
- 19c to 26ai migration guidance: [`property-graph/docs/migration-19c-to-26ai.md`](property-graph/docs/migration-19c-to-26ai.md)

## Repository Validation

Run the validation script before opening a pull request or after moving files:

```bash
node scripts/validate-repo.js
```

The script checks local Markdown links, JSON-based notebooks, cleared Jupyter outputs, required README files, and stray `.DS_Store` files.

## Contributing

Contributions are welcome. Before opening a pull request, please:

- Keep examples self-contained and reproducible.
- Include setup notes for any database, Python, or notebook dependencies.
- Place version-specific property graph examples under `property-graph/26ai/` or `property-graph/19c/`.
- Place reusable datasets, utilities, assets, and cross-domain demos under `shared/` when they span more than one Oracle Graph area.
- Add expected output or screenshots when the result is visual.
- Avoid committing credentials, connection strings, wallets, or generated data that should not be shared.

## Support

For questions, issues, or demo requests, open a GitHub issue or contact the repository maintainers.
