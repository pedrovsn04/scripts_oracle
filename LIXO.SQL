select	s.sql_id,
		substr('kill -9 '||p.spid,1,16) "KILL",
		substr(s.SID,1,7) "SID",
		substr(s.SERIAL#,1,8) "SERIAL#",
		P.SPID,
		s.inst_id,
		substr(s.USERNAME,1,15) "Username",
		substr(s.osuser,1,10) "OS USER",
		s.status,(select substr(EVENT,1,40) from v$session_wait w where w.sid = s.sid) " EVENT ",
        substr(to_char(s.LOGON_TIME,'dd/mm/yyyy hh24:mi:ss'),1,20) "Data Ini.",
		substr(s.LOCKWAIT,1,8) "LOCKWAIT",
        substr(floor(s.last_call_et/3600)||':'||floor(mod(s.last_call_et,3600)/60)||':'||mod(mod(s.last_call_et,3600),60),1,8) "IDLE",
        substr(s.TERMINAL,1,16) TERMINAL, substr(s.MACHINE,1,22) "Machine",
        s.MODULE, substr(s.PROGRAM,1,20) "Program"
--        s.PADDR,
--        s.server,
--        s.SQL_ADDRESS,
--        s.CLIENT_INFO,
--		'alter system kill session '|| '''' || s.sid ||','|| s.serial#|| ',@'|| s.inst_id || '''' ||' immediate;' AS "PEDALA SESSÃO"
from Gv$session s,
     Gv$process p
WHERE s.paddr = p.addr(+)
   and s.username is not null
--   and s.username not in ('SYS', 'SYSTEM')
   and s.type <> 'BACKGROUND'
  --and s.status = 'ACTIVE'
  and s.inst_id = p.inst_id
-- and p.spid =
-- and s.SID =
-- and s.SERIAL# =
-- and s.USERNAME like '% %'
-- and s.osuser  like '% %'
order by 10 desc
/
