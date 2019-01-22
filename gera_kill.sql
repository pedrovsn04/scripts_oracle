select 
		'alter system kill session '||''''||sid||','||serial#||''''||' immediate;'
from v$session
where username = '&user'
/
-- and machine = '&machine'