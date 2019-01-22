REM     Autor   : JOAO HENRIQUE FERREIRA BARBOSA
REM     Empresa : ÂNCORA CONSULTORES
REM     Data    : 07/01
REM     Versao  : 5.1
REM     ==================================================================
REM     
REM     Tabela          :  DBA_TABLES
REM     Tabela          :  DBA_SEGMENTS
REM
accept QTD   Prompt "Entre com a quantidade de EXTENTES.: " 
accept Owner Prompt "Entre com o Owner ou Enter para TODOS.: " 

PROMPT
PROMPT
PROMPT =====================
PROMPT FRAGMENTACAO - TABELA
PROMPT =====================
PROMPT
PROMPT Tabelas  com  mais  de  &QTD Extents
PROMPT  

column "c01"  format a30        	heading "Tablespace"    
column "c02"  format a25        	heading "Owner"
column "c03"  format a30     	   	heading "Tabela"
column "c04"  format 999,999,999    	heading "Alocacao|Kb"
column "c05"  format 9999       	heading "Extents"

select 
        ds.tablespace_name      "c01",  
        dt.owner                "c02",
        dt.table_name           "c03",
        ds.bytes/1024           "c04",
        ds.extents              "c05"
from    
        dba_segments ds ,
        dba_tables dt
where 
        ds.tablespace_name = dt.tablespace_name         and
        ds.owner = dt.owner                             and
	ds.owner like '%'||upper('&OWNER')||'%' AND
--	  dS.owner = nvl(upper('xxxOWNER',DT.OWNER) AND
        ds.segment_name = dt.table_name                 and
        dt.owner not in ('SYS','SYSTEM')                         and
        ds.extents > &QTD 
order by 5 desc,2,1,3;

column "c01"  format a30        	heading "Tabela"
column "c02"  format a25        	heading "Owner"
column "c03"  format 999,999,999    	heading "Initial   |Extent(Kb)"
column "c04"  format 99,999,999    	heading "Next      |Extent(Kb)"
column "c05"  format 9999999999 	heading "Max    |Extents"
column "c06"  format 90         	heading "Pct     |Increase"
column "c07"  format 90         	heading "Pct |Free"
column "c08"  format 90         	heading "Pct |Used"

select 
        dt.table_name           "c01",
        dt.owner                "c02",
        dt.initial_extent/1024  "c03",
        dt.next_extent/1024     "c04",
        dt.max_extents          "c05",
        dt.pct_increase         "c06",
        dt.pct_free             "c07",
        dt.pct_used             "c08"
from    
        dba_segments        ds ,
        dba_tables          dt
where 
        ds.tablespace_name = dt.tablespace_name         and
        ds.owner = dt.owner                             and
        ds.segment_name = dt.table_name                 and
        dt.owner not in ('SYS','SYSTEM')                and
	ds.extents > &QTD 
order by 1,2;
