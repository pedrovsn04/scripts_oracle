
set line 175
set pages 2000

col name format a24
col path format a55

select GROUP_NUMBER, DISK_NUMBER, name , state, total_mb, free_mb,path, header_status
from v$ASM_DISK
order by 1,2
/

