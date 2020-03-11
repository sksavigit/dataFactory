SET SERVEROUT ON SIZE 1000000
SET HEADING OFF ECHO OFF FEEDBACK OFF TRIMSPOOL ON LINES 2000 PAGES 0
PROMPT Script:/interface/dataFactory/scripts/SQLs/w_ad_proposals.sql-Started
@/interface/dataFactory/scripts/SQLs/w_ad_proposals.sql;
PROMPT Script:/interface/dataFactory/scripts/SQLs/w_ad_proposals.sql-Completed

exit;
