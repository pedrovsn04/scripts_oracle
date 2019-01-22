set lines 2000
col spid for 999999
col sid for 9999999
col event for a40
col sql_text for a1000
col 'USER_UNIX' for a35
col 'KG_BYTES' for 999999999999
col username for a15

select unique c.spid, a.sid, a.username, a.osuser USER_UNIX, e.event,e.seconds_in_wait,e.p1,e.p2,
                 a.program, a.status, a.machine, round(sum(b.value/1024),0) as KG_BYTES , sql_text
                 from v$session a, v$sesstat b, v$process c , v$sql d, v$session_wait e
where b.statistic# = 12
and a.sid = b.sid
and a.paddr = c.addr
and a.status='ACTIVE'
and a.username is not null
and a.sql_address = d.address
and e.sid = a.sid
and e.event not like '%queue%'
group by c.spid, a.sid, a.username, a.osuser, e.event,e.seconds_in_wait,e.p1,e.p2,
         a.program, a.status, a.machine, sql_text
order by KG_BYTES desc
/


  
