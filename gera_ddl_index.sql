REM
REM                      SCRIPT FOR CREATING INDEXES
REM
REM This script must be run by a user with the DBA role.
REM
REM Running this script will in turn create a script to build all the
REM indexes in the database.  This created script, create_index.sql,
REM can be run by any user with the DBA role or with the 'CREATE ANY INDEX'
REM system privilege.
REM
REM The script will NOT capture the indexes created by the user 'SYS'.
REM
REM The script will capture indexes for clusters, but the create statement
REM for these indexes will fail because it DOES NOT include the
REM keyword CLUSTER.  If the create index of a cluster is executed, it
REM will result in an error 'ora-942 table or view does not exist' because
REM it will be looking for a table of that name NOT A CLUSTER.
REM
REM NOTE:  Indexes automatically created by table CONSTRAINTS will also
REM be INCLUDED in the create_index.sql script.  It may cause a problem to
REM create an index with a system assigned name such as SYS_C00333.
REM

set verify off;
set termout off;
set feedback off;
set echo off;
set pagesize 0;

set termout on
select 'Creating index build script...' from dual;
set termout off;

create table i_temp
     (lineno NUMBER, id_owner VARCHAR2(30), id_name VARCHAR2(30),
      text VARCHAR2(800))
/


DECLARE
   CURSOR ind_cursor IS select   owner,
                                 index_name,
                                 table_owner,
                                 table_name,
                                 uniqueness,
                                 tablespace_name,
                                 ini_trans,
                                 max_trans,
                                 initial_extent,
                                 next_extent,
                                 min_extents,
                                 max_extents,
                                 pct_increase,
                                 pct_free
                        from     dba_indexes
			where index_name IN (SELECT OBJECT_NAME FROM DBA_OBJECTS WHERE OBJECT_TYPE='INDEX' AND CREATED > '01/03/2007')
                        order by index_name;
   CURSOR col_cursor (i_own VARCHAR2, c_ind VARCHAR2, c_tab VARCHAR2) IS
               select   column_name
               from     dba_ind_columns
               where    index_owner = i_own
                 and    index_name = c_ind
                 and    table_name = c_tab
                order   by column_position;

   lv_index_owner       dba_indexes.owner%TYPE;
   lv_index_name        dba_indexes.index_name%TYPE;
   lv_table_owner       dba_indexes.table_owner%TYPE;
   lv_table_name        dba_indexes.table_name%TYPE;
   lv_uniqueness        dba_indexes.uniqueness%TYPE;
   lv_tablespace_name   dba_indexes.tablespace_name%TYPE;
   lv_ini_trans         dba_indexes.ini_trans%TYPE;
   lv_max_trans         dba_indexes.max_trans%TYPE;
   lv_initial_extent    dba_indexes.initial_extent%TYPE;
   lv_next_extent       dba_indexes.next_extent%TYPE;
   lv_min_extents       dba_indexes.min_extents%TYPE;
   lv_max_extents       dba_indexes.max_extents%TYPE;
   lv_pct_increase      dba_indexes.pct_increase%TYPE;
   lv_pct_free          dba_indexes.pct_free%TYPE;
   lv_column_name       dba_ind_columns.column_name%TYPE;
   lv_first_rec         BOOLEAN;
   lv_string            VARCHAR2(800);
   lv_lineno            number := 0;

   procedure write_out(p_line INTEGER, p_owner varchar2, p_name VARCHAR2,
                       p_string VARCHAR2) is
   begin
      insert into i_temp (lineno,id_owner, id_name,text)
             values (p_line,p_owner,p_name,p_string);
   end;

BEGIN
   OPEN ind_cursor;
   LOOP
      FETCH ind_cursor INTO     lv_index_owner,
                                lv_index_name,
                                lv_table_owner,
                                lv_table_name,
                                lv_uniqueness,
                                lv_tablespace_name,
                                lv_ini_trans,
                                lv_max_trans,
                                lv_initial_extent,
                                lv_next_extent,
                                lv_min_extents,
                                lv_max_extents,
                                lv_pct_increase,
                                lv_pct_free;
      EXIT WHEN ind_cursor%NOTFOUND;
        lv_lineno := 1;
      lv_first_rec := TRUE;
      if (lv_uniqueness = 'UNIQUE') then
         lv_string:= 'CREATE UNIQUE INDEX ' || lower(lv_index_owner) || '.' ||
                     lower(lv_index_name);
         write_out(lv_lineno, lv_index_owner, lv_index_name, lv_string);
         lv_lineno := lv_lineno + 1;
      else
         lv_string:= 'CREATE INDEX ' || lower(lv_index_owner) || '.' ||
                     lower(lv_index_name);
         write_out(lv_lineno, lv_index_owner, lv_index_name, lv_string);
         lv_lineno := lv_lineno + 1;
      end if;
      OPEN col_cursor(lv_index_owner,lv_index_name,lv_table_name);
      LOOP
         FETCH col_cursor INTO lv_column_name;
         EXIT WHEN col_cursor%NOTFOUND;
         if (lv_first_rec) then
            lv_string := '   ON '|| lower(lv_table_owner) || '.' ||
                         lower(lv_table_name)||' (';
         lv_first_rec := FALSE;
         else
            lv_string := lv_string || ', ';
         end if;
         lv_string := lv_string || lower(lv_column_name);
      END LOOP;
      CLOSE col_cursor;
      lv_string := lv_string || ')';
      write_out(lv_lineno, lv_index_owner, lv_index_name, lv_string);
      lv_lineno := lv_lineno + 1;
      lv_string := null;
      lv_string := 'PCTFREE ' || to_char(lv_pct_free);
      write_out(lv_lineno, lv_index_owner, lv_index_name, lv_string);
      lv_lineno := lv_lineno + 1;
      lv_string := 'INITRANS ' || to_char(lv_ini_trans) ||
                  ' MAXTRANS ' || to_char(lv_max_trans);
      write_out(lv_lineno, lv_index_owner, lv_index_name, lv_string);
      lv_lineno := lv_lineno + 1;
      lv_string := 'TABLESPACE ' || lv_tablespace_name || ' STORAGE (';
      write_out(lv_lineno, lv_index_owner, lv_index_name, lv_string);
      lv_lineno := lv_lineno + 1;
      lv_string := 'INITIAL ' || to_char(lv_initial_extent) ||
                   ' NEXT ' || to_char(lv_next_extent);
      write_out(lv_lineno, lv_index_owner, lv_index_name, lv_string);
      lv_lineno := lv_lineno + 1;
      lv_string := 'MINEXTENTS ' || to_char(lv_min_extents) ||
                  ' MAXEXTENTS ' || to_char(lv_max_extents) ||
                 ' PCTINCREASE ' || to_char(lv_pct_increase) || ')';
      write_out(lv_lineno, lv_index_owner, lv_index_name, lv_string);
      lv_lineno := lv_lineno + 1;
      lv_string := '/';
      write_out(lv_lineno, lv_index_owner, lv_index_name, lv_string);
      lv_lineno := lv_lineno + 1;
      lv_lineno := lv_lineno + 1;
      lv_string:='                                                  ';
      write_out(lv_lineno, lv_index_owner, lv_index_name, lv_string);
   END LOOP;
   CLOSE ind_cursor;
END;
/

spool create_indexes.sql
set heading off
set recsep off
col text format a80 word_wrap

select   text
from     I_temp
order by id_owner, id_name, lineno;

spool off

drop table i_temp;
