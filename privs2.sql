select 'System Privs : '||PRIVILEGE from dba_sys_privs where GRANTEE = upper('&&1')
union
select 'Role Privs : '||GRANTED_ROLE from dba_role_privs where GRANTEE = upper('&&1')
/
