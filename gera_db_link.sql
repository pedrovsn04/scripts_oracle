select 'create '||decode(a.owner,'PUBLIC','PUBLIC ',NULL)||'database link '||
       decode(a.owner,'PUBLIC',NULL,a.owner||'.')||a.DB_LINK||' connect to '||
       a.USERNAME||' identified by '||b.PASSWORD||' using '||''''||a.host||''''||';'
  from dba_db_links a, sys.link$ b, (select username,user_id from dba_users union select 'PUBLIC',1 from dual) c
 where a.OWNER=c.username
   and b.OWNER# = c.user_id
   and b.name = a.db_link
order by a.owner,a.db_link
/
