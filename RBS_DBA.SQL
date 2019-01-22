  SELECT SUBSTR(r.name,1,10)                   rbs,
         substr(nvl(s.username, 'None'),1,15)  oracle_user,
         substr(s.osuser,1,15)                 client_user,
         p.username               unix_user,
         SUBSTR(to_char(s.sid)||','||to_char(s.serial#),1,15) as sid_serial,
         p.spid                   unix_pid,
 --        TO_CHAR(s.logon_time, 'mm/dd/yy hh24:mi:ss') as login_time,
 --        TO_CHAR(sysdate - (s.last_call_et) / 86400,'mm/dd/yy hh24:mi:ss') as last_txn,
         t.used_ublk * TO_NUMBER(x.value)/1024  as undo_kb,
	 decode (s.command,1,'CREATE TABLE',
                           2,'INSERT',
                           3,'SELECT',
                           6,'UPDATE',
                           7,'DELETE',
                           9,'CREATE INDEX',
                          10,'DROP INDEX',
                          12,'DROP INDEX',
                          26,'LOCK TABLE',
                          44,'COMMIT',
                          45,'ROLLBACK',
                          46,'SAVEPOINT', 
                          NULL, NULL,
                         'look it up '||to_char(s.command)) Comando
    FROM v$process     p,
         v$rollname    r,
         v$session     s,
         v$transaction t,
         v$parameter   x
   WHERE s.taddr = t.addr
     AND s.paddr = p.addr(+)
     AND r.usn   = t.xidusn(+)
     AND x.name  = 'db_block_size'
   ORDER
      BY r.name;