REM     Autor   : JOAO HENRIQUE FERREIRA BARBOSA
REM     Empresa : ÂNCORA CONSULTORES
REM     Data    : 07/01
REM     Versao  : 5.1
REM     ==================================================================
REM     
REM     Tabela          :  DBA_INDEXES
REM     Tabela          :  DBA_SEGMENTS
REM
accept QTD Prompt "Entre com a quantidade de EXTENTES.: " 
PROMPT
PROMPT
PROMPT =====================
PROMPT FRAGMENTACAO - INDICE
PROMPT =====================
PROMPT
PROMPT Indices  com  mais  de  &QTD  Extents
PROMPT  

set newpage 2

column "c01"  format a15        new_value ts  noprint
column "c02"  format a10        new_value own noprint
column "c03"  format a30        new_value tab noprint
column "c04"  format a30        new_value idx noprint
column "c05"  format 999,999    heading "Alocacao Kb"
column "c06"  format 9999       heading "Extents"
column "c07"  format 9999999999 heading "Maximo |Extents"
column "c08"  format 999,999    heading "Initial Kb|Extents   "
column "c09"  format 999,999    heading "Next Kb|Extents"
column "c10"  format 990        heading "Pct     |increase"
column "c11"  format 990        heading "Pct |free"

break on "c04" skip page

ttitle  left 'Tablespace : ' ts  skip 1 -
        left 'Tabela     : ' tab skip 1 -
        left 'Owner      : ' own skip 1 -
        left 'INDICE     : ' idx skip 1 -
        left ' '
select 
        ds.tablespace_name      "c01",  
        di.owner                "c02",
        di.table_name           "c03",
        di.index_name           "c04",
        ds.bytes/1024           "c05",
        ds.extents              "c06",
        di.max_extents          "c07",
        di.initial_extent/1024  "c08",
        di.next_extent/1024     "c09",
        di.pct_increase         "c10",
        di.pct_free             "c11"
from    
        dba_segments ds ,
        dba_indexes di
where 
        ds.tablespace_name = di.tablespace_name         and
        ds.owner = di.owner                             and
        ds.segment_name = di.index_name                 and
        di.owner not in ('SYS','SYSTEM')                         and
        ds.extents > &QTD
order by 6 desc,2,1,3;

clear columns
clear breaks
ttitle off
set newpage 1

