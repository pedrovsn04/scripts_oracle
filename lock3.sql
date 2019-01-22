DECLARE
VW_STATUS   VARCHAR2(100);
VW_USERNAME VARCHAR2(100);
VW_OSUSER VARCHAR2(100);
VW_MACHINE VARCHAR2(100);
VW_MODULE VARCHAR2(100);
VW_PROGRAM VARCHAR2(100);
VW_SID NUMBER;
VW_PID NUMBER;
VW_OBJ_ID    NUMBER;
VW_ROWID VARCHAR2(100);
VW_SQLHASHVALUE VARCHAR2(100);
VW_SQLTEXT VARCHAR2(1000);
VW_OBJ_OWNER VARCHAR2(100);
VW_OBJ_NAME VARCHAR2(100);
VW_OBJ_TYPE VARCHAR2(100);

VH_STATUS VARCHAR2(100);
VH_USERNAME VARCHAR2(100);
VH_OSUSER VARCHAR2(100);
VH_MACHINE VARCHAR2(100);
VH_MODULE VARCHAR2(100);
VH_PROGRAM VARCHAR2(100);
VH_SID NUMBER;
VH_PID NUMBER;
VH_OBJ_ID      NUMBER;      
VH_ROWID VARCHAR2(100);
VH_SQLHASHVALUE VARCHAR2(100);
VH_SQLTEXT VARCHAR2(1000);
VH_OBJ_OWNER VARCHAR2(100);
VH_OBJ_NAME VARCHAR2(100);
VH_OBJ_TYPE VARCHAR2(100);
CURSOR C1 IS
SELECT /*+ RULE */
          S1.STATUS,
          s1.username,
          s1.osuser,
          s1.machine,
          s1.module,
          s1.program,
          to_number(substr(to_char(W.session_id),1,6)),
          P1.spid,
          s1.ROW_WAIT_OBJ#,
          dbms_rowid.rowid_create ( 1, s2.ROW_WAIT_OBJ#, s2.ROW_WAIT_FILE#, s2.ROW_WAIT_BLOCK#, s2.ROW_WAIT_ROW# ),
          S1.SQL_HASH_VALUE,
          S2.STATUS,
          s2.username,
          s2.osuser,
          s2.machine,
          s2.module,
          s2.program,
          to_number(substr(to_char(h.session_id),1,6)),
          P2.spid,
          s2.ROW_WAIT_OBJ#,
          dbms_rowid.rowid_create ( 1, s1.ROW_WAIT_OBJ#, s1.ROW_WAIT_FILE#, s1.ROW_WAIT_BLOCK#, s1.ROW_WAIT_ROW# ),
          S2.SQL_HASH_VALUE
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
BEGIN
    OPEN C1;
        LOOP
        FETCH C1 INTO VW_STATUS,VW_USERNAME,VW_OSUSER,VW_MACHINE,VW_MODULE,VW_PROGRAM,VW_SID,VW_PID,VW_OBJ_ID,VW_ROWID,VW_SQLHASHVALUE,VH_STATUS,VH_USERNAME,VH_OSUSER,VH_MACHINE,VH_MODULE,VH_PROGRAM,VH_SID,VH_PID,VH_OBJ_ID,VH_ROWID,VH_SQLHASHVALUE;     
        EXIT WHEN C1%NOTFOUND;
BEGIN
                SELECT SQL_TEXT INTO VW_SQLTEXT FROM V$SQLAREA WHERE HASH_VALUE = VW_SQLHASHVALUE;
                select OWNER,OBJECT_NAME,OBJECT_TYPE INTO VW_OBJ_OWNER,VW_OBJ_NAME,VW_OBJ_TYPE from dba_objects where object_id = VW_OBJ_ID;
                
                IF VH_SQLHASHVALUE IS NOT NULL AND VH_SQLHASHVALUE <> 0 THEN
                    SELECT SQL_TEXT INTO VH_SQLTEXT FROM V$SQLAREA WHERE HASH_VALUE = VH_SQLHASHVALUE;
                ELSE
                    VH_SQLTEXT := 'PROCURAR NA CURSOR';
                END IF;          
                
                IF VH_OBJ_ID IS NOT NULL AND VH_OBJ_ID <> 0 THEN
                    select OWNER,OBJECT_NAME,OBJECT_TYPE INTO VH_OBJ_OWNER,VH_OBJ_NAME,VH_OBJ_TYPE from dba_objects where object_id = VH_OBJ_ID;
                               END IF;
                
                
        DBMS_OUTPUT.PUT_LINE('Waiter');  
        dbms_output.put_line(substr('Status ',1,length(VW_STATUS))||substr('Us  ',1,length(VW_USERNAME))||'Os User');     
        DBMS_OUTPUT.PUT_LINE(VW_STATUS||' - '||VW_USERNAME||' - '||VW_OSUSER||' - '||VW_MACHINE||' - '||VW_MODULE||' - '||VW_PROGRAM||' - '||VW_SID||' - '||VW_PID||' - '||VW_OBJ_ID||' - '||VW_ROWID||' - '||VW_SQLHASHVALUE||' - '||VW_OBJ_OWNER||' - '||VW_OBJ_NAME||' - '||VW_OBJ_TYPE||chr(10));       
        dbms_output.put_line(vw_sqltext);
        dbms_output.put_line('Holder ');     
        DBMS_OUTPUT.PUT_LINE(VH_STATUS||VH_USERNAME||VH_OSUSER||VH_MACHINE||VH_MODULE||VH_PROGRAM||VH_SID||VH_PID||VH_OBJ_ID||VH_ROWID||VH_SQLHASHVALUE||VH_SQLTEXT||VH_OBJ_OWNER||VH_OBJ_NAME||VH_OBJ_TYPE||chr(10));     
  
            END;
        END LOOP;
    CLOSE C1;                    
END;
/'