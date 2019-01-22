SET SERVEROUTPUT ON
accept SSi prompt   'Entre com a SSI ou lista de SSI ex 123,124,125 .: '
set feed off;
SPOOL SSI_PROMPT.LST
DECLARE
stmt2 varchar2(200);
stmt varchar2(200);
     TYPE t_tab IS TABLE OF NUMBER;
     l_tab1 t_tab := t_tab(&SSi);
BEGIN
FOR i IN l_tab1.first .. l_tab1.last LOOP
   DBMS_OUTPUT.put_line(' Prompt Executando a SSi => '|| l_tab1(i));
    stmt := 'EXEC NXT_ADM_USUARIOS.CREATE_USER_SSI('||l_tab1(i)||');';
    dbms_output.put_line(stmt);
END LOOP;
END;
/
SPOOL OFF
set feed on;
set define on;
START SSI_PROMPT.LST

