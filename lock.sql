prompt WAINTTING_USER Sessão LOCADA
prompt HOLDING_USER  Sessão QUE ESTA LOCANDO

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
'ALTER SYSTEM KILL SESSION '''||S2.SID||','||S2.SERIAL#||''';',
        'kill -9 ' ,P2.spid PID
--       S1.SERIAL#,s1.status,
--       S2.SERIAL#,
FROM sys.v_$process P1,
     sys.v_$process P2,
     sys.v_$session S1,
     sys.v_$session S2,
     sys.dba_lock w,
     sys.dba_lock h
WHERE h.mode_held       != 'None'
  AND h.mode_held       != 'Null'
  AND w.mode_requested  != 'None'
  AND w.lock_type (+)    = h.lock_type
  AND w.lock_id1  (+)    = h.lock_id1
  AND w.lock_id2  (+)    = h.lock_id2
  AND w.session_id  = S1.sid  (+)
  AND h.session_id       = S2.sid  (+)
  AND S1.paddr           = P1.addr (+)
  AND S2.paddr           = P2.addr (+)
ORDER BY 7;

