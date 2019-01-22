column sid format 9999
column user_ora format a13
column conexao format a13
column status format a8
column user_unix format a9
column estacao format a30
column process format a7    heading 'PROCESS'
column comando format a15
column LocWait format a7
col machine for a30
set linesize 2000
set pagesize 1000
select a.sid SID,
      a.serial#,
       a.sql_address, a.machine,
       a.username USER_ORA,
       decode (substr(a.osuser,1,9),'OraUser','C/S',
              substr(a.osuser,1,9)) USER_UNIX,
       decode (substr(a.terminal,1,6),'Window',machine,machine) ESTACAO,
       to_char(logon_time,'HH24:MI:SS') CONEXAO,
       b.spid PROCESS,
       d.CONSISTENT_GETS GETS,
       d.BLOCK_CHANGES CHANGES,
       c.name COMANDO,
       decode(a.lockwait,'','NAO','SIM') LocWait
from v$session  a,v$process b,audit_actions c,v$sess_io d,v$sesstat e,v$statname f
where a.paddr=b.addr
and   a.username!=' '
-- and   a.username <> 'SYS'
and   a.status='ACTIVE'
-- and a.username = 'DBANET'
and a.command=c.action
and a.sid=d.sid
and a.sid=e.sid
and e.STATISTIC#=f.STATISTIC#
and e.STATISTIC#=12
and f.STATISTIC#=12
order by GETS
/
