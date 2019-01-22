set verify off
accept tablespace char prompt 'Informe a Tablespace: '
accept file_id number prompt 'Informe o File Id : '
select  substr(owner,1,15) Owner,
	substr(tablespace_name,1,15) Tablespace,
        substr((segment_name)||' - '||(segment_type),1,38) "Objeto - Tipo",
        file_id Id,
        block_id Block_id,
        blocks Blocks,
        BYTES,
        bytes/1024 KBytes,
        bytes/1024/1024 MBytes
  from dba_extents c 
 where c.tablespace_name like upper('%&tablespace%')
   and c.file_id like &file_id
   and c.block_id = (select max(d.block_id) 
                    from dba_extents d 
                    where c.tablespace_name = d.tablespace_name 
                    and c.file_id = d.file_id)
union
select  'Espaço Livre' Owner,
	substr(tablespace_name,1,15) Tablespace,
        '   ' Objeto,
        file_id Id,
        block_id Block_id,
        blocks Blocks,
        BYTES,
        bytes/1024 KBytes,
        bytes/1024/1024 MBytes
  from dba_free_space a
 where a.tablespace_name like upper('%&tablespace%')
   and a.file_id like  &file_id
   and a.block_id = (select max(b.block_id)
                    from dba_free_space b
                    where b.tablespace_name = a.tablespace_name
                    and b.file_id = a.file_id)     
   order by block_id               
/
set verify on

