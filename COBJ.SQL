SET PAUSE ON ECHO OFF VERIFY OFF FEED ON
ACCEPT OWNER PROMPT 'Entre com o Owner.: '
select 	count(*) , object_type tipo , owner 
from 	dba_objects 
where 	OWNER LIKE UPPER('%&OWNER%')
GROUP BY owner , object_type
/

select 	count(*), decode(constraint_type, 'C', 'CHECK_CONSTRAINT','P','PRIMARY KEY' ,'R','FOREING KEY',constraint_type) tipo, 
		owner 
from 	dba_constraints 
where  	OWNER LIKE UPPER('%&OWNER%')
GROUP BY owner ,constraint_type
/
