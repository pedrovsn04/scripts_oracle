select
c.sql_text
from
gv$session s,
gv$process p,
gV$sqlarea  c
where c.address = s.sql_address
and s.paddr = p.addr
and s.inst_id= &inst_id
and p.spid = &spid
/