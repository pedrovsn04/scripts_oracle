COLUMN sid FORMAT 99999
COLUMN serial# FORMAT 9999999
COLUMN machine FORMAT A30
COLUMN progress_pct FORMAT 99999999.00
COLUMN elapsed FORMAT A10
COLUMN remaining FORMAT A10

SELECT s.sid,
       s.serial#,
       s.machine,
       TRUNC(sl.elapsed_seconds/60) || ':' || MOD(sl.elapsed_seconds,60) elapsed,
       TRUNC(sl.time_remaining/60) || ':' || MOD(sl.time_remaining,60) remaining,
       ROUND(sl.sofar/sl.totalwork*100, 2) progress_pct
 FROM   gv$session s,
        gv$session_longops sl
 WHERE  s.sid     = sl.sid
 and        s.USERNAME LIKE UPPER('%&USUARIO%')
 and        ROUND(sl.sofar/sl.totalwork*100, 2) <> 100.00
 AND    s.serial# = sl.serial#
 ORDER BY 5;
 
 