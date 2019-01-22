
select
 'kill -9 '||p.spid kill,
s.status,
--i.instance_name,
s.SID,
--,s.SERIAL#,
--       p.spid,s.server,
       substr(to_char(s.LOGON_TIME,'dd/mm/yyyy hh24:mi:ss'),1,20) "Data Ini.",
       s.LOCKWAIT,
       substr(floor(s.last_call_et/3600)||':'||
       floor(mod(s.last_call_et,3600)/60)||':'||
       mod(mod(s.last_call_et,3600),60),1,8) "IDLE",
       substr(s.USERNAME,1,15) "Username",
       substr(s.osuser,1,12) OSUSER,
       s.MODULE,
       substr(s.MACHINE,1,15) "Machine",
       substr(s.PROGRAM,1,30) "Program",
       s.PADDR,
       s.SQL_ADDRESS,
       s.action,
       s.TERMINAL,
       s.CLIENT_INFO
from gv$session s,
     gv$process p,
     sys.GV_$INSTANCE i
WHERE s.paddr = p.addr(+)
  and i.inst_id = s.inst_id
  and s.username is not null
 and p.spid in (25629,25648,3971,4003)
--and s.machine = 'spolxp01'
AND s.USERNAME like  'SCHED%'
--and s.module like '01@ /tmp/MITGRAS%'
-- and s.osuser = 'dolivei2'
--and s.program like '%kv_2.exe%'
--and s.program like '%sfiscm.exe%'
--and s.action like '%LGARCI4%'
-- and s.status ='ACTIVE'
-- and (s.status='ACTIVE' or s.last_call_et < 1)
-- and s.status ='SNIPED'
-- and s.status ='KILLED'
order by s.status,s.last_call_et
/
