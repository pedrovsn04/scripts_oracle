set verify off
PROMPT 'Recupera todas as tabelas do dicionario e suas descri��es'
select table_name, substr(COMMENTS,1,70) Comentario
from dictionary
 where table_name like upper('%&Tabela%')
/
