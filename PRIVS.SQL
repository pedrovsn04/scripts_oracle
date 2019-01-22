select 'System Privs : '||PRIVILEGE from dba_sys_privs where GRANTEE = upper('&&1')
union
select 'Role Privs : '||GRANTED_ROLE from dba_role_privs where GRANTEE = upper('&&1')
union
select 'Tab Privs : '||owner||'.'||TABLE_NAME||' - '||privilege from dba_tab_privs where GRANTEE = upper('&&1')
union
select 'Column Privs : '||owner||'.'||TABLE_NAME||'.'||column_name||' - '||privilege from dba_col_privs where GRANTEE = upper('&&1')
/
undef 1