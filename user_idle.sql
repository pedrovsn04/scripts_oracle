set lines 1000
select 
		sid, 
		username, 
		osuser, 
		substr(floor(s.last_call_et/3600)||':'||floor(mod(s.last_call_et,3600)/60)||':'||mod(mod(s.last_call_et,3600),60),1,8) IDLE
from v$session s
where username like upper('%&username%')
order by 4
/


