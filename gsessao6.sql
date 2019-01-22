column KILL format a16
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
column action for a20
column event for a40
select  substr(event,1,40) event,
        substr('kill -9 '||p.spid,1,16) "KILL",
		substr(s.SID,1,7) "SID",
		substr(s.SERIAL#,1,8) "SERIAL#",
		P.SPID,
--		s.inst_id,
		substr(s.USERNAME,1,15) "Username",
		substr(s.osuser,1,10) "OS USER",
		s.status,
        substr(to_char(s.LOGON_TIME,'dd/mm/yyyy hh24:mi:ss'),1,20) "Data Ini.",
		substr(s.LOCKWAIT,1,8) "LOCKWAIT",
        substr(floor(s.last_call_et/3600)||':'||floor(mod(s.last_call_et,3600)/60)||':'||mod(mod(s.last_call_et,3600),60),1,8) "IDLE",
		s.action,
        substr(s.TERMINAL,1,16) TERMINAL,
        substr(s.MACHINE,1,22) "Machine",
        s.MODULE,
        substr(s.PROGRAM,1,20) "Program",
        s.PADDR,
        s.server,
        s.SQL_ADDRESS,
        s.CLIENT_INFO,
        'ALTER SYSTEM KILL SESSION '''||S.SID||','||S.SERIAL#||''';' AS "PEDALA SESSÃO"
from gv$session s,
     gv$process p
WHERE s.paddr = p.addr(+)
   and s.username is not null
  and s.status = 'ACTIVE'
-- and p.spid = 
-- and s.SID =
-- and s.SERIAL# =
-- and s.USERNAME like '% %'
-- and s.osuser  like '% %'
order by s.last_call_et
/
