set pages 24
prompt so as 10 primeiras
column buffer_gets format 999,999,999,999,999
column disk_reads format 999,999,999,999,999

SELECT * FROM (
select a.sid,a.serial#,a.username,a.osuser, A.STATUS, a.machine,
 b.sql_text,b.buffer_gets/decode(executions,0,1,executions) buffer_gets,
b.disk_reads/decode(executions,0,1,executions) disk_reads,b.executions,
b.hash_value
from v$session a,v$sqlarea b
where a.status='ACTIVE' and
address=sql_address  
and buffer_gets/decode(executions,0,1,executions) > 500
AND users_executing > 0 
order by b.disk_reads/decode(executions,0,1,executions) desc )
WHERE rownum < 11
/

prompt onde:
prompt buffer_gets/executinos  = é a quantidade de vezes que ele requisitou
prompt disk_reads/executions  = é a quantidade que ele precisou ir no disco buscar a informação, pois
prompt	                          não tinha na memória.isto siginifca que o Hit hatio fica baixo.
prompt executions                   = quantas vezes ele executou a operação



prompt select address, sql_text, buffer_gets/executions, executions from v$sql
prompt where executions > 0 and
prompt users_executing > 0 and
prompt buffer_gets/decode(executions,0,1,executions) > 500
prompt order by 2 desc


