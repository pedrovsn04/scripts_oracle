set editfile LIXO.SQL
set colsep   " "
set array 5
set pages 0
set lines 100
set long  8000000
set longchunksize  8000000
set feed off

select 'spool C:\env\scripts_oracle\log\spool_'||to_char(sysdate,'yyyymmddhh24miss')||'_'||instance_name from v$instance

spool C:\env\scripts_oracle\log\spool.sql
/

alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
SPOOL PROMPT.LST
SELECT 'SET SQLPROMPT '||decode(SUBSTR(GLOBAL_NAME,1,INSTR(GLOBAL_NAME,'.')),null,GLOBAL_NAME||'.',
       SUBSTR(GLOBAL_NAME,1,INSTR(GLOBAL_NAME,'.')))||USER||'>' 
FROM GLOBAL_NAME
/
--SELECT 'SET SQLPROMPT '||GLOBAL_NAME||'.'||USER||'>' 
--FROM GLOBAL_NAME
--/
SPOOL OFF
START PROMPT.LST
set pages 0
select '##*******************************************************************' from dual;
SELECT '## H-Data/Hora Corrente     : '||sysdate from dual
/
SELECT '## H-Size SGA (Mb)          : '||trunc(sum(VALUE)/1024/1024) from v$sga
/
SELECT '## I-Host Name              : '||HOST_NAME FROM v$instance union
SELECT '## I-Version                : '||version FROM v$instance union
SELECT '## I-Startup Time           : '||to_char(STARTUP_TIME,'dd/mm/yyyy hh24:mi:ss') FROM v$instance union
SELECT '## I-Logins                 : '||LOGINS FROM v$instance union
SELECT '## I-Log Switch Wait        : '||LOG_SWITCH_WAIT FROM v$instance union
SELECT '## I-Status                 : '||status FROM v$instance
/
SELECT '## C-Created                : '||CREATED from v$database union
SELECT '## C-ResetLog Time          : '||RESETLOGS_TIME from v$database union
SELECT '## C-OpenMode               : '||OPEN_MODE from v$database
/
SELECT '## G-Sessions Max           : '||SESSIONS_MAX from V$LICENSE union
SELECT '## G-Sessions HighWater     : '||SESSIONS_HIGHWATER from V$LICENSE union
select '## G-Sessions Parameter     : '||value from v$parameter where name='sessions' union
SELECT '## G-Sessions Current       : '||SESSIONS_CURRENT from V$LICENSE union
SELECT '## G-Sessions Warning       : '||SESSIONS_WARNING from V$LICENSE union
select '## G-Processes Parameter    : '||value from v$parameter where name='processes' union
select '## G-Job Processes Parameter: '||value from v$parameter where name='job_queue_processes' union
SELECT '## G-Users Max              : '||USERS_MAX from V$LICENSE
/
select '## A-CPU Count              : '||value from v$parameter where name='cpu_count' union
select '## A-Latch                  : '||value from v$parameter where name='db_block_lru_latches' union
--select '## B-DB Name                : '||value from v$parameter where name='db_name' union
select '## B-Instance               : '||instance from V$THREAD union
select '## B-Block Size             : '||value from v$parameter where name='db_block_size' union
select '## B-MultiBlock Read Count  : '||value from v$parameter where name='db_file_multiblock_read_count' union
select '## D-Arquive Mode           : '||log_mode from v$database union
select '## D-Arquive Automatico     : '||value from v$parameter where name='log_archive_start' union
select '## D-Optimizer              : '||value from v$parameter where name='optimizer_mode' union
select '## D-Timed Statistcs        : '||value from v$parameter where name='timed_statistics' union
select '## X-Optimizer Features     : '||value from v$parameter where name='optimizer_features_enable' union
select '## E-Audit Mode             : '||value from v$parameter where name='audit_trail' union
select '## X-Compatible             : '||value from v$parameter where name='compatible'
/
select distinct '## X-SID desta Sessão       : '||sid from v$mystat
/
select '##*******************************************************************' from dual;
select * from v$version
/
select '##*******************************************************************' from dual;
set feed on
set lines 1000
set pages 10000
set long 80000000
set longchunksize  8000000
set serveroutput on size 1000000 format wrapped
set time on
SET TRIMSPOOL ON
column sid format 999999
column name format a40
column db_link format a30
column host format a20
column segment_name format a30
column object_name format a30
column MBytes format 999,999,999,990.00
column owner format a16
column object format a30
column COLUMN_NAME format a30
column FILE_NAME format a60
column GLOBAL_NAME format a30
column DIRECTORY_PATH format a40
REM Plano de execução
column plan_plus_exp format a120
REM tom Kytes
column what format a30 word_wrapped
set feed off
set verify off
set pages 0
@C:\env\scripts_oracle\log\spool.sql
set feed on
set verify on
set pages 1000