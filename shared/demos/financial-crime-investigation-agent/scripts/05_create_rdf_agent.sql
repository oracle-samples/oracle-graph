-- Financial Crime Investigation Demo
-- Step 6: create RDF helper functions and AI agent tools.
--
-- These functions are used as DBMS_CLOUD_AI_AGENT tools. The fixed tools run
-- predictable SPARQL for cases/entities, while the dynamic tool lets the LLM
-- inspect the live ontology before writing SPARQL.

CREATE OR REPLACE FUNCTION get_aml_ontology_schema RETURN CLOB
AUTHID DEFINER
IS
  l_result  CLOB := TO_CLOB('');
  l_sql     CLOB;
  TYPE t_cur IS REF CURSOR;
  c_cur     t_cur;
  l_a       VARCHAR2(4000);
  l_b       VARCHAR2(4000);
  l_c       VARCHAR2(4000);
  l_found   BOOLEAN;
  PROCEDURE add_line(p_text IN VARCHAR2) IS
  BEGIN l_result := l_result || p_text || CHR(10); END;
  PROCEDURE clean(p_in IN OUT VARCHAR2) IS
  BEGIN p_in := REGEXP_REPLACE(p_in, '^.*#|>$', ''); END;
BEGIN
  add_line('ONTOLOGY: BANK_RISK_KG');
  add_line('Base URI: http://example.com/aml# (abbreviated as aml:)');
  add_line('Network: FINANCIAL_DEMO / RDF_NETWORK');
  add_line('Reasoning: use SEM_RULEBASES(''OWL2RL'') for inferred results');
  add_line('');

  add_line('--- CLASS HIERARCHY ---');
  l_sql := SEM_APIS.SPARQL_TO_SQL(
    'PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
     PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
     PREFIX owl:  <http://www.w3.org/2002/07/owl#>
     SELECT ?child ?parent WHERE {
       ?child rdf:type owl:Class .
       ?child rdfs:subClassOf ?parent .
       FILTER(isIRI(?parent)) }',
    SEM_MODELS('BANK_RISK_KG'), null,
    null, null, ' PLUS_RDFT=VC ', null, null,
    'FINANCIAL_DEMO', 'RDF_NETWORK'
  );
  l_sql := 'SELECT child$rdfterm, parent$rdfterm FROM (' || l_sql ||
           ') WHERE child$rdfterm LIKE ''%example.com/aml%'' ORDER BY child$rdfterm';
  l_found := FALSE;
  OPEN c_cur FOR l_sql;
  LOOP FETCH c_cur INTO l_a, l_b; EXIT WHEN c_cur%NOTFOUND;
    l_found := TRUE; clean(l_a); clean(l_b);
    add_line('  aml:' || l_a || ' subClassOf aml:' || l_b);
  END LOOP; CLOSE c_cur;
  IF NOT l_found THEN add_line('  (none found)'); END IF;
  add_line('');

  add_line('--- OWL RESTRICTIONS (inference rules) ---');
  add_line('Anything matching (has aml:property some aml:range) => aml:targetClass');
  l_sql := SEM_APIS.SPARQL_TO_SQL(
    'PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
     PREFIX owl: <http://www.w3.org/2002/07/owl#>
     SELECT ?targetClass ?onProperty ?someValuesFrom WHERE {
       ?targetClass owl:equivalentClass ?r .
       ?r rdf:type owl:Restriction .
       ?r owl:onProperty ?onProperty .
       ?r owl:someValuesFrom ?someValuesFrom . }',
    SEM_MODELS('BANK_RISK_KG'), null,
    null, null, ' PLUS_RDFT=VC ', null, null,
    'FINANCIAL_DEMO', 'RDF_NETWORK'
  );
  l_sql := 'SELECT targetclass$rdfterm, onproperty$rdfterm, somevaluesfrom$rdfterm
            FROM (' || l_sql || ')
            WHERE targetclass$rdfterm LIKE ''%example.com/aml%''
            ORDER BY targetclass$rdfterm';
  l_found := FALSE;
  OPEN c_cur FOR l_sql;
  LOOP FETCH c_cur INTO l_a, l_b, l_c; EXIT WHEN c_cur%NOTFOUND;
    l_found := TRUE; clean(l_a); clean(l_b); clean(l_c);
    add_line('  aml:' || l_a || ' <=> (has aml:' || l_b || ' some aml:' || l_c || ')');
  END LOOP; CLOSE c_cur;
  IF NOT l_found THEN add_line('  (none found)'); END IF;
  add_line('');

  add_line('--- OBJECT PROPERTIES ---');
  l_sql := SEM_APIS.SPARQL_TO_SQL(
    'PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
     PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
     PREFIX owl:  <http://www.w3.org/2002/07/owl#>
     SELECT ?prop ?domain ?range WHERE {
       ?prop rdf:type owl:ObjectProperty .
       OPTIONAL { ?prop rdfs:domain ?domain . }
       OPTIONAL { ?prop rdfs:range  ?range  . } }',
    SEM_MODELS('BANK_RISK_KG'), null,
    null, null, ' PLUS_RDFT=VC ', null, null,
    'FINANCIAL_DEMO', 'RDF_NETWORK'
  );
  l_sql := 'SELECT prop$rdfterm, domain$rdfterm, range$rdfterm
            FROM (' || l_sql || ')
            WHERE prop$rdfterm LIKE ''%example.com/aml%''
            ORDER BY prop$rdfterm';
  l_found := FALSE;
  OPEN c_cur FOR l_sql;
  LOOP FETCH c_cur INTO l_a, l_b, l_c; EXIT WHEN c_cur%NOTFOUND;
    l_found := TRUE; clean(l_a); clean(l_b); clean(l_c);
    add_line('  aml:' || l_a || '  domain:' || NVL(l_b,'(any)') ||
             '  range:' || NVL(l_c,'(any)'));
  END LOOP; CLOSE c_cur;
  IF NOT l_found THEN add_line('  (none found)'); END IF;
  add_line('');

  add_line('--- SPARQL WRITING RULES ---');
  add_line('  1. Always declare prefixes.');
  add_line('  2. Use OWL2RL rulebase for inferred classifications.');
  add_line('  3. Filter internal findings to example.com/aml.');
  add_line('  4. For portfolio sweeps use variables ?cust and ?country.');
  add_line('  5. For classification queries use variable ?finding.');

  RETURN l_result;
EXCEPTION WHEN OTHERS THEN
  RETURN 'Error in GET_AML_ONTOLOGY_SCHEMA: ' || SQLERRM;
END;
/

CREATE OR REPLACE FUNCTION run_aml_sparql(p_sparql IN CLOB) RETURN CLOB
AUTHID DEFINER
IS
  l_sql    CLOB;
  l_base   CLOB;
  l_result CLOB := TO_CLOB('');
  TYPE t_cur IS REF CURSOR;
  c_cur    t_cur;
  l_a      VARCHAR2(4000);
  l_b      VARCHAR2(4000);
  l_found  BOOLEAN := FALSE;
  PROCEDURE add_line(p_text IN VARCHAR2) IS
  BEGIN l_result := l_result || p_text || CHR(10); END;
  PROCEDURE clean(p_in IN OUT VARCHAR2) IS
  BEGIN p_in := REGEXP_REPLACE(p_in, '^.*#|>$', ''); END;
BEGIN
  add_line('[SPARQL]: ' || SUBSTR(p_sparql, 1, 500));
  add_line('');
  add_line('[RESULTS]:');

  l_base := SEM_APIS.SPARQL_TO_SQL(
    p_sparql, SEM_MODELS('BANK_RISK_KG'), SEM_RULEBASES('OWL2RL'),
    null, null, ' PLUS_RDFT=VC ', null, null,
    'FINANCIAL_DEMO', 'RDF_NETWORK'
  );

  BEGIN
    l_sql := 'SELECT entity$rdfterm, finding$rdfterm FROM (' || l_base || ')';
    OPEN c_cur FOR l_sql;
    LOOP FETCH c_cur INTO l_a, l_b; EXIT WHEN c_cur%NOTFOUND;
      l_found := TRUE; clean(l_a); clean(l_b);
      add_line(NVL(l_a,'(case)') || ' -> ' || l_b);
    END LOOP; CLOSE c_cur;
    IF l_found THEN RETURN l_result; END IF;
  EXCEPTION WHEN OTHERS THEN NULL; END;

  BEGIN
    l_sql := 'SELECT finding$rdfterm FROM (' || l_base || ')';
    OPEN c_cur FOR l_sql;
    LOOP FETCH c_cur INTO l_a; EXIT WHEN c_cur%NOTFOUND;
      l_found := TRUE; clean(l_a); add_line('- ' || l_a);
    END LOOP; CLOSE c_cur;
    IF l_found THEN RETURN l_result; END IF;
  EXCEPTION WHEN OTHERS THEN NULL; END;

  BEGIN
    l_sql := 'SELECT cust$rdfterm, country$rdfterm FROM (' || l_base || ')';
    OPEN c_cur FOR l_sql;
    LOOP FETCH c_cur INTO l_a, l_b; EXIT WHEN c_cur%NOTFOUND;
      l_found := TRUE; clean(l_a); clean(l_b);
      add_line(l_a || ' -> ' || l_b);
    END LOOP; CLOSE c_cur;
    IF l_found THEN RETURN l_result; END IF;
  EXCEPTION WHEN OTHERS THEN NULL; END;

  add_line('No results. Check URIs use aml:ENTITYID format.');
  RETURN l_result;
EXCEPTION WHEN OTHERS THEN
  RETURN l_result || CHR(10) || 'SPARQL error: ' || SQLERRM;
END;
/

CREATE OR REPLACE FUNCTION aml_rdf_case_evidence(p_case_id IN VARCHAR2) RETURN CLOB
AUTHID DEFINER
IS
  l_case_id VARCHAR2(128) := REGEXP_REPLACE(UPPER(p_case_id), '[^A-Z0-9_-]', '');
  l_sparql  CLOB;
BEGIN
  l_sparql :=
    'PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
     PREFIX aml: <http://example.com/aml#>
     SELECT ?entity ?finding WHERE {
       { aml:' || l_case_id || ' rdf:type ?finding . BIND(aml:' || l_case_id || ' AS ?entity) }
       UNION { aml:' || l_case_id || ' aml:involvesSanctionedCounterparty ?entity . ?entity rdf:type ?finding . }
       UNION { aml:' || l_case_id || ' aml:involvesTransitAccount ?entity . ?entity rdf:type ?finding . }
       UNION { aml:' || l_case_id || ' aml:involvesRelatedAccount ?entity . ?entity rdf:type ?finding . }
       FILTER(CONTAINS(STR(?finding), ''example.com/aml''))
     }';
  RETURN run_aml_sparql(l_sparql);
END;
/

CREATE OR REPLACE FUNCTION aml_rdf_customer_classification(p_customer_id IN VARCHAR2) RETURN CLOB
AUTHID DEFINER
IS
  l_entity_id VARCHAR2(128) := REGEXP_REPLACE(UPPER(p_customer_id), '[^A-Z0-9_-]', '');
  l_result    CLOB := TO_CLOB('');
BEGIN
  l_result := l_result || 'ENTITY CLASSIFICATION' || CHR(10);
  l_result := l_result || run_aml_sparql(
    'PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
     PREFIX aml: <http://example.com/aml#>
     SELECT ?entity ?finding WHERE {
       BIND(aml:' || l_entity_id || ' AS ?entity)
       aml:' || l_entity_id || ' rdf:type ?finding .
       FILTER(CONTAINS(STR(?finding), ''example.com/aml''))
     }'
  ) || CHR(10);

  l_result := l_result || 'RELATED CASES' || CHR(10);
  l_result := l_result || run_aml_sparql(
    'PREFIX aml: <http://example.com/aml#>
     SELECT ?finding WHERE {
       { ?finding aml:involvesSanctionedCounterparty aml:' || l_entity_id || ' . }
       UNION { ?finding aml:involvesTransitAccount aml:' || l_entity_id || ' . }
       UNION { ?finding aml:involvesRelatedAccount aml:' || l_entity_id || ' . }
     }'
  );
  RETURN l_result;
END;
/

-- Financial Crime Investigation Demo
-- Step 7: create AI agent tools, task, agent, and team.
--
-- Requires the OCI_GENAI_OPENAI Select AI profile from the Select AI setup step.

BEGIN DBMS_CLOUD_AI_AGENT.DROP_TEAM('AML_RDF_CASE_TEAM');          EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN DBMS_CLOUD_AI_AGENT.DROP_TASK('AML_RDF_CASE_TASK');          EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN DBMS_CLOUD_AI_AGENT.DROP_AGENT('AML_RDF_CASE_AGENT');        EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN DBMS_CLOUD_AI_AGENT.DROP_TOOL('AML_RDF_CASE_EVIDENCE_TOOL'); EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN DBMS_CLOUD_AI_AGENT.DROP_TOOL('AML_RDF_ENTITY_TOOL');        EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN DBMS_CLOUD_AI_AGENT.DROP_TOOL('AML_ONTOLOGY_SCHEMA_TOOL');   EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN DBMS_CLOUD_AI_AGENT.DROP_TOOL('AML_RDF_QUERY_TOOL');         EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
  DBMS_CLOUD_AI_AGENT.CREATE_TOOL(
    tool_name => 'AML_RDF_CASE_EVIDENCE_TOOL',
    attributes => q'[{
      "instruction": "Use this tool when the user gives a case id like CASE-1042. It returns RDF-inferred classifications for the case itself and every entity linked to it via involvesSanctionedCounterparty, involvesTransitAccount, and involvesRelatedAccount.",
      "function": "AML_RDF_CASE_EVIDENCE",
      "tool_inputs": [{"name": "p_case_id", "mandatory": true, "description": "Investigation case id, e.g. CASE-1042"}]
    }]',
    description => 'Fixed SPARQL tool for case-level RDF evidence with OWL2RL inference.'
  );
END;
/

BEGIN
  DBMS_CLOUD_AI_AGENT.CREATE_TOOL(
    tool_name => 'AML_RDF_ENTITY_TOOL',
    attributes => q'[{
      "instruction": "Use this tool when the user gives a customer or account id like C300 or A300. It classifies the entity using OWL2RL inference and reverse-lookups any investigation case that references it.",
      "function": "AML_RDF_CUSTOMER_CLASSIFICATION",
      "tool_inputs": [{"name": "p_customer_id", "mandatory": true, "description": "Customer or account id, e.g. C300 or A300"}]
    }]',
    description => 'Fixed SPARQL tool for entity classification and reverse case lookup.'
  );
END;
/

BEGIN
  DBMS_CLOUD_AI_AGENT.CREATE_TOOL(
    tool_name => 'AML_ONTOLOGY_SCHEMA_TOOL',
    attributes => q'[{
      "instruction": "Call this tool FIRST before writing any SPARQL. It returns the live ontology schema, class hierarchy, OWL restriction inference rules, and exact SPARQL writing rules.",
      "function": "GET_AML_ONTOLOGY_SCHEMA",
      "tool_inputs": []
    }]',
    description => 'Queries the live ontology so the LLM can write correct SPARQL.'
  );
END;
/

BEGIN
  DBMS_CLOUD_AI_AGENT.CREATE_TOOL(
    tool_name => 'AML_RDF_QUERY_TOOL',
    attributes => q'[{
      "instruction": "Execute a SPARQL SELECT query against BANK_RISK_KG with OWL2RL inference. Always call AML_ONTOLOGY_SCHEMA_TOOL first.",
      "function": "RUN_AML_SPARQL",
      "tool_inputs": [{"name": "p_sparql", "mandatory": true, "description": "Complete SPARQL SELECT query including PREFIX declarations"}]
    }]',
    description => 'Executes SPARQL SELECT against BANK_RISK_KG with OWL2RL inference.'
  );
END;
/

BEGIN
  DBMS_CLOUD_AI_AGENT.CREATE_TASK(
    task_name => 'AML_RDF_CASE_TASK',
    attributes => q'~{
      "instruction": "Answer the user request: {query}. ROUTING LOGIC: If the user gives a case id like CASE-1042, call AML_RDF_CASE_EVIDENCE_TOOL. If the user gives a customer or account id like C300 or A300, call AML_RDF_ENTITY_TOOL. For exploratory questions, call AML_ONTOLOGY_SCHEMA_TOOL first, then AML_RDF_QUERY_TOOL with SPARQL you write based on what you read. Use OWL2RL. Do not invent results. Explain whether classifications were directly asserted or inferred.",
      "tools": ["AML_RDF_CASE_EVIDENCE_TOOL", "AML_RDF_ENTITY_TOOL", "AML_ONTOLOGY_SCHEMA_TOOL", "AML_RDF_QUERY_TOOL"]
    }~',
    description => 'RDF investigation task: routes to fixed or dynamic tools based on question type.'
  );
END;
/

BEGIN
  DBMS_CLOUD_AI_AGENT.CREATE_AGENT(
    agent_name => 'AML_RDF_CASE_AGENT',
    attributes => q'[{
      "profile_name": "OCI_GENAI_OPENAI",
      "role": "You are an AML semantic investigation assistant with access to an Oracle RDF knowledge graph. Use tools before answering factual questions. Explain whether classifications were directly asserted or inferred by OWL2RL."
    }]',
    description => 'RDF agent with fixed and dynamic SPARQL tools and OWL2RL inference.'
  );
END;
/

BEGIN
  DBMS_CLOUD_AI_AGENT.CREATE_TEAM(
    team_name => 'AML_RDF_CASE_TEAM',
    attributes => q'[{
      "agents": [{"name": "AML_RDF_CASE_AGENT", "task": "AML_RDF_CASE_TASK"}],
      "process": "sequential"
    }]',
    description => 'RDF investigation team: fixed and dynamic SPARQL with OWL2RL inference.'
  );
END;
/

SELECT 'TOOLS' AS type, tool_name AS name
FROM user_ai_agent_tools
WHERE tool_name IN (
  'AML_RDF_CASE_EVIDENCE_TOOL','AML_RDF_ENTITY_TOOL',
  'AML_ONTOLOGY_SCHEMA_TOOL','AML_RDF_QUERY_TOOL'
)
UNION ALL
SELECT 'TASK', task_name FROM user_ai_agent_tasks
WHERE task_name = 'AML_RDF_CASE_TASK'
UNION ALL
SELECT 'AGENT', agent_name FROM user_ai_agents
WHERE agent_name = 'AML_RDF_CASE_AGENT'
UNION ALL
SELECT 'TEAM', agent_team_name FROM user_ai_agent_teams
WHERE agent_team_name = 'AML_RDF_CASE_TEAM'
ORDER BY 1, 2;

-- Demo question: entity-first. The agent should classify A300 and find CASE-1042.
SELECT CAST(DBMS_CLOUD_AI_AGENT.RUN_TEAM(
  team_name   => 'AML_RDF_CASE_TEAM',
  user_prompt => 'What is notable about account A300 from a risk classification perspective, and how was that determined?',
  params      => '{"conversation_id":"' || DBMS_CLOUD_AI.CREATE_CONVERSATION() || '"}'
) AS VARCHAR2(32767)) AS agent_response
FROM dual;
