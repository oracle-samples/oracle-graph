# Changelog

Notable changes to this repository, newest first.

This format follows [Keep a Changelog](https://keepachangelog.com/). Version numbers align with major Oracle Graph release milestones.

## Added

- Added `LEARNING_PATH.md`, a guided learning sequence through the repository content.
- Added the Oracle SQL Developer Graph Visualization extension for VS Code to `README.md`, `LEARNING_PATH.md`, and `tools/README.md`.

## Changed

- Reworked the `README.md` Start Here section: aligned new-user guidance with the learning path, added RDF and compatibility/migration rows, and merged the duplicate Common Use Cases table into it. Added `tools/` and `LEARNING_PATH.md` to Repository Contents and the Folder Guide.
- Streamlined `LEARNING_PATH.md`: removed the route table that duplicated the README, and added the 19c migration guide, graph algorithms, cross-domain demos, and tools to the sequence.
- Updated Oracle Property Graph documentation link from Release 26.1 to [26.2](https://docs.oracle.com/en/database/oracle/property-graph/26.2/index.html) in `property-graph/26ai/README.md`.
- Improved `tools/graphviz-demo/README.md`: switched to consistent asterisk list markers, reordered query language references (SQL:2023 before PGQL), fixed grammar/spacing/emphasis in multiple sections, clarified quick start and version compatibility notes.
- Updated `tools/jupyter-notebooks/requirements.txt` to use the current `oraclegraph` package (replacing the previous `oracle-graph-client`).
- Standardized CHANGELOG.md section headers (changed `###` to `##` for consistency with top-level sections) and added whitespace.
