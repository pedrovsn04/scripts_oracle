select
   'kill -9 ' || p.spid, s.username, s.osuser,
   to_char(s.logon_time, 'dd/mm/yyyy hh24:mi:ss') as CONECTADO, s.status
from  v$access l, v$session s, v$process p
where l.object like upper('%&NOME_DO_OBJETO_LOCADO%')
and l.sid=s.sid
--and l.side
and s.paddr = p.addr
order by s.logon_time
/
