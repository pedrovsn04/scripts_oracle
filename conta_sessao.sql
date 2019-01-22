select
count(*) ,
s.USERNAME,s.status
from gv$session s,
     gv$process p,
     sys.GV_$INSTANCE i
WHERE s.paddr = p.addr(+)
  and i.inst_id = s.inst_id
--  and (s.status='ACTIVE' or s.last_call_et < 1)
  and s.username is not null
-- and p.spid in (18544,1929)
 --and s.machine = 'sposnac5'
--   and s.osuser = 'dolivei2'
 --and s.program like '%kv_2.exe%'
 and s.status ='ACTIVE'
-- and s.status ='SNIPED'
group by s.USERNAME, s.status
order by 1
/
