 COL C1  FORMAT 999999   HEADING 'Ses'
 COL C2  FORMAT 99999999  HEADING 'Id'
 COL C3  FORMAT A10  HEADING 'Submitter'     TRUNC
 COL C4  FORMAT A10  HEADING 'Security'      TRUNC
 COL C5  FORMAT A50  HEADING 'Job'           WORD_WRAPPED
 COL C6  FORMAT A5   HEADING 'Last|Ok|Date'
 COL C7  FORMAT A5   HEADING 'Last|Ok|Time'
 COL C8  FORMAT A5   HEADING 'This|Run|Date'
 COL C9  FORMAT A5   HEADING 'This|Run|Time'
 COL C10 FORMAT 99   HEADING 'Err'
 SELECT  /*+ RULE */ A.SID                         C1,
         A.JOB                         C2,
         B.LOG_USER                    C3,
         B.PRIV_USER                   C4,
         B.WHAT                        C5,
         to_char(A.LAST_DATE,'DD/MM')  C6,
         substr(A.LAST_SEC,1,5)        C7,
         to_char(A.THIS_DATE,'DD/MM')  C8,
         substr(A.THIS_SEC,1,5)        C9,
         A.FAILURES                    C10
         FROM DBA_JOBS B, DBA_JOBS_RUNNING A
         WHERE A.JOB = B.JOB
/

