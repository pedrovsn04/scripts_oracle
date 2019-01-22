set lines 10000
set pages 10000
col serial# for 9999999999

rem  -- v$sort_segment
select s.username, s.sid, s.serial#, s.osuser, u.extents, (u.blocks*8192) tam, u.SEGRFNO#, u.TABLESPACE, u.CONTENTS, u.SEGTYPE        
 from v$session s, v$sort_usage u
 where u.SESSION_ADDR = s.SADDR
 order by 6;
