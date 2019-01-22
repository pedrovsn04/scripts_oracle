set verify off
Accept usu char Prompt 'Digite o Usuario: '
exec dbascon.reset_senha('&usu');
/
set verify on