set line 175
set pages 2000
col name format a30
col COMPATIBILITY format a10
col DATABASE_COMPATIBILITY format a10

select GROUP_NUMBER, NAME, STATE, TYPE, TOTAL_MB, FREE_MB, USABLE_FILE_MB, OFFLINE_DISKS, COMPATIBILITY, DATABASE_COMPATIBILITY
from v$ASM_diskgroup
/