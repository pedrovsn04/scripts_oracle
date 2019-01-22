set lines 3000
col osuser format a10
col serial# for 999999
col sess format a15
col username format a10
col sid format 99999
select	a.*, b.serial#, b.sql_hash_value, b.username, substr(b.osuser,1,10) osuser, decode(b.status,'ACTIVE','A','I') status
from 	(SELECT	inst_id, 
				DECODE (request, 0, 'Holder: ', 'Waiter: ') || SID sess,
				id1, id2, lmode,
				DECODE (lmode,0, 'None', 1, 'Null', 2, 'Row Share', 3, 'Row Exlusive', 4, 'Share', 5, 'Sh/Row Exlusive', 6, 'Exclusive') dslmode,
				request,
				DECODE (request, 0, 'None', 1, 'Null', 2, 'Row Share', 3, 'Row Exlusive', 4, 'Share', 5, 'Sh/Row Exlusive', 6, 'Exclusive') dsrequest,
				TYPE, sid
		 FROM	gv$lock
		 WHERE (id1, id2, TYPE) IN (SELECT	id1, id2, TYPE
								   FROM 	gv$lock a
								   wherE a.request > 0
								  )
		) a, gv$session b
where	a.sid = b.sid 
and		a.inst_id = b.inst_id
order by id1, request
/


