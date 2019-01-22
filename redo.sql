
set feedback on
set heading on



column cdate format a10
column DAY format a10
column  00 format a5
column  01 format a5
column  02 format a5
column  03 format a5
column  04 format a5
column  05 format a5
column  06 format a5
column  07 format a5
column  08 format a5
column  09 format a5
column  10 format a5
column  11 format a5
column  12 format a5
column  13 format a5
column  14 format a5
column  15 format a5
column  16 format a5
column  17 format a5
column  18 format a5
column  19 format a5
column  20 format a5
column  21 format a5
column  22 format a5
column  23 format a5



--Quantidade de switch de redo por dia
ALTER SESSION SET nls_date_format='dd.mm.yyyy';

SELECT TO_CHAR(FIRST_TIME,'DD.MM') CDATE,
    max(to_char(to_date(FIRST_TIME,'DD.MM.YYYY'),'Dy')) DAY,
    count('1') TOTAL,
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'00',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'00',1,0)),'999')) "00",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'01',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'01',1,0)),'999')) "01",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'02',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'02',1,0)),'999')) "02",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'03',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'03',1,0)),'999')) "03",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'04',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'04',1,0)),'999')) "04",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'05',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'05',1,0)),'999')) "05",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'06',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'06',1,0)),'999')) "06",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'07',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'07',1,0)),'999')) "07",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'08',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'08',1,0)),'999')) "08",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'09',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'09',1,0)),'999')) "09",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'10',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'10',1,0)),'999')) "10",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'11',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'11',1,0)),'999')) "11",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'12',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'12',1,0)),'999')) "12",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'13',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'13',1,0)),'999')) "13",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'14',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'14',1,0)),'999')) "14",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'15',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'15',1,0)),'999')) "15",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'16',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'16',1,0)),'999')) "16",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'17',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'17',1,0)),'999')) "17",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'18',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'18',1,0)),'999')) "18",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'19',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'19',1,0)),'999')) "19",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'20',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'20',1,0)),'999')) "20",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'21',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'21',1,0)),'999')) "21",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'22',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'22',1,0)),'999')) "22",
    decode(to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'23',1,0)),'999'),'   0','   ',to_char(SUM(decode(TO_CHAR(FIRST_TIME,'HH24'),'23',1,0)),'999')) "23"
FROM V$log_history
WHERE TO_CHAR(FIRST_TIME,'MM.YYYY') = TO_CHAR(SYSDATE,'MM.YYYY')
GROUP BY TO_CHAR(FIRST_TIME,'DD.MM')
ORDER BY TO_CHAR(FIRST_TIME,'DD.MM') DESC
/

