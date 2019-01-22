-- |############################################################################|
-- | DATABASE  : Oracle                                                         |
-- | FILE      : su_11g.sql                                                     |
-- | PURPOSE   : Connect to database using the informed username                |
-- | PARAMETER : Username                                                       |
-- | PRE-REQS  : The user that will execute the script needs                    |
-- |             to have acess to the object sys.user$ or DBA role              |
-- |############################################################################|

set define on
set sqlbl off
set pages 0
set feed off
set termout off
set verify off

select 'alter user ' || name || ' identified by values ' || '''' || password || '''' || ';' from sys.user$ where name=upper('&1')

spool x1.sql
/
spool off

select 'alter user ' || username || ' identified by x;' from dba_users where username=upper('&&1')

spool x2.sql
/
spool off

-- Connection using global name
select 'CONN &&1/x@' || global_name from global_name

-- Connection using instance_name
--select 'CONN &&1/x@' || instance_name from v$instance

spool x3.sql
/
spool off

@x2
@x3
@x1
