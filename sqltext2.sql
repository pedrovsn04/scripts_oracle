 select (select sql_text from gv$sqlarea where hash_value = s.sql_hash_value) " Sql Text"
   from gv$session s,
        gv$process p
  where s.paddr   = p.addr
    and p.spid    = &spid
/
