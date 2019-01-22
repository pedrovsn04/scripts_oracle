 select  p.spid, substr(s.USERNAME,1,10) USERNAME 
,substr(floor(s.last_call_et/3600)||':'||
 floor(mod(s.last_call_et,3600)/60)||':'||
 mod(mod(s.last_call_et,3600),60),1,8) "IDLE",
 substr(s.MODULE,1,20) MODULE,
 substr(s.MACHINE,1,15) "Machine",
 substr(s.PROGRAM,1,30) "Program", 
  (select substr(sql_text,1,150)  from v$sqlarea where hash_value = s.sql_hash_value  ) " Sql Text" -- and sql_text like '%kcrv_interface%') " Sql Text"
   from v$session s,
        v$process p
  where s.paddr   = p.addr
    and p.spid    in (select
p.spid
from gv$session s,
     gv$process p,
     sys.GV_$INSTANCE i
WHERE s.paddr = p.addr(+)
  and i.inst_id = s.inst_id
  and s.username is not null
AND s.USERNAME like  '&USER%'
 and s.status ='ACTIVE'
-- and (s.status='ACTIVE' or s.last_call_et < 1)
)
order by 3
/
