col event for a70

compute sum of QTD_SESS on report
break on report
col event form a35
select	event, count(1) as "QTD_SESS", sum(seconds_in_wait) as "SECOND_WAIT"
from 	gv$session_wait
group by event
/
