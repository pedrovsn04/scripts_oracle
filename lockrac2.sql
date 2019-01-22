set lines 3000
col osuser format a10
col serial# for 999999
col sess format a15
col username format a10
col sid format 99999
SELECT /*+ RULE */ 
S1.STATUS,
substr(s1.username,1,12) "LOCADA(WAINTTING_USER)",
substr(s1.osuser,1,8) OS_LOCADA,
substr(to_char(w.session_id),1,5) Sid_LOCADA,
P1.spid,
substr(s2.username,1,12) "LOCANDO(HOLDING_User)",
S2.STATUS ,
substr(s2.osuser,1,8) OS_LOCANDO,
to_number(substr(to_char(h.session_id),1,5)) Sid_LOCANDO,
P2.spid PID
, S2.PROCESS process_lockando
-- S1.SERIAL#,s1.status,
-- S2.SERIAL#,
FROM gv$process P1,
gv$process P2,
gv$session S1,
gv$session S2,
dba_lock w,
dba_lock h
WHERE h.mode_held != 'None'
AND h.mode_held != 'Null'
AND w.mode_requested != 'None'
AND w.lock_type (+) = h.lock_type
AND w.lock_id1 (+) = h.lock_id1
AND w.lock_id2 (+) = h.lock_id2
AND w.session_id = S1.sid (+)
AND h.session_id = S2.sid (+)
AND S1.paddr = P1.addr (+)
AND S2.paddr = P2.addr (+)
ORDER BY 7
/


