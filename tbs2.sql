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
