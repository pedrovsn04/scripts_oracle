set linesize 300
set pagesize 1000
col USERNAME for a15 trunc
col MACHINE for a15 trunc
col PROGRAM for a15 trunc
col SQLTEXT for a50 trunc

--exibe a utilização da TEMP
select d.tablespace_name,
       nvl(a.bytes/1024/1024,0) size_mb,
           nvl(t.bytes/1024/1024,0) used_mb,
           round(nvl(t.bytes/a.bytes*100,0),2) "%_used"
from sys.dba_tablespaces d,
        (select tablespace_name, sum(bytes) bytes
         from dba_temp_files
         group by tablespace_name) a,
        (select ss.tablespace_name,
                sum((ss.used_blocks * ts.blocksize)) bytes
         from gv$sort_segment ss,
              sys.ts$ ts
     where ss.tablespace_name = ts.name
         group by ss.tablespace_name) t
where d.tablespace_name = a.tablespace_name(+)
and d.tablespace_name = t.tablespace_name(+)
and d.extent_management like 'LOCAL'
and d.contents like 'TEMPORARY'
order by 1;