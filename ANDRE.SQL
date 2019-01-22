select
       'kill -9 '||p.spid,
       substr('ALTER SYSTEM KILL SESSION '''||S.SID||','||S.SERIAL#||''';',1,38) "PEDALA SESSÃO",
       substr(s.USERNAME,1,8) "USERNAME",
       substr(s.osuser,1,20) OSUSER,
       substr(s.SID,1,5) "SID",
       substr(s.SERIAL#,1,7) "SERIAL#",
       substr(p.spid,1,7) "PSID",
       substr(s.status,1,6) STATUS,
       substr(to_char(s.LOGON_TIME,'dd/mm/yyyy hh24:mi:ss'),1,20) "Data Inicial",
       substr(s.LOCKWAIT,1,9) LOCKWAIT,
substr(floor(s.last_call_et/3600)||':'||floor(mod(s.last_call_et,3600)/60)||':'||mod(mod(s.last_call_et,3600),60),1,8) "IDLE",
       SUBSTR( A.OBJECT,1,35) OBJETO ,
       SUBSTR(A.TYPE,1,8) TIPO,
       substr(s.MACHINE,1,25) "MAQUINA",
       substr(s.PROGRAM,1,65) "PROGRAMA"
from v$session s,
     v$process p,
     V$ACCESS a
WHERE s.paddr = p.addr(+)
  AND s.USERNAME is not null
  and A.SID = S.SID
-- and p.spid = 28476
--and s.osuser = 'yapplbr'
--AND s.USERNAME = 'SFAUSR'
--And A.OWNER = 'IAP'
--And A.TYPE  = 'TABLE'
and a.object = UPPER('%&objetos%')
and s.status ='ACTIVE'
order by s.status,s.last_call_et
/
