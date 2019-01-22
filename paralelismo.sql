 select count(*) , sysdate DAT_COLETA
 , s.status,  substr(s.USERNAME,1,15) "Username",
        substr(to_char(s.LOGON_TIME,'dd/mm/yyyy hh24:mi:ss'),1,20) "Data Ini.",
        substr(s.osuser,1,12) OSUSER,
        s.MODULE,
        substr(s.MACHINE,1,25) "Machine"
 from gv$session s,
      gv$process p,
      sys.GV_$INSTANCE i
 WHERE s.paddr = p.addr(+)
   and i.inst_id = s.inst_id
  and p.inst_id = s.inst_id
   and s.username is not null
 and s.program like '%(P0%'
 group  by
  s.status,   s.USERNAME,
         s.LOGON_TIME,
         s.osuser,
        s.MODULE,
        s.MACHINE
/

 select count(*) TOTAL
 from gv$session s,
      gv$process p,
      sys.GV_$INSTANCE i
 WHERE s.paddr = p.addr(+)
   and i.inst_id = s.inst_id
  and p.inst_id = s.inst_id
   and s.username is not null
 and s.program like '%(P0%'
 /
