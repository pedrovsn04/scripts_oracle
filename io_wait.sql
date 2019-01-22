col username format a15
col machine format a25
col p1text format a15
col p2text format a15
col p3text format a15
col sid format 99999
col event format a30
select 
		s.username, 
		s.machine, 
		s.sid, 
		w.event, 
		w.p1text, 
		w.p1, 
		w.p2text, 
		w.p2, 
		w.p3text, 
		w.p3, 
		w.wait_time, 
		w.seconds_in_wait, 
		w.state
from v$session s, v$session_wait w
where s.sid = w.sid
and s.type = 'USER'
and w.event in ('db file scattered read',
				'db file sequencial read',
				'direct path read',
				'direct path read temp',
				'direct path write',
				'direct path write temp')
and s.status = 'ACTIVE'
order by event
/


