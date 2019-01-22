alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS'
/

select	distinct tablespace_name,'alter tablespace '||tablespace_name|| ' end backup;',a.status
		--, time, substr(file_name,1,60) File_Name
from	v$backup a, dba_data_files b
where	file# = file_id
and		a.status not in ('DELAYED OPEN','NOT ACTIVE')
/
