select 
		s.sid, 
		s.username, 
		s.osuser, 
		s.terminal, 
		s.machine, 
		s.program, 
		w.event, 
		w.SECONDS_IN_WAIT 
from v$session s, v$session_wait w 
where w.event='latch free' 
and s.sid=w.sid
/
