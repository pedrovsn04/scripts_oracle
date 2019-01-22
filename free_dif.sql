break on report
comp sum of ocup on report
comp sum of aloc on report
comp sum of free on report
comp sum of Free(Mb) on report
col tablespace_name format a30
col ocup format 999,999,999,999,999
col aloc format 999,999,999,999,999
col free format 999,999,999,999,999
col "%FREE"  format 999,999,999.99
col "%FREE"  format a10
col "Free(mb)" format 999,999,999,999.99
select   a.tablespace_name,a.bytes-b.bytes ocup , a.bytes aloc ,b.bytes free ,b.bytes/(1024*1024) "Free(Mb)",
to_char(round((b.bytes/a.bytes)*100,2),'999.99') "%FREE"
from (select sum(bytes) bytes,tablespace_name 
      from dba_data_files 
	   group by tablespace_name ) a, 
     ( select sum(bytes) bytes , tablespace_name
       from dba_free_space  
       group by tablespace_name ) b
where a.tablespace_name=b.tablespace_name
order by 5
/