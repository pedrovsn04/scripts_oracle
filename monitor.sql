select	sysdate, s.sid, s.value, n.name, s.statistic#
from	v$sesstat s, v$statname n
where	s.statistic# = n.statistic#
and     s.statistic# in ( 2, 3, 9, 13, 14, 15, 16, 39, 40, 41, 42, 97, 98, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 162, 163, 164, 231, 239, 240 )
and     s.sid = &sid
order	by s.sid, s.statistic#
/