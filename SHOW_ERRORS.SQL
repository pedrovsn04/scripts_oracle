SELECT 'SHOW ERRORS '||OBJECT_TYPE||' '||OBJECT_NAME||';'
FROM user_OBJECTS
WHERE STATUS  = 'INVALID'
/
