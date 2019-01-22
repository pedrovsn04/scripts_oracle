select 	sid, username, osuser, machine, module, logon_time, status 
from	v$session 
where 	username like 'SCHED' or osuser like 'sched' 
order by logon_time
/
