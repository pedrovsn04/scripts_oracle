set heading off;
select 'Tables with migrated/chained rows and no RAW columns.' from dual;
set heading on;
select 
   owner              c1, 
   table_name         c2, 
   pct_free           c3, 
   pct_used           c4, 
   avg_row_len        c5, 
   num_rows           c6, 
   chain_cnt          c7,
   chain_cnt/num_rows c8
from dba_tables
where
owner = '&owner'
and
table_name not in
 (select table_name from dba_tab_columns
   where
 data_type in ('RAW','LONG RAW')
 )
and
chain_cnt > 0
order by 8 DESC
;

