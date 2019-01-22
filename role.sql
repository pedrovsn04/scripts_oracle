ACCEPT USUARIO PROMPT 'Entre com o nome do usuario:  '

select * from dba_role_privs where grantee like upper('%&USUARIO%');
