select a.name , a.file# , b.PHYRDS as "LEITURA_FISICA" , b.PHYWRTS as "ESCRITA_FISICA"
from v$filestat b , v$datafile a
where a.file# = b.file#
order by 3
/