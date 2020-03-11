spool on
spool /interface/dataFactory/data/m_ad_proposals_dump.csv
Select 'PROP_REFERENCE, PROP_PRD_NUMBER, PROP_EXPIRY_DATE, PROP_CREATED_BY, PROP_CREATED_DATE, PROP_UPDATED_DATE, PROP_UPDATED_BY, PROP_CHANNEL, PROP_CNT_INITIAL_NUMBER, PROP_NO_TARIFFS, PROP_COMPLEX_CASE' from dual;
Select PROP_REFERENCE||','|| PROP_PRD_NUMBER||','|| PROP_EXPIRY_DATE||','|| PROP_CREATED_BY||','|| PROP_CREATED_DATE||','|| PROP_UPDATED_DATE ||','||PROP_UPDATED_BY ||','||PROP_CHANNEL||','|| PROP_CNT_INITIAL_NUMBER||','|| PROP_NO_TARIFFS ||','||PROP_COMPLEX_CASE output
from ad_proposals;
spool off;
