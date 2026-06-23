# Simple RDF FOAF Example

This starter example provides a small RDF dataset and SPARQL queries that can be used when adding an Oracle RDF walkthrough.

It is intentionally small so users can inspect the triples and understand what each query returns before moving to larger semantic graph examples.

## Files

| Path | Purpose |
| --- | --- |
| [`data/people.ttl`](data/people.ttl) | Turtle dataset with people and friendship relationships. |
| [`queries/friends-of-alice.sparql`](queries/friends-of-alice.sparql) | Finds Alice's direct friends. |
| [`queries/people-and-interests.sparql`](queries/people-and-interests.sparql) | Lists people and their interests. |

## Expected Output

The friends query should return Bob and Carol as Alice's direct friends. The interests query should return each person with one or more interests such as graphs, databases, or semantic web.

## Next Steps

When this example is expanded into a runnable Oracle RDF demo, add the database setup steps here, including how to load the Turtle file, run the SPARQL queries, and clean up the RDF model.

## Related Links

- RDF examples: [`../../`](../../)
- Knowledge graph examples: [`../../../knowledge-graph/`](../../../knowledge-graph/)
