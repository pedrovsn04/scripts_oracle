select /*+ RULE */s.status,i.instance_name instance,s.SID,s.SERIAL#,
       p.spid,s.server,
       substr(to_char(s.LOGON_TIME,'dd/mm/yyyy hh24:mi:ss'),1,20) "Data Ini.",
       s.LOCKWAIT,
       substr(floor(s.last_call_et/3600)||':'||
       floor(mod(s.last_call_et,3600)/60)||':'||
       mod(mod(s.last_call_et,3600),60),1,8) "IDLE",
       substr(s.USERNAME,1,15) "Username",
       substr(s.MACHINE,1,15) "Machine",
       substr(s.PROGRAM,1,30) "Program",
       s.osuser,
       s.MODULE,
       s.failover_type,s.failover_method,s.failed_over,
       s.PADDR,
       s.SQL_ADDRESS,
       s.TERMINAL,
       s.CLIENT_INFO,
       s.action,
       substr(c.NETWORK_SERVICE_BANNER ,1,30) Network
from gv$session s,
     gv$process p,
     sys.GV_$INSTANCE i,
     gv$session_connect_info c
WHERE p.addr(+) = s.paddr
  and p.inst_id(+) = s.inst_id
  and i.inst_id = s.inst_id
  and s.username is not null
  and c.inst_id(+) = s.inst_id
  and c.sid(+) = s.sid
  and c.NETWORK_SERVICE_BANNER(+) like '%Protocol%'
order by s.status,s.last_call_et
/
