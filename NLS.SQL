rem Retorna os parâmetros de NLS do Servidor
select 'alter session set '||parameter||' = '''||value||''';' from nls_database_parameters
/
