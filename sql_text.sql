--set feedback off
--set heading off

--spool D:\Logs_TAM\dataaux.sql
--select 'define data = ' || to_char(sysdate, 'yyyymmdd_hh24miss') || '_' || INSTANCE_NAME || '_' || host_name from v$instance;
--spool off
--@D:\Logs_TAM\dataaux.sql
--set feedback on
--set heading on



--spool D:\Logs_TAM\sql_text_&data..log


select sid, sql_text from gv$session s, gv$sqltext v
where v.address = s.sql_address
  and sid = &sid
--  and hash_value = hash
order by piece
/

--spool off
