select substr(a.os_user_name,1,8) "OS User"
, substr(b.object_name,1,30) "Object Name"
, substr(b.object_type,1,8) "Type"
, substr(c.segment_name,1,10) "RBS"
, e.process "PROCESS"
, substr(d.used_urec,1,8) "# of Records"
from v$locked_object a
, dba_objects b
, dba_rollback_segs c
, v$transaction d
, v$session e
where a.object_id = b.object_id
and a.xidusn = c.segment_id
and a.xidusn = d.xidusn
and a.xidslot = d.xidslot
and d.addr = e.taddr
/