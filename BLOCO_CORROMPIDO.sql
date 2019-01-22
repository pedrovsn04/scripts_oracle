SELECT 	tablespace_name, segment_type, owner, segment_name           
FROM	dba_extents          
WHERE	file_id = &FILE01 
and 	&BLOCK01 between block_id AND block_id + blocks - 1  
/



REM Create the repair table in a given tablespace:

BEGIN
DBMS_REPAIR.ADMIN_TABLES (
TABLE_NAME => 'REPAIR_TABLE',
TABLE_TYPE => dbms_repair.repair_table,
ACTION => dbms_repair.create_action,
TABLESPACE => '&tablespace_name');
END;
/ 

REM Identify corrupted blocks for schema.object:

set serveroutput on
DECLARE num_corrupt INT;
BEGIN
num_corrupt := 0;
DBMS_REPAIR.CHECK_OBJECT (
SCHEMA_NAME => '&schema_name',
OBJECT_NAME => '&object_name',
REPAIR_TABLE_NAME => 'REPAIR_TABLE',
corrupt_count => num_corrupt);
DBMS_OUTPUT.PUT_LINE('number corrupt: ' || TO_CHAR (num_corrupt));
END;
/

REM Optionally display any corrupted block identified by check_object:

select BLOCK_ID, CORRUPT_TYPE, CORRUPT_DESCRIPTION 
from REPAIR_TABLE;

REM Mark the identified blocks as corrupted

DECLARE num_fix INT;
BEGIN
num_fix := 0;
DBMS_REPAIR.FIX_CORRUPT_BLOCKS (
SCHEMA_NAME => '&schema_name',
OBJECT_NAME=> '&object_name',
OBJECT_TYPE => dbms_repair.table_object,
REPAIR_TABLE_NAME => 'REPAIR_TABLE',
FIX_COUNT=> num_fix);
DBMS_OUTPUT.PUT_LINE('num fix: ' || to_char(num_fix));
END;
/

REM Allow future DML statements to skip the corrupted blocks:

BEGIN
DBMS_REPAIR.SKIP_CORRUPT_BLOCKS (
SCHEMA_NAME => '&schema_name',
OBJECT_NAME => '&object_name',
OBJECT_TYPE => dbms_repair.table_object,
FLAGS => dbms_repair.SKIP_FLAG);
END;
/

Use the dbms_repair.NOSKIP_FLAG in the FLAGS value in procedure SKIP_CORRUPT_BLOCKS if it is needed to stop skipping corrupt blocks in the object after the dbms_repair.SKIP_FLAG was used.


