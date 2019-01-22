col table_name form a40 trunc

select substr(sql_text,14,instr(sql_text,'(')-5) table_name, rows_processed,
round((sysdate - to_date(first_load_time, 'yyyy-mm-dd hh24:mi:ss'))*24*60,1) minutes,
trunc(rows_processed/((sysdate - to_date(first_load_time, 'yyyy-mm-dd hh24:mi:ss'))*24*60)) rows_per_min
from v$sqlarea
where upper(sql_text) like 'INSERT%'
and command_type = 2
and open_versions > 0

/


