set feed off

SELECT /*+ RULE */
          substr(S1.STATUS,1,8) "Status",
          substr(s1.username,1,15) "User",
          substr(s1.osuser,1,15) "Os User",
          substr(s1.machine,1,25) "Machine",
          substr(s1.module,1,20) "Module",
          substr(s1.program,1,25) "Program",
          substr(to_char(w.session_id),1,6) "SID",
          substr(P1.spid,1,10) "PSID",
          ' -> ESTA LOCANDO -> ' " <- ESTA LOCADA -< ",
          substr(S2.STATUS,1,8) "Status",
          substr(s2.username,1,15) "User",
          substr(s2.osuser,1,15) "Os User",
          substr(s2.machine,1,25) "Machine",
          substr(s2.module,1,20) "Module",
          substr(s2.program,1,25) "Program",
          to_number(substr(to_char(h.session_id),1,6)) "SID",
          substr(P2.spid,1,10)  "PSID",
          '||' "||",
          case when s1.ROW_WAIT_OBJ# = s2.ROW_WAIT_OBJ# then s1.ROW_WAIT_OBJ# else s2.ROW_WAIT_OBJ# end "Id Objeto",
          (select substr(object_name,1,20)||'-'||OBJECT_TYPE from dba_objects where object_id=s1.ROW_WAIT_OBJ#) "Object Name",
          dbms_rowid.rowid_create ( 1, s1.ROW_WAIT_OBJ#, s1.ROW_WAIT_FILE#, s1.ROW_WAIT_BLOCK#, s1.ROW_WAIT_ROW# ) "Rowid da Linha Locada      "
   FROM sys.v_$process P1,
        sys.v_$process P2,
        sys.v_$session S1,
        sys.v_$session S2,
        sys.dba_lock w,
        sys.dba_lock h
   WHERE h.mode_held       != 'None'
     AND h.mode_held       != 'Null'
     AND w.mode_requested  != 'None'
     AND w.lock_type (+)    = h.lock_type
     AND w.lock_id1  (+)    = h.lock_id1
     AND w.lock_id2  (+)    = h.lock_id2
     AND w.session_id       = S1.sid  (+)
     AND h.session_id       = S2.sid  (+)
     AND S1.paddr           = P1.addr (+)
     AND S2.paddr           = P2.addr (+)
   ORDER BY 7;

DECLARE
VSID NUMBER;
VUSERNAME VARCHAR2(100);
VSQL_HASH_VALUE NUMBER;
VSQL_TEXT VARCHAR2(1000);
CURSOR C1 IS
               SELECT /*+ RULE */
                      a.sql_hash_value,a.sid,a.username
                 FROM sys.dba_lock w,
                      sys.dba_lock h,
                      v$session a 
                WHERE h.mode_held       != 'None'
                  AND h.mode_held       != 'Null'
                  AND w.mode_requested  != 'None'
                  AND w.lock_type (+)    = h.lock_type
                  AND w.lock_id1  (+)    = h.lock_id1
                  AND w.lock_id2  (+)    = h.lock_id2
                  and a.sid              = to_number(substr(to_char(w.session_id),1,6));

BEGIN
    OPEN C1;
        LOOP
        FETCH C1 INTO VSQL_HASH_VALUE,VSID,VUSERNAME;
        EXIT WHEN C1%NOTFOUND;
        
            BEGIN
                SELECT SQL_TEXT 
                  INTO VSQL_TEXT
                  FROM V$SQLAREA 
                 WHERE HASH_VALUE = VSQL_HASH_VALUE;
                 
                dbms_output.put_line('SID -> '||VSID||'  USERNAME -> '||VUSERNAME||'   SQL HASH -> '||VSQL_HASH_VALUE);
                dbms_output.put_line(VSQL_TEXT||chr(10)||chr(10));   
                  
            END;
        END LOOP;
    CLOSE C1;                    
END;
/