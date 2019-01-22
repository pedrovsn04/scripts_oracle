select 
c.sql_text
from 
v$session s,
v$process p,
V$sqlarea  c
where c.address = s.sql_address
and s.paddr = p.addr
and p.spid = &spid
/
