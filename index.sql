SELECT substr(A.TABLE_NAME,1,30) table_name ,
 	SUBSTR(A.INDEX_OWNER,1,15) OWNER,
	b.tablespace_name,
       A.INDEX_NAME      NOME,
       B.STATUS,	
       SUBSTR(COLUMN_NAME,1,30) COLUNA,
       substr(COLUMN_POSITION,1,4) POS,
	b.distinct_keys
--	,B.LAST_ANALYZED
       FROM  DBA_IND_COLUMNS A, DBA_INDEXES B
WHERE A.TABLE_NAME LIKE UPPER('%&TABELA%')
AND A.INDEX_OWNER = NVL(UPPER('&OWNER1'),A.INDEX_OWNER)
and a.index_name = b.index_name
and A.INDEX_OWNER = b.owner 
and a.table_name = b.table_name
ORDER BY A.INDEX_OWNER,A.INDEX_NAME,A.COLUMN_POSITION, b.tablespace_name
/
