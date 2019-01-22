set lines 2000
col "SID,SERIAL#" for a20
col sql_text for a200
select 	sesion.sid ||','|| sesion.serial# as "SID,SERIAL#",
        sesion.username,
        optimizer_mode,
        hash_value,
        address,
        cpu_time,
        elapsed_time,
		executions,
        sql_text,
		sqlarea.rows_processed
from	v$sqlarea sqlarea, v$session sesion
where	sesion.sql_hash_value = sqlarea.hash_value
and sesion.sql_address    = sqlarea.address
and sesion.username is not null
and sesion.username not in ('SYS', 'SYSTEM')
and sesion.sid =&sid
order by sqlarea.rows_processed
/