select	owner , object_name , object_type , to_char(last_ddl_time, 'dd/mm/yyyy hh24:mi:ss')
from	dba_objects
where	to_char(last_ddl_time, 'dd/mm/yyyy hh24:mi:ss') between '&begin_data_time' and '&end_data_time'
/