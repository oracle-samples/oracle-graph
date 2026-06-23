# Oracle Graph Demos for 26ai

This folder contains complete property graph demos for Oracle AI Database 26ai and Autonomous AI Database 26ai. These examples go beyond the first getting-started path and show applied graph workflows using SQL, notebooks, and Graph Studio.

If you are new to Oracle Graph, start with [`../get-started/`](../get-started/) before running these demos.

## Available Demos

| Demo | What It Covers | Entry Points |
| --- | --- | --- |
| [`bank_graph/`](bank_graph/) | Bank account and transfer graph for pattern matching, circular payment detection, and graph analysis. | SQL Developer script and Jupyter notebook |
| [`sales-history/`](sales-history/) | Sales History graph notebook for learning PGQL constructs in Graph Studio. | Graph Studio notebook |

## How To Use This Folder

Each demo should be self-contained and include its own `README.md` with setup steps, prerequisites, and the recommended way to run the example.

Use this folder for complete 26ai property graph scenarios. Use [`../get-started/`](../get-started/) for the first beginner path, and use [`../../../shared/`](../../../shared/) only for datasets or utilities reused by more than one demo.

## Common Prerequisites

Different demos may require different tools. Check each demo README first, but common requirements include:

- Oracle AI Database 26ai or Autonomous AI Database 26ai.
- Oracle Graph enabled for your database environment.
- SQL Developer, SQLcl, Graph Studio, or another supported SQL client.
- Python and Jupyter for notebook-based demos.

## Related Links

- 26ai getting started: [`../get-started/`](../get-started/)
- Graph algorithms: [`../../algorithms/`](../../algorithms/)
- Compatibility notes: [`../../docs/compatibility.md`](../../docs/compatibility.md)
- Knowledge graph demos: [`../../../knowledge-graph/demo/`](../../../knowledge-graph/demo/)
