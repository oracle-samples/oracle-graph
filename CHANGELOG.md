# Changelog

Notable changes to this repository, newest first.

This format follows [Keep a Changelog](https://keepachangelog.com/). Version numbers align with major Oracle Graph release milestones.

### Changed
- Reorganized repository around database-version paths:
  - `property-graph/26ai/` for Oracle AI Database 26ai property graph examples.
  - `property-graph/19c/` for Oracle Database 19c property graph examples.
  - `property-graph/algorithms/` for graph algorithm samples.
  - `shared/` for reusable datasets, utilities, and cross-domain demos.
  - `property-graph/docs/` for compatibility and migration guidance.

### Moved
- `get-started-26ai/` -> `property-graph/26ai/get-started/`
- `get-started-19c/` -> `property-graph/19c/get-started/`
- `26ai-graph-demos/` -> `property-graph/26ai/demos/`
- `built-in-algorithms/` -> `property-graph/algorithms/built-in/`

### Added
- Root README navigation for choosing between 26ai, 19c, algorithms, shared assets, and docs.
- `shared/demos/financial-crime-investigation-agent/` for a financial crime investigation demo that combines property graph, RDF Graph, Select AI, OWL2RL inference, and `DBMS_CLOUD_AI_AGENT`.
