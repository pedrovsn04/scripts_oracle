prompt "  "
prompt "Este Script lista os Espaços livres da Tablespace "
prompt " " 
prompt " Dependendo da situação deve se efetuar o move tablespace ou rebuild index "
prompt "  "

SET PAUSE ON ECHO OFF VERIFY OFF FEED ON

ACCEPT TABLESPACE PROMPT 'DIGITE O NOME DA TABLESPACE :'
set pause off
set lines 132
set pages 9000
set term off
break on file_id skip page duplicate
col segment_name format a30
col bytes format 9,999,999,999
COL TABLESPACE_NAME FORMAT A14
spool mapa.lis
select 'owner ' owner,file_id,tablespace_name,'FREE >->->->->->->-> ' segment_name , block_id,bytes
from dba_free_space
where tablespace_name = nvl(upper('&tablespace'),tablespace_name)
union
select owner, file_id,tablespace_name,segment_name,block_id,bytes
from dba_extents
where tablespace_name = nvl(upper('&tablespace'),tablespace_name)
order by file_id,tablespace_name,block_id asc
/
spool off
set pages 30
set pause on
set term on
