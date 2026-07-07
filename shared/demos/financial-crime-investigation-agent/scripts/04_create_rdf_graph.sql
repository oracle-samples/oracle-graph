-- Financial Crime Investigation Demo
-- Step 5: create and load the RDF graph.
--
-- The RDF graph stores the semantic layer: ontology classes, OWL2RL restrictions,
-- case/entity facts, and contrast data used to show inference.
--
-- Run the RDF network creation below as a privileged user if your RDF network does
-- not already exist. Then run the rest as FINANCIAL_DEMO.
--
-- CREATE TABLESPACE rdf_tblspace
--   DATAFILE 'rdf_tblspace.dat'
--   SIZE 128M REUSE
--   AUTOEXTEND ON NEXT 128M MAXSIZE 4G
--   SEGMENT SPACE MANAGEMENT AUTO;
--
-- EXECUTE SEM_APIS.CREATE_RDF_NETWORK(
--   'rdf_tblspace',
--   network_owner => 'FINANCIAL_DEMO',
--   network_name  => 'RDF_NETWORK'
-- );

BEGIN
  SEM_APIS.CREATE_RDF_GRAPH(
    'BANK_RISK_KG',
    'null',
    'null',
    network_owner => 'FINANCIAL_DEMO',
    network_name  => 'RDF_NETWORK'
  );
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('RDF graph may already exist: ' || SQLERRM);
END;
/

-- TBox: the reasoning blueprint. These are the rules and class hierarchies.
BEGIN
  SEM_APIS.UPDATE_RDF_GRAPH('BANK_RISK_KG',
    'PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
     PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
     PREFIX owl:  <http://www.w3.org/2002/07/owl#>
     PREFIX aml:  <http://example.com/aml#>
     INSERT DATA {
       aml:Customer rdf:type owl:Class .
       aml:Account  rdf:type owl:Class .
       aml:Case     rdf:type owl:Class .
       aml:AMLTypology          rdf:type owl:Class .
       aml:InvestigationFinding rdf:type owl:Class .
       aml:Jurisdiction         rdf:type owl:Class .

       aml:SanctionedJurisdiction rdfs:subClassOf aml:HighRiskJurisdiction .
       aml:ElevatedJurisdiction   rdfs:subClassOf aml:HighRiskJurisdiction .
       aml:HighRiskJurisdiction   rdfs:subClassOf aml:Jurisdiction .

       aml:BusinessCustomer rdfs:subClassOf aml:Customer .
       aml:BeneficialOwner  rdfs:subClassOf aml:Customer .

       aml:RapidMovementTypology rdfs:subClassOf aml:AMLTypology .
       aml:MuleAccountTypology   rdfs:subClassOf aml:AMLTypology .

       aml:RequiresSARReview            rdfs:subClassOf aml:InvestigationFinding .
       aml:RequiresEnhancedDueDiligence rdfs:subClassOf aml:InvestigationFinding .
       aml:HighRiskCustomer             rdfs:subClassOf aml:RequiresEnhancedDueDiligence .

       aml:SanctionedCounterpartyCaseWithCycle rdfs:subClassOf aml:RapidMovementTypology .
       aml:SanctionedCounterpartyCaseWithCycle rdfs:subClassOf aml:MuleAccountTypology .
       aml:SanctionedCounterpartyCaseWithCycle rdfs:subClassOf aml:RequiresSARReview .

       aml:PersonalAccountInHighValueChain rdfs:subClassOf aml:PersonalAccount .
       aml:PersonalAccountInHighValueChain rdfs:subClassOf aml:MuleAccountTypology .

       aml:HighRiskCustomer owl:equivalentClass [
         rdf:type owl:Restriction ;
         owl:onProperty aml:hasResidenceCountry ;
         owl:someValuesFrom aml:HighRiskJurisdiction ] .

       aml:PersonalAccount owl:equivalentClass [
         rdf:type owl:Restriction ;
         owl:onProperty aml:ownedByPersonCustomer ;
         owl:someValuesFrom aml:Customer ] .

       aml:hasResidenceCountry            rdf:type owl:ObjectProperty .
       aml:ownedByPersonCustomer          rdf:type owl:ObjectProperty .
       aml:involvesSanctionedCounterparty rdf:type owl:ObjectProperty .
       aml:involvesTransitAccount         rdf:type owl:ObjectProperty .
       aml:involvesRelatedAccount         rdf:type owl:ObjectProperty .
     }',
    network_owner => 'FINANCIAL_DEMO',
    network_name  => 'RDF_NETWORK');
