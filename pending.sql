select 'rollback force '''||LOCAL_TRAN_ID ||''';'||chr(10)||
	'alter session set "_smu_debug_mode" = 4;'||chr(10)||
	'Execute dbms_transaction.purge_lost_db_entry('''||LOCAL_TRAN_ID ||''');'||chr(10)||
	'Commit;'
from dba_2pc_pending;

