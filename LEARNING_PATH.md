# Oracle Graph Learning Path

This page gives a suggested order for working through Oracle Graph learning resources. It links to the existing Oracle Database Insider overview and to examples in this repository; it does not reproduce the blog content. To jump to a specific area instead, use the [Start Here](README.md#start-here) table in the repository README.

## Suggested sequence

### 1. Learn the graph fundamentals

Read the [Oracle Graph Learning Path article](https://blogs.oracle.com/database/oracle-graph-learning-path) for an introduction to property graphs and RDF graphs, graph tools, videos, and use cases.

### 2. Follow the property graph route for your database version

- **Oracle AI Database 26ai:** follow the [getting started guide](property-graph/26ai/get-started/), then explore the [26ai demos](property-graph/26ai/demos/).
- **Oracle Database 19c:** follow the [19c getting started guide](property-graph/19c/get-started/), then browse the [19c demos](property-graph/19c/demos/). When you are ready to move to 26ai, see the [compatibility notes](property-graph/docs/compatibility.md) and the [19c to 26ai migration guide](property-graph/docs/migration-19c-to-26ai.md).
- **Visualize your results:** if you work in VS Code, install the [Oracle SQL Developer Graph Visualization extension](https://marketplace.visualstudio.com/items?itemName=Oracle.sql-developer-graph-visualization) to see SQL graph query results as an interactive graph. It requires Oracle AI Database 26ai. See [Getting Started with the Graph Visualization Extension for VS Code](https://docs.oracle.com/en/database/oracle/property-graph/26.1/spgdg/getting-started-vs-code-graph-visualization-extension.html).
- **Analyze your graph:** run [property graph algorithms](property-graph/algorithms/) such as PageRank, shortest path, centrality, and community detection.

### 3. Explore RDF and knowledge graphs

- Try the [RDF examples](rdf/examples/), including the [university ontology](rdf/examples/university-ontology/).
- Continue with the [knowledge graph demos](knowledge-graph/demo/), including the [GraphRAG demo](knowledge-graph/demo/graph-rag/).

### 4. Bring it together

- Explore the [cross-domain demos](shared/demos/), such as the [financial crime investigation agent](shared/demos/financial-crime-investigation-agent/), which span multiple Oracle Graph areas.
- Browse the [tools](tools/) folder for Jupyter notebooks, Graph Studio interpreter setup, and visualization demos.
- Review the [repository README](README.md) for prerequisites, documentation, and additional examples.

## Before you begin

Requirements vary by example. Check the README in the relevant folder for database version, tools, and setup instructions. The repository's [prerequisites](README.md#prerequisites) section gives a general overview.
