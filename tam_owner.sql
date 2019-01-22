select  owner,
        trunc(sum(bytes)/1024/1024) MBYTES
from    dba_segments 
WHERE owner LIKE UPPER('%&owner%')
group by owner
/

