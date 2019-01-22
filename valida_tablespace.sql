SELECT to_char(sysdate,'dd/mm/yy hh24:mi') || ' - DBA_ALERT_W - Tablespace Critical: ' || CASE
    WHEN (a.cap_max < 100 ) AND a.tablespace_name in ('SYSAUX','SYSTEM','USERS') THEN 'Tablespace with status Critical ' 
        || a.tablespace_name || ' with ' || trunc(a.cap_max) || ' Mbytes free'
    WHEN (a.cap_max < 300) AND a.tablespace_name in ('SYSAUX','SYSTEM','USERS') THEN 'Tablespace with status Warning '  
        || a.tablespace_name || ' with ' || trunc(a.cap_max) || ' Mbytes free'
    WHEN (a.cap_max < 2000) THEN 'Tablespace with status Critical ' || a.tablespace_name || ' with ' || trunc(a.cap_max) || ' Mbytes free'
    WHEN (a.cap_max > 2000) THEN 'Tablespace with status Warning '  || a.tablespace_name || ' with ' || trunc(a.cap_max) || ' Mbytes free'
       ELSE 'Tablespaces are OK'
  END AS RESULTSET
FROM
      (SELECT b.tablespace_name,(nvl(a.free_mbytes,0) + (b.max_mbytes - b.mbytes)) cap_max,(b.mbytes) mbytes
     FROM
      (SELECT tablespace_name,SUM (BYTES) / 1024 / 1024 free_mbytes   FROM dba_free_space GROUP BY tablespace_name) a,
        (SELECT tablespace_name,SUM (BYTES / 1024 / 1024) mbytes,SUM(DECODE(autoextensible,'NO',BYTES/1024/1024,maxbytes/1024/1024)) max_mbytes 
         FROM dba_data_files GROUP BY tablespace_name) b
    WHERE a.tablespace_name (+) = b.tablespace_name) a,
    (SELECT tablespace_name FROM dba_tablespaces WHERE CONTENTS = 'PERMANENT' AND status = 'ONLINE') b,
    DUAL
WHERE a.tablespace_name = b.tablespace_name
AND  (a.cap_max < (select CASE WHEN a.tablespace_name in ('SYSAUX','SYSTEM','USERS') THEN 300 ELSE 5000 END as valor from dual) )
/
