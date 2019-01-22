12:21:19 PNXTL08.OP_PNET2>declare
12:21:19   2     v_btimeslice date := sysdate-30;
12:21:19   3     v_etimeslice date := sysdate;
12:21:19   4     v_btime date;
12:21:19   5     v_etime date;
12:21:19   6     v_elasecs integer;
12:21:19   7     v_bcpu integer;
12:21:19   8     v_ecpu integer;
12:21:19   9     v_cpusecs integer;
12:21:19  10     v_total number;
12:21:19  11     cursor c_snaps is
12:21:19  12            select s.snap_id snap_id , to_char(s.snap_time,'yy/mm/dd-HH24:mi') snapdat
12:21:19  13              from stats$snapshot s
12:21:19  14             where s.snap_time between v_btimeslice and v_etimeslice
12:21:19  15             order by s.snap_time;
12:21:19  16     cursor c_data (v_bid in integer, v_eid in integer) is
12:21:19  17          select event , time time_s
12:21:19  18                    from (  select e.event, (e.time_waited_micro - nvl(b.time_waited_micro,0))/1000000 time
12:21:19  19                           from stats$system_event b
12:21:19  20                              , stats$system_event e
12:21:19  21                          where b.snap_id(+)          = v_bid
12:21:19  22                            and e.snap_id             = v_eid
12:21:19  23                            and b.event(+)            = e.event
12:21:19  24                            and e.total_waits         > nvl(b.total_waits,0)
12:21:19  25                            and e.event not in (select event from stats$idle_event)
12:21:19  26                          UNION ALL
12:21:19  27                         select 'CPU' event, (e.value-b.value)/100 time
12:21:19  28                           from stats$sysstat b, stats$sysstat e
12:21:19  29                          where e.snap_id         = v_eid
12:21:19  30                            and b.snap_id         = v_bid
12:21:19  31                            and e.name            = 'CPU used by this session'
12:21:19  32                            and b.name            = 'CPU used by this session'
12:21:19  33                          order by time desc
12:21:19  34                        ) where time > 0
12:21:19  35           and rownum <= 25;
12:21:19  36  begin
12:21:19  37     dbms_output.put_line('SnapID;DataHora;Evento;Tempo(s)');
12:21:19  38     for r_snap in c_snaps loop
12:21:19  39        v_total := 0;
12:21:19  40        for r_data in c_data(r_snap.snap_id, r_snap.snap_id+1) loop
12:21:19  41            v_total := v_total + r_data.time_s;
12:21:19  42            dbms_output.put_line(r_snap.snap_id||';'||r_snap.snapdat||';'||r_data.event||';'||r_data.time_s);
12:21:19  43        end loop;
12:21:19  44     end loop;
12:21:19  45  end;
12:21:19  46  /
            from stats$snapshot s
                 *
ERRO na linha 13:
ORA-06550: line 13, column 18:
PL/SQL: ORA-00942: table or view does not exist
ORA-06550: line 12, column 11:
PL/SQL: SQL Statement ignored
ORA-06550: line 20, column 31:
PL/SQL: ORA-00942: table or view does not exist
ORA-06550: line 17, column 9:
PL/SQL: SQL Statement ignored
ORA-06550: line 40, column 28:
PLS-00364: loop index variable 'R_SNAP' use is invalid
ORA-06550: line 40, column 7:
PL/SQL: Statement ignored


12:21:20 PNXTL08.OP_PNET2>spool off
