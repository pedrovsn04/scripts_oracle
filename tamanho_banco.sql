select 
		sum(c.MBYTES) "Tamanho (Mb)" , 
		round(sum(c.MBYTES)/1024 , 2) "Tamanho (Gb)",	   
		round(sum(c.MBYTES)/1024/1024,2) "Tamanho (Tb)"
from
		(select 	TABLESPACE_NAME, 
					trunc(sum(BYTES)/1024/1024) MBYTES 
		 from 		dba_free_space 
		 group by TABLESPACE_NAME
		) a, dba_tablespaces b, (select 	TABLESPACE_NAME, 
											trunc(sum(BYTES)/1024/1024) MBYTES 
								 from 		dba_data_files 
								 where 		status = 'AVAILABLE' 
								 group by 	TABLESPACE_NAME
								) c
where	a.TABLESPACE_NAME = b.TABLESPACE_NAME 
and 	c.TABLESPACE_NAME = b.TABLESPACE_NAME
/
