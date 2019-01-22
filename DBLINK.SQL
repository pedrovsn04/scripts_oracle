SELECT distinct SUBSTR(a.OWNER,1,25) OWNER , SUBSTR(a.DB_LINK, 1,25) DB_LINK , a.USERNAME, SUBSTR(a.HOST, 1,20) HOST, SUBSTR(password,1,15) Nome_PWD,CREATED
FROM DBA_DB_LINKS a,
     sys.link$ 
where db_link = name
and A.HOST LIKE UPPER ('%&HOST%')
ORDER BY db_link
/