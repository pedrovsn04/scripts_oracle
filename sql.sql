col sql_fulltext for a100

select sql_fulltext
from v$sql
where sql_id = '&sql_id'
/
