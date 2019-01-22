col osuser format a10


select 'kill -9 '||p.spid kill
     , s.status
-- , i.instance_name
     , s.SID
-- , s.SERIAL#
-- , p.spid,s.server
     , substr(to_char(s.LOGON_TIME,'dd/mm/yyyy hh24:mi:ss'),1,20) "Data Ini."
     , s.LOCKWAIT
     , substr(floor(s.last_call_et/3600)||':'
       || floor(mod(s.last_call_et,3600)/60)||':'
       || mod(mod(s.last_call_et,3600),60),1,8) "IDLE"
     , substr(s.USERNAME,1,15) "Username"
     , s.osuser
     , s.process
     , s.action
     , s.MODULE
     , substr(s.MACHINE,1,15) "Machine"
     , substr(s.PROGRAM,1,30) "Program"
     , s.PADDR
     , s.SQL_ADDRESS
     , s.TERMINAL
     , s.CLIENT_INFO
  from gv$session s
     , gv$process p
     , sys.GV_$INSTANCE i
 WHERE s.paddr = p.addr(+)
   And i.inst_id = s.inst_id
   And (s.status='ACTIVE' or s.last_call_et < 1)
   And s.username is not null
-- And p.spid in (18544,1929)
-- And s.machine = 'sposnac5'
-- AND s.USERNAME like  'MBSU%'
-- And s.osuser = 'dolivei2'
-- And s.program like '%kv_2.exe%'
   And s.status ='ACTIVE'
-- And s.status ='SNIPED'
-- And s.lockwait is not null
-- And s.sid in (121)
--   And s.action like '%'
--   And s.module like '%%'
  Order by s.status,s.last_call_et
/
