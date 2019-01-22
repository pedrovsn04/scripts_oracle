select 'Espaço Livre' Owner,'   ' Objeto,file_id,block_id,blocks,BYTES,bytes/1024 KBytes,bytes/1024/1024 MBytes
  from dba_free_space
 where tablespace_name = upper('&1')
   and  file_id = &2
union
  select substr(owner,1,20),
         substr(segment_name,1,30)||' -'||
         segment_type,
         file_id,
         block_id,
         blocks,
         BYTES,
         bytes/1024 KBytes,
         bytes/1024/1024 MBytes
  from   dba_extents
  where  tablespace_name = upper('&&1')
    and  file_id = &&2
    and  rownum < 2
  order  by blocks desc
/
