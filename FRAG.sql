select 	tddf.tablespace_name, tddf.total_bytes/1024/1024 totalspace,
		(tddf.total_bytes - nvl(sum(dfs.bytes),0))/1024 usedspace,
		nvl(sum(dfs.bytes),0)/1024 freespace, 
		round(((tddf.total_bytes - nvl(sum(dfs.bytes),0))/tddf.total_bytes) * 100) pcttused,
		round((nvl(sum(dfs.bytes), 0)/tddf.total_bytes) * 100) pcttfree,
		abs(sqrt(max(dfs.blocks)/sum(dfs.blocks)) * (100 / sqrt(sqrt(count(dfs.blocks)))) - 100) pcttfrag
from dba_free_space dfs, op_pnet2.temp_dba_data_files tddf
where dfs.tablespace_name (+) = tddf.tablespace_name 
group by tddf.tablespace_name, tddf.total_bytes;


create table temp_dba_data_files
as 	select	tablespace_name, sum(bytes/1024/1024) total_bytes
	from 	dba_data_files
	group by tablespace_name
/




select owner, table_name, blocks "Bloco USADO", empty_blocks "Nunca USADO", num_rows "Total LINHAS"
from dba_tables 
where owner='DWH'
and rownum < 10
/


select table_name, round((num_rows*avg_row_len/1024),2)||'kb' "size"
,  (round((blocks*8),2)- round((num_rows*avg_row_len/1024),2)) , num_rows
from dba_tables
where owner = 'DWH'
and table_name not like 'DWH%'
and rownum < 10
/



