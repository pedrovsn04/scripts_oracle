select 
		tablespace_name, file_name, round(sum(bytes/1024/1024/1024),0) as GB, AUTOEXTENSIBLE 
from 	dba_data_files
where 	tablespace_name = ('&tablespace')
or
		file_name = '&file_name'
group by tablespace_name, file_name, AUTOEXTENSIBLE 
order by 2
/