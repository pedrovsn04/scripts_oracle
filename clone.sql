-- ********************************************************************
-- * Copyright Notice   : (c)2003 OraPub, Inc.
-- * Filename           : clone.sql
-- * Author             : Craig A. Shallahamer
-- * Original           : 20-Nov-02
-- * Last Update        : 18-Dec-03
-- * Description        : Shows the number of blocks clones in the buffer cache for
-- *                      each file/block
-- * Usage              : start clone.sql
-- ********************************************************************

def osm_prog    = 'clone.sql'
def osm_title   = 'Buffer Clone Summary Report'

start osmtitle

set echo off feedback off verify off

col fl       format 999999      heading "File #"
col blk      format 999999      heading "Block #"
col cnt	     format 999999	heading "Clones"

select file# fl, 
       block# blk, 
       count(*) cnt
from   v$bh 
group by file#, block# 
having count(*) > 1
order by cnt
/

start osmclear

prompt
prompt For file|block details run, objfb.sql <file#> <block#>

