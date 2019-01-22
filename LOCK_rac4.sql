   SELECT /*+ RULE */
          substr(S1.STATUS,1,8) "Status",
          substr(s1.username,1,15) "User",
          substr(s1.osuser,1,15) "Os User",
          substr(s1.machine,1,25) "Machine",
          substr(s1.module,1,20) "Module",
          substr(s1.program,1,20) "Program",
          to_number(substr(to_char(w.session_id),1,6)) "SID",
          substr(P1.spid,1,10) "PSID",
          s1.ROW_WAIT_OBJ# "Objet Id",
--          dbms_rowid.rowid_create(1,s1.ROW_WAIT_OBJ#,s1.ROW_WAIT_FILE#,s1.ROW_WAIT_BLOCK#,s1.ROW_WAIT_ROW# ) "Rowid da Linha",
          S1.SQL_HASH_VALUE " Sql Hash",
          (select substr(object_name,1,20)||' - '||OBJECT_TYPE from dba_objects where object_id=s1.ROW_WAIT_OBJ#) "Object Name",
          ' -> ESTA LOCANDO -> ' " <- ESTA LOCADA -< ",
          substr(S2.STATUS,1,8) "Status",
          substr(s2.username,1,15) "User",
          substr(s2.osuser,1,15) "Os User",
          substr(s2.machine,1,25) "Machine",
          substr(s2.module,1,20) "Module",
          substr(s2.program,1,20) "Program",
          to_number(substr(to_char(h.session_id),1,6)) "SID",
          substr(P2.spid,1,10)  "PSID",
          s2.ROW_WAIT_OBJ# "Objet Id",
--          dbms_rowid.rowid_create(1,s2.ROW_WAIT_OBJ#,s2.ROW_WAIT_FILE#,s2.ROW_WAIT_BLOCK#,s2.ROW_WAIT_ROW# ) "Rowid da Linha",
          S2.SQL_HASH_VALUE " Sql Hash",
          (select substr(object_name,1,20)||' - '||OBJECT_TYPE from dba_objects where object_id=s2.ROW_WAIT_OBJ#) "Object Name"
   FROM gv$process P1,
        gv$process P2,
        gv$session S1,
        gv$session S2,
        dba_lock w,
        dba_lock h
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
     AND s1.last_call_et > 15
   ORDER BY 7;

        
               SELECT /*+ RULE */
                      'Sql Locado  -> '||s1.sid||' - '||s1.username||' - '||(select substr(sql_text,1,100)||chr(10)||substr(sql_text,101,200) from gv$sqlarea where hash_value = s1.sql_hash_value)||chr(10)||
                      'Sql Locando -> '||s2.sid||' - '||s2.username||' - '||case when s2.sql_hash_value = 0 then (select ' VERIFICAR NA CURSOR ' FROM DUAL ) else (select sql_text from gv$sqlarea where hash_value = s2.sql_hash_value) end " Sql Text - Lock " 
                 FROM dba_lock w,
                      dba_lock h,
                      gv$session s1,
                      gv$session s2
                 WHERE h.mode_held       != 'None'
                  AND h.mode_held       != 'Null'
                  AND w.mode_requested  != 'None'
                  AND w.lock_type (+)    = h.lock_type
                  AND w.lock_id1  (+)    = h.lock_id1
                  AND w.lock_id2  (+)    = h.lock_id2
                  AND w.session_id       = S1.sid  (+)
                  AND h.session_id       = S2.sid  (+);