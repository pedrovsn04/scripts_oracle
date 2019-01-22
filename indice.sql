select substr(index_owner,1,5) Owner,
       index_name,
       table_owner,
	table_name,
	column_name
from dba_ind_columns 
where table_name like upper ('%&Tabela%')
/
