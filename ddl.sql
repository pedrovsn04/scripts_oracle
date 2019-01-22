break on object_name skip page duplicate
col DDL for a90

select	
'spool pnxtl08_bix_' || a.owner || '.'||  a.object_name || '.sql;' 
|| CHR(10)
|| 'select dbms_metadata.get_ddl('|| '''' || b.object_type ||'''' || ','''|| b.object_name || '''' ||',''' || b.owner || ''') from dual;'
||CHR(10)
|| 'spool off;' as DDL
from	dba_objects a, dba_objects b, dba_objects c
where	a.object_name in(
'KBIX_APP_SEQUENCE_COMPOSITION',
'KBIX_BILLCYCLES_I',
'KBIX_BILLING_ACCOUNT_I',
'KBIX_CCONTACT_ALL_I',
'KBIX_COMP_RESOURCE',
'KBIX_CUSTOMER_ALL_I',
'KBIX_MAJOR_CURRENCY',
'KBIX_MAXVALUE',
'KBIX_MPUUBTAB_I',
'KBIX_PAYMENT_ALL',
'KBIX_PAYMENT_I',
'KBIX_USERS_I',
'KBIX_UTIL',
'KBSC_CUSTOMER_I',
'KRAI_SERVICE_DETAIL',
'KBPT_JAVA',
'KGBT_DOWNLOAD_I',
'KGBT_DOWNLOAD',
'KRAI_PLAN',
'KRAI_SELECTS',
'KRAI_SERVICE',
'PCK_INTERFACE_CDR_ATS_I')
and a.owner = b.owner 
and b.owner = c.owner 
and c.owner in ('PPA','RAI','GBT','BPT','BIX')
and a.object_type = b.object_type
and b.object_type= c.object_type
and c.object_type = 'PACKAGE'
and a.object_name = b.object_name
and b.object_name = c.object_name
/


