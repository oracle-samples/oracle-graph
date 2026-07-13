-- Financial Crime Investigation Demo
-- Step 2: load synthetic data.
--
-- The base data comes from oracle-graph-agent-demo-build-guide.md.
-- The RDF notebook adds C700/A700 as a clean contrast case for inference.
-- C300 is assigned to XZ here so relational, property graph, and RDF stories agree.

INSERT INTO countries VALUES ('US', 'United States', 'STANDARD');
INSERT INTO countries VALUES ('GB', 'United Kingdom', 'STANDARD');
INSERT INTO countries VALUES ('AE', 'United Arab Emirates', 'ELEVATED');
INSERT INTO countries VALUES ('XZ', 'Example Sanctioned Jurisdiction', 'SANCTIONED');

INSERT INTO customers VALUES ('C100', 'Alice Rivera', 'PERSON', 'US', 35);
INSERT INTO customers VALUES ('C200', 'Ben Holt', 'PERSON', 'US', 20);
INSERT INTO customers VALUES ('C300', 'Kiran Shah', 'PERSON', 'XZ', 88);
INSERT INTO customers VALUES ('C400', 'Metro Imports LLC', 'BUSINESS', 'AE', 62);
INSERT INTO customers VALUES ('C500', 'Vega Holdings', 'BUSINESS', 'XZ', 91);
INSERT INTO customers VALUES ('C600', 'Noor Haddad', 'PERSON', 'AE', 58);
INSERT INTO customers VALUES ('C700', 'Maya Chen', 'PERSON', 'US', 12);

INSERT INTO accounts VALUES ('A100', 'CHECKING', DATE '2024-02-11', 'ACTIVE');
INSERT INTO accounts VALUES ('A200', 'CHECKING', DATE '2024-04-20', 'ACTIVE');
INSERT INTO accounts VALUES ('A300', 'CHECKING', DATE '2024-05-01', 'ACTIVE');
INSERT INTO accounts VALUES ('A400', 'BUSINESS', DATE '2023-10-19', 'ACTIVE');
INSERT INTO accounts VALUES ('A500', 'BUSINESS', DATE '2023-11-08', 'ACTIVE');
INSERT INTO accounts VALUES ('A600', 'CHECKING', DATE '2024-06-13', 'ACTIVE');
INSERT INTO accounts VALUES ('A700', 'CHECKING', DATE '2024-07-04', 'ACTIVE');

INSERT INTO account_owners VALUES ('A100', 'C100', 'PRIMARY');
INSERT INTO account_owners VALUES ('A200', 'C200', 'PRIMARY');
INSERT INTO account_owners VALUES ('A300', 'C300', 'PRIMARY');
INSERT INTO account_owners VALUES ('A400', 'C400', 'PRIMARY');
INSERT INTO account_owners VALUES ('A500', 'C500', 'PRIMARY');
INSERT INTO account_owners VALUES ('A600', 'C600', 'PRIMARY');
INSERT INTO account_owners VALUES ('A700', 'C700', 'PRIMARY');

INSERT INTO devices VALUES ('D100', 'fp-mobile-7a91', SYSTIMESTAMP - INTERVAL '30' DAY);
INSERT INTO devices VALUES ('D200', 'fp-laptop-443e', SYSTIMESTAMP - INTERVAL '20' DAY);
INSERT INTO devices VALUES ('D300', 'fp-vpn-91aa', SYSTIMESTAMP - INTERVAL '10' DAY);

INSERT INTO logins VALUES ('L100', 'A100', 'D100', SYSTIMESTAMP - INTERVAL '7' DAY);
INSERT INTO logins VALUES ('L101', 'A300', 'D100', SYSTIMESTAMP - INTERVAL '6' DAY);
INSERT INTO logins VALUES ('L102', 'A200', 'D200', SYSTIMESTAMP - INTERVAL '5' DAY);
INSERT INTO logins VALUES ('L103', 'A400', 'D200', SYSTIMESTAMP - INTERVAL '4' DAY);
INSERT INTO logins VALUES ('L104', 'A500', 'D300', SYSTIMESTAMP - INTERVAL '3' DAY);

INSERT INTO transactions VALUES ('T100', 'A100', 'A200', 9800, 'USD', 'WIRE', SYSTIMESTAMP - INTERVAL '72' HOUR);
INSERT INTO transactions VALUES ('T101', 'A200', 'A300', 9700, 'USD', 'WIRE', SYSTIMESTAMP - INTERVAL '60' HOUR);
INSERT INTO transactions VALUES ('T102', 'A300', 'A400', 9600, 'USD', 'WIRE', SYSTIMESTAMP - INTERVAL '48' HOUR);
INSERT INTO transactions VALUES ('T103', 'A400', 'A100', 9500, 'USD', 'WIRE', SYSTIMESTAMP - INTERVAL '36' HOUR);
INSERT INTO transactions VALUES ('T104', 'A300', 'A500', 24000, 'USD', 'WIRE', SYSTIMESTAMP - INTERVAL '30' HOUR);
INSERT INTO transactions VALUES ('T105', 'A500', 'A600', 23000, 'USD', 'WIRE', SYSTIMESTAMP - INTERVAL '24' HOUR);

INSERT INTO investigation_cases(case_id, alerted_account, alert_type, priority)
VALUES ('CASE-1042', 'A100', 'Rapid movement with shared device and high-risk counterparty', 'HIGH');

COMMIT;
