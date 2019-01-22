select  owner,
        segment_name,
        segment_type,
        tablespace_name,
        trunc(sum(bytes)/1024/1024) MBYTES
from    dba_segments 
WHERE segment_name LIKE UPPER('%&segment_name%')
group by tablespace_name, segment_name, segment_type, owner
/