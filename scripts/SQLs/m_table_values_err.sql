spool on
spool /interface/dataFactory/data/m_TableValues.csv
Select 'TVS_TAD_CODE, TVS_CODE, TVS_DESCRIPTION, TVS_CONSTRUCTED_BY, TVS_CONSTRUCTION_TIME, TVS_CHANGED_BY, TVS_CHANGE_TIME' from dal;
Select TVS_TAD_CODE||','|| TVS_CODE||','|| TVS_DESCRIPTION',' TVS_CONSTRUCTED_BY||','|| TVS_CONSTRUCTION_TIME ||','||TVS_CHANGED_BY ||','||TVS_CHANGE_TIME from table_values;
spool off;
