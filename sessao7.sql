select
substr(s.USERNAME,1,12) "Username",
count(*)
from gv$session s,
     gv$process p,
     gv$instance x
WHERE s.paddr = p.addr(+)
  AND s.USERNAME is not null
-- and p.spid = 28476
--and s.osuser = 'calim3'
--AND s.USERNAME = 'SYSADM'
and s.status ='ACTIVE'
group by substr(s.USERNAME,1,12)
order by 2 desc
/
