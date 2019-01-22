SELECT 'GRANT '||DECODE(OBJECT_TYPE,'SEQUENCE','SELECT','EXECUTE')||'  ON '||OWNER||'.'||OBJECT_NAME ||' TO R'||OWNER||'_USERS;'
FROM DBA_OBJECTS
WHERE OWNER = '&&OWNER'
AND  OBJECT_TYPE IN ('PROCEDURE','SEQUENCE','PACKAGE', 'FUNCTION')
UNION
SELECT 'GRANT SELECT, INSERT,DELETE, UPDATE ON '||OWNER||'.'||OBJECT_NAME ||' TO R'||OWNER||'_USERS;'
FROM DBA_OBJECTS
WHERE OWNER = '&&OWNER'
AND  OBJECT_TYPE IN ('TABLE')
UNION
SELECT 'GRANT SELECT ON '||OWNER||'.'||OBJECT_NAME ||' TO R'||OWNER||'_SELECT;'
FROM DBA_OBJECTS
WHERE OWNER = '&&OWNER'
AND  OBJECT_TYPE IN ('TABLE','VIEW')

SPOOL ACERTA_ROLE
/
SPOOL OFF
@ACERTA_ROLE.LST
UNDEF OWNER