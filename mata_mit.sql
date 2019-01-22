 select
  'kill -9 '||p.spid kill,
 s.status,
 --s.FAILOVER_METHOD ,i.instance_name, s.INST_ID,
 s.SID,
 -- s.SERIAL#,s.server,
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
--  and s.sid not in (2032 ,1754,5267)
 and ( s.MODULE like '%MIT%' or s.module like 'phantom%' or s.osuser='dsadm' or
 s.MODULE like '%ODS%'  or s.machine = 'papp07' or machine = 'vodatastage')
 order by s.status,s.last_call_et
 /