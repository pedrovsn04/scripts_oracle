SELECT Privilege "GRANT DE ",
       substr(grantor,1,20 ) "DO OWNER",
       GRANTEE "NA ROLE",       
       substr(table_name,1,40) "NO OBJETO"
FROM DBA_TAB_PRIVS WHERE GRANTEE LIKE 'R%SELECT'
     AND Privilege != 'SELECT'
     ORDER BY GRANTEE
/
