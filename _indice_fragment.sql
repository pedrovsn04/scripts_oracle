--REM fragmentacao indices
PROMPT "Fragmentacao Indices"
select owner, index_name, BLEVEL, LEAF_BLOCKS, partitioned from dba_indexes where blevel > 3 ;


--REM TABLESPACES COM ASSM (GERENCIAMENTO AUTOMÁTICO)NÃO TEM FRAGMENTAÇÃO DE TABELAS, ENTÃO DESCONSIDERAR O FATO DAS TABELAS QUE ESTÃO COM MUITOS EXTENDS.
Prompt "Se o segment_space_manegement estiver como AUTO, nao ha fragmentacao"
select TABLESPACE_NAME, SEGMENT_SPACE_MANAGEMENT from dba_tablespaces order by 2;


--REM tabelas com linhas migradas, verificar o pct_free, se tiver 10, aumentar para 40 e fazer o move 
--REM da tabela e monitor para ver se diminuiu a qte de linhas migradas
PROMPT 'Tabelas com linhas migradas precisa fazer o move'
PROMPT
--REM Script que retorna a Percentagem de Linhas Migradas.
--Rem Detectando Migração e Encadeamento de Linhas
PROMPT ### DBA_TABLES
PROMPT
Prompt '     Retorna os Objetos acima de  10% de Linhas Migradas'
prompt ' Precisa ser rodado o ANALYZE  compute Statistics'
select 	substr(owner,1,10) OWNER , table_name "Nome da Tabela",
		to_char(LAST_ANALYZED, 'dd/mm/yyyy hh24:mi:ss') " Último Analyze" ,
		num_rows "Nº de Linhas" ,
		chain_cnt " Nº de Migradas",
		'    '||round((chain_cnt/num_rows)*100 ,2) ||'%' " Percentual "
from dba_tables 
where ((chain_cnt/num_rows)*100) > 10 -- maior que 10 %
and num_rows  >0
order by 6 desc
/

--REM Script que retorna a Percentagem de Linhas Migradas.
--Rem Detectando Migração e Encadeamento de Linhas
PROMPT 
PROMPT ### DBA_TAB_PARTITIONS
PROMPT 
Prompt '     Retorna os Objetos acima de  10% de Linhas Migradas'
prompt ' Precisa ser rodado o ANALYZE  compute Statistics'
select	substr(table_owner,1,10) OWNER, table_name "Nome da Tabela",
		to_char(LAST_ANALYZED, 'dd/mm/yyyy hh24:mi:ss') " Último Analyze" ,
		num_rows "Nº de Linhas" ,
		chain_cnt " Nº de Migradas",
		'    '||round((chain_cnt/num_rows)*100 ,2) ||'%' " Percentual "
from dba_tab_partitions 
where ((chain_cnt/num_rows)*100) > 10 -- maior que 10 %
and num_rows  >0
order by 6 desc
/

