column kill format a15
column "Data Ini." format a20
column idle  format a10
column  Machine format a35
column  MODULE format a35
column  event format a35
column  spid format a6
column  sid format 999999
column id for 99
column schemaname for a12
column kill_session for a55
column kill_session_rac for a55

SELECT s.sql_hash_value, 
 s.inst_id id,
 p.spid,
 s.SID,
 substr(s.username, 1, 14) username,
 s.schemaname,
 s.status,
 s.LOCKWAIT,
 substr(FLOOR (s.last_call_et / 3600)||':'||FLOOR (MOD (s.last_call_et, 3600) / 60)||':'|| MOD (MOD (s.last_call_et, 3600), 60),1,8) "IDLE",
 to_char(s.logon_time,'dd/mm hh24:mi') Logon_time,
 s.event,
 s.SERVICE_NAME,
 substr(s.module, 1, 20) module, SUBSTR (s.machine, 1, 24) "Machine",
 substr(s.program, 1, 20) "Program",
 s.sql_hash_value,
 (SELECT substr(sql_text, 1, 200) FROM gv$sqlarea w WHERE hash_value = s.sql_hash_value AND w.address = s.sql_address AND w.inst_id = s.inst_id) " Sql Text", 
 'ALTER SYSTEM KILL SESSION '''||S.SID||','||S.SERIAL#||''' IMMEDIATE;' as kill_session,
 'ALTER SYSTEM KILL SESSION '''||S.SID||','||S.SERIAL#||',@'||S.INST_ID||''' IMMEDIATE;' as kill_session_rac,
 'kill -9 ' || p.spid
FROM
 gv$session s,
 gv$process p
WHERE s.paddr = p.addr
 AND s.paddr = p.addr(+)
 AND s.inst_id = p.inst_id
 and s.sid=&sid
 AND s.username IS NOT NULL
 AND s.type <> 'BACKGROUND'
 AND s.username LIKE UPPER('%&USER%')
 AND s.status = 'ACTIVE'
ORDER BY  s.last_call_et
/