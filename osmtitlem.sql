-- ********************************************************************
-- * Copyright Notice   : (c)1998,2004 OraPub, Inc.
-- * Filename		: osmtitle.sql - Version 1.0
-- * Author		: Craig A. Shallahamer
-- * Original		: 10-jan-04
-- * Last Update	: 02-jun-04
-- * Description	: Standard OSM title header
-- * Usage		: start osmtitle.sql
-- ********************************************************************

set termout off

break on today
col today new_value now
select to_char(sysdate, 'DD-MON-YY HH:MIam') today 
from   dual;

col val1 new_value db noprint
select value val1 
from   v$parameter 
where  name = 'db_name';

clear breaks
set termout on
set heading on
set linesize 118

ttitle -
    left 'Database: &db'        right now              skip 0 -
    left 'Report:   &osm_prog'  center 'OSM by OraPub, Inc.' - 
    right 'Page' sql.pno                               skip 1 -
    center '&osm_title'                                skip 2
