select     *       
from       dba_tab_privs
where      table_name = '&NOME_OBJ'        
-- and     PRIVILEGE = '&EXECUTE'
/
