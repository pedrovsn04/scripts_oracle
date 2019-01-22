select substr(b.TABLESPACE_NAME,1,30) "TableSpace",
--	C.FILE_ID "File_id",	
	c.AUTOEXTENSIBLE,
       substr(c.file_name,1,52) "File_name", 
       b.STATUS,
       nvl(a.MBYTES,0) "Livre (Mb)",
       c.MBYTES "Tamanho (Mb)",
       trunc((c.MBYTES-nvl(a.MBYTES,0))/c.MBYTES*100) "% Ocupação",
      trunc(nvl(a.MBYTES,0)/c.MBYTES*100) "% Livre"
--,       b.ALLOCATION_TYPE "Tipo de Alocação"
,b.EXTENT_MANAGEMENT "Ger.Extent"
 from (select TABLESPACE_NAME,
              trunc(sum(BYTES)/1024/1024) MBYTES
         from dba_free_space
       group by TABLESPACE_NAME) a,
      dba_tablespaces b,
      (select TABLESPACE_NAME,file_name,AUTOEXTENSIBLE, --FILE_ID ,
              trunc(sum(BYTES)/1024/1024) MBYTES
       from dba_data_files
        where status = 'AVAILABLE'
       group by TABLESPACE_NAME , file_name,AUTOEXTENSIBLE ) c --,FILE_ID) c
where a.TABLESPACE_NAME(+) = b.TABLESPACE_NAME
  and c.TABLESPACE_NAME(+) = b.TABLESPACE_NAME
order by b.tablespace_name
/
prompt " Listando os TEMPORARY TABLESPACES "
select * from dba_temp_files
/

select substr(b.TABLESPACE_NAME,1,30) "TableSpace",
       nvl(a.MBYTES,0) "Livre (Mb)", 
       c.MBYTES "Tamanho (Mb)",
       (c.MBYTES - nvl(a.MBYTES,0)) "Ocupado (Mb)" ,
      trunc((c.MBYTES-nvl(a.MBYTES,0))/c.MBYTES*100) "% Ocupação",
      trunc(nvl(a.MBYTES,0)/c.MBYTES*100) "% Livre"
 from 
(select TABLESPACE_NAME, trunc(sum(BYTES)/1024/1024) MBYTES from dba_free_space group by TABLESPACE_NAME) a,
 dba_tablespaces b,
(select TABLESPACE_NAME, trunc(sum(BYTES)/1024/1024) MBYTES from dba_data_files where status = 'AVAILABLE' 
	group by TABLESPACE_NAME) c
where b.TABLESPACE_NAME = a.TABLESPACE_NAME(+)
  and c.TABLESPACE_NAME = b.TABLESPACE_NAME
order by b.tablespace_name
/

