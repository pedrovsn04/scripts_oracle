set lines 120

column sid         format 9999
column spid        format 99999
column client_info format a25
column event       format a30
column secs        format 99999
COLUMN %_DONE      FORMAT 99.9

SELECT SID, SPID, CLIENT_INFO, event, seconds_in_wait secs, p1, p2, p3
  FROM V$PROCESS p, V$SESSION s
  WHERE p.ADDR = s.PADDR
  and CLIENT_INFO like 'rman channel=%'
/

ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YY HH24:MI:SS'
/

SELECT SID, 
       START_TIME,
       TOTALWORK, 
       SOFAR SO_FAR, 
       (SOFAR/TOTALWORK) * 100 "%_DONE", 
       SYSDATE + TIME_REMAINING/3600/24 END_AT
FROM V$SESSION_LONGOPS 
WHERE TOTALWORK > SOFAR
AND opname LIKE 'RMAN%'
AND opname NOT LIKE '%aggregate%'
/