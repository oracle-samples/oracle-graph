# Dataset Inventory

This demo uses inline synthetic data. No external CSV files are required.

The base relational data comes from oracle-graph-agent-demo-build-guide.md. The RDF notebook adds the clean contrast customer/account C700/A700 and uses C300 as the sanctioned-jurisdiction inference example.

## Relational Tables

| Table | Rows | Purpose |
| --- | ---: | --- |
| countries | 4 | Jurisdiction reference data: US, GB, AE, XZ. |
| customers | 7 | Customers and businesses used as account owners. C300 and C500 are in XZ; C700 is the clean US contrast. |
| accounts | 7 | Bank accounts A100 through A700. |
| account_owners | 7 | Ownership edges between accounts and customers. |
| devices | 3 | Device fingerprints used as shared-device evidence. |
| logins | 5 | Account-to-device events. A100 and A300 share D100. |
| transactions | 6 | Transfer chain and cycle evidence among A100, A200, A300, A400, A500, and A600. |
| investigation_cases | 1 | CASE-1042 flags A100 for rapid movement, shared device, and high-risk counterparty evidence. |
| case_notes | 0 initially | Optional analyst notes table for an APEX or agent workflow. |

## RDF Facts

| RDF area | Key entities | Purpose |
| --- | --- | --- |
| TBox classes | Customer, Account, Case, AMLTypology, InvestigationFinding, Jurisdiction | Defines the semantic vocabulary. |
| TBox hierarchy | SanctionedJurisdiction -> HighRiskJurisdiction, HighRiskCustomer -> RequiresEnhancedDueDiligence | Allows subclass inference. |
| OWL restrictions | hasResidenceCountry some HighRiskJurisdiction -> HighRiskCustomer; ownedByPersonCustomer some Customer -> PersonalAccount | Produces derived classifications under OWL2RL. |
| ABox customer facts | C300 -> XZ, C700 -> US, C500 -> XZ | Shows high-risk and clean contrast behavior. |
| ABox account facts | A300 ownedByPersonCustomer C300, A700 ownedByPersonCustomer C700 | Lets RDF classify accounts independently from the property graph. |
| ABox case facts | CASE-1042 involves C500, A300, A500 and is a SanctionedCounterpartyCaseWithCycle | Lets the agent answer case-level RDF questions. |

## Demo Evidence

- Property graph: A100 reaches A200, A300, and A400 within three transfer hops.
- Property graph: A100 and A300 share device D100 / fp-mobile-7a91.
- RDF: C300 is inferred as HighRiskCustomer because it has residence country XZ, and XZ is a SanctionedJurisdiction.
- RDF: A300 is inferred as PersonalAccount because it is owned by C300, a Customer.
- Agent: CASE-1042, C300, and A300 questions route to fixed RDF tools; open-ended ontology questions route to dynamic SPARQL.
