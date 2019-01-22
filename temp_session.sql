col module for a33
col program for a33
col username for a15
col osuser for a15
col tablespace_name for a20

COMPUTE SUM LABEL "Totals Mb" OF mb_used ON REPORT

SELECT S.sid , S.serial# sid_serial, S.username, S.osuser, P.spid, S.module,
S.program, SUM (T.blocks) * TBS.block_size / 1024 / 1024 mb_used, T.tablespace,
COUNT(*) sort_ops
FROM v$sort_usage T, v$session S, dba_tablespaces TBS, v$process P
WHERE T.session_addr = S.saddr
AND S.paddr = P.addr
AND T.tablespace = TBS.tablespace_name
GROUP BY S.sid, S.serial#, S.username, S.osuser, P.spid, S.module,
S.program, TBS.block_size, T.tablespace
ORDER BY 8 desc;