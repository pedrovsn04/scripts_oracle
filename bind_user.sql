column KILL format a16
COL VALUE_STRING FOR A20
column SID format a7
column "SERIAL#" format a7
column SPID format a7
column "Username" format a15
column "OS USER" format a10
column status format a10
column "Data Ini." format a20
column LOCKWAIT format a8
column IDLE format a8
column TERMINAL format a16
column Machine format a22

select	
		substr('kill -9 '||p.spid,1,16) "KILL",	
		substr(s.SID,1,7) "SID", 
		substr(s.SERIAL#,1,8) "SERIAL#", 
		P.SPID, 
		s.SQL_ID, b.VALUE_STRING, B.NAME,
		s.inst_id,
		substr(s.USERNAME,1,15) "Username", 
		substr(s.osuser,1,10) "OS USER", 
		s.status,(select substr(EVENT,1,40) from v$session_wait w where w.sid = s.sid) " EVENT ",
        substr(to_char(s.LOGON_TIME,'dd/mm/yyyy hh24:mi:ss'),1,20) "Data Ini.",
		substr(s.LOCKWAIT,1,8) "LOCKWAIT",
        substr(floor(s.last_call_et/3600)||':'||floor(mod(s.last_call_et,3600)/60)||':'||mod(mod(s.last_call_et,3600),60),1,8) "IDLE",
        substr(s.TERMINAL,1,16) TERMINAL, substr(s.MACHINE,1,22) "Machine",
        s.MODULE, substr(s.PROGRAM,1,20) "Program",
        s.PADDR,
        s.server,
        s.SQL_ADDRESS,
        s.CLIENT_INFO,
		'alter system kill session '|| '''' || s.sid ||','|| s.serial#|| ',@'|| s.inst_id || '''' ||' immediate;' AS "PEDALA SESSÃO"
from Gv$session s,
     Gv$process p, gV$SQL_BIND_CAPTURE b
WHERE s.paddr = p.addr(+)
   and s.username in ('SNGUSRA','SNGUSRO','SNGUSRB')
   and s.sql_id = b.sql_id
   and s.username not in ('SYS', 'SYSTEM')
   and b.sql_id = '&sql_id'
   and s.type <> 'BACKGROUND'
  and s.status = 'ACTIVE'
  and s.inst_id = p.inst_id
-- and p.spid = 
-- and s.SID =
-- and s.SERIAL# =
-- and s.USERNAME like '% %'
-- and s.osuser  like '% %'
order by 10 desc
/
