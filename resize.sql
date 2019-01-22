select 'alter database datafile '||''''||name||''''||' resize '||to_char(MB_datafile-MBytes)||'m;'
  from (select /*+ RULE */
               a.tablespace_name,a.file_id,c.name,trunc(c.bytes/1024/1024) MB_datafile,trunc(sum(a.bytes/1024/1024)) MBytes
          from dba_free_space a,
               (select TABLESPACE_NAME,FILE_ID,max(BLOCK_ID) blockid
                  from dba_extents
                 where tablespace_name <>'SYSTEM'
                group by TABLESPACE_NAME,FILE_ID) b,
               v$datafile c
         where a.tablespace_name = b.tablespace_name
           and a.tablespace_name <> 'SYSTEM'
           and b.tablespace_name <> 'SYSTEM'
           and a.file_id = b.file_id
           and a.block_id > b.blockid
           and a.bytes/1024/1024 >= 1
           and c.file# = a.file_id
        group by a.tablespace_name,a.file_id,c.name,c.bytes/1024/1024)
 where MB_datafile-MBytes > 0
   and mbytes > 50
   and MB_datafile > 101
/
