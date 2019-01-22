ACCEPT origem  char PROMPT 'Origem: '

ACCEPT destino char PROMPT 'Destino: '

ACCEPT scr     char PROMPT 'Numero da SCR: '

ACCEPT amb CHAR prompt 'Ambiente: '

SELECT 
HOST PCLI get -pr//BRSAO3W3PFS09\merant\Nextel\DATABASE -ppNEXTEL/ -a"&destino" -z -o -r&amb-v'&scr' -v&scr "&origem"

PCLI get -a"C:\WORK\NEXTEL\BILLING\BIT\ACEITE" -rPreProducao -v15750 "/BILLING/BIT/KBIT_RECEITA_BGH.sql"