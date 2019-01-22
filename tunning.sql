SET LINES 120
SELECT 	'ANALYZE INDEX '||OWNER||'.'||SEGMENT_NAME||' VALIDATE STRUCTURE;',
		'SELECT (DEL_LF_ROWS_LEN / LF_ROWS_LEN ) * 100 AS USO_INDEX FROM INDEX_STATS;'
FROM 	DBA_SEGMENTS
WHERE 	SEGMENT_NAME IN  (SELECT	SEGMENT_NAME
                          FROM 		DBA_SEGMENTS
                          WHERE 	SEGMENT_NAME IN (SELECT 	INDEX_NAME
                                                     FROM 		DBA_INDEXES
													)
                          GROUP BY 	SEGMENT_NAME, SEGMENT_TYPE
                          HAVING 	SUM(BYTES)/1024/1024 > 1000
						 )
/