END;
/

-- ABox: raw instance facts. Risk labels are intentionally not directly asserted
-- for C300, A300, or CASE-1042; OWL2RL derives them.
BEGIN
  SEM_APIS.UPDATE_RDF_GRAPH('BANK_RISK_KG',
    'PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
     PREFIX aml: <http://example.com/aml#>
     INSERT DATA {
       aml:C100 rdf:type aml:Customer .
       aml:C200 rdf:type aml:Customer .
       aml:C300 rdf:type aml:Customer .
       aml:C300 aml:hasResidenceCountry aml:XZ .
       aml:C400 rdf:type aml:BusinessCustomer .
       aml:C400 aml:hasResidenceCountry aml:AE .
       aml:C500 rdf:type aml:BusinessCustomer .
       aml:C500 rdf:type aml:BeneficialOwner .
       aml:C500 aml:hasResidenceCountry aml:XZ .
       aml:C600 rdf:type aml:Customer .
       aml:C700 rdf:type aml:Customer .
       aml:C700 aml:hasResidenceCountry aml:US .

       aml:XZ rdf:type aml:SanctionedJurisdiction .
       aml:AE rdf:type aml:ElevatedJurisdiction .
       aml:US rdf:type aml:Jurisdiction .

       aml:A300 rdf:type aml:Account .
       aml:A300 aml:ownedByPersonCustomer aml:C300 .
       aml:A300 rdf:type aml:PersonalAccountInHighValueChain .
       aml:A500 rdf:type aml:Account .
       aml:A500 aml:ownedByPersonCustomer aml:C500 .
       aml:A700 rdf:type aml:Account .
       aml:A700 aml:ownedByPersonCustomer aml:C700 .

       aml:CASE-1042 rdf:type aml:Case .
       aml:CASE-1042 rdf:type aml:SanctionedCounterpartyCaseWithCycle .
       aml:CASE-1042 aml:involvesSanctionedCounterparty aml:C500 .
       aml:CASE-1042 aml:involvesTransitAccount aml:A300 .
       aml:CASE-1042 aml:involvesRelatedAccount aml:A500 .
     }',
    network_owner => 'FINANCIAL_DEMO',
    network_name  => 'RDF_NETWORK');
END;
/

-- Build the OWL2RL inference index for this model/rulebase combination.
-- SEM_MATCH with SEM_RULEBASES('OWL2RL') needs this index before it can
-- return inferred classifications. Re-run this block after changing RDF data.
BEGIN
  SEM_APIS.CREATE_INFERRED_GRAPH(
    'BANK_RISK_KG_OWL2RL_IDX',
    SEM_MODELS('BANK_RISK_KG'),
    SEM_RULEBASES('OWL2RL'),
    network_owner => 'FINANCIAL_DEMO',
    network_name  => 'RDF_NETWORK'
  );
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -13199 THEN
      DBMS_OUTPUT.PUT_LINE('OWL2RL inferred graph already exists; continuing.');
    ELSE
      RAISE;
    END IF;
END;
/

-- Contrast: C300 without OWL2RL shows only asserted facts.
SELECT RTRIM(REGEXP_REPLACE(class$rdfterm, '^.*#', ''), '>') AS asserted_only
FROM TABLE(SEM_MATCH(
  'PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
   PREFIX aml: <http://example.com/aml#>
   SELECT ?class WHERE { aml:C300 rdf:type ?class . }',
  SEM_MODELS('BANK_RISK_KG'), null,
  null, null, null, ' PLUS_RDFT=VC ', null, null,
  'FINANCIAL_DEMO', 'RDF_NETWORK'
))
WHERE class$rdfterm LIKE '%example.com/aml%'
ORDER BY 1;

-- With OWL2RL, the database derives HighRiskCustomer and RequiresEnhancedDueDiligence.
SELECT RTRIM(REGEXP_REPLACE(class$rdfterm, '^.*#', ''), '>') AS classification
FROM TABLE(SEM_MATCH(
  'PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
   PREFIX aml: <http://example.com/aml#>
   SELECT ?class WHERE { aml:C300 rdf:type ?class . }',
  SEM_MODELS('BANK_RISK_KG'), SEM_RULEBASES('OWL2RL'),
  null, null, null, ' PLUS_RDFT=VC ', null, null,
  'FINANCIAL_DEMO', 'RDF_NETWORK'
))
WHERE class$rdfterm LIKE '%example.com/aml%'
ORDER BY 1;
