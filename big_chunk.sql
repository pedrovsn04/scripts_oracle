REM
REM Verifique se existe algum extent a ser alocado que sera maior que o maior espaco livre
REM
prompt  Verifique se existe algum extent a ser alocado que sera maior que o maior espaco livre
column table_name format a30
column tablespace_name format a30

select a.table_name, a.next_extent, a.tablespace_name
from   all_tables a,
       (select tablespace_name, max(bytes) as big_chunk
        from   dba_free_space
        group  by tablespace_name) f
where  f.tablespace_name = a.tablespace_name
and    a.next_extent > f.big_chunk
/
