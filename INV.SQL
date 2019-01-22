set linesize 100;
set pagesize 100;
SELECT owner, substr(OBJECT_NAME,1,40) object_name, OBJECT_TYPE, status, last_ddl_time
FROM   dba_OBJECTS
WHERE  STATUS = 'INVALID'
ORDER  BY owner, OBJECT_NAME;
