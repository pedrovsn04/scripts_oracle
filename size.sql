SET ECHO off 
set verify off
REM NAME:   ROWSZ.SQL 
REM USAGE:"@rowsz" 
REM -------------------------------------------------------------------------- 
REM REQUIREMENTS: 
REM    Should be run under the schema ID of the tables being reported. 
REM    Tables with LONG columns will not report row size properly!! 
REM -------------------------------------------------------------------------- 
REM PURPOSE: 
REM    Calculate the average row size for all tables in a schema. 
REM    It generates a script (getavgcol.sql) off of USER_TABLES and then runs 
REM    it.  The following type of SELECT is generated for table in USER_TABLES: 
REM         SELECT round(avg(nvl(vsize(COL1),0)) +   
REM                round(avg(nvl(vsize(COL2),0)) + ... +  
REM                round(avg(nvl(vsize(COLn),0)) 
REM              
REM Where n=# of cols. on the table 
REM 
REM    Input:           NONE 
REM    Output:          getavgcol.sql - Script that is generated and run 
REM     getavgcol.lst - Report of each table and its 
REM                     average row length 
REM             
REM DISCLAIMER: 
REM    This script is provided for educational purposes only. It is NOT  
REM    supported by Oracle World Wide Technical Support. 
REM    The script has been tested and appears to work as intended. 
REM    You should always run new scripts on a test instance initially. 
REM -------------------------------------------------------------------------- 
REM Main text of script follows: 
 
drop table column_counts; 
create table column_counts 
        ( 
        table_name, 
        column_count 
        ) 
        as 
        ( 
        select table_name, max(column_id) 
        from all_tab_columns 
        where OWNER='&owner' and data_type not like 'LONG%' AND TABLE_NAME = '&TABELA'
        group by table_name 
        ) 
        ; 
column select_line format A8  
column end_line format A1  
column from_stmt format A34 word_wrap 
column col_nm format A100  
column col_val format A32  
column tnm1 noprint  
column tnmprint format A37  
column column_id noprint 
break on tnm1 skip 2 
clear breaks 
spool 1.sql
select UTC.table_name tnm1, 
        decode(column_id,1,'select ' || chr(39) || UTC.table_name || chr(39) || 
                ' TB, ', '        ') || 
        'round(avg(nvl(vsize('||column_name||'),0)),0)' || 
        decode(column_id,column_count, ' row_size from ' || UTC.table_name 
             || ';'|| chr(10)||chr(10), 
                ' +') col_nm 
from user_tab_columns UTC, column_counts CC 
where UTC.data_type not like 'LONG%' AND UTC.table_name = CC.table_name 
order by UTC.table_name, UTC.column_id; 
spool off
@1.sql

