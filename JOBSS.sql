SELECT substr(OWNER,1,10) OWNER,
       substr(JOB_NAME,1,20) "NAME",
       substr(JOB_CREATOR,1,10) "CREATOR",
       substr(JOB_TYPE,1,10) "TYPE",
       substr(JOB_ACTION,1,50) "ACTION",
       substr(START_DATE,1,10) "START DATE",
       substr(REPEAT_INTERVAL,1,10) "REPETI��O",
       SUBSTR(ENABLED,1,5) "ENABLED",
       SUBSTR(RUN_COUNT,1,3) "RUN COUNT",
       SUBSTR(FAILURE_COUNT,1,3) "FAILURE COUNT",
       SUBSTR(NEXT_RUN_DATE,1,10) "NEXT RUN DATE",
       SUBSTR(COMMENTS,1,30) "COMENT�RIO"
FROM ALL_SCHEDULER_JOBS;