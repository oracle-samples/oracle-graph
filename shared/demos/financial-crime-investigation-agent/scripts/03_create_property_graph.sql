-- Financial Crime Investigation Demo
-- Step 3: create and query the property graph.
--
-- The property graph turns the relational tables into an investigation network:
-- customers own accounts, accounts transfer money, accounts use devices, and cases flag accounts.

BEGIN
  EXECUTE IMMEDIATE 'DROP PROPERTY GRAPH bank_investigation_graph';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE PROPERTY GRAPH bank_investigation_graph
  VERTEX TABLES (
    customers
      KEY (customer_id)
      LABEL customer
      PROPERTIES (customer_id, full_name, customer_type, country_code, risk_score),

    accounts
      KEY (account_id)
      LABEL account
      PROPERTIES (account_id, account_type, open_date, status),

    devices
      KEY (device_id)
      LABEL device
      PROPERTIES (device_id, device_fingerprint, first_seen_ts),

    investigation_cases
      KEY (case_id)
      LABEL investigation_case
      PROPERTIES (case_id, alerted_account, alert_type, case_status, priority, created_ts)
  )
  EDGE TABLES (
    account_owners
      KEY (account_id, customer_id)
      SOURCE KEY (account_id) REFERENCES accounts (account_id)
      DESTINATION KEY (customer_id) REFERENCES customers (customer_id)
      LABEL owned_by
      PROPERTIES (owner_role),

    transactions
      KEY (transaction_id)
      SOURCE KEY (from_account_id) REFERENCES accounts (account_id)
      DESTINATION KEY (to_account_id) REFERENCES accounts (account_id)
      LABEL transferred_to
      PROPERTIES (transaction_id, amount, currency_code, channel, transaction_ts),

    logins
      KEY (login_id)
      SOURCE KEY (account_id) REFERENCES accounts (account_id)
      DESTINATION KEY (device_id) REFERENCES devices (device_id)
      LABEL used_device
      PROPERTIES (login_id, login_ts),

    investigation_cases AS case_account_edge
      KEY (case_id)
      SOURCE KEY (case_id) REFERENCES investigation_cases (case_id)
      DESTINATION KEY (alerted_account) REFERENCES accounts (account_id)
      LABEL flagged_account
      PROPERTIES (alert_type, priority)
  );

-- Query A: accounts reached from the alerted account within three transfer hops.
SELECT *
FROM GRAPH_TABLE (
  bank_investigation_graph
  MATCH (a IS account) -[t IS transferred_to]->{1,3} (b IS account)
  WHERE a.account_id = 'A100'
  ONE ROW PER STEP (src, hop, dst)
  COLUMNS (
    vertex_id(src) AS src_id,
    edge_id(hop)   AS hop_id,
    vertex_id(dst) AS dst_id
  )
);

-- Query B: shared device evidence linking A100 to another account.
SELECT *
FROM GRAPH_TABLE (
  bank_investigation_graph
  MATCH (a1 IS account) -[u1 IS used_device]-> (d IS device) <-[u2 IS used_device]- (a2 IS account)
  WHERE a1.account_id = 'A100'
    AND a2.account_id <> a1.account_id
  ONE ROW PER MATCH
  COLUMNS (
    vertex_id(a1) AS a1_id,
    vertex_id(d)  AS device_id,
    vertex_id(a2) AS related_account_id,
    edge_id(u1)   AS a1_device_edge_id,
    edge_id(u2)   AS a2_device_edge_id
  )
);

-- Query C: case-to-customer context for the analyst.
SELECT case_id, account_id, customer_id, full_name, risk_score
FROM GRAPH_TABLE (
  bank_investigation_graph
  MATCH (c IS investigation_case) -[IS flagged_account]-> (a IS account)
        -[IS owned_by]-> (cust IS customer)
  WHERE c.case_id = 'CASE-1042'
  COLUMNS (
    c.case_id AS case_id,
    a.account_id AS account_id,
    cust.customer_id AS customer_id,
    cust.full_name AS full_name,
    cust.risk_score AS risk_score
  )
);
