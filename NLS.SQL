rem Retorna os parāmetros de NLS do Servidor
select 'alter session set '||parameter||' = '''||value||''';' from nls_database_parameters
/
