# Financial Crime Investigation Graph, RDF, and AI Agents

This demo shows a financial-crime investigation workflow that combines Oracle property graph, Oracle RDF Graph, Select AI, and `DBMS_CLOUD_AI_AGENT`.

The core story is `CASE-1042`:

- The property graph finds a transfer chain from `A100` and shared-device evidence linking `A100` to `A300`.
- The RDF graph explains semantic risk using an AML ontology and OWL2RL inference.
- The AI agent exposes fixed and dynamic RDF tools for case, customer, account, and exploratory questions.

## Contents

| Path | Purpose |
| --- | --- |
| [`scripts/financial-crime-investigation-full-demo.sql`](scripts/financial-crime-investigation-full-demo.sql) | One runnable SQL script with the full demo flow and explanatory comments. |
| [`scripts/01_create_tables.sql`](scripts/01_create_tables.sql) | Relational table DDL. |
| [`scripts/02_load_demo_data.sql`](scripts/02_load_demo_data.sql) | Synthetic demo data inserts. |
| [`scripts/03_create_property_graph.sql`](scripts/03_create_property_graph.sql) | Property graph DDL and proof queries. |
| [`scripts/04_create_rdf_graph.sql`](scripts/04_create_rdf_graph.sql) | RDF graph setup, ontology, facts, and OWL2RL inference checks. |
| [`scripts/05_create_rdf_agent.sql`](scripts/05_create_rdf_agent.sql) | RDF helper functions and `DBMS_CLOUD_AI_AGENT` setup. |
| [`graph-studio-notebooks/financial-crime-investigation-graph-rdf-ai-agents.dsnb`](graph-studio-notebooks/financial-crime-investigation-graph-rdf-ai-agents.dsnb) | Graph Studio notebook version of the full demo flow. |
| [`docs/datasets.md`](docs/datasets.md) | Dataset inventory and source notes. |

## Prerequisites

- Oracle AI Database 26ai or Autonomous AI Database 26ai.
- A database user for the demo, for example `FINANCIAL_DEMO`.
- Graph privileges for the demo user, including `GRAPH_DEVELOPER`.
- RDF Graph support enabled.
- An RDF network available to the demo schema. The scripts assume network owner `FINANCIAL_DEMO` and network name `RDF_NETWORK`.
- Select AI configured with an OCI Generative AI credential named `AI_CREDENTIAL`.
- Access to `DBMS_CLOUD_AI`, `DBMS_CLOUD_AI_AGENT`, and RDF packages such as `SEM_APIS`.

The demo uses inline synthetic data. No external CSV files are required.

## Before You Run

The scripts include safe placeholders instead of credentials or compartment identifiers. Update these values before running the Select AI and agent portions:

| Placeholder or literal | Where | What to update |
| --- | --- | --- |
| `<your_oci_region>` | Select AI profile section | OCI region for Generative AI. |
| `<your_compartment_ocid>` | Select AI profile section | OCI compartment OCID. |
| `FINANCIAL_DEMO` | RDF and Select AI sections | Replace if your schema name differs. |
| `RDF_NETWORK` | RDF sections | Replace if your RDF network name differs. |
| `AI_CREDENTIAL` | Select AI profile section | Replace if your credential name differs. |

## Option A: Run The Full Script

Use this path for a single end-to-end SQL Developer, SQLcl, Database Actions, or Graph Studio SQL worksheet demo.

1. Connect as the demo schema.
2. Open [`scripts/financial-crime-investigation-full-demo.sql`](scripts/financial-crime-investigation-full-demo.sql).
3. Update the Select AI placeholders.
4. Verify the RDF network owner and network name.
5. Run the script from top to bottom.

The full script creates relational tables, loads synthetic data, creates the property graph, configures Select AI, creates the RDF graph, builds the OWL2RL inferred graph, creates AI agent tools, and runs example questions.

## Option B: Run The Step Scripts

Use this path when presenting the demo interactively or debugging one layer at a time.

1. Run [`scripts/01_create_tables.sql`](scripts/01_create_tables.sql).
2. Run [`scripts/02_load_demo_data.sql`](scripts/02_load_demo_data.sql).
3. Run [`scripts/03_create_property_graph.sql`](scripts/03_create_property_graph.sql).
4. Configure Select AI using the profile section in the full script.
5. Create or verify the RDF network.
6. Run [`scripts/04_create_rdf_graph.sql`](scripts/04_create_rdf_graph.sql).
7. Run [`scripts/05_create_rdf_agent.sql`](scripts/05_create_rdf_agent.sql).

## Option C: Use Graph Studio

Import [`graph-studio-notebooks/financial-crime-investigation-graph-rdf-ai-agents.dsnb`](graph-studio-notebooks/financial-crime-investigation-graph-rdf-ai-agents.dsnb) into Graph Studio and run the paragraphs in order.

The notebook follows the same chronological flow as the full SQL script, with markdown narration for a live demo.

## Objects Created

| Object type | Names |
| --- | --- |
| Tables | `COUNTRIES`, `CUSTOMERS`, `ACCOUNTS`, `ACCOUNT_OWNERS`, `DEVICES`, `LOGINS`, `TRANSACTIONS`, `INVESTIGATION_CASES`, `CASE_NOTES` |
| Property graph | `BANK_INVESTIGATION_GRAPH` |
| Select AI profile | `OCI_GENAI_PROFILE` |
| RDF graph | `BANK_RISK_KG` |
| Inferred RDF graph | `BANK_RISK_KG_OWL2RL_IDX` |
| Functions | `GET_AML_ONTOLOGY_SCHEMA`, `RUN_AML_SPARQL`, `AML_RDF_CASE_EVIDENCE`, `AML_RDF_CUSTOMER_CLASSIFICATION` |
| AI agent objects | `AML_RDF_CASE_TEAM`, `AML_RDF_CASE_AGENT`, `AML_RDF_CASE_TASK`, `AML_RDF_CASE_EVIDENCE_TOOL`, `AML_RDF_ENTITY_TOOL`, `AML_ONTOLOGY_SCHEMA_TOOL`, `AML_RDF_QUERY_TOOL` |

## Expected Results

- `A100` reaches `A200`, `A300`, and `A400` within three transfer hops.
- `A100` and `A300` share device `D100`.
- `C300` is inferred as `HighRiskCustomer` because it has residence country `XZ`, and `XZ` is a sanctioned jurisdiction.
- `A300` is inferred as `PersonalAccount` because it is owned by customer `C300`.
- The RDF agent can explain case and entity risk for prompts about `CASE-1042`, `C300`, and `A300`.

## Notes

- The data is synthetic and intentionally small for a repeatable demo.
- The scripts do not commit real credentials, wallet files, compartment OCIDs, or connection strings.
- If you re-run the demo, the table and property graph sections drop and recreate their objects. Review the RDF graph section before re-running if you want to preserve an existing RDF network or model.
