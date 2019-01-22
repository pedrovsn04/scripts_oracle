select b.GROUP#, a.status, substr(MEMBER,1,60) , sum(a.bytes)/1024/1024 MB from  V$LOG a , v$logfile b
where a.group# = b.group#
group by b.GROUP#,a.status, substr(MEMBER,1,60)
/
