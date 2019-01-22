BEGIN
   FOR reg IN (SELECT s.SID SID, s.serial# serial#, s.last_call_et,
                      SUBSTR (   FLOOR (s.last_call_et / 3600)
                              || ':'
                              || FLOOR (MOD (s.last_call_et, 3600) / 60)
                              || ':'
                              || MOD (MOD (s.last_call_et, 3600), 60),
                              1,
                              8
                             ) "IDLE"
                 FROM gv$session s, gv$process p, SYS.gv_$instance i
                WHERE s.paddr = p.addr(+)
                  AND i.inst_id = s.inst_id
                  AND (s.status = 'ACTIVE' OR s.last_call_et < 1)
                  AND s.username IS NOT NULL
                  AND s.status = 'ACTIVE'
                  AND s.action LIKE 'FRM%'
                  AND (s.last_call_et / 3600) > 1)
   LOOP
      EXECUTE IMMEDIATE    'alter system kill session '''|| reg.SID || ',' || reg.serial# || '''';
   END LOOP;
END;
/
