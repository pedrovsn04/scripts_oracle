set linesize 300
set pagesize 1000
col USERNAME for a15 trunc
col MACHINE for a15 trunc
col PROGRAM for a15 trunc
col SQLTEXT for a50 trunc

--exibe as sessões que estão ocupando a TEMP
select t1.inst_id, t1.username, t1.sql_id, t1.tablespace, t1.segtype,
     t2.sid, t1.session_num as serial#, t2.MACHINE, t2.PROGRAM,
     substr(t3.sql_text,1,50) as sqltext,
     round(sum(t1.blocks*8192/1024/1024),2) as size_mb_temp
from gv$tempseg_usage t1,
     gv$session       t2,
     v$sqlarea        t3
where t1.session_num = t2.serial#
and t2.saddr   = t1.session_addr
and t1.inst_id = t2.inst_id
and t3.sql_id  = t1.sql_id
group by t1.inst_id, t1.username, t1.sql_id, t1.tablespace, t1.segtype,
     t2.sid, t1.session_num, t2.MACHINE, t2.PROGRAM, t3.sql_text
order by size_mb_temp desc;
