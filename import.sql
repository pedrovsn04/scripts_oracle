select substr(sql_text,instr(upper(sql_text),'INTO')+4,instr(upper(sql_text),'INTO')+30) table_name,
       rows_processed,
       round((sysdate - to_date(first_load_time, 'yyyy-mm-dd hh24:mi:ss'))*24*60,1) minutes,
       trunc(rows_processed/((sysdate - to_date(first_load_time, 'yyyy-mm-dd hh24:mi:ss'))*24*60)) rows_per_min,
       sql_text
  from v$sqlarea
 where upper(sql_text) like 'INSERT%'
  and command_type = 2
  and open_versions > 0
  and rows_processed > 100

