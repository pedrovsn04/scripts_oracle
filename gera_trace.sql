select
s.status ,p.spid,substr(s.username,1,10),
'alter system set timed_statistics = true; ' GERA_STATISTICA,
'exec sys.dbms_system.set_sql_trace_in_session('||s.sid||','||s.serial#||',true);' GERA_TRACE
,a.value||'/ora_'||p.spid||'*.trc'  nome_arquivo_trace
FROM v$session s, v$process p, v$parameter a
WHERE s.paddr = p.addr
--and s.username like '"&"USER%'
  and  s.username like '&Usuario%'
--and  s.status = 'ACTIVE'
  and a.name = 'user_dump_dest'
/