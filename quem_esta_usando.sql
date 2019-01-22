select
--'alter system kill session '|| '''' || s.sid ||','|| s.serial#|| ',@'|| s.inst_id || '''' ||' immediate;' as KILL ,
           'kill -9 '||p.spid||  '    '||s.username||' '||s.osuser , s.status, s.INST_ID
from  DBA_DmL_LOCKS l, gv$session s, gv$process p
where name like upper('%&NOME_DO_OBJETO_LOCADO%')
and session_id=s.sid
--and s.username not in ('IT_PPNETO')
and s.paddr = p.addr
and s.status = 'ACTIVE'
and s.inst_id = p.inst_id
/