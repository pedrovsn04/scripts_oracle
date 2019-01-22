--**********************************************
--
--   Copyright © 2003 by Rampant TechPress Inc.
--
--   Free for non-commercial use.
--   For commercial licensing, e-mail info@rampant.cc
--
-- *********************************************

rem  ****************************************************************rem
rem  NAME: CHAINING.sql     
rem
rem  FUNCTION: Report on the number of CHAINED rows within a named table 
rem
rem  NOTES:  Requires DBA priviledges.
rem          The target table must have a column that is the leading portion
rem             of an index and is defined as not null.
rem          Uses the V$SESSTAT table where USERNAME is the current user.
rem              A problem if > 1 session active with that USERID.
rem          The statistics in V$SESSTAT may change between releases and
rem              platforms.  Make sure that 'table fetch continued row' is
rem              a valid statistic.
rem          This routine can be run by AUTO_CHN.sql by remarking the two
rem              accepts and un-remarking the two defines.
rem
rem  INPUTS: obj_own = the owner of the table.
rem          obj_nam = the name of the table.
rem
rem  ****************************************************************

rem accept obj_own prompt 'Enter the table owner''s name: '
rem accept obj_nam prompt 'Enter the name of the table: '

define obj_own = &1
define obj_nam = &2

set termout off feedback off verify off echo off heading off embedded on

rem  Find out what statistic we want
column statistic# new_value stat_no 
select statistic# 
  from v$statname n
 where n.name = 'table fetch continued row'
/

rem  Find out who we are in terms of sid
column sid new_value user_sid 
select distinct sid from v$session
 where audsid = userenv('SESSIONID')
/

rem  Find the last col of the table and a not null indexed column
column column_name new_value last_col 
column name new_value indexed_column 
column value new_value before_count 
select column_name
  from dba_tab_columns
 where table_name = upper('&&obj_nam')
   and owner      = upper('&&obj_own')
 order by column_id
/
select c.name
  from sys.col$ c, sys.obj$ idx, sys.obj$ base, sys.icol$ ic
 where base.obj#   = c.obj#
   and ic.bo#      = base.obj#
   and ic.col#     = c.col#
   and base.owner# = (select user# from sys.user$
		       where name = upper('&&obj_own'))
   and ic.obj#     = idx.obj#
   and base.name   = upper('&&obj_nam')
   and ic.pos#     = 1
   and c.null$     > 0
/
select value
  from v$sesstat
 where v$sesstat.sid = &user_sid
   and v$sesstat.statistic# = &stat_no
/

rem  Select every row from the target table
select &last_col xx
  from &obj_own..&obj_nam
 where &indexed_column <= (select max(&indexed_column)
			     from &obj_own..&obj_nam)
/

column value new_value after_count 
select value
  from v$sesstat
 where v$sesstat.sid = &user_sid
   and v$sesstat.statistic# = &stat_no
/
 
set termout on

select 'Table '||upper('&obj_own')||'.'||upper('&obj_nam')||' contains '||
       (to_number(&after_count) - to_number(&before_count))||
       ' chained row'||
       decode(to_number(&after_count) - to_number(&before_count),1,'.','s.')
  from dual
 where rtrim('&indexed_column') is not null
/

rem If we don't have an indexed column this won't work so say so
select 'Table '||
       upper('&obj_own')||'.'||upper('&obj_nam')||
      ' has no indexed, not null columns.'
  from dual
 where rtrim('&indexed_column') is null
/

set termout on feedback 15 verify on pagesize 20 linesize 80 space 1 heading on
undef obj_nam
undef obj_own
undef before_count
undef after_count
undef indexed_column
undef last_col
undef stat_no
undef user_sid
clear columns
clear computes
