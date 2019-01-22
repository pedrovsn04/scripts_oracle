select 
		* 
from (select 
				b.sid, 
				b.value,
				v.username, 
				v.status, 
				v.osuser 
      from v$sesstat b, v$statname a, v$session v
      where a.statistic# = b.statistic#
      and a.name ='session uga memory'
      and b.sid = v.sid
      order by 2 desc
     )
where rownum < 11
/
