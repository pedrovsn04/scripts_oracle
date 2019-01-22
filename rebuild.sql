select  substr(b.TABLESPACE_NAME,1,11) "TABLESPACE",
        substr(d.file_id,1,4) "ID",
        substr('alter database datafile '''||d.file_name||''' resize',1,76) "Datafile",
        c.MBYTES "Tamanho (Mb)",
        (c.MBYTES - nvl(a.MBYTES,0)) "Ocupado (Mb)" ,
        nvl(a.MBYTES,0) "Livre (Mb)",
        AUTOEXTENSIBLE
    from  dba_data_files d,
       (select TABLESPACE_NAME,file_id, trunc(sum(BYTES)/1024/1024) MBYTES
          from dba_free_space
        group by TABLESPACE_NAME,file_id) a,
        dba_tablespaces b,
       (select TABLESPACE_NAME,file_id, trunc(sum(BYTES)/1024/1024) MBYTES
          from dba_data_files
         where status = 'AVAILABLE'
                group by TABLESPACE_NAME,file_id) c
  where b.TABLESPACE_NAME = a.TABLESPACE_NAME(+)
    and c.TABLESPACE_NAME = b.TABLESPACE_NAME
    and c.file_id = d.file_id
    and a.tablespace_name like nvl(upper('%&tablespace%'),d.tablespace_name)
    and a.tablespace_name = d.tablespace_name
    and a.file_id = d.file_id
union
select  substr(TABLESPACE_NAME,1,11) "TABLESPACE",
        substr(file_id,1,4) "ID",
        substr('alter database datafile '''||file_name||''' resize',1,76) "Datafile",
        trunc((bytes)/1024/1024) "Tamanho (Mb)",
        trunc((USER_BYTES)/1024/1024) "Ocupado (Mb)",
        trunc (((BYTES)-(USER_BYTES))/1024/1024) "Livre",
        AUTOEXTENSIBLE
  from dba_temp_files
 where upper(file_name) like upper('%&tablespace%')
order by 4 desc
/
