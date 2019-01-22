SET ECHO off 
set feedback on  
set echo on  
set verify off  

def towner=&1  def tname=&2    

--analyze table &towner..&tname compute statistics ;

col val1 new_value blks_w_rows   
col val2 new_value blks_above   

select blocks val1, empty_blocks val2  
  from dba_tables  
 where owner      = upper('&towner') 
;

  
col val1 new_value alloc_blocks   
select blocks val1  
  from dba_segments  
 where owner        = upper('&&towner') 
;
 
col val1 new_value hwm   
select &alloc_blocks-&blks_above-1 val1   
  from dual ;    


col val1 new_value cr   
select chain_cnt val1   
  from dba_tables  
 where owner        = upper('&&towner') 
;

col val1 new_val sf   
select count(*) val1  
  from dba_extents  
 where owner        = upper('&towner') 
;
drop table tfrag;

create table tfrag
 (    owner				        char(30),    
      name				        char(30),    
      hwm				        number,    
      blks_w_rows			    number,    
      avg_row_size		 	    number,    
      possible_bytes_per_block	number,    
      no_frag_rows			    number,    
      no_extents			    number  )  ;  
      
create unique index tfrag_u1 
    on tfrag (owner,name);  

delete    
  from  tfrag  
 where owner='&&towner' 
;   
insert into tfrag 
values ('SNG','&&tname',&hwm,&blks_w_rows,0,0,&cr,&sf)  ;  

commit;    

set echo off 
set verify on 


SET ECHO off 
col towner	heading 'Owner'			format a8 	trunc 
col tname	heading 'Table Name'		format a40 	trunc 
col exts	heading 'Exts'			format 999 	trunc 
col omega1	heading 'Omega1'		format 0.999 	trunc 
col chains	heading 'Chains'		format 99,990 	trunc   
ttitle  -   center  'Table Fragmentation Characteristics'   skip 2   
select owner towner, 
       name tname, 
       no_extents exts, 
       (hwm - blks_w_rows)/(hwm + 0.0001) omega1, 
       no_frag_rows chains  
  from tfrag  
  order by 1,2 ;  
             
             
SET ECHO off 
col towner	format a70  
col tname	format a70  
col exts	format 999  
col omega1	format 90.9999  
col chains	format 99,990  
col rpb		format 999  
col hwm		format 9,999,999  
col bwr		format 9,999,999    
ttitle -   center  'Detailed Table Fragmentation Characteristics'  skip 2    
set heading off    
select 'Table Owner : '||owner towner,
       'Name        : '||name tname,
       'Extents     : '||no_extents exts,
       'High water mark     : '||hwm			hwm,         
       'Blocks with rows    : '||blks_w_rows		bwr,         
       'Block frag: Omega1  : '||(hwm - blks_w_rows)/(hwm + 0.0001) omega1,         
       'Migrated rows       : '||no_frag_rows		chains  
from   tfrag  order by 1,2 ;
set heading on
 
 