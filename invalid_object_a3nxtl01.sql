20:18:20 A3NXTL01.IT_PPNETO>l
  1  SELECT owner, substr(OBJECT_NAME,1,40) object_name, OBJECT_TYPE, status, last_ddl_time
  2  FROM   dba_OBJECTS
  3  WHERE  STATUS = 'INVALID'
  4  and owner in ('SYS', 'SYSTEM', 'SYSAUX')
  5* ORDER  BY owner, OBJECT_NAME
20:18:21 A3NXTL01.IT_PPNETO>/

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        ALL_APPLY_ENQUEUE              VIEW                                INVALID 29/12/2012 04:12:07
SYS        ALL_APPLY_EXECUTE              VIEW                                INVALID 29/12/2012 04:15:52
SYS        ALL_CAPTURE                    VIEW                                INVALID 29/12/2012 05:09:42
SYS        ALL_CAPTURE_EXTRA_ATTRIBUTES   VIEW                                INVALID 29/12/2012 04:15:53
SYS        ALL_CAPTURE_PARAMETERS         VIEW                                INVALID 29/12/2012 04:15:53
SYS        ALL_IND_STATISTICS             VIEW                                INVALID 14/11/2012 22:55:26
SYS        ALL_JAVA_COMPILER_OPTIONS      VIEW                                INVALID 14/11/2012 22:55:26
SYS        ALL_PROPAGATION                VIEW                                INVALID 29/12/2012 04:15:53
SYS        ALL_QUEUE_SUBSCRIBERS          VIEW                                INVALID 29/12/2012 04:19:42
SYS        ALL_REPCAT                     VIEW                                INVALID 29/12/2012 03:06:22
SYS        ALL_REPCATLOG                  VIEW                                INVALID 29/12/2012 03:06:31
SYS        ALL_REPCOLUMN                  VIEW                                INVALID 29/12/2012 03:06:26
SYS        ALL_REPCOLUMN_GROUP            VIEW                                INVALID 29/12/2012 03:06:34
SYS        ALL_REPDDL                     VIEW                                INVALID 29/12/2012 03:06:32
SYS        ALL_REPFLAVOR_COLUMNS          VIEW                                INVALID 29/12/2012 03:06:46
SYS        ALL_REPFLAVOR_OBJECTS          VIEW                                INVALID 29/12/2012 03:06:45
SYS        ALL_REPGENERATED               VIEW                                INVALID 29/12/2012 03:06:31
SYS        ALL_REPGENOBJECTS              VIEW                                INVALID 29/12/2012 03:06:30
SYS        ALL_REPGROUP                   VIEW                                INVALID 29/12/2012 03:06:22
SYS        ALL_REPGROUPED_COLUMN          VIEW                                INVALID 29/12/2012 03:06:35
SYS        ALL_REPKEY_COLUMNS             VIEW                                INVALID 29/12/2012 03:06:29
SYS        ALL_REPOBJECT                  VIEW                                INVALID 29/12/2012 03:06:24
SYS        ALL_REPPARAMETER_COLUMN        VIEW                                INVALID 29/12/2012 03:06:42
SYS        ALL_REPPROP                    VIEW                                INVALID 29/12/2012 03:06:28
SYS        ALL_RULES                      VIEW                                INVALID 15/04/2012 01:18:13
SYS        ALL_SCHEDULER_JOB_ARGS         VIEW                                INVALID 15/04/2012 01:48:10
SYS        ALL_SCHEDULER_PROGRAM_ARGS     VIEW                                INVALID 15/04/2012 01:48:10
SYS        ALL_SQLSET_BINDS               VIEW                                INVALID 15/04/2012 01:48:24
SYS        ALL_STREAMS_COLUMNS            VIEW                                INVALID 15/04/2012 02:16:08
SYS        ALL_STREAMS_GLOBAL_RULES       VIEW                                INVALID 29/12/2012 04:40:34
SYS        ALL_STREAMS_MESSAGE_CONSUMERS  VIEW                                INVALID 29/12/2012 04:45:06
SYS        ALL_STREAMS_MESSAGE_RULES      VIEW                                INVALID 29/12/2012 04:49:43
SYS        ALL_STREAMS_NEWLY_SUPPORTED    VIEW                                INVALID 29/12/2012 04:49:43
SYS        ALL_STREAMS_RULES              VIEW                                INVALID 29/12/2012 05:09:42
SYS        ALL_STREAMS_SCHEMA_RULES       VIEW                                INVALID 29/12/2012 04:54:29
SYS        ALL_STREAMS_TABLE_RULES        VIEW                                INVALID 29/12/2012 05:09:39
SYS        ALL_STREAMS_TRANSFORM_FUNCTION VIEW                                INVALID 29/12/2012 05:04:28
SYS        ALL_STREAMS_UNSUPPORTED        VIEW                                INVALID 29/12/2012 05:04:28
SYS        ALL_SYNC_CAPTURE_TABLES        VIEW                                INVALID 29/12/2012 05:09:40
SYS        ALL_TAB_STATISTICS             VIEW                                INVALID 14/11/2012 23:47:17
SYS        ALL_WARNING_SETTINGS           VIEW                                INVALID 14/11/2012 23:47:17
SYS        ALL_XDS_ATTRIBUTE_SECS         VIEW                                INVALID 29/12/2012 05:09:40
SYS        ALL_XDS_INSTANCE_SETS          VIEW                                INVALID 29/12/2012 05:09:40
SYS        ALL_XDS_OBJECTS                VIEW                                INVALID 15/04/2012 02:27:19
SYS        ALL_XML_INDEXES                VIEW                                INVALID 29/12/2012 05:09:40
SYS        ALL_XSC_AGGREGATE_PRIVILEGE    VIEW                                INVALID 06/12/2012 22:05:38
SYS        ALL_XSC_PRIVILEGE              VIEW                                INVALID 06/12/2012 22:05:39
SYS        ALL_XSC_SECURITY_CLASS         VIEW                                INVALID 29/12/2012 05:09:41
SYS        ALL_XSC_SECURITY_CLASS_DEP     VIEW                                INVALID 06/12/2012 22:05:39
SYS        ALL_XSTREAM_OUTBOUND           VIEW                                INVALID 29/12/2012 05:09:41
SYS        ALL_XSTREAM_OUTBOUND_PROGRESS  VIEW                                INVALID 29/12/2012 05:09:41
SYS        ALL_XSTREAM_RULES              VIEW                                INVALID 29/12/2012 05:09:42
SYS        ANYDATA                        TYPE BODY                           INVALID 29/12/2012 04:08:10
SYS        ANYDATASET                     TYPE BODY                           INVALID 29/12/2012 04:08:10
SYS        ANYTYPE                        TYPE BODY                           INVALID 14/11/2012 22:33:22
SYS        AQ$ALERT_QT                    VIEW                                INVALID 15/04/2012 01:49:13
SYS        AQ$ALERT_QT_R                  VIEW                                INVALID 29/12/2012 05:20:29
SYS        AQ$AQ_EVENT_TABLE              VIEW                                INVALID 15/04/2012 01:28:12
SYS        AQ$AQ_PROP_TABLE               VIEW                                INVALID 15/04/2012 01:49:18
SYS        AQ$AQ_PROP_TABLE_R             VIEW                                INVALID 29/12/2012 05:37:22
SYS        AQ$KUPC$DATAPUMP_QUETAB        VIEW                                INVALID 29/12/2012 05:37:22
SYS        AQ$KUPC$DATAPUMP_QUETAB_1      VIEW                                INVALID 29/12/2012 05:37:22
SYS        AQ$KUPC$DATAPUMP_QUETAB_1_R    VIEW                                INVALID 29/12/2012 05:43:05
SYS        AQ$SCHEDULER$_EVENT_QTAB       VIEW                                INVALID 15/04/2012 01:49:11
SYS        AQ$SCHEDULER$_EVENT_QTAB_R     VIEW                                INVALID 29/12/2012 05:54:46
SYS        AQ$SCHEDULER$_REMDB_JOBQTAB    VIEW                                INVALID 15/04/2012 01:49:12
SYS        AQ$SCHEDULER$_REMDB_JOBQTAB_R  VIEW                                INVALID 29/12/2012 06:07:16
SYS        AQ$SCHEDULER_FILEWATCHER_QT    VIEW                                INVALID 15/04/2012 01:49:12
SYS        AQ$SCHEDULER_FILEWATCHER_QT_R  VIEW                                INVALID 29/12/2012 06:20:46
SYS        AQ$SYS$SERVICE_METRICS_TAB     VIEW                                INVALID 15/04/2012 01:49:20
SYS        AQ$SYS$SERVICE_METRICS_TAB_R   VIEW                                INVALID 29/12/2012 06:34:36
SYS        AQ$_ALERT_QT_F                 VIEW                                INVALID 15/04/2012 02:26:36
SYS        AQ$_AQ$_MEM_MC_F               VIEW                                INVALID 15/04/2012 02:26:52
SYS        AQ$_AQ_EVENT_TABLE_F           VIEW                                INVALID 15/04/2012 02:26:54
SYS        AQ$_AQ_PROP_TABLE_F            VIEW                                INVALID 15/04/2012 02:26:52
SYS        AQ$_DEQUEUE_HISTORY            TYPE                                INVALID 29/12/2012 03:04:53
SYS        AQ$_DEQUEUE_HISTORY_T          TYPE                                INVALID 14/11/2012 22:33:22
SYS        AQ$_DESCRIPTOR                 TYPE                                INVALID 14/04/2012 10:48:13
SYS        AQ$_DESCRIPTOR                 TYPE                                INVALID 14/04/2012 10:48:23
SYS        AQ$_DESCRIPTOR                 TYPE                                INVALID 14/04/2012 10:48:23
SYS        AQ$_DESCRIPTOR                 TYPE                                INVALID 16/09/2007 01:08:14
SYS        AQ$_DESCRIPTOR                 TYPE                                INVALID 29/12/2012 04:08:10
SYS        AQ$_DUMMY_T                    TYPE                                INVALID 29/12/2012 03:04:57
SYS        AQ$_EVENT_MESSAGE              TYPE                                INVALID 14/04/2012 10:48:21
SYS        AQ$_EVENT_MESSAGE              TYPE                                INVALID 14/04/2012 10:48:22
SYS        AQ$_EVENT_MESSAGE              TYPE                                INVALID 14/11/2012 22:33:22
SYS        AQ$_GET_SUBSCRIBERS            FUNCTION                            INVALID 29/12/2012 10:25:28
SYS        AQ$_HISTORY                    TYPE                                INVALID 29/12/2012 03:04:53
SYS        AQ$_JMS_ARRAY_ERRORS           TYPE                                INVALID 30/10/2012 22:11:23
SYS        AQ$_JMS_ARRAY_ERROR_INFO       TYPE                                INVALID 30/10/2012 22:11:23
SYS        AQ$_JMS_ARRAY_MSGIDS           TYPE                                INVALID 30/10/2012 22:11:23
SYS        AQ$_JMS_ARRAY_MSGID_INFO       TYPE                                INVALID 14/11/2012 22:33:23
SYS        AQ$_JMS_BYTES_MESSAGE          TYPE BODY                           INVALID 14/11/2012 22:33:23
SYS        AQ$_JMS_BYTES_MESSAGE          TYPE                                INVALID 30/10/2012 22:11:01
SYS        AQ$_JMS_BYTES_MESSAGES         TYPE                                INVALID 30/10/2012 22:11:24
SYS        AQ$_JMS_EXCEPTION              TYPE                                INVALID 30/10/2012 22:11:01
SYS        AQ$_JMS_HEADER                 TYPE BODY                           INVALID 14/11/2012 22:33:24

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        AQ$_JMS_HEADER                 TYPE                                INVALID 30/10/2012 22:10:59
SYS        AQ$_JMS_MAP_MESSAGE            TYPE BODY                           INVALID 14/11/2012 22:33:24
SYS        AQ$_JMS_MAP_MESSAGE            TYPE                                INVALID 30/10/2012 22:11:02
SYS        AQ$_JMS_MAP_MESSAGES           TYPE                                INVALID 30/10/2012 22:11:24
SYS        AQ$_JMS_MESSAGE                TYPE BODY                           INVALID 29/12/2012 04:08:11
SYS        AQ$_JMS_MESSAGE                TYPE                                INVALID 30/10/2012 22:11:22
SYS        AQ$_JMS_MESSAGES               TYPE                                INVALID 30/10/2012 22:11:22
SYS        AQ$_JMS_MESSAGE_PROPERTIES     TYPE                                INVALID 30/10/2012 22:11:23
SYS        AQ$_JMS_MESSAGE_PROPERTY       TYPE                                INVALID 30/10/2012 22:11:23
SYS        AQ$_JMS_NAMEARRAY              TYPE                                INVALID 30/10/2012 22:11:02
SYS        AQ$_JMS_OBJECT_MESSAGE         TYPE                                INVALID 30/10/2012 22:11:04
SYS        AQ$_JMS_OBJECT_MESSAGES        TYPE                                INVALID 30/10/2012 22:11:24
SYS        AQ$_JMS_STREAM_MESSAGE         TYPE                                INVALID 30/10/2012 22:11:05
SYS        AQ$_JMS_STREAM_MESSAGE         TYPE BODY                           INVALID 14/11/2012 22:33:26
SYS        AQ$_JMS_STREAM_MESSAGES        TYPE                                INVALID 30/10/2012 22:11:24
SYS        AQ$_JMS_TEXT_MESSAGE           TYPE                                INVALID 30/10/2012 22:10:59
SYS        AQ$_JMS_TEXT_MESSAGE           TYPE BODY                           INVALID 14/11/2012 22:33:27
SYS        AQ$_JMS_TEXT_MESSAGES          TYPE                                INVALID 30/10/2012 22:11:24
SYS        AQ$_JMS_USERPROPARRAY          TYPE                                INVALID 30/10/2012 22:10:57
SYS        AQ$_JMS_USERPROPERTY           TYPE                                INVALID 30/10/2012 22:10:57
SYS        AQ$_JMS_VALUE                  TYPE                                INVALID 30/10/2012 22:11:02
SYS        AQ$_KUPC$DATAPUMP_QUETAB_1_E   QUEUE                               INVALID 20/06/2012 19:28:19
SYS        AQ$_KUPC$DATAPUMP_QUETAB_1_F   VIEW                                INVALID 29/12/2012 07:02:56
SYS        AQ$_KUPC$DATAPUMP_QUETAB_1_P   TABLE                               INVALID 20/06/2012 19:28:21
SYS        AQ$_KUPC$DATAPUMP_QUETAB_1_V   EVALUATION CONTEXT                  INVALID 20/06/2012 19:28:16
SYS        AQ$_KUPC$DATAPUMP_QUETAB_E     QUEUE                               INVALID 15/04/2012 01:49:22
SYS        AQ$_KUPC$DATAPUMP_QUETAB_F     VIEW                                INVALID 29/12/2012 07:02:56
SYS        AQ$_KUPC$DATAPUMP_QUETAB_V     EVALUATION CONTEXT                  INVALID 15/04/2012 01:49:18
SYS        AQ$_MIDARRAY                   TYPE                                INVALID 29/12/2012 03:04:54
SYS        AQ$_NOTIFY_MSG                 TYPE                                INVALID 29/12/2012 03:04:53
SYS        AQ$_NTFN_DESCRIPTOR            TYPE                                INVALID 31/10/2012 00:40:21
SYS        AQ$_NTFN_MSGID_ARRAY           TYPE                                INVALID 30/10/2012 22:10:58
SYS        AQ$_POST_INFO                  TYPE                                INVALID 14/04/2012 10:48:23
SYS        AQ$_POST_INFO_LIST             TYPE                                INVALID 16/09/2007 01:08:14
SYS        AQ$_RECIPIENTS                 TYPE                                INVALID 29/12/2012 03:04:53
SYS        AQ$_REG_INFO                   TYPE BODY                           INVALID 29/12/2012 04:08:12
SYS        AQ$_REG_INFO                   TYPE                                INVALID 14/04/2012 10:48:21
SYS        AQ$_REG_INFO                   TYPE                                INVALID 14/04/2012 10:46:48
SYS        AQ$_REG_INFO                   TYPE                                INVALID 14/04/2012 10:46:42
SYS        AQ$_REG_INFO_LIST              TYPE                                INVALID 16/09/2007 01:08:14
SYS        AQ$_REG_INFO_LIST              TYPE                                INVALID 14/04/2012 10:48:20
SYS        AQ$_REG_INFO_LIST              TYPE                                INVALID 14/04/2012 10:46:48
SYS        AQ$_SCHEDULER$_EVENT_QTAB_F    VIEW                                INVALID 15/04/2012 02:26:35
SYS        AQ$_SCHEDULER$_REMDB_JOBQTAB_F VIEW                                INVALID 15/04/2012 02:26:35
SYS        AQ$_SCHEDULER_FILEWATCHER_QT_F VIEW                                INVALID 15/04/2012 02:26:35
SYS        AQ$_SRVNTFN_MESSAGE            TYPE                                INVALID 29/12/2012 04:08:12
SYS        AQ$_SRVNTFN_MESSAGE            TYPE                                INVALID 14/04/2012 10:46:49
SYS        AQ$_SRVNTFN_MESSAGE            TYPE                                INVALID 14/04/2012 10:46:49
SYS        AQ$_SRVNTFN_MESSAGE            TYPE                                INVALID 14/04/2012 10:51:33
SYS        AQ$_SRVNTFN_MESSAGE            TYPE                                INVALID 14/04/2012 10:48:22
SYS        AQ$_SRVNTFN_MESSAGE            TYPE                                INVALID 14/04/2012 10:48:13
SYS        AQ$_SUBSCRIBER                 TYPE                                INVALID 29/12/2012 03:04:57
SYS        AQ$_SUBSCRIBERS                TYPE                                INVALID 29/12/2012 03:04:53
SYS        AQ$_SUBSCRIBER_T               TYPE                                INVALID 29/12/2012 03:04:57
SYS        AQ$_SYS$SERVICE_METRICS_TAB_F  VIEW                                INVALID 15/04/2012 02:26:54
SYS        AS_REPLAY                      PACKAGE                             INVALID 31/10/2012 01:13:18
SYS        AS_REPLAY                      PACKAGE BODY                        INVALID 31/10/2012 01:13:18
SYS        AWRRPT_CLB_ARY                 TYPE                                INVALID 29/12/2012 03:05:56
SYS        AWRRPT_NUM_ARY                 TYPE                                INVALID 29/12/2012 03:05:56
SYS        AWRRPT_ROW_TYPE                TYPE                                INVALID 29/12/2012 03:05:56
SYS        AWRRPT_VCH_ARY                 TYPE                                INVALID 29/12/2012 03:05:56
SYS        AWR_OBJECT_INFO_TABLE_TYPE     TYPE                                INVALID 14/11/2012 22:33:29
SYS        AW_DROP_PROC                   PROCEDURE                           INVALID 30/10/2012 22:19:25
SYS        AW_DROP_TRG                    TRIGGER                             INVALID 30/10/2012 22:19:25
SYS        AW_REN_PROC                    PROCEDURE                           INVALID 31/10/2012 01:48:57
SYS        AW_REN_TRG                     TRIGGER                             INVALID 31/10/2012 01:48:57
SYS        AW_TRUNC_PROC                  PROCEDURE                           INVALID 31/10/2012 01:48:56
SYS        AW_TRUNC_TRG                   TRIGGER                             INVALID 31/10/2012 01:48:56
SYS        BLASTN_ALIGN                   FUNCTION                            INVALID 31/10/2012 01:53:01
SYS        BLASTN_COMPRESS                FUNCTION                            INVALID 04/12/2012 05:36:03
SYS        BLASTN_MATCH                   FUNCTION                            INVALID 31/10/2012 01:53:01
SYS        BLASTP_ALIGN                   FUNCTION                            INVALID 31/10/2012 01:53:01
SYS        BLASTP_MATCH                   FUNCTION                            INVALID 31/10/2012 01:53:01
SYS        BLAST_CUR                      PACKAGE                             INVALID 31/10/2012 01:53:01
SYS        CDC_ALTER_CTABLE_BEFORE        TRIGGER                             INVALID 29/12/2012 04:08:07
SYS        CDC_CREATE_CTABLE_AFTER        TRIGGER                             INVALID 29/12/2012 04:08:07
SYS        CDC_CREATE_CTABLE_BEFORE       TRIGGER                             INVALID 29/12/2012 04:08:07
SYS        CDC_DROP_CTABLE_BEFORE         TRIGGER                             INVALID 29/12/2012 04:08:08
SYS        CHECK_UPGRADE                  FUNCTION                            INVALID 31/10/2012 01:49:58
SYS        CHNF$_REG_INFO                 TYPE BODY                           INVALID 29/12/2012 04:08:13
SYS        CHNF$_REG_INFO                 TYPE                                INVALID 14/04/2012 10:48:27
SYS        CLIENT_IP_ADDRESS              FUNCTION                            INVALID 30/10/2012 22:13:40
SYS        CREATE_TABLE_COST_COLINFO      TYPE                                INVALID 30/10/2012 21:45:35
SYS        CREATE_TABLE_COST_COLUMNS      TYPE                                INVALID 30/10/2012 21:45:35
SYS        CUBE_TABLE                     FUNCTION                            INVALID 29/12/2012 03:26:01
SYS        DATABASE_NAME                  FUNCTION                            INVALID 30/10/2012 22:13:39
SYS        DBA_ADDM_FDG_BREAKDOWN         VIEW                                INVALID 15/04/2012 02:15:48
SYS        DBA_ADDM_SYSTEM_DIRECTIVES     VIEW                                INVALID 15/04/2012 02:15:48
SYS        DBA_ADDM_TASK_DIRECTIVES       VIEW                                INVALID 15/04/2012 02:00:40
SYS        DBA_ADVISOR_DEF_PARAMETERS     VIEW                                INVALID 15/04/2012 01:48:07
SYS        DBA_ADVISOR_EXECUTION_TYPES    VIEW                                INVALID 15/04/2012 01:48:07
SYS        DBA_ADVISOR_EXEC_PARAMETERS    VIEW                                INVALID 15/04/2012 01:15:52
SYS        DBA_ADVISOR_FDG_BREAKDOWN      VIEW                                INVALID 15/04/2012 01:48:07
SYS        DBA_ADVISOR_FINDING_NAMES      VIEW                                INVALID 15/04/2012 01:09:43
SYS        DBA_ADVISOR_JOURNAL            VIEW                                INVALID 15/04/2012 01:48:08
SYS        DBA_ADVISOR_LOG                VIEW                                INVALID 15/04/2012 01:48:07
SYS        DBA_ADVISOR_PARAMETERS_PROJ    VIEW                                INVALID 15/04/2012 01:48:07

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        DBA_ADVISOR_SQLW_JOURNAL       VIEW                                INVALID 15/04/2012 01:48:26
SYS        DBA_ADVISOR_SQLW_PARAMETERS    VIEW                                INVALID 15/04/2012 01:48:26
SYS        DBA_APPLY_ENQUEUE              VIEW                                INVALID 29/12/2012 07:39:11
SYS        DBA_APPLY_EXECUTE              VIEW                                INVALID 29/12/2012 07:46:31
SYS        DBA_AUTOTASK_SCHEDULE          VIEW                                INVALID 29/12/2012 07:46:31
SYS        DBA_CAPTURE                    VIEW                                INVALID 29/12/2012 07:46:31
SYS        DBA_HIST_BASELINE_DETAILS      VIEW                                INVALID 29/12/2012 07:46:31
SYS        DBA_IAS_POSTGEN_STMTS          VIEW                                INVALID 29/12/2012 03:06:55
SYS        DBA_IAS_PREGEN_STMTS           VIEW                                INVALID 29/12/2012 03:06:55
SYS        DBA_JAVA_COMPILER_OPTIONS      VIEW                                INVALID 15/11/2012 03:01:37
SYS        DBA_LOGMNR_PURGED_LOG          VIEW                                INVALID 15/11/2012 03:01:38
SYS        DBA_LOGMNR_SESSION             VIEW                                INVALID 29/12/2012 03:06:58
SYS        DBA_LOGSTDBY_EDS_SUPPORTED     VIEW                                INVALID 14/11/2012 21:47:07
SYS        DBA_LOGSTDBY_NOT_UNIQUE        VIEW                                INVALID 15/11/2012 03:01:38
SYS        DBA_LOGSTDBY_UNSUPPORTED       VIEW                                INVALID 15/11/2012 03:01:38
SYS        DBA_LOGSTDBY_UNSUPPORTED_TABLE VIEW                                INVALID 14/11/2012 21:47:07
SYS        DBA_NETWORK_ACLS               VIEW                                INVALID 29/12/2012 07:46:31
SYS        DBA_NETWORK_ACL_PRIVILEGES     VIEW                                INVALID 29/12/2012 07:46:31
SYS        DBA_PARALLEL_EXECUTE_TASKS     VIEW                                INVALID 15/04/2012 02:16:12
SYS        DBA_PROPAGATION                VIEW                                INVALID 29/12/2012 07:46:32
SYS        DBA_QUEUE_SUBSCRIBERS          VIEW                                INVALID 29/12/2012 07:53:51
SYS        DBA_REGISTRY                   VIEW                                INVALID 04/01/2013 20:00:19
SYS        DBA_REGISTRY_HIERARCHY         VIEW                                INVALID 29/12/2012 03:05:35
SYS        DBA_REPCOLUMN                  VIEW                                INVALID 29/12/2012 03:06:25
SYS        DBA_REPFLAVOR_COLUMNS          VIEW                                INVALID 29/12/2012 03:06:46
SYS        DBA_REPOBJECT                  VIEW                                INVALID 29/12/2012 03:06:25
SYS        DBA_REPPROP                    VIEW                                INVALID 29/12/2012 03:06:28
SYS        DBA_RULES                      VIEW                                INVALID 15/04/2012 01:18:13
SYS        DBA_SCHEDULER_JOB_ARGS         VIEW                                INVALID 15/04/2012 01:48:10
SYS        DBA_SCHEDULER_PROGRAM_ARGS     VIEW                                INVALID 15/04/2012 01:48:10
SYS        DBA_SERVER_REGISTRY            VIEW                                INVALID 29/12/2012 03:05:35
SYS        DBA_SQLSET_BINDS               VIEW                                INVALID 15/04/2012 01:14:39
SYS        DBA_SQLTUNE_BINDS              VIEW                                INVALID 15/04/2012 01:15:52
SYS        DBA_STREAMS_ADD_COLUMN         VIEW                                INVALID 29/12/2012 08:38:18
SYS        DBA_STREAMS_DELETE_COLUMN      VIEW                                INVALID 29/12/2012 08:38:18
SYS        DBA_STREAMS_KEEP_COLUMNS       VIEW                                INVALID 29/12/2012 08:38:18
SYS        DBA_STREAMS_MESSAGE_CONSUMERS  VIEW                                INVALID 29/12/2012 08:45:44
SYS        DBA_STREAMS_NEWLY_SUPPORTED    VIEW                                INVALID 29/12/2012 08:45:44
SYS        DBA_STREAMS_RENAME_COLUMN      VIEW                                INVALID 29/12/2012 08:45:44
SYS        DBA_STREAMS_RENAME_SCHEMA      VIEW                                INVALID 29/12/2012 08:45:44
SYS        DBA_STREAMS_RENAME_TABLE       VIEW                                INVALID 29/12/2012 08:45:44
SYS        DBA_STREAMS_RULES              VIEW                                INVALID 15/04/2012 02:16:07
SYS        DBA_STREAMS_SPLIT_MERGE        VIEW                                INVALID 29/12/2012 08:53:12
SYS        DBA_STREAMS_SPLIT_MERGE_HIST   VIEW                                INVALID 29/12/2012 08:53:13
SYS        DBA_STREAMS_TP_COMPONENT_LINK  VIEW                                INVALID 15/11/2012 03:05:08
SYS        DBA_STREAMS_TRANSFORMATIONS    VIEW                                INVALID 29/12/2012 09:00:39
SYS        DBA_STREAMS_TRANSFORM_FUNCTION VIEW                                INVALID 29/12/2012 09:08:06
SYS        DBA_STREAMS_UNSUPPORTED        VIEW                                INVALID 29/12/2012 09:08:06
SYS        DBA_SUBSCR_REGISTRATIONS       VIEW                                INVALID 15/04/2012 01:47:03
SYS        DBA_TABLESPACE_THRESHOLDS      VIEW                                INVALID 15/11/2012 03:06:01
SYS        DBA_WALLET_ACLS                VIEW                                INVALID 29/12/2012 09:15:37
SYS        DBA_WARNING_SETTINGS           VIEW                                INVALID 15/11/2012 03:06:01
SYS        DBA_WORKLOAD_REPLAY_DIVERGENCE VIEW                                INVALID 15/04/2012 01:48:33
SYS        DBA_XDS_ATTRIBUTE_SECS         VIEW                                INVALID 29/12/2012 09:15:38
SYS        DBA_XDS_INSTANCE_SETS          VIEW                                INVALID 29/12/2012 09:15:38
SYS        DBA_XMLSCHEMA_LEVEL_VIEW       VIEW                                INVALID 29/12/2012 09:38:28
SYS        DBA_XMLSCHEMA_LEVEL_VIEW_DUP   VIEW                                INVALID 29/12/2012 09:38:28
SYS        DBA_XML_INDEXES                VIEW                                INVALID 29/12/2012 09:15:38
SYS        DBA_XML_SCHEMAS                VIEW                                INVALID 29/12/2012 09:15:38
SYS        DBA_XML_SCHEMA_DEPENDENCY      VIEW                                INVALID 29/12/2012 09:38:28
SYS        DBA_XML_SCHEMA_IMPORTS         VIEW                                INVALID 29/12/2012 09:15:38
SYS        DBA_XML_SCHEMA_INCLUDES        VIEW                                INVALID 29/12/2012 09:15:38
SYS        DBA_XSTREAM_OUTBOUND           VIEW                                INVALID 29/12/2012 09:15:38
SYS        DBA_XSTREAM_OUTBOUND_PROGRESS  VIEW                                INVALID 29/12/2012 09:15:38
SYS        DBA_XSTREAM_OUT_SUPPORT_MODE   VIEW                                INVALID 15/11/2012 03:07:14
SYS        DBA_XSTREAM_RULES              VIEW                                INVALID 29/12/2012 09:23:08
SYS        DBFS_CONTENT                   VIEW                                INVALID 29/12/2012 09:23:08
SYS        DBFS_CONTENT_PROPERTIES        VIEW                                INVALID 29/12/2012 09:23:08
SYS        DBJ_LONG_NAME                  FUNCTION                            INVALID 31/10/2012 00:07:21
SYS        DBJ_SHORT_NAME                 FUNCTION                            INVALID 31/10/2012 00:07:21
SYS        DBMSHSXP                       PACKAGE                             INVALID 31/10/2012 02:07:21
SYS        DBMSHSXP                       PACKAGE BODY                        INVALID 31/10/2012 02:07:22
SYS        DBMSOBJG                       PACKAGE BODY                        INVALID 29/12/2012 03:27:45
SYS        DBMSOBJG                       PACKAGE                             INVALID 29/12/2012 03:27:42
SYS        DBMSOBJG2                      PACKAGE BODY                        INVALID 29/12/2012 03:27:47
SYS        DBMSOBJG2                      PACKAGE                             INVALID 29/12/2012 03:27:46
SYS        DBMSOBJGWRAPPER                PACKAGE BODY                        INVALID 30/10/2012 22:20:40
SYS        DBMSOBJGWRAPPER                PACKAGE                             INVALID 30/10/2012 22:20:40
SYS        DBMSOBJG_DP                    PACKAGE BODY                        INVALID 29/12/2012 03:27:48
SYS        DBMSOBJG_DP                    PACKAGE                             INVALID 29/12/2012 03:27:47
SYS        DBMSZEXP_SYSPKGGRNT            PACKAGE                             INVALID 30/10/2012 21:47:48
SYS        DBMSZEXP_SYSPKGGRNT            PACKAGE BODY                        INVALID 30/10/2012 21:47:49
SYS        DBMS_ADDM                      PACKAGE BODY                        INVALID 31/10/2012 01:50:34
SYS        DBMS_ADDM                      PACKAGE                             INVALID 31/10/2012 01:50:34
SYS        DBMS_ADVANCED_REWRITE          PACKAGE                             INVALID 31/10/2012 01:52:39
SYS        DBMS_ADVANCED_REWRITE          PACKAGE BODY                        INVALID 31/10/2012 01:52:39
SYS        DBMS_ADVISOR                   PACKAGE BODY                        INVALID 31/10/2012 00:53:21
SYS        DBMS_ALERT                     PACKAGE BODY                        INVALID 30/10/2012 21:47:43
SYS        DBMS_ALERT                     PACKAGE                             INVALID 30/10/2012 21:46:12
SYS        DBMS_APBACKEND                 PACKAGE BODY                        INVALID 29/12/2012 00:32:45
SYS        DBMS_APBACKEND                 PACKAGE                             INVALID 29/12/2012 00:32:45
SYS        DBMS_APPCTX                    PACKAGE                             INVALID 30/10/2012 22:13:36
SYS        DBMS_APPCTX                    PACKAGE BODY                        INVALID 30/10/2012 22:13:36
SYS        DBMS_APPLY_ADM                 PACKAGE                             INVALID 29/12/2012 03:27:48
SYS        DBMS_APPLY_ADM                 PACKAGE BODY                        INVALID 29/12/2012 03:29:47
SYS        DBMS_APPLY_ADM_INTERNAL        PACKAGE BODY                        INVALID 29/12/2012 03:29:50
SYS        DBMS_APPLY_ADM_INTERNAL        PACKAGE                             INVALID 29/12/2012 03:29:47

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        DBMS_APPLY_ERROR               PACKAGE BODY                        INVALID 29/12/2012 03:29:51
SYS        DBMS_APPLY_ERROR               PACKAGE                             INVALID 29/12/2012 03:29:50
SYS        DBMS_APPLY_HANDLER_ADM         PACKAGE                             INVALID 15/04/2012 01:47:44
SYS        DBMS_APPLY_HANDLER_ADM         PACKAGE BODY                        INVALID 31/10/2012 01:27:14
SYS        DBMS_APPLY_HANDLER_INTERNAL    PACKAGE BODY                        INVALID 31/10/2012 01:52:09
SYS        DBMS_APPLY_HANDLER_INTERNAL    PACKAGE                             INVALID 31/10/2012 01:52:09
SYS        DBMS_APPLY_POSITION            PACKAGE BODY                        INVALID 29/12/2012 03:29:54
SYS        DBMS_APPLY_POSITION            PACKAGE                             INVALID 29/12/2012 03:29:54
SYS        DBMS_APPLY_PROCESS             PACKAGE BODY                        INVALID 30/10/2012 22:55:40
SYS        DBMS_APPLY_PROCESS             PACKAGE                             INVALID 30/10/2012 22:55:40
SYS        DBMS_AQ                        PACKAGE BODY                        INVALID 29/12/2012 14:01:26
SYS        DBMS_AQADM                     PACKAGE BODY                        INVALID 14/11/2012 21:46:52
SYS        DBMS_AQADM_INV                 PACKAGE BODY                        INVALID 31/10/2012 02:36:45
SYS        DBMS_AQADM_INV                 PACKAGE                             INVALID 15/04/2012 01:48:06
SYS        DBMS_AQADM_SYS                 PACKAGE BODY                        INVALID 29/12/2012 14:01:27
SYS        DBMS_AQADM_SYSCALLS            PACKAGE BODY                        INVALID 29/12/2012 14:01:27
SYS        DBMS_AQELM                     PACKAGE                             INVALID 30/10/2012 22:11:31
SYS        DBMS_AQELM                     PACKAGE BODY                        INVALID 30/10/2012 22:11:31
SYS        DBMS_AQIN                      PACKAGE                             INVALID 29/12/2012 14:01:27
SYS        DBMS_AQIN                      PACKAGE BODY                        INVALID 29/12/2012 14:01:28
SYS        DBMS_AQJMS                     PACKAGE                             INVALID 29/12/2012 14:01:28
SYS        DBMS_AQJMS                     PACKAGE BODY                        INVALID 29/12/2012 14:01:28
SYS        DBMS_AQJMS_INTERNAL            PACKAGE                             INVALID 29/12/2012 14:01:28
SYS        DBMS_AQJMS_INTERNAL            PACKAGE BODY                        INVALID 29/12/2012 14:01:28
SYS        DBMS_AQ_BQVIEW                 PACKAGE                             INVALID 31/10/2012 01:52:40
SYS        DBMS_AQ_BQVIEW                 PACKAGE BODY                        INVALID 31/10/2012 02:36:45
SYS        DBMS_AQ_EXP_CMT_TIME_TABLES    PACKAGE BODY                        INVALID 31/10/2012 02:36:44
SYS        DBMS_AQ_EXP_CMT_TIME_TABLES    PACKAGE                             INVALID 31/10/2012 01:50:30
SYS        DBMS_AQ_EXP_DEQUEUELOG_TABLES  PACKAGE                             INVALID 31/10/2012 01:50:29
SYS        DBMS_AQ_EXP_DEQUEUELOG_TABLES  PACKAGE BODY                        INVALID 31/10/2012 02:36:44
SYS        DBMS_AQ_EXP_HISTORY_TABLES     PACKAGE                             INVALID 30/10/2012 22:11:12
SYS        DBMS_AQ_EXP_HISTORY_TABLES     PACKAGE BODY                        INVALID 30/10/2012 22:11:12
SYS        DBMS_AQ_EXP_INDEX_TABLES       PACKAGE BODY                        INVALID 30/10/2012 22:11:12
SYS        DBMS_AQ_EXP_INDEX_TABLES       PACKAGE                             INVALID 30/10/2012 22:11:12
SYS        DBMS_AQ_EXP_QUEUES             PACKAGE                             INVALID 30/10/2012 22:11:13
SYS        DBMS_AQ_EXP_QUEUES             PACKAGE BODY                        INVALID 30/10/2012 22:11:13
SYS        DBMS_AQ_EXP_QUEUE_TABLES       PACKAGE                             INVALID 30/10/2012 22:11:11
SYS        DBMS_AQ_EXP_QUEUE_TABLES       PACKAGE BODY                        INVALID 30/10/2012 22:11:12
SYS        DBMS_AQ_EXP_SIGNATURE_TABLES   PACKAGE                             INVALID 30/10/2012 22:11:12
SYS        DBMS_AQ_EXP_SIGNATURE_TABLES   PACKAGE BODY                        INVALID 30/10/2012 22:11:13
SYS        DBMS_AQ_EXP_SUBSCRIBER_TABLES  PACKAGE                             INVALID 30/10/2012 22:11:13
SYS        DBMS_AQ_EXP_SUBSCRIBER_TABLES  PACKAGE BODY                        INVALID 30/10/2012 22:11:13
SYS        DBMS_AQ_EXP_TIMEMGR_TABLES     PACKAGE                             INVALID 30/10/2012 22:11:12
SYS        DBMS_AQ_EXP_TIMEMGR_TABLES     PACKAGE BODY                        INVALID 30/10/2012 22:11:12
SYS        DBMS_AQ_EXP_ZECURITY           PACKAGE                             INVALID 30/10/2012 22:11:11
SYS        DBMS_AQ_EXP_ZECURITY           PACKAGE BODY                        INVALID 30/10/2012 22:11:11
SYS        DBMS_AQ_IMPORT_INTERNAL        PACKAGE                             INVALID 30/10/2012 22:11:08
SYS        DBMS_AQ_IMPORT_INTERNAL        PACKAGE BODY                        INVALID 14/11/2012 21:46:52
SYS        DBMS_AQ_IMP_INTERNAL           PACKAGE BODY                        INVALID 14/11/2012 21:46:55
SYS        DBMS_AQ_IMP_INTERNAL           PACKAGE                             INVALID 30/10/2012 22:11:28
SYS        DBMS_AQ_IMP_ZECURITY           PACKAGE BODY                        INVALID 30/10/2012 22:11:27
SYS        DBMS_AQ_INV                    PACKAGE                             INVALID 15/04/2012 01:48:06
SYS        DBMS_AQ_INV                    PACKAGE BODY                        INVALID 31/10/2012 01:52:41
SYS        DBMS_AQ_SYS_EXP_ACTIONS        PACKAGE                             INVALID 30/10/2012 22:11:11
SYS        DBMS_AQ_SYS_EXP_ACTIONS        PACKAGE BODY                        INVALID 30/10/2012 22:11:11
SYS        DBMS_AQ_SYS_EXP_INTERNAL       PACKAGE BODY                        INVALID 14/11/2012 21:46:48
SYS        DBMS_AQ_SYS_EXP_INTERNAL       PACKAGE                             INVALID 30/10/2012 22:11:10
SYS        DBMS_AQ_SYS_IMP_INTERNAL       PACKAGE BODY                        INVALID 14/11/2012 21:46:54
SYS        DBMS_AQ_SYS_IMP_INTERNAL       PACKAGE                             INVALID 30/10/2012 22:11:26
SYS        DBMS_ARCH_PROVIDER_INTL        PACKAGE BODY                        INVALID 29/12/2012 00:36:05
SYS        DBMS_ARCH_PROVIDER_INTL        PACKAGE                             INVALID 29/12/2012 00:36:05
SYS        DBMS_ASH_INTERNAL              PACKAGE                             INVALID 29/12/2012 03:30:00
SYS        DBMS_ASH_INTERNAL              PACKAGE BODY                        INVALID 29/12/2012 03:30:01
SYS        DBMS_ASYNCRPC_PUSH             PACKAGE BODY                        INVALID 30/10/2012 22:19:53
SYS        DBMS_ASYNCRPC_PUSH             PACKAGE                             INVALID 30/10/2012 22:19:53
SYS        DBMS_AUDIT_MGMT                PACKAGE                             INVALID 31/10/2012 01:50:23
SYS        DBMS_AUDIT_MGMT                PACKAGE BODY                        INVALID 31/10/2012 02:36:40
SYS        DBMS_AUTOTASK_PRVT             PACKAGE                             INVALID 31/10/2012 00:53:19
SYS        DBMS_AUTOTASK_PRVT             PACKAGE BODY                        INVALID 31/10/2012 00:53:20
SYS        DBMS_AUTO_SQLTUNE              PACKAGE BODY                        INVALID 29/12/2012 03:30:03
SYS        DBMS_AUTO_SQLTUNE              PACKAGE                             INVALID 29/12/2012 03:30:02
SYS        DBMS_AUTO_TASK                 PACKAGE BODY                        INVALID 29/12/2012 00:36:14
SYS        DBMS_AUTO_TASK_ADMIN           PACKAGE BODY                        INVALID 31/10/2012 00:53:21
SYS        DBMS_AUTO_TASK_EXPORT          PACKAGE                             INVALID 31/10/2012 01:53:09
SYS        DBMS_AUTO_TASK_EXPORT          PACKAGE BODY                        INVALID 31/10/2012 02:07:22
SYS        DBMS_AUTO_TASK_IMMEDIATE       PACKAGE BODY                        INVALID 31/10/2012 00:53:20
SYS        DBMS_AW                        PACKAGE BODY                        INVALID 30/10/2012 22:19:32
SYS        DBMS_AW                        PACKAGE                             INVALID 30/10/2012 22:19:28
SYS        DBMS_AW$_COLUMNLIST_T          TYPE                                INVALID 30/10/2012 22:19:28
SYS        DBMS_AW$_DIMENSION_SOURCES_T   TYPE                                INVALID 30/10/2012 22:19:28
SYS        DBMS_AW$_DIMENSION_SOURCE_T    TYPE                                INVALID 30/10/2012 22:19:28
SYS        DBMS_AWR_REPORT_LAYOUT         PACKAGE                             INVALID 31/10/2012 01:51:00
SYS        DBMS_AWR_REPORT_LAYOUT         PACKAGE BODY                        INVALID 31/10/2012 01:51:53
SYS        DBMS_AW_EXP                    PACKAGE BODY                        INVALID 30/10/2012 22:19:33
SYS        DBMS_AW_EXP                    PACKAGE                             INVALID 30/10/2012 22:19:30
SYS        DBMS_AW_STATS                  PACKAGE                             INVALID 31/10/2012 01:48:58
SYS        DBMS_AW_STATS                  PACKAGE BODY                        INVALID 31/10/2012 01:48:58
SYS        DBMS_BACKUP_RESTORE            PACKAGE                             INVALID 30/10/2012 22:13:24
SYS        DBMS_BACKUP_RESTORE            PACKAGE BODY                        INVALID 30/10/2012 22:13:35
SYS        DBMS_CACHEUTIL                 PACKAGE BODY                        INVALID 31/10/2012 01:52:14
SYS        DBMS_CACHEUTIL                 PACKAGE                             INVALID 31/10/2012 01:52:14
SYS        DBMS_CAPTURE_ADM               PACKAGE BODY                        INVALID 29/12/2012 03:30:03
SYS        DBMS_CAPTURE_ADM               PACKAGE                             INVALID 29/12/2012 03:30:03
SYS        DBMS_CAPTURE_ADM_INTERNAL      PACKAGE BODY                        INVALID 29/12/2012 03:30:04
SYS        DBMS_CAPTURE_ADM_INTERNAL      PACKAGE                             INVALID 29/12/2012 03:30:03
SYS        DBMS_CAPTURE_PROCESS           PACKAGE BODY                        INVALID 30/10/2012 23:48:03
SYS        DBMS_CAPTURE_PROCESS           PACKAGE                             INVALID 30/10/2012 22:55:43

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        DBMS_CAPTURE_SWITCH_ADM        PACKAGE                             INVALID 31/10/2012 01:52:11
SYS        DBMS_CAPTURE_SWITCH_ADM        PACKAGE BODY                        INVALID 31/10/2012 01:52:11
SYS        DBMS_CAPTURE_SWITCH_INTERNAL   PACKAGE BODY                        INVALID 31/10/2012 01:52:11
SYS        DBMS_CAPTURE_SWITCH_INTERNAL   PACKAGE                             INVALID 31/10/2012 01:52:10
SYS        DBMS_CDC_DPUTIL                PACKAGE BODY                        INVALID 29/12/2012 14:01:29
SYS        DBMS_CDC_DPUTIL                PACKAGE                             INVALID 29/12/2012 14:01:28
SYS        DBMS_CDC_EXPDP                 PACKAGE BODY                        INVALID 31/10/2012 01:48:46
SYS        DBMS_CDC_EXPDP                 PACKAGE                             INVALID 31/10/2012 01:48:45
SYS        DBMS_CDC_EXPVDP                PACKAGE BODY                        INVALID 31/10/2012 01:48:46
SYS        DBMS_CDC_EXPVDP                PACKAGE                             INVALID 31/10/2012 01:48:46
SYS        DBMS_CDC_IMPDP                 PACKAGE BODY                        INVALID 31/10/2012 01:48:44
SYS        DBMS_CDC_IMPDP                 PACKAGE                             INVALID 31/10/2012 01:48:42
SYS        DBMS_CDC_IMPDPV                PACKAGE BODY                        INVALID 31/10/2012 01:48:44
SYS        DBMS_CDC_IMPDPV                PACKAGE                             INVALID 31/10/2012 01:48:44
SYS        DBMS_CDC_IPUBLISH              PACKAGE                             INVALID 15/04/2012 01:03:37
SYS        DBMS_CDC_IPUBLISH              PACKAGE BODY                        INVALID 31/10/2012 01:48:40
SYS        DBMS_CDC_ISUBSCRIBE            PACKAGE BODY                        INVALID 31/10/2012 01:48:41
SYS        DBMS_CDC_ISUBSCRIBE            PACKAGE                             INVALID 15/04/2012 01:49:14
SYS        DBMS_CDC_PUBLISH               PACKAGE                             INVALID 30/10/2012 22:18:58
SYS        DBMS_CDC_PUBLISH               PACKAGE BODY                        INVALID 30/10/2012 22:19:00
SYS        DBMS_CDC_SUBSCRIBE             PACKAGE BODY                        INVALID 30/10/2012 22:19:01
SYS        DBMS_CDC_SUBSCRIBE             PACKAGE                             INVALID 30/10/2012 22:18:59
SYS        DBMS_CDC_SYS_IPUBLISH          PACKAGE                             INVALID 15/04/2012 01:49:13
SYS        DBMS_CDC_SYS_IPUBLISH          PACKAGE BODY                        INVALID 31/10/2012 01:48:40
SYS        DBMS_CDC_UTILITY               PACKAGE                             INVALID 30/10/2012 22:18:57
SYS        DBMS_CDC_UTILITY               PACKAGE BODY                        INVALID 14/11/2012 21:47:05
SYS        DBMS_CHANGE_NOTIFICATION       PACKAGE                             INVALID 29/12/2012 10:26:42
SYS        DBMS_CHANGE_NOTIFICATION       PACKAGE BODY                        INVALID 29/12/2012 10:26:42
SYS        DBMS_CLIENT_RESULT_CACHE       PACKAGE BODY                        INVALID 31/10/2012 02:36:44
SYS        DBMS_CLIENT_RESULT_CACHE       PACKAGE                             INVALID 31/10/2012 01:50:29
SYS        DBMS_CLUSTDB                   PACKAGE BODY                        INVALID 31/10/2012 00:36:14
SYS        DBMS_CMP_INT                   PACKAGE                             INVALID 29/12/2012 14:01:29
SYS        DBMS_CMP_INT                   PACKAGE BODY                        INVALID 29/12/2012 14:01:29
SYS        DBMS_COMPARISON                PACKAGE                             INVALID 31/10/2012 01:52:06
SYS        DBMS_COMPARISON                PACKAGE BODY                        INVALID 31/10/2012 01:52:07
SYS        DBMS_COMPRESSION               PACKAGE                             INVALID 31/10/2012 01:52:15
SYS        DBMS_COMPRESSION               PACKAGE BODY                        INVALID 31/10/2012 01:52:15
SYS        DBMS_CONNECTION_POOL           PACKAGE BODY                        INVALID 31/10/2012 02:07:40
SYS        DBMS_CONNECTION_POOL           PACKAGE                             INVALID 31/10/2012 01:50:29
SYS        DBMS_CRYPTO                    PACKAGE BODY                        INVALID 31/10/2012 02:07:41
SYS        DBMS_CRYPTO                    PACKAGE                             INVALID 31/10/2012 01:50:22
SYS        DBMS_CRYPTO_FFI                PACKAGE                             INVALID 31/10/2012 02:07:41
SYS        DBMS_CRYPTO_FFI                PACKAGE BODY                        INVALID 31/10/2012 02:07:41
SYS        DBMS_CRYPTO_TOOLKIT            PACKAGE BODY                        INVALID 31/10/2012 00:07:04
SYS        DBMS_CRYPTO_TOOLKIT            PACKAGE                             INVALID 30/10/2012 23:18:12
SYS        DBMS_CRYPTO_TOOLKIT_FFI        PACKAGE BODY                        INVALID 31/10/2012 00:07:03
SYS        DBMS_CRYPTO_TOOLKIT_FFI        PACKAGE                             INVALID 30/10/2012 23:18:11
SYS        DBMS_CRYPTO_TOOLKIT_TYPES      PACKAGE                             INVALID 30/10/2012 23:18:11
SYS        DBMS_CUBE_LOG                  PACKAGE BODY                        INVALID 31/10/2012 01:48:59
SYS        DBMS_CUBE_LOG                  PACKAGE                             INVALID 31/10/2012 01:48:58
SYS        DBMS_DATAPUMP                  PACKAGE BODY                        INVALID 29/12/2012 14:01:30
SYS        DBMS_DATAPUMP                  PACKAGE                             INVALID 04/01/2013 20:09:56
SYS        DBMS_DATAPUMP_UTL              PACKAGE BODY                        INVALID 31/10/2012 01:48:56
SYS        DBMS_DATA_MINING               PACKAGE BODY                        INVALID 29/12/2012 03:30:10
SYS        DBMS_DATA_MINING               PACKAGE                             INVALID 29/12/2012 03:30:08
SYS        DBMS_DATA_MINING_INTERNAL      PACKAGE BODY                        INVALID 29/12/2012 03:30:15
SYS        DBMS_DATA_MINING_INTERNAL      PACKAGE                             INVALID 29/12/2012 03:30:11
SYS        DBMS_DATA_MINING_TRANSFORM     PACKAGE BODY                        INVALID 31/10/2012 01:52:56
SYS        DBMS_DATA_MINING_TRANSFORM     PACKAGE                             INVALID 31/10/2012 01:52:52
SYS        DBMS_DBFS_CONTENT              PACKAGE BODY                        INVALID 29/12/2012 00:36:36
SYS        DBMS_DBFS_CONTENT              PACKAGE                             INVALID 29/12/2012 00:36:34
SYS        DBMS_DBFS_CONTENT_ADMIN        PACKAGE                             INVALID 31/10/2012 01:52:20
SYS        DBMS_DBFS_CONTENT_ADMIN        PACKAGE BODY                        INVALID 31/10/2012 01:52:20
SYS        DBMS_DBFS_CONTENT_SPI          PACKAGE                             INVALID 29/12/2012 00:36:36
SYS        DBMS_DBFS_HS                   PACKAGE BODY                        INVALID 29/12/2012 00:36:43
SYS        DBMS_DBFS_HS                   PACKAGE                             INVALID 29/12/2012 00:36:37
SYS        DBMS_DBFS_SFS                  PACKAGE BODY                        INVALID 29/12/2012 00:36:48
SYS        DBMS_DBFS_SFS                  PACKAGE                             INVALID 29/12/2012 00:36:45
SYS        DBMS_DBFS_SFS_ADMIN            PACKAGE BODY                        INVALID 31/10/2012 01:52:28
SYS        DBMS_DBFS_SFS_ADMIN            PACKAGE                             INVALID 31/10/2012 01:52:28
SYS        DBMS_DBVERIFY                  PACKAGE                             INVALID 31/10/2012 01:50:26
SYS        DBMS_DBVERIFY                  PACKAGE BODY                        INVALID 31/10/2012 02:36:41
SYS        DBMS_DB_VERSION                PACKAGE                             INVALID 31/10/2012 00:31:03
SYS        DBMS_DDL                       PACKAGE BODY                        INVALID 30/10/2012 21:47:32
SYS        DBMS_DDL_INTERNAL              PACKAGE BODY                        INVALID 30/10/2012 21:47:32
SYS        DBMS_DDL_INTERNAL              PACKAGE                             INVALID 30/10/2012 21:47:21
SYS        DBMS_DEBUG                     PACKAGE                             INVALID 30/10/2012 22:11:49
SYS        DBMS_DEBUG                     PACKAGE BODY                        INVALID 30/10/2012 22:11:55
SYS        DBMS_DEBUG_JDWP                PACKAGE                             INVALID 30/10/2012 22:19:23
SYS        DBMS_DEBUG_JDWP                PACKAGE BODY                        INVALID 30/10/2012 22:19:24
SYS        DBMS_DEBUG_JDWP_CUSTOM         PACKAGE BODY                        INVALID 30/10/2012 22:19:24
SYS        DBMS_DEBUG_JDWP_CUSTOM         PACKAGE                             INVALID 30/10/2012 22:19:24
SYS        DBMS_DEBUG_VC2COLL             TYPE                                INVALID 30/10/2012 22:11:49
SYS        DBMS_DEFER                     PACKAGE                             INVALID 29/12/2012 03:30:16
SYS        DBMS_DEFER                     PACKAGE BODY                        INVALID 29/12/2012 03:30:17
SYS        DBMS_DEFERGEN                  PACKAGE                             INVALID 29/12/2012 03:30:18
SYS        DBMS_DEFERGEN                  PACKAGE BODY                        INVALID 29/12/2012 03:30:19
SYS        DBMS_DEFERGEN_AUDIT            PACKAGE                             INVALID 29/12/2012 03:30:19
SYS        DBMS_DEFERGEN_AUDIT            PACKAGE BODY                        INVALID 29/12/2012 03:30:20
SYS        DBMS_DEFERGEN_INTERNAL         PACKAGE BODY                        INVALID 29/12/2012 03:30:21
SYS        DBMS_DEFERGEN_INTERNAL         PACKAGE                             INVALID 29/12/2012 03:30:20
SYS        DBMS_DEFERGEN_LOB              PACKAGE                             INVALID 29/12/2012 03:30:21
SYS        DBMS_DEFERGEN_LOB              PACKAGE BODY                        INVALID 29/12/2012 03:30:21
SYS        DBMS_DEFERGEN_PRIORITY         PACKAGE                             INVALID 30/10/2012 22:19:43
SYS        DBMS_DEFERGEN_PRIORITY         PACKAGE BODY                        INVALID 30/10/2012 22:19:43
SYS        DBMS_DEFERGEN_RESOLUTION       PACKAGE BODY                        INVALID 29/12/2012 03:30:23
SYS        DBMS_DEFERGEN_RESOLUTION       PACKAGE                             INVALID 29/12/2012 03:30:21

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        DBMS_DEFERGEN_UTIL             PACKAGE                             INVALID 29/12/2012 03:30:23
SYS        DBMS_DEFERGEN_UTIL             PACKAGE BODY                        INVALID 29/12/2012 03:30:24
SYS        DBMS_DEFERGEN_WRAP             PACKAGE                             INVALID 29/12/2012 03:30:24
SYS        DBMS_DEFERGEN_WRAP             PACKAGE BODY                        INVALID 29/12/2012 03:30:25
SYS        DBMS_DEFER_ENQ_UTL             PACKAGE                             INVALID 29/12/2012 03:30:25
SYS        DBMS_DEFER_ENQ_UTL             PACKAGE BODY                        INVALID 29/12/2012 03:30:25
SYS        DBMS_DEFER_IMPORT_INTERNAL     PACKAGE BODY                        INVALID 30/10/2012 22:11:48
SYS        DBMS_DEFER_IMPORT_INTERNAL     PACKAGE                             INVALID 30/10/2012 22:11:47
SYS        DBMS_DEFER_INTERNAL_QUERY      PACKAGE BODY                        INVALID 30/10/2012 22:19:53
SYS        DBMS_DEFER_INTERNAL_QUERY      PACKAGE                             INVALID 30/10/2012 22:19:53
SYS        DBMS_DEFER_INTERNAL_SYS        PACKAGE BODY                        INVALID 14/11/2012 21:47:14
SYS        DBMS_DEFER_INTERNAL_SYS        PACKAGE                             INVALID 30/10/2012 22:19:54
SYS        DBMS_DEFER_QUERY               PACKAGE                             INVALID 29/12/2012 03:30:25
SYS        DBMS_DEFER_QUERY               PACKAGE BODY                        INVALID 29/12/2012 03:30:26
SYS        DBMS_DEFER_QUERY_UTL           PACKAGE                             INVALID 29/12/2012 03:30:27
SYS        DBMS_DEFER_QUERY_UTL           PACKAGE BODY                        INVALID 29/12/2012 03:30:27
SYS        DBMS_DEFER_REPCAT              PACKAGE BODY                        INVALID 29/12/2012 03:30:28
SYS        DBMS_DEFER_REPCAT              PACKAGE                             INVALID 29/12/2012 03:30:28
SYS        DBMS_DEFER_SYS                 PACKAGE                             INVALID 30/10/2012 22:11:40
SYS        DBMS_DEFER_SYS                 PACKAGE BODY                        INVALID 14/11/2012 21:46:58
SYS        DBMS_DEFER_SYS_PART1           PACKAGE                             INVALID 30/10/2012 22:19:55
SYS        DBMS_DEFER_SYS_PART1           PACKAGE BODY                        INVALID 30/10/2012 22:19:55
SYS        DBMS_DESCRIBE                  PACKAGE BODY                        INVALID 30/10/2012 21:47:43
SYS        DBMS_DESCRIBE                  PACKAGE                             INVALID 30/10/2012 21:46:12
SYS        DBMS_DG                        PACKAGE BODY                        INVALID 31/10/2012 02:36:40
SYS        DBMS_DG                        PACKAGE                             INVALID 31/10/2012 01:50:25
SYS        DBMS_DIMENSION                 PACKAGE                             INVALID 15/04/2012 01:47:19
SYS        DBMS_DIMENSION                 PACKAGE BODY                        INVALID 31/10/2012 00:53:17
SYS        DBMS_DISTRIBUTED_TRUST_ADMIN   PACKAGE                             INVALID 30/10/2012 22:12:43
SYS        DBMS_DISTRIBUTED_TRUST_ADMIN   PACKAGE BODY                        INVALID 30/10/2012 22:12:43
SYS        DBMS_DM_EXP_INTERNAL           PACKAGE                             INVALID 29/12/2012 14:01:30
SYS        DBMS_DM_EXP_INTERNAL           PACKAGE BODY                        INVALID 29/12/2012 14:01:31
SYS        DBMS_DM_IMP_INTERNAL           PACKAGE BODY                        INVALID 31/10/2012 01:48:02
SYS        DBMS_DM_IMP_INTERNAL           PACKAGE                             INVALID 31/10/2012 01:47:57
SYS        DBMS_DM_MODEL_EXP              PACKAGE                             INVALID 31/10/2012 01:47:57
SYS        DBMS_DM_MODEL_EXP              PACKAGE BODY                        INVALID 31/10/2012 01:48:00
SYS        DBMS_DM_MODEL_IMP              PACKAGE BODY                        INVALID 29/12/2012 00:37:03
SYS        DBMS_DM_MODEL_IMP              PACKAGE                             INVALID 29/12/2012 00:37:03
SYS        DBMS_DM_UTIL                   PACKAGE                             INVALID 31/10/2012 01:47:43
SYS        DBMS_DM_UTIL                   PACKAGE BODY                        INVALID 31/10/2012 01:47:57
SYS        DBMS_DM_UTIL_INTERNAL          PACKAGE                             INVALID 31/10/2012 01:47:57
SYS        DBMS_DM_UTIL_INTERNAL          PACKAGE BODY                        INVALID 31/10/2012 01:47:57
SYS        DBMS_DNFS                      PACKAGE                             INVALID 31/10/2012 01:52:31
SYS        DBMS_DNFS                      PACKAGE BODY                        INVALID 31/10/2012 01:52:31
SYS        DBMS_DRS                       PACKAGE BODY                        INVALID 30/10/2012 22:19:34
SYS        DBMS_DRS                       PACKAGE                             INVALID 30/10/2012 22:19:33
SYS        DBMS_DST                       PACKAGE                             INVALID 31/10/2012 01:52:14
SYS        DBMS_DST                       PACKAGE BODY                        INVALID 31/10/2012 01:52:15
SYS        DBMS_EDITIONS_UTILITIES        PACKAGE BODY                        INVALID 31/10/2012 01:50:20
SYS        DBMS_EDITIONS_UTILITIES        PACKAGE                             INVALID 31/10/2012 01:50:20
SYS        DBMS_EPG                       PACKAGE                             INVALID 31/10/2012 01:50:08
SYS        DBMS_EPG                       PACKAGE BODY                        INVALID 31/10/2012 01:50:11
SYS        DBMS_EPGC                      PACKAGE BODY                        INVALID 30/10/2012 22:19:11
SYS        DBMS_EPGC                      PACKAGE                             INVALID 30/10/2012 22:19:09
SYS        DBMS_ERRLOG                    PACKAGE BODY                        INVALID 31/10/2012 02:07:36
SYS        DBMS_ERRLOG                    PACKAGE                             INVALID 31/10/2012 01:50:17
SYS        DBMS_EXPORT_EXTENSION          PACKAGE BODY                        INVALID 30/10/2012 21:47:47
SYS        DBMS_EXPORT_EXTENSION          PACKAGE                             INVALID 30/10/2012 21:46:19
SYS        DBMS_EXTENDED_TTS_CHECKS       PACKAGE                             INVALID 30/10/2012 22:12:39
SYS        DBMS_EXTENDED_TTS_CHECKS       PACKAGE BODY                        INVALID 30/10/2012 22:12:42
SYS        DBMS_FBT                       PACKAGE BODY                        INVALID 31/10/2012 02:36:40
SYS        DBMS_FBT                       PACKAGE                             INVALID 31/10/2012 01:50:25
SYS        DBMS_FEATURE_APEX              PROCEDURE                           INVALID 31/10/2012 01:13:26
SYS        DBMS_FEATURE_AUTOSTA           PROCEDURE                           INVALID 31/10/2012 01:13:25
SYS        DBMS_FEATURE_AUTO_MEM          PROCEDURE                           INVALID 31/10/2012 01:13:29
SYS        DBMS_FEATURE_AUTO_SGA          PROCEDURE                           INVALID 31/10/2012 01:13:29
SYS        DBMS_FEATURE_CDC               PROCEDURE                           INVALID 31/10/2012 01:13:27
SYS        DBMS_FEATURE_DATABASE_VAULT    PROCEDURE                           INVALID 31/10/2012 01:26:52
SYS        DBMS_FEATURE_DATA_GUARD        PROCEDURE                           INVALID 31/10/2012 01:13:29
SYS        DBMS_FEATURE_DEFERRED_SEG_CRT  PROCEDURE                           INVALID 31/10/2012 01:26:52
SYS        DBMS_FEATURE_DYN_SGA           PROCEDURE                           INVALID 31/10/2012 01:13:29
SYS        DBMS_FEATURE_EXADATA           PROCEDURE                           INVALID 31/10/2012 01:26:51
SYS        DBMS_FEATURE_EXTENSIBILITY     PROCEDURE                           INVALID 31/10/2012 01:13:27
SYS        DBMS_FEATURE_HCC               PROCEDURE                           INVALID 31/10/2012 01:13:27
SYS        DBMS_FEATURE_JOB_SCHEDULER     PROCEDURE                           INVALID 29/12/2012 04:01:17
SYS        DBMS_FEATURE_LMT               PROCEDURE                           INVALID 31/10/2012 01:13:30
SYS        DBMS_FEATURE_OBJECT            PROCEDURE                           INVALID 31/10/2012 01:13:26
SYS        DBMS_FEATURE_PARTITION_SYSTEM  PROCEDURE                           INVALID 31/10/2012 01:13:26
SYS        DBMS_FEATURE_PARTITION_USER    PROCEDURE                           INVALID 31/10/2012 01:13:25
SYS        DBMS_FEATURE_PLSQL_NATIVE      PROCEDURE                           INVALID 31/10/2012 01:13:26
SYS        DBMS_FEATURE_RAC               PROCEDURE                           INVALID 31/10/2012 01:13:26
SYS        DBMS_FEATURE_REGISTER_ALLFEAT  PROCEDURE                           INVALID 29/12/2012 04:07:51
SYS        DBMS_FEATURE_REGISTER_ALLHWM   PROCEDURE                           INVALID 31/10/2012 01:26:53
SYS        DBMS_FEATURE_RMAN_BASIC        PROCEDURE                           INVALID 31/10/2012 01:13:30
SYS        DBMS_FEATURE_RMAN_BZIP2        PROCEDURE                           INVALID 31/10/2012 01:13:29
SYS        DBMS_FEATURE_RMAN_HIGH         PROCEDURE                           INVALID 31/10/2012 01:13:30
SYS        DBMS_FEATURE_RMAN_LOW          PROCEDURE                           INVALID 31/10/2012 01:13:30
SYS        DBMS_FEATURE_RMAN_MEDIUM       PROCEDURE                           INVALID 31/10/2012 01:13:30
SYS        DBMS_FEATURE_RMAN_ZLIB         PROCEDURE                           INVALID 31/10/2012 01:13:29
SYS        DBMS_FEATURE_RULESMANAGER      PROCEDURE                           INVALID 31/10/2012 01:13:27
SYS        DBMS_FEATURE_SECUREFILES_SYS   PROCEDURE                           INVALID 31/10/2012 01:13:28
SYS        DBMS_FEATURE_SECUREFILES_USR   PROCEDURE                           INVALID 31/10/2012 01:13:27
SYS        DBMS_FEATURE_SEGADV_USER       PROCEDURE                           INVALID 31/10/2012 01:13:30
SYS        DBMS_FEATURE_SERVICES          PROCEDURE                           INVALID 31/10/2012 01:13:27
SYS        DBMS_FEATURE_SFCOMPRESS_SYS    PROCEDURE                           INVALID 31/10/2012 01:13:28
SYS        DBMS_FEATURE_SFCOMPRESS_USR    PROCEDURE                           INVALID 31/10/2012 01:13:28
SYS        DBMS_FEATURE_SFDEDUP_SYS       PROCEDURE                           INVALID 31/10/2012 01:13:28

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        DBMS_FEATURE_SFDEDUP_USR       PROCEDURE                           INVALID 31/10/2012 01:13:28
SYS        DBMS_FEATURE_SFENCRYPT_SYS     PROCEDURE                           INVALID 31/10/2012 01:13:28
SYS        DBMS_FEATURE_SFENCRYPT_USR     PROCEDURE                           INVALID 31/10/2012 01:13:28
SYS        DBMS_FEATURE_TEST_PROC_1       PROCEDURE                           INVALID 31/10/2012 01:26:52
SYS        DBMS_FEATURE_TEST_PROC_2       PROCEDURE                           INVALID 31/10/2012 01:26:52
SYS        DBMS_FEATURE_TEST_PROC_3       PROCEDURE                           INVALID 31/10/2012 01:26:52
SYS        DBMS_FEATURE_TEST_PROC_4       PROCEDURE                           INVALID 31/10/2012 01:26:52
SYS        DBMS_FEATURE_TEST_PROC_5       PROCEDURE                           INVALID 31/10/2012 01:26:53
SYS        DBMS_FEATURE_USAGE             PACKAGE BODY                        INVALID 31/10/2012 01:52:00
SYS        DBMS_FEATURE_USAGE_REPORT      PACKAGE                             INVALID 31/10/2012 01:52:00
SYS        DBMS_FEATURE_USAGE_REPORT      PACKAGE BODY                        INVALID 31/10/2012 01:52:00
SYS        DBMS_FEATURE_USER_MVS          PROCEDURE                           INVALID 31/10/2012 01:13:27
SYS        DBMS_FEATURE_UTILITIES1        PROCEDURE                           INVALID 29/12/2012 04:07:52
SYS        DBMS_FEATURE_UTILITIES2        PROCEDURE                           INVALID 29/12/2012 04:07:52
SYS        DBMS_FEATURE_UTILITIES3        PROCEDURE                           INVALID 29/12/2012 04:07:52
SYS        DBMS_FEATURE_UTILITIES4        PROCEDURE                           INVALID 29/12/2012 04:07:52
SYS        DBMS_FEATURE_WCR_CAPTURE       PROCEDURE                           INVALID 31/10/2012 01:13:25
SYS        DBMS_FEATURE_WCR_REPLAY        PROCEDURE                           INVALID 31/10/2012 01:13:25
SYS        DBMS_FEATURE_XDB               PROCEDURE                           INVALID 31/10/2012 01:13:26
SYS        DBMS_FGA                       PACKAGE                             INVALID 30/10/2012 22:19:01
SYS        DBMS_FGA                       PACKAGE BODY                        INVALID 30/10/2012 22:19:01
SYS        DBMS_FILE_GROUP                PACKAGE                             INVALID 31/10/2012 01:52:05
SYS        DBMS_FILE_GROUP                PACKAGE BODY                        INVALID 31/10/2012 01:52:06
SYS        DBMS_FILE_GROUP_DECL           PACKAGE                             INVALID 31/10/2012 02:07:23
SYS        DBMS_FILE_GROUP_EXP            PACKAGE                             INVALID 31/10/2012 02:07:24
SYS        DBMS_FILE_GROUP_EXP            PACKAGE BODY                        INVALID 31/10/2012 02:07:24
SYS        DBMS_FILE_GROUP_EXP_INTERNAL   PACKAGE                             INVALID 31/10/2012 02:07:24
SYS        DBMS_FILE_GROUP_EXP_INTERNAL   PACKAGE BODY                        INVALID 31/10/2012 02:07:24
SYS        DBMS_FILE_GROUP_IMP            PACKAGE                             INVALID 31/10/2012 02:07:24
SYS        DBMS_FILE_GROUP_IMP            PACKAGE BODY                        INVALID 31/10/2012 02:07:25
SYS        DBMS_FILE_GROUP_IMP_INTERNAL   PACKAGE BODY                        INVALID 31/10/2012 02:07:25
SYS        DBMS_FILE_GROUP_IMP_INTERNAL   PACKAGE                             INVALID 31/10/2012 02:07:25
SYS        DBMS_FILE_GROUP_INTERNAL_INVOK PACKAGE BODY                        INVALID 31/10/2012 02:07:24
SYS        DBMS_FILE_GROUP_INTERNAL_INVOK PACKAGE                             INVALID 31/10/2012 02:07:24
SYS        DBMS_FILE_GROUP_UTL            PACKAGE                             INVALID 29/12/2012 10:26:43
SYS        DBMS_FILE_GROUP_UTL            PACKAGE BODY                        INVALID 29/12/2012 10:26:43
SYS        DBMS_FILE_GROUP_UTL_INVOK      PACKAGE                             INVALID 29/12/2012 10:26:43
SYS        DBMS_FILE_GROUP_UTL_INVOK      PACKAGE BODY                        INVALID 29/12/2012 10:26:43
SYS        DBMS_FILE_TRANSFER             PACKAGE                             INVALID 31/10/2012 01:50:25
SYS        DBMS_FILE_TRANSFER             PACKAGE BODY                        INVALID 31/10/2012 01:50:26
SYS        DBMS_FLASHBACK                 PACKAGE BODY                        INVALID 29/12/2012 00:37:05
SYS        DBMS_FLASHBACK                 PACKAGE                             INVALID 29/12/2012 00:37:05
SYS        DBMS_FLASHBACK_ARCHIVE         PACKAGE BODY                        INVALID 31/10/2012 02:07:40
SYS        DBMS_FLASHBACK_ARCHIVE         PACKAGE                             INVALID 31/10/2012 01:50:21
SYS        DBMS_FREQUENT_ITEMSET          PACKAGE                             INVALID 29/12/2012 03:30:29
SYS        DBMS_FREQUENT_ITEMSET          PACKAGE BODY                        INVALID 29/12/2012 03:30:29
SYS        DBMS_FUSE                      PACKAGE                             INVALID 29/12/2012 00:37:05
SYS        DBMS_FUSE                      PACKAGE BODY                        INVALID 29/12/2012 00:37:05
SYS        DBMS_GOLDENGATE_AUTH           PACKAGE                             INVALID 31/10/2012 01:52:07
SYS        DBMS_GOLDENGATE_AUTH           PACKAGE BODY                        INVALID 31/10/2012 01:52:07
SYS        DBMS_HA_ALERTS                 PACKAGE BODY                        INVALID 31/10/2012 02:36:46
SYS        DBMS_HA_ALERTS                 PACKAGE                             INVALID 31/10/2012 01:52:31
SYS        DBMS_HM                        PACKAGE BODY                        INVALID 31/10/2012 02:36:45
SYS        DBMS_HM                        PACKAGE                             INVALID 31/10/2012 01:50:30
SYS        DBMS_HPROF                     PACKAGE                             INVALID 31/10/2012 01:50:27
SYS        DBMS_HPROF                     PACKAGE BODY                        INVALID 31/10/2012 02:36:41
SYS        DBMS_HS                        PACKAGE                             INVALID 30/10/2012 23:18:03
SYS        DBMS_HS                        PACKAGE BODY                        INVALID 31/10/2012 00:06:59
SYS        DBMS_HS_ALT                    PACKAGE                             INVALID 30/10/2012 23:18:04
SYS        DBMS_HS_ALT                    PACKAGE BODY                        INVALID 31/10/2012 00:07:00
SYS        DBMS_HS_CHK                    PACKAGE                             INVALID 30/10/2012 23:18:05
SYS        DBMS_HS_CHK                    PACKAGE BODY                        INVALID 31/10/2012 00:07:00
SYS        DBMS_HS_PARALLEL               PACKAGE BODY                        INVALID 31/10/2012 01:48:56
SYS        DBMS_HS_PARALLEL               PACKAGE                             INVALID 31/10/2012 01:48:50
SYS        DBMS_HS_PARALLEL_METADATA      PACKAGE                             INVALID 31/10/2012 01:48:49
SYS        DBMS_HS_PARALLEL_METADATA      PACKAGE BODY                        INVALID 31/10/2012 01:48:53
SYS        DBMS_HS_UTL                    PACKAGE                             INVALID 30/10/2012 23:18:05
SYS        DBMS_HS_UTL                    PACKAGE BODY                        INVALID 31/10/2012 00:07:01
SYS        DBMS_IAS_CONFIGURE             PACKAGE BODY                        INVALID 30/10/2012 22:12:23
SYS        DBMS_IAS_CONFIGURE             PACKAGE                             INVALID 30/10/2012 22:12:23
SYS        DBMS_IJOB                      PACKAGE                             INVALID 30/10/2012 21:47:21
SYS        DBMS_IJOB                      PACKAGE BODY                        INVALID 30/10/2012 21:47:50
SYS        DBMS_INDEX_UTL                 PACKAGE                             INVALID 15/04/2012 01:47:17
SYS        DBMS_INDEX_UTL                 PACKAGE BODY                        INVALID 31/10/2012 00:53:13
SYS        DBMS_INTERNAL_LOGSTDBY         PACKAGE BODY                        INVALID 14/11/2012 21:47:06
SYS        DBMS_INTERNAL_REPCAT           PACKAGE BODY                        INVALID 29/12/2012 03:30:30
SYS        DBMS_INTERNAL_REPCAT           PACKAGE                             INVALID 29/12/2012 03:30:30
SYS        DBMS_INTERNAL_SAFE_SCN         PACKAGE BODY                        INVALID 31/10/2012 01:50:03
SYS        DBMS_INTERNAL_TRIGGER          PACKAGE                             INVALID 30/10/2012 22:11:48
SYS        DBMS_INTERNAL_TRIGGER          PACKAGE BODY                        INVALID 30/10/2012 22:11:48
SYS        DBMS_IR                        PACKAGE                             INVALID 31/10/2012 01:50:30
SYS        DBMS_IR                        PACKAGE BODY                        INVALID 31/10/2012 02:36:47
SYS        DBMS_IREFRESH                  PACKAGE BODY                        INVALID 29/12/2012 03:30:31
SYS        DBMS_IREFRESH                  PACKAGE                             INVALID 29/12/2012 03:30:30
SYS        DBMS_ISCHED                    PACKAGE BODY                        INVALID 29/12/2012 10:26:43
SYS        DBMS_ISCHED                    PACKAGE                             INVALID 29/12/2012 10:26:43
SYS        DBMS_ISCHED_CHAIN_CONDITION    PACKAGE                             INVALID 31/10/2012 01:52:41
SYS        DBMS_ISCHED_CHAIN_CONDITION    PACKAGE BODY                        INVALID 31/10/2012 01:52:42
SYS        DBMS_ISCHED_REMDB_JOB          PACKAGE                             INVALID 31/10/2012 01:52:42
SYS        DBMS_ISCHED_REMDB_JOB          PACKAGE BODY                        INVALID 31/10/2012 01:52:42
SYS        DBMS_ISNAPSHOT                 PACKAGE BODY                        INVALID 30/10/2012 22:12:17
SYS        DBMS_ISNAPSHOT                 PACKAGE                             INVALID 30/10/2012 22:12:08
SYS        DBMS_ITRIGGER_UTL              PACKAGE BODY                        INVALID 30/10/2012 22:11:49
SYS        DBMS_ITRIGGER_UTL              PACKAGE                             INVALID 30/10/2012 22:11:48
SYS        DBMS_I_INDEX_UTL               PACKAGE                             INVALID 15/04/2012 01:47:17
SYS        DBMS_I_INDEX_UTL               PACKAGE BODY                        INVALID 31/10/2012 00:53:13
SYS        DBMS_JAVA                      PACKAGE                             INVALID 31/10/2012 00:07:19

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        DBMS_JAVA                      PACKAGE BODY                        INVALID 29/12/2012 00:20:24
SYS        DBMS_JAVA_DEFINERS             PACKAGE                             INVALID 31/10/2012 01:49:02
SYS        DBMS_JAVA_DEFINERS             PACKAGE BODY                        INVALID 31/10/2012 01:49:03
SYS        DBMS_JAVA_DUMP                 PACKAGE                             INVALID 31/10/2012 01:52:35
SYS        DBMS_JAVA_DUMP                 PACKAGE BODY                        INVALID 31/10/2012 02:36:40
SYS        DBMS_JDM_INTERNAL              PACKAGE BODY                        INVALID 31/10/2012 01:49:02
SYS        DBMS_JDM_INTERNAL              PACKAGE                             INVALID 31/10/2012 01:48:59
SYS        DBMS_JMS_PLSQL                 PACKAGE BODY                        INVALID 31/10/2012 02:36:45
SYS        DBMS_JMS_PLSQL                 PACKAGE                             INVALID 31/10/2012 01:52:39
SYS        DBMS_JOB                       PACKAGE BODY                        INVALID 30/10/2012 21:47:49
SYS        DBMS_JVM_EXP_PERMS             PACKAGE                             INVALID 31/10/2012 01:49:04
SYS        DBMS_JVM_EXP_PERMS             PACKAGE BODY                        INVALID 31/10/2012 01:49:05
SYS        DBMS_LCR                       PACKAGE                             INVALID 30/10/2012 23:18:26
SYS        DBMS_LDAP                      PACKAGE BODY                        INVALID 31/10/2012 00:07:02
SYS        DBMS_LDAP_API_FFI              PACKAGE BODY                        INVALID 31/10/2012 00:07:03
SYS        DBMS_LDAP_API_FFI              PACKAGE                             INVALID 30/10/2012 23:18:09
SYS        DBMS_LDAP_UTL                  PACKAGE BODY                        INVALID 31/10/2012 00:07:03
SYS        DBMS_LDAP_UTL                  PACKAGE                             INVALID 30/10/2012 23:18:08
SYS        DBMS_LOB                       PACKAGE BODY                        INVALID 30/10/2012 21:48:36
SYS        DBMS_LOBUTIL                   PACKAGE BODY                        INVALID 31/10/2012 02:07:25
SYS        DBMS_LOBUTIL                   PACKAGE                             INVALID 31/10/2012 01:50:34
SYS        DBMS_LOBUTIL_INODE_T           TYPE                                INVALID 31/10/2012 00:10:40
SYS        DBMS_LOBUTIL_LOBEXTENTS_T      TYPE                                INVALID 31/10/2012 00:10:40
SYS        DBMS_LOBUTIL_LOBEXTENT_T       TYPE                                INVALID 31/10/2012 00:10:40
SYS        DBMS_LOBUTIL_LOBMAP_T          TYPE                                INVALID 31/10/2012 00:10:40
SYS        DBMS_LOB_AM_PRIVATE            PACKAGE BODY                        INVALID 31/10/2012 01:48:40
SYS        DBMS_LOB_AM_PRIVATE            PACKAGE                             INVALID 31/10/2012 01:48:39
SYS        DBMS_LOCK                      PACKAGE BODY                        INVALID 30/10/2012 21:47:42
SYS        DBMS_LOGMNR                    PACKAGE BODY                        INVALID 30/10/2012 22:13:43
SYS        DBMS_LOGMNR                    PACKAGE                             INVALID 30/10/2012 22:13:43
SYS        DBMS_LOGMNR_D                  PACKAGE BODY                        INVALID 30/10/2012 22:13:48
SYS        DBMS_LOGMNR_D                  PACKAGE                             INVALID 30/10/2012 22:13:43
SYS        DBMS_LOGMNR_FFVTOLOGMNRT       PROCEDURE                           INVALID 29/12/2012 04:07:52
SYS        DBMS_LOGMNR_INTERNAL           PACKAGE                             INVALID 30/10/2012 22:13:48
SYS        DBMS_LOGMNR_INTERNAL           PACKAGE BODY                        INVALID 30/10/2012 22:14:01
SYS        DBMS_LOGMNR_LOGREP_DICT        PACKAGE BODY                        INVALID 30/10/2012 22:14:05
SYS        DBMS_LOGMNR_LOGREP_DICT        PACKAGE                             INVALID 30/10/2012 22:14:03
SYS        DBMS_LOGMNR_SESSION            PACKAGE BODY                        INVALID 14/11/2012 21:47:05
SYS        DBMS_LOGMNR_SESSION            PACKAGE                             INVALID 30/10/2012 22:19:01
SYS        DBMS_LOGREP_DEF_PROC           PACKAGE BODY                        INVALID 29/12/2012 03:30:34
SYS        DBMS_LOGREP_DEF_PROC           PACKAGE                             INVALID 29/12/2012 03:30:33
SYS        DBMS_LOGREP_DEF_PROC_UTL       PACKAGE BODY                        INVALID 30/10/2012 22:55:45
SYS        DBMS_LOGREP_DEF_PROC_UTL       PACKAGE                             INVALID 30/10/2012 22:55:45
SYS        DBMS_LOGREP_EXP                PACKAGE BODY                        INVALID 29/12/2012 03:37:23
SYS        DBMS_LOGREP_EXP                PACKAGE                             INVALID 29/12/2012 03:30:34
SYS        DBMS_LOGREP_IMP                PACKAGE                             INVALID 30/10/2012 23:18:01
SYS        DBMS_LOGREP_IMP                PACKAGE BODY                        INVALID 12/12/2012 18:58:09
SYS        DBMS_LOGREP_IMP_INTERNAL       PACKAGE                             INVALID 30/10/2012 23:18:02
SYS        DBMS_LOGREP_IMP_INTERNAL       PACKAGE BODY                        INVALID 31/10/2012 00:06:59
SYS        DBMS_LOGREP_UTIL               PACKAGE                             INVALID 29/12/2012 10:26:45
SYS        DBMS_LOGREP_UTIL               PACKAGE BODY                        INVALID 29/12/2012 10:26:45
SYS        DBMS_LOGREP_UTIL_INVOK         PACKAGE BODY                        INVALID 31/10/2012 01:27:05
SYS        DBMS_LOGREP_UTIL_INVOK         PACKAGE                             INVALID 15/04/2012 01:48:00
SYS        DBMS_LOGSTDBY                  PACKAGE BODY                        INVALID 30/10/2012 22:19:02
SYS        DBMS_MAINT_GEN                 PACKAGE BODY                        INVALID 14/11/2012 21:47:14
SYS        DBMS_MAINT_GEN                 PACKAGE                             INVALID 30/10/2012 22:19:50
SYS        DBMS_MANAGEMENT_PACKS          PACKAGE BODY                        INVALID 04/01/2013 16:03:19
SYS        DBMS_METADATA                  PACKAGE                             INVALID 04/01/2013 20:10:01
SYS        DBMS_METADATA                  PACKAGE BODY                        INVALID 29/12/2012 10:26:46
SYS        DBMS_METADATA_BUILD            PACKAGE                             INVALID 31/10/2012 01:50:38
SYS        DBMS_METADATA_BUILD            PACKAGE BODY                        INVALID 31/10/2012 01:50:39
SYS        DBMS_METADATA_DIFF             PACKAGE BODY                        INVALID 29/12/2012 10:26:46
SYS        DBMS_METADATA_DIFF             PACKAGE                             INVALID 29/12/2012 10:26:46
SYS        DBMS_METADATA_DPBUILD          PACKAGE BODY                        INVALID 31/10/2012 00:52:30
SYS        DBMS_METADATA_INT              PACKAGE                             INVALID 30/10/2012 22:18:44
SYS        DBMS_METADATA_INT              PACKAGE BODY                        INVALID 30/10/2012 22:18:44
SYS        DBMS_METADATA_UTIL             PACKAGE                             INVALID 29/12/2012 10:26:46
SYS        DBMS_METADATA_UTIL             PACKAGE BODY                        INVALID 29/12/2012 10:26:46
SYS        DBMS_MONITOR                   PACKAGE                             INVALID 31/10/2012 01:50:30
SYS        DBMS_MONITOR                   PACKAGE BODY                        INVALID 31/10/2012 01:50:30
SYS        DBMS_NETWORK_ACL_ADMIN         PACKAGE BODY                        INVALID 31/10/2012 01:50:20
SYS        DBMS_NETWORK_ACL_ADMIN         PACKAGE                             INVALID 31/10/2012 01:50:19
SYS        DBMS_NETWORK_ACL_UTILITY       PACKAGE BODY                        INVALID 31/10/2012 01:50:21
SYS        DBMS_NETWORK_ACL_UTILITY       PACKAGE                             INVALID 31/10/2012 01:50:20
SYS        DBMS_OBFUSCATION_TOOLKIT       PACKAGE BODY                        INVALID 30/10/2012 22:13:43
SYS        DBMS_OBFUSCATION_TOOLKIT       PACKAGE                             INVALID 30/10/2012 22:13:42
SYS        DBMS_OBFUSCATION_TOOLKIT_FFI   PACKAGE                             INVALID 30/10/2012 22:13:42
SYS        DBMS_OBFUSCATION_TOOLKIT_FFI   PACKAGE BODY                        INVALID 30/10/2012 22:13:42
SYS        DBMS_OBJECTS_UTILS             PACKAGE BODY                        INVALID 31/10/2012 01:52:13
SYS        DBMS_ODCI                      PACKAGE                             INVALID 29/12/2012 10:26:46
SYS        DBMS_ODCI                      PACKAGE BODY                        INVALID 29/12/2012 10:26:47
SYS        DBMS_OFFLINE_INTERNAL          PACKAGE BODY                        INVALID 29/12/2012 03:37:25
SYS        DBMS_OFFLINE_INTERNAL          PACKAGE                             INVALID 29/12/2012 03:37:25
SYS        DBMS_OFFLINE_OG                PACKAGE BODY                        INVALID 30/10/2012 22:20:42
SYS        DBMS_OFFLINE_OG                PACKAGE                             INVALID 30/10/2012 22:20:42
SYS        DBMS_OFFLINE_RGT               PACKAGE                             INVALID 29/12/2012 03:37:25
SYS        DBMS_OFFLINE_RGT               PACKAGE BODY                        INVALID 29/12/2012 03:37:26
SYS        DBMS_OFFLINE_SNAPSHOT          PACKAGE                             INVALID 30/10/2012 22:20:24
SYS        DBMS_OFFLINE_SNAPSHOT          PACKAGE BODY                        INVALID 30/10/2012 22:20:24
SYS        DBMS_OFFLINE_UTL               PACKAGE BODY                        INVALID 29/12/2012 03:37:27
SYS        DBMS_OFFLINE_UTL               PACKAGE                             INVALID 29/12/2012 03:37:26
SYS        DBMS_PARALLEL_EXECUTE          PACKAGE BODY                        INVALID 31/10/2012 01:52:15
SYS        DBMS_PARALLEL_EXECUTE          PACKAGE                             INVALID 31/10/2012 01:52:15
SYS        DBMS_PARALLEL_EXECUTE_INTERNAL PACKAGE                             INVALID 31/10/2012 01:52:16
SYS        DBMS_PARALLEL_EXECUTE_INTERNAL PACKAGE BODY                        INVALID 31/10/2012 01:52:16
SYS        DBMS_PCLXUTIL                  PACKAGE BODY                        INVALID 30/10/2012 21:47:36
SYS        DBMS_PCLXUTIL                  PACKAGE                             INVALID 30/10/2012 21:45:44

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        DBMS_PIPE                      PACKAGE BODY                        INVALID 30/10/2012 21:47:43
SYS        DBMS_PIPE                      PACKAGE                             INVALID 30/10/2012 21:46:11
SYS        DBMS_PITR                      PACKAGE                             INVALID 30/10/2012 22:12:24
SYS        DBMS_PITR                      PACKAGE BODY                        INVALID 30/10/2012 22:12:26
SYS        DBMS_PLUGTS                    PACKAGE BODY                        INVALID 30/10/2012 22:12:41
SYS        DBMS_PLUGTS                    PACKAGE                             INVALID 30/10/2012 22:12:26
SYS        DBMS_PLUGTSP                   PACKAGE BODY                        INVALID 30/10/2012 22:12:41
SYS        DBMS_PLUGTSP                   PACKAGE                             INVALID 30/10/2012 22:12:38
SYS        DBMS_PREDICTIVE_ANALYTICS      PACKAGE                             INVALID 31/10/2012 01:53:02
SYS        DBMS_PREDICTIVE_ANALYTICS      PACKAGE BODY                        INVALID 31/10/2012 01:53:02
SYS        DBMS_PREPROCESSOR              PACKAGE                             INVALID 31/10/2012 01:50:20
SYS        DBMS_PREPROCESSOR              PACKAGE BODY                        INVALID 31/10/2012 02:07:39
SYS        DBMS_PROFILER                  PACKAGE BODY                        INVALID 31/10/2012 02:36:41
SYS        DBMS_PROFILER                  PACKAGE                             INVALID 31/10/2012 01:50:26
SYS        DBMS_PROPAGATION_ADM           PACKAGE BODY                        INVALID 30/10/2012 22:55:44
SYS        DBMS_PROPAGATION_ADM           PACKAGE                             INVALID 30/10/2012 22:55:44
SYS        DBMS_PROPAGATION_INTERNAL      PACKAGE                             INVALID 15/04/2012 01:47:45
SYS        DBMS_PROPAGATION_INTERNAL      PACKAGE BODY                        INVALID 31/10/2012 01:27:04
SYS        DBMS_PRVTAQIM                  PACKAGE BODY                        INVALID 14/11/2012 21:46:52
SYS        DBMS_PRVTAQIM                  PACKAGE                             INVALID 30/10/2012 22:11:18
SYS        DBMS_PRVTAQIP                  PACKAGE                             INVALID 29/12/2012 10:26:47
SYS        DBMS_PRVTAQIP                  PACKAGE BODY                        INVALID 29/12/2012 10:26:48
SYS        DBMS_PRVTAQIS                  PACKAGE                             INVALID 29/12/2012 10:26:48
SYS        DBMS_PRVTAQIS                  PACKAGE BODY                        INVALID 29/12/2012 10:26:48
SYS        DBMS_PRVTRMIE                  PACKAGE                             INVALID 30/10/2012 22:11:36
SYS        DBMS_PRVTRMIE                  PACKAGE BODY                        INVALID 30/10/2012 22:11:37
SYS        DBMS_PSP                       PACKAGE BODY                        INVALID 30/10/2012 21:48:33
SYS        DBMS_PSP                       PACKAGE                             INVALID 30/10/2012 21:48:31
SYS        DBMS_PSWMG_IMPORT              PACKAGE                             INVALID 30/10/2012 22:11:49
SYS        DBMS_PSWMG_IMPORT              PACKAGE BODY                        INVALID 30/10/2012 22:11:49
SYS        DBMS_RANDOM                    PACKAGE BODY                        INVALID 30/10/2012 22:13:41
SYS        DBMS_RCVMAN                    PACKAGE BODY                        INVALID 14/11/2012 21:47:00
SYS        DBMS_RCVMAN                    PACKAGE                             INVALID 30/10/2012 22:12:43
SYS        DBMS_RECOVERABLE_SCRIPT        PACKAGE BODY                        INVALID 31/10/2012 01:52:08
SYS        DBMS_RECOVERABLE_SCRIPT        PACKAGE                             INVALID 31/10/2012 01:52:08
SYS        DBMS_RECO_SCRIPT_INT           PACKAGE BODY                        INVALID 31/10/2012 01:52:08
SYS        DBMS_RECO_SCRIPT_INT           PACKAGE                             INVALID 31/10/2012 01:52:08
SYS        DBMS_RECO_SCRIPT_INVOK         PACKAGE BODY                        INVALID 31/10/2012 01:52:08
SYS        DBMS_RECO_SCRIPT_INVOK         PACKAGE                             INVALID 31/10/2012 01:52:08
SYS        DBMS_RECTIFIER_DIFF            PACKAGE                             INVALID 29/12/2012 03:37:31
SYS        DBMS_RECTIFIER_DIFF            PACKAGE BODY                        INVALID 29/12/2012 03:37:31
SYS        DBMS_RECTIFIER_FRIENDS         PACKAGE BODY                        INVALID 29/12/2012 03:37:32
SYS        DBMS_RECTIFIER_FRIENDS         PACKAGE                             INVALID 29/12/2012 03:37:31
SYS        DBMS_REDEFINITION              PACKAGE                             INVALID 30/10/2012 22:12:03
SYS        DBMS_REDEFINITION              PACKAGE BODY                        INVALID 30/10/2012 22:12:24
SYS        DBMS_REFRESH                   PACKAGE BODY                        INVALID 29/12/2012 03:37:32
SYS        DBMS_REFRESH                   PACKAGE                             INVALID 29/12/2012 03:37:32
SYS        DBMS_REFRESH_EXP_LWM           PACKAGE                             INVALID 30/10/2012 22:12:15
SYS        DBMS_REFRESH_EXP_LWM           PACKAGE BODY                        INVALID 30/10/2012 22:12:20
SYS        DBMS_REFRESH_EXP_SITES         PACKAGE BODY                        INVALID 30/10/2012 22:12:20
SYS        DBMS_REFRESH_EXP_SITES         PACKAGE                             INVALID 30/10/2012 22:12:15
SYS        DBMS_REGISTRY_SYS              PACKAGE BODY                        INVALID 04/01/2013 20:09:12
SYS        DBMS_REGXDB                    PACKAGE BODY                        INVALID 31/10/2012 01:50:15
SYS        DBMS_REPAIR                    PACKAGE BODY                        INVALID 30/10/2012 22:13:39
SYS        DBMS_REPAIR                    PACKAGE                             INVALID 30/10/2012 22:13:38
SYS        DBMS_REPCAT                    PACKAGE                             INVALID 29/12/2012 03:37:33
SYS        DBMS_REPCAT                    PACKAGE BODY                        INVALID 29/12/2012 03:37:35
SYS        DBMS_REPCAT_ADD_MASTER         PACKAGE BODY                        INVALID 29/12/2012 03:37:38
SYS        DBMS_REPCAT_ADD_MASTER         PACKAGE                             INVALID 29/12/2012 03:37:36
SYS        DBMS_REPCAT_ADMIN              PACKAGE                             INVALID 29/12/2012 03:37:38
SYS        DBMS_REPCAT_ADMIN              PACKAGE BODY                        INVALID 29/12/2012 03:37:39
SYS        DBMS_REPCAT_AUTH               PACKAGE                             INVALID 30/10/2012 22:20:43
SYS        DBMS_REPCAT_AUTH               PACKAGE BODY                        INVALID 30/10/2012 22:20:43
SYS        DBMS_REPCAT_CACHE              PACKAGE                             INVALID 29/12/2012 03:37:39
SYS        DBMS_REPCAT_CACHE              PACKAGE BODY                        INVALID 29/12/2012 03:37:39
SYS        DBMS_REPCAT_COMMON_UTL         PACKAGE                             INVALID 29/12/2012 03:37:39
SYS        DBMS_REPCAT_COMMON_UTL         PACKAGE BODY                        INVALID 29/12/2012 03:37:40
SYS        DBMS_REPCAT_CONF               PACKAGE                             INVALID 29/12/2012 03:37:40
SYS        DBMS_REPCAT_CONF               PACKAGE BODY                        INVALID 29/12/2012 03:37:42
SYS        DBMS_REPCAT_DECL               PACKAGE                             INVALID 29/12/2012 03:37:43
SYS        DBMS_REPCAT_DECL               PACKAGE BODY                        INVALID 29/12/2012 03:37:44
SYS        DBMS_REPCAT_EXP                PACKAGE BODY                        INVALID 31/10/2012 01:26:59
SYS        DBMS_REPCAT_EXP                PACKAGE                             INVALID 31/10/2012 01:26:59
SYS        DBMS_REPCAT_FLA                PACKAGE BODY                        INVALID 29/12/2012 03:37:45
SYS        DBMS_REPCAT_FLA                PACKAGE                             INVALID 29/12/2012 03:37:44
SYS        DBMS_REPCAT_FLA_MAS            PACKAGE                             INVALID 29/12/2012 03:37:45
SYS        DBMS_REPCAT_FLA_MAS            PACKAGE BODY                        INVALID 29/12/2012 03:37:46
SYS        DBMS_REPCAT_FLA_UTL            PACKAGE                             INVALID 29/12/2012 03:37:46
SYS        DBMS_REPCAT_FLA_UTL            PACKAGE BODY                        INVALID 29/12/2012 03:37:47
SYS        DBMS_REPCAT_INSTANTIATE        PACKAGE                             INVALID 30/10/2012 22:21:13
SYS        DBMS_REPCAT_INSTANTIATE        PACKAGE BODY                        INVALID 30/10/2012 22:21:13
SYS        DBMS_REPCAT_INTERNAL           PACKAGE                             INVALID 30/10/2012 22:20:01
SYS        DBMS_REPCAT_INTERNAL           PACKAGE BODY                        INVALID 30/10/2012 22:20:01
SYS        DBMS_REPCAT_INTERNAL_PACKAGE   PACKAGE BODY                        INVALID 29/12/2012 03:37:47
SYS        DBMS_REPCAT_INTERNAL_PACKAGE   PACKAGE                             INVALID 29/12/2012 03:37:47
SYS        DBMS_REPCAT_MAS                PACKAGE                             INVALID 29/12/2012 03:37:47
SYS        DBMS_REPCAT_MAS                PACKAGE BODY                        INVALID 29/12/2012 03:37:51
SYS        DBMS_REPCAT_MIG                PACKAGE                             INVALID 30/10/2012 22:21:01
SYS        DBMS_REPCAT_MIG                PACKAGE BODY                        INVALID 30/10/2012 22:21:01
SYS        DBMS_REPCAT_MIGRATION          PACKAGE                             INVALID 29/12/2012 03:37:51
SYS        DBMS_REPCAT_MIGRATION          PACKAGE BODY                        INVALID 29/12/2012 03:37:53
SYS        DBMS_REPCAT_MIG_INTERNAL       PACKAGE BODY                        INVALID 29/12/2012 03:37:54
SYS        DBMS_REPCAT_MIG_INTERNAL       PACKAGE                             INVALID 29/12/2012 03:37:53
SYS        DBMS_REPCAT_OBJ_UTL            PACKAGE BODY                        INVALID 29/12/2012 03:37:56
SYS        DBMS_REPCAT_OBJ_UTL            PACKAGE                             INVALID 29/12/2012 03:37:55
SYS        DBMS_REPCAT_OUTPUT             PACKAGE                             INVALID 30/10/2012 22:20:02
SYS        DBMS_REPCAT_OUTPUT             PACKAGE BODY                        INVALID 30/10/2012 22:20:02

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        DBMS_REPCAT_RGT                PACKAGE                             INVALID 30/10/2012 22:20:41
SYS        DBMS_REPCAT_RGT                PACKAGE BODY                        INVALID 30/10/2012 22:20:41
SYS        DBMS_REPCAT_RGT_ALT            PACKAGE BODY                        INVALID 30/10/2012 22:21:11
SYS        DBMS_REPCAT_RGT_ALT            PACKAGE                             INVALID 30/10/2012 22:21:11
SYS        DBMS_REPCAT_RGT_CHK            PACKAGE                             INVALID 30/10/2012 22:21:10
SYS        DBMS_REPCAT_RGT_CHK            PACKAGE BODY                        INVALID 30/10/2012 22:21:10
SYS        DBMS_REPCAT_RGT_CUST           PACKAGE                             INVALID 30/10/2012 22:21:07
SYS        DBMS_REPCAT_RGT_CUST           PACKAGE BODY                        INVALID 30/10/2012 22:21:07
SYS        DBMS_REPCAT_RGT_CUST2          PACKAGE BODY                        INVALID 30/10/2012 22:21:12
SYS        DBMS_REPCAT_RGT_CUST2          PACKAGE                             INVALID 30/10/2012 22:21:12
SYS        DBMS_REPCAT_RGT_EXP            PACKAGE BODY                        INVALID 30/10/2012 22:21:13
SYS        DBMS_REPCAT_RGT_EXP            PACKAGE                             INVALID 30/10/2012 22:21:13
SYS        DBMS_REPCAT_RGT_UTL            PACKAGE                             INVALID 30/10/2012 22:21:06
SYS        DBMS_REPCAT_RGT_UTL            PACKAGE BODY                        INVALID 30/10/2012 22:21:06
SYS        DBMS_REPCAT_RPC                PACKAGE BODY                        INVALID 29/12/2012 03:37:59
SYS        DBMS_REPCAT_RPC                PACKAGE                             INVALID 29/12/2012 03:37:57
SYS        DBMS_REPCAT_RPC_UTL            PACKAGE                             INVALID 30/10/2012 22:20:51
SYS        DBMS_REPCAT_RPC_UTL            PACKAGE BODY                        INVALID 30/10/2012 22:20:51
SYS        DBMS_REPCAT_RQ                 PACKAGE                             INVALID 30/10/2012 22:21:02
SYS        DBMS_REPCAT_RQ                 PACKAGE BODY                        INVALID 30/10/2012 22:21:02
SYS        DBMS_REPCAT_SNA                PACKAGE                             INVALID 29/12/2012 03:37:59
SYS        DBMS_REPCAT_SNA                PACKAGE BODY                        INVALID 29/12/2012 03:37:59
SYS        DBMS_REPCAT_SNA_UTL            PACKAGE BODY                        INVALID 29/12/2012 03:38:02
SYS        DBMS_REPCAT_SNA_UTL            PACKAGE                             INVALID 29/12/2012 03:38:00
SYS        DBMS_REPCAT_SQL_UTL            PACKAGE BODY                        INVALID 29/12/2012 03:38:03
SYS        DBMS_REPCAT_SQL_UTL            PACKAGE                             INVALID 29/12/2012 03:38:02
SYS        DBMS_REPCAT_UNTRUSTED          PACKAGE                             INVALID 30/10/2012 22:20:23
SYS        DBMS_REPCAT_UNTRUSTED          PACKAGE BODY                        INVALID 30/10/2012 22:20:23
SYS        DBMS_REPCAT_UTL                PACKAGE                             INVALID 29/12/2012 03:38:03
SYS        DBMS_REPCAT_UTL                PACKAGE BODY                        INVALID 29/12/2012 03:38:07
SYS        DBMS_REPCAT_UTL2               PACKAGE BODY                        INVALID 29/12/2012 03:38:08
SYS        DBMS_REPCAT_UTL2               PACKAGE                             INVALID 29/12/2012 03:38:07
SYS        DBMS_REPCAT_UTL3               PACKAGE                             INVALID 29/12/2012 03:38:09
SYS        DBMS_REPCAT_UTL3               PACKAGE BODY                        INVALID 29/12/2012 03:38:10
SYS        DBMS_REPCAT_UTL4               PACKAGE                             INVALID 29/12/2012 03:38:11
SYS        DBMS_REPCAT_UTL4               PACKAGE BODY                        INVALID 29/12/2012 03:38:13
SYS        DBMS_REPCAT_VALIDATE           PACKAGE BODY                        INVALID 29/12/2012 03:38:13
SYS        DBMS_REPCAT_VALIDATE           PACKAGE                             INVALID 29/12/2012 03:38:13
SYS        DBMS_REPORT                    PACKAGE BODY                        INVALID 29/12/2012 03:38:13
SYS        DBMS_REPORT                    PACKAGE                             INVALID 04/01/2013 03:29:45
SYS        DBMS_REPUTIL                   PACKAGE                             INVALID 30/10/2012 22:19:46
SYS        DBMS_REPUTIL                   PACKAGE BODY                        INVALID 30/10/2012 22:19:46
SYS        DBMS_REPUTIL2                  PACKAGE BODY                        INVALID 30/10/2012 22:19:48
SYS        DBMS_REPUTIL2                  PACKAGE                             INVALID 30/10/2012 22:19:48
SYS        DBMS_RESOURCE_MANAGER          PACKAGE                             INVALID 30/10/2012 22:11:34
SYS        DBMS_RESOURCE_MANAGER          PACKAGE BODY                        INVALID 30/10/2012 22:11:36
SYS        DBMS_RESOURCE_MANAGER_PRIVS    PACKAGE                             INVALID 30/10/2012 22:11:36
SYS        DBMS_RESOURCE_MANAGER_PRIVS    PACKAGE BODY                        INVALID 30/10/2012 22:11:36
SYS        DBMS_RESULT_CACHE              PACKAGE BODY                        INVALID 31/10/2012 02:36:44
SYS        DBMS_RESULT_CACHE              PACKAGE                             INVALID 31/10/2012 01:50:28
SYS        DBMS_RESULT_CACHE_API          PACKAGE                             INVALID 31/10/2012 01:50:29
SYS        DBMS_RESUMABLE                 PACKAGE                             INVALID 30/10/2012 22:19:24
SYS        DBMS_RESUMABLE                 PACKAGE BODY                        INVALID 30/10/2012 22:19:25
SYS        DBMS_RLS                       PACKAGE                             INVALID 07/12/2012 03:28:54
SYS        DBMS_RLS                       PACKAGE BODY                        INVALID 30/10/2012 22:13:36
SYS        DBMS_RMGR_GROUP_EXPORT         PACKAGE                             INVALID 30/10/2012 22:11:38
SYS        DBMS_RMGR_GROUP_EXPORT         PACKAGE BODY                        INVALID 30/10/2012 22:11:38
SYS        DBMS_RMGR_PACT_EXPORT          PACKAGE BODY                        INVALID 30/10/2012 22:11:40
SYS        DBMS_RMGR_PACT_EXPORT          PACKAGE                             INVALID 30/10/2012 22:11:38
SYS        DBMS_RMGR_PLAN_EXPORT          PACKAGE                             INVALID 30/10/2012 22:11:37
SYS        DBMS_RMGR_PLAN_EXPORT          PACKAGE BODY                        INVALID 30/10/2012 22:11:37
SYS        DBMS_RMIN                      PACKAGE BODY                        INVALID 30/10/2012 22:11:33
SYS        DBMS_RMIN                      PACKAGE                             INVALID 30/10/2012 22:11:31
SYS        DBMS_ROWID                     PACKAGE                             INVALID 30/10/2012 21:45:43
SYS        DBMS_ROWID                     PACKAGE BODY                        INVALID 30/10/2012 21:47:36
SYS        DBMS_RULE                      PACKAGE                             INVALID 29/12/2012 03:38:14
SYS        DBMS_RULE                      PACKAGE BODY                        INVALID 29/12/2012 03:38:14
SYS        DBMS_RULEADM_INTERNAL          PACKAGE                             INVALID 29/12/2012 03:38:14
SYS        DBMS_RULEADM_INTERNAL          PACKAGE BODY                        INVALID 29/12/2012 03:38:14
SYS        DBMS_RULE_ADM                  PACKAGE                             INVALID 29/12/2012 03:57:06
SYS        DBMS_RULE_ADM                  PACKAGE BODY                        INVALID 29/12/2012 03:38:14
SYS        DBMS_RULE_COMPATIBLE_90        PACKAGE                             INVALID 30/10/2012 22:10:46
SYS        DBMS_RULE_COMPATIBLE_90        PACKAGE BODY                        INVALID 14/11/2012 21:46:47
SYS        DBMS_RULE_EXIMP                PACKAGE BODY                        INVALID 14/11/2012 21:26:15
SYS        DBMS_RULE_EXIMP                PACKAGE                             INVALID 30/10/2012 21:48:41
SYS        DBMS_RULE_EXP_EC_INTERNAL      PACKAGE                             INVALID 30/10/2012 21:56:01
SYS        DBMS_RULE_EXP_EC_INTERNAL      PACKAGE BODY                        INVALID 30/10/2012 21:56:02
SYS        DBMS_RULE_EXP_EV_CTXS          PACKAGE                             INVALID 30/10/2012 22:10:44
SYS        DBMS_RULE_EXP_EV_CTXS          PACKAGE BODY                        INVALID 30/10/2012 22:10:45
SYS        DBMS_RULE_EXP_RL_INTERNAL      PACKAGE BODY                        INVALID 14/11/2012 21:32:36
SYS        DBMS_RULE_EXP_RL_INTERNAL      PACKAGE                             INVALID 30/10/2012 21:56:02
SYS        DBMS_RULE_EXP_RS_INTERNAL      PACKAGE                             INVALID 30/10/2012 21:56:02
SYS        DBMS_RULE_EXP_RS_INTERNAL      PACKAGE BODY                        INVALID 14/11/2012 21:32:36
SYS        DBMS_RULE_EXP_RULES            PACKAGE                             INVALID 30/10/2012 22:10:45
SYS        DBMS_RULE_EXP_RULES            PACKAGE BODY                        INVALID 30/10/2012 22:10:46
SYS        DBMS_RULE_EXP_RULE_SETS        PACKAGE                             INVALID 30/10/2012 22:10:45
SYS        DBMS_RULE_EXP_RULE_SETS        PACKAGE BODY                        INVALID 30/10/2012 22:10:45
SYS        DBMS_RULE_EXP_UTL              PACKAGE                             INVALID 30/10/2012 21:55:56
SYS        DBMS_RULE_EXP_UTL              PACKAGE BODY                        INVALID 30/10/2012 21:56:01
SYS        DBMS_RULE_EXP_UTLI             PACKAGE BODY                        INVALID 31/10/2012 00:53:12
SYS        DBMS_RULE_EXP_UTLI             PACKAGE                             INVALID 15/04/2012 01:47:18
SYS        DBMS_RULE_IMP_OBJ              PACKAGE                             INVALID 29/12/2012 00:56:59
SYS        DBMS_RULE_IMP_OBJ              PACKAGE BODY                        INVALID 29/12/2012 00:56:59
SYS        DBMS_RULE_INTERNAL             PACKAGE                             INVALID 29/12/2012 03:38:14
SYS        DBMS_RULE_INTERNAL             PACKAGE BODY                        INVALID 29/12/2012 03:38:14
SYS        DBMS_SCHEDULER                 PACKAGE BODY                        INVALID 15/04/2012 01:18:20
SYS        DBMS_SCHED_ATTRIBUTE_EXPORT    PACKAGE                             INVALID 31/10/2012 01:50:37

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        DBMS_SCHED_ATTRIBUTE_EXPORT    PACKAGE BODY                        INVALID 31/10/2012 01:50:37
SYS        DBMS_SCHED_CHAIN_EXPORT        PACKAGE                             INVALID 31/10/2012 01:50:37
SYS        DBMS_SCHED_CHAIN_EXPORT        PACKAGE BODY                        INVALID 31/10/2012 01:50:37
SYS        DBMS_SCHED_CLASS_EXPORT        PACKAGE BODY                        INVALID 31/10/2012 01:50:36
SYS        DBMS_SCHED_CLASS_EXPORT        PACKAGE                             INVALID 31/10/2012 01:50:36
SYS        DBMS_SCHED_CREDENTIAL_EXPORT   PACKAGE BODY                        INVALID 31/10/2012 01:50:37
SYS        DBMS_SCHED_CREDENTIAL_EXPORT   PACKAGE                             INVALID 31/10/2012 01:50:37
SYS        DBMS_SCHED_EXPORT_CALLOUTS     PACKAGE BODY                        INVALID 31/10/2012 01:50:38
SYS        DBMS_SCHED_EXPORT_CALLOUTS     PACKAGE                             INVALID 31/10/2012 01:50:37
SYS        DBMS_SCHED_FILE_WATCHER_EXPORT PACKAGE                             INVALID 31/10/2012 01:50:37
SYS        DBMS_SCHED_FILE_WATCHER_EXPORT PACKAGE BODY                        INVALID 31/10/2012 01:50:37
SYS        DBMS_SCHED_JOB_EXPORT          PACKAGE BODY                        INVALID 31/10/2012 01:50:36
SYS        DBMS_SCHED_JOB_EXPORT          PACKAGE                             INVALID 31/10/2012 01:50:35
SYS        DBMS_SCHED_MAIN_EXPORT         PACKAGE BODY                        INVALID 31/10/2012 01:50:35
SYS        DBMS_SCHED_MAIN_EXPORT         PACKAGE                             INVALID 31/10/2012 01:50:34
SYS        DBMS_SCHED_PROGRAM_EXPORT      PACKAGE BODY                        INVALID 31/10/2012 01:50:35
SYS        DBMS_SCHED_PROGRAM_EXPORT      PACKAGE                             INVALID 31/10/2012 01:50:35
SYS        DBMS_SCHED_SCHEDULE_EXPORT     PACKAGE                             INVALID 31/10/2012 01:50:36
SYS        DBMS_SCHED_SCHEDULE_EXPORT     PACKAGE BODY                        INVALID 31/10/2012 01:50:36
SYS        DBMS_SCHED_WINDOW_EXPORT       PACKAGE                             INVALID 31/10/2012 01:50:36
SYS        DBMS_SCHED_WINDOW_EXPORT       PACKAGE BODY                        INVALID 31/10/2012 01:50:36
SYS        DBMS_SCHED_WINGRP_EXPORT       PACKAGE BODY                        INVALID 31/10/2012 01:50:36
SYS        DBMS_SCHED_WINGRP_EXPORT       PACKAGE                             INVALID 31/10/2012 01:50:36
SYS        DBMS_SERVER_ALERT              PACKAGE BODY                        INVALID 31/10/2012 00:53:18
SYS        DBMS_SERVER_ALERT_EXPORT       PACKAGE                             INVALID 31/10/2012 01:50:43
SYS        DBMS_SERVER_ALERT_EXPORT       PACKAGE BODY                        INVALID 31/10/2012 01:50:43
SYS        DBMS_SERVER_ALERT_PRVT         PACKAGE BODY                        INVALID 31/10/2012 00:53:19
SYS        DBMS_SERVER_TRACE              PACKAGE BODY                        INVALID 31/10/2012 02:36:41
SYS        DBMS_SERVER_TRACE              PACKAGE                             INVALID 31/10/2012 01:50:26
SYS        DBMS_SERVICE                   PACKAGE BODY                        INVALID 31/10/2012 02:36:42
SYS        DBMS_SERVICE                   PACKAGE                             INVALID 31/10/2012 01:50:27
SYS        DBMS_SESSION                   PACKAGE BODY                        INVALID 30/10/2012 21:47:31
SYS        DBMS_SESSION_STATE             PACKAGE                             INVALID 31/10/2012 01:50:31
SYS        DBMS_SESSION_STATE             PACKAGE BODY                        INVALID 31/10/2012 02:36:47
SYS        DBMS_SHARED_POOL               PACKAGE                             INVALID 31/10/2012 00:26:20
SYS        DBMS_SHARED_POOL               PACKAGE BODY                        INVALID 31/10/2012 00:26:21
SYS        DBMS_SMB                       PACKAGE BODY                        INVALID 31/10/2012 01:52:04
SYS        DBMS_SNAPSHOT                  PACKAGE                             INVALID 29/12/2012 10:26:27
SYS        DBMS_SNAPSHOT                  PACKAGE BODY                        INVALID 29/12/2012 03:38:16
SYS        DBMS_SNAPSHOT_UTL              PACKAGE                             INVALID 30/10/2012 22:12:10
SYS        DBMS_SNAPSHOT_UTL              PACKAGE BODY                        INVALID 30/10/2012 22:12:16
SYS        DBMS_SNAP_INTERNAL             PACKAGE                             INVALID 30/10/2012 22:12:12
SYS        DBMS_SNAP_INTERNAL             PACKAGE BODY                        INVALID 30/10/2012 22:12:19
SYS        DBMS_SNAP_REPAPI               PACKAGE                             INVALID 30/10/2012 22:12:14
SYS        DBMS_SNAP_REPAPI               PACKAGE BODY                        INVALID 30/10/2012 22:12:15
SYS        DBMS_SPACE                     PACKAGE BODY                        INVALID 14/11/2012 21:26:04
SYS        DBMS_SPACE                     PACKAGE                             INVALID 30/10/2012 21:45:35
SYS        DBMS_SPM                       PACKAGE BODY                        INVALID 31/10/2012 01:52:03
SYS        DBMS_SQLDIAG                   PACKAGE BODY                        INVALID 31/10/2012 01:47:43
SYS        DBMS_SQLDIAG_INTERNAL          PACKAGE                             INVALID 29/12/2012 03:38:16
SYS        DBMS_SQLDIAG_INTERNAL          PACKAGE BODY                        INVALID 29/12/2012 03:38:16
SYS        DBMS_SQLHASH                   PACKAGE BODY                        INVALID 31/10/2012 02:07:41
SYS        DBMS_SQLHASH                   PACKAGE                             INVALID 31/10/2012 01:50:22
SYS        DBMS_SQLJTYPE                  PACKAGE                             INVALID 30/10/2012 22:19:25
SYS        DBMS_SQLJTYPE                  PACKAGE BODY                        INVALID 30/10/2012 22:19:25
SYS        DBMS_SQLPA                     PACKAGE                             INVALID 29/12/2012 03:38:16
SYS        DBMS_SQLPA                     PACKAGE BODY                        INVALID 29/12/2012 03:38:16
SYS        DBMS_SQLPLUS_SCRIPT            PACKAGE BODY                        INVALID 31/10/2012 02:07:40
SYS        DBMS_SQLPLUS_SCRIPT            PACKAGE                             INVALID 31/10/2012 02:07:40
SYS        DBMS_SQLTCB_INTERNAL           PACKAGE BODY                        INVALID 29/12/2012 03:38:17
SYS        DBMS_SQLTCB_INTERNAL           PACKAGE                             INVALID 29/12/2012 03:38:17
SYS        DBMS_SQLTUNE                   PACKAGE BODY                        INVALID 04/01/2013 03:29:45
SYS        DBMS_SQLTUNE_INTERNAL          PACKAGE BODY                        INVALID 31/10/2012 00:53:44
SYS        DBMS_SQLTUNE_UTIL0             PACKAGE                             INVALID 04/01/2013 03:29:45
SYS        DBMS_SQLTUNE_UTIL0             PACKAGE BODY                        INVALID 29/12/2012 03:38:17
SYS        DBMS_SQLTUNE_UTIL1             PACKAGE BODY                        INVALID 31/10/2012 01:51:57
SYS        DBMS_SQLTUNE_UTIL2             PACKAGE BODY                        INVALID 14/11/2012 21:11:43
SYS        DBMS_STATS                     PACKAGE BODY                        INVALID 04/01/2013 03:29:46
SYS        DBMS_STATS_INTERNAL            PACKAGE BODY                        INVALID 29/12/2012 03:38:17
SYS        DBMS_STATS_INTERNAL            PACKAGE                             INVALID 04/01/2013 03:29:48
SYS        DBMS_STAT_FUNCS                PACKAGE                             INVALID 31/10/2012 01:50:18
SYS        DBMS_STAT_FUNCS                PACKAGE BODY                        INVALID 31/10/2012 02:07:39
SYS        DBMS_STAT_FUNCS_AUX            PACKAGE                             INVALID 31/10/2012 02:07:36
SYS        DBMS_STAT_FUNCS_AUX            PACKAGE BODY                        INVALID 31/10/2012 02:07:37
SYS        DBMS_STORAGE_MAP               PACKAGE                             INVALID 30/10/2012 23:18:06
SYS        DBMS_STORAGE_MAP               PACKAGE BODY                        INVALID 31/10/2012 00:07:01
SYS        DBMS_STREAMS                   PACKAGE                             INVALID 29/12/2012 03:38:19
SYS        DBMS_STREAMS                   PACKAGE BODY                        INVALID 29/12/2012 03:38:19
SYS        DBMS_STREAMS_ADM               PACKAGE                             INVALID 29/12/2012 03:38:20
SYS        DBMS_STREAMS_ADM               PACKAGE BODY                        INVALID 29/12/2012 03:40:54
SYS        DBMS_STREAMS_ADM_UTL           PACKAGE                             INVALID 29/12/2012 03:40:54
SYS        DBMS_STREAMS_ADM_UTL           PACKAGE BODY                        INVALID 29/12/2012 03:48:41
SYS        DBMS_STREAMS_ADM_UTL_INT       PACKAGE                             INVALID 31/10/2012 01:52:09
SYS        DBMS_STREAMS_ADM_UTL_INVOK     PACKAGE BODY                        INVALID 29/12/2012 03:48:41
SYS        DBMS_STREAMS_ADM_UTL_INVOK     PACKAGE                             INVALID 29/12/2012 03:48:41
SYS        DBMS_STREAMS_ADVISOR_ADM       PACKAGE BODY                        INVALID 31/10/2012 01:52:05
SYS        DBMS_STREAMS_ADVISOR_ADM       PACKAGE                             INVALID 31/10/2012 01:52:05
SYS        DBMS_STREAMS_ADV_ADM_UTL       PACKAGE                             INVALID 15/04/2012 01:47:45
SYS        DBMS_STREAMS_ADV_ADM_UTL       PACKAGE BODY                        INVALID 31/10/2012 01:27:10
SYS        DBMS_STREAMS_ADV_ADM_UTL_INVOK PACKAGE                             INVALID 31/10/2012 01:52:09
SYS        DBMS_STREAMS_ADV_ADM_UTL_INVOK PACKAGE BODY                        INVALID 31/10/2012 01:52:10
SYS        DBMS_STREAMS_AUTH              PACKAGE                             INVALID 31/10/2012 01:52:04
SYS        DBMS_STREAMS_AUTH              PACKAGE BODY                        INVALID 31/10/2012 01:52:05
SYS        DBMS_STREAMS_AUTO_INT          PACKAGE BODY                        INVALID 31/10/2012 01:27:12
SYS        DBMS_STREAMS_AUTO_INT          PACKAGE                             INVALID 15/04/2012 01:47:44
SYS        DBMS_STREAMS_CDC_ADM           PACKAGE                             INVALID 31/10/2012 01:52:10
SYS        DBMS_STREAMS_CDC_ADM           PACKAGE BODY                        INVALID 31/10/2012 01:52:10

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        DBMS_STREAMS_CONTROL_ADM       PACKAGE BODY                        INVALID 31/10/2012 01:52:09
SYS        DBMS_STREAMS_CONTROL_ADM       PACKAGE                             INVALID 07/12/2012 03:28:55
SYS        DBMS_STREAMS_DATAPUMP          PACKAGE BODY                        INVALID 31/10/2012 01:52:35
SYS        DBMS_STREAMS_DATAPUMP          PACKAGE                             INVALID 31/10/2012 01:52:35
SYS        DBMS_STREAMS_DATAPUMP_UTIL     PACKAGE                             INVALID 15/04/2012 01:48:00
SYS        DBMS_STREAMS_DATAPUMP_UTIL     PACKAGE BODY                        INVALID 31/10/2012 01:27:06
SYS        DBMS_STREAMS_DECL              PACKAGE                             INVALID 15/04/2012 01:43:56
SYS        DBMS_STREAMS_HANDLER_ADM       PACKAGE                             INVALID 15/04/2012 01:47:42
SYS        DBMS_STREAMS_HANDLER_ADM       PACKAGE BODY                        INVALID 31/10/2012 01:27:13
SYS        DBMS_STREAMS_HANDLER_INTERNAL  PACKAGE                             INVALID 15/04/2012 01:47:44
SYS        DBMS_STREAMS_HANDLER_INTERNAL  PACKAGE BODY                        INVALID 31/10/2012 01:27:14
SYS        DBMS_STREAMS_LCR_INT           PACKAGE BODY                        INVALID 29/12/2012 03:48:42
SYS        DBMS_STREAMS_LCR_INT           PACKAGE                             INVALID 29/12/2012 03:48:42
SYS        DBMS_STREAMS_MC                PACKAGE BODY                        INVALID 29/12/2012 03:48:42
SYS        DBMS_STREAMS_MC                PACKAGE                             INVALID 29/12/2012 03:48:42
SYS        DBMS_STREAMS_MC_INV            PACKAGE BODY                        INVALID 31/10/2012 01:52:12
SYS        DBMS_STREAMS_MC_INV            PACKAGE                             INVALID 31/10/2012 01:52:12
SYS        DBMS_STREAMS_MESSAGING         PACKAGE BODY                        INVALID 29/12/2012 03:48:43
SYS        DBMS_STREAMS_MESSAGING         PACKAGE                             INVALID 29/12/2012 03:48:43
SYS        DBMS_STREAMS_MT                PACKAGE                             INVALID 29/12/2012 03:48:43
SYS        DBMS_STREAMS_MT                PACKAGE BODY                        INVALID 29/12/2012 03:48:46
SYS        DBMS_STREAMS_PUB_RPC           PACKAGE BODY                        INVALID 31/10/2012 01:52:10
SYS        DBMS_STREAMS_PUB_RPC           PACKAGE                             INVALID 31/10/2012 01:52:10
SYS        DBMS_STREAMS_RPC               PACKAGE BODY                        INVALID 31/10/2012 01:27:05
SYS        DBMS_STREAMS_RPC               PACKAGE                             INVALID 15/04/2012 02:15:27
SYS        DBMS_STREAMS_RPC_INTERNAL      PACKAGE                             INVALID 31/10/2012 01:52:10
SYS        DBMS_STREAMS_RPC_INTERNAL      PACKAGE BODY                        INVALID 31/10/2012 01:52:10
SYS        DBMS_STREAMS_SM                PACKAGE                             INVALID 15/04/2012 01:47:43
SYS        DBMS_STREAMS_SM                PACKAGE BODY                        INVALID 31/10/2012 01:27:08
SYS        DBMS_STREAMS_TABLESPACE_ADM    PACKAGE                             INVALID 15/04/2012 01:47:41
SYS        DBMS_STREAMS_TABLESPACE_ADM    PACKAGE BODY                        INVALID 31/10/2012 01:27:07
SYS        DBMS_STREAMS_TBS_INT           PACKAGE                             INVALID 15/04/2012 01:48:31
SYS        DBMS_STREAMS_TBS_INT           PACKAGE BODY                        INVALID 31/10/2012 01:27:06
SYS        DBMS_STREAMS_TBS_INT_INVOK     PACKAGE BODY                        INVALID 29/12/2012 03:48:46
SYS        DBMS_STREAMS_TBS_INT_INVOK     PACKAGE                             INVALID 29/12/2012 03:48:46
SYS        DBMS_SUMMARY                   PACKAGE                             INVALID 30/10/2012 22:11:57
SYS        DBMS_SUMMARY                   PACKAGE BODY                        INVALID 30/10/2012 22:12:21
SYS        DBMS_SUMREF_UTIL               PACKAGE BODY                        INVALID 30/10/2012 22:12:20
SYS        DBMS_SUMREF_UTIL               PACKAGE                             INVALID 30/10/2012 22:12:20
SYS        DBMS_SUMVDM                    PACKAGE                             INVALID 30/10/2012 22:12:21
SYS        DBMS_SUMVDM                    PACKAGE BODY                        INVALID 30/10/2012 22:12:22
SYS        DBMS_SUM_RWEQ_EXPORT           PACKAGE                             INVALID 31/10/2012 01:52:36
SYS        DBMS_SUM_RWEQ_EXPORT           PACKAGE BODY                        INVALID 31/10/2012 01:52:39
SYS        DBMS_SUM_RWEQ_EXPORT_INTERNAL  PACKAGE BODY                        INVALID 31/10/2012 01:52:36
SYS        DBMS_SUM_RWEQ_EXPORT_INTERNAL  PACKAGE                             INVALID 31/10/2012 01:52:35
SYS        DBMS_SUPPORT                   PACKAGE BODY                        INVALID 31/10/2012 01:48:41
SYS        DBMS_SUPPORT                   PACKAGE                             INVALID 31/10/2012 01:48:41
SYS        DBMS_SWRF_INTERNAL             PACKAGE BODY                        INVALID 04/01/2013 20:09:55
SYS        DBMS_SWRF_REPORT_INTERNAL      PACKAGE BODY                        INVALID 29/12/2012 00:57:11
SYS        DBMS_SWRF_REPORT_INTERNAL      PACKAGE                             INVALID 29/12/2012 00:57:11
SYS        DBMS_SYS_ERROR                 PACKAGE BODY                        INVALID 30/10/2012 21:47:42
SYS        DBMS_TDB                       PACKAGE                             INVALID 31/10/2012 01:50:21
SYS        DBMS_TDB                       PACKAGE BODY                        INVALID 31/10/2012 01:50:22
SYS        DBMS_TDE_TOOLKIT               PACKAGE                             INVALID 31/10/2012 01:50:42
SYS        DBMS_TDE_TOOLKIT               PACKAGE BODY                        INVALID 31/10/2012 01:50:42
SYS        DBMS_TDE_TOOLKIT_FFI           PACKAGE                             INVALID 31/10/2012 01:50:42
SYS        DBMS_TDE_TOOLKIT_FFI           PACKAGE BODY                        INVALID 31/10/2012 01:50:42
SYS        DBMS_TRACE                     PACKAGE BODY                        INVALID 30/10/2012 22:12:24
SYS        DBMS_TRACE                     PACKAGE                             INVALID 30/10/2012 22:12:24
SYS        DBMS_TRANSACTION_INTERNAL_SYS  PACKAGE BODY                        INVALID 30/10/2012 21:47:32
SYS        DBMS_TRANSFORM                 PACKAGE BODY                        INVALID 30/10/2012 21:48:39
SYS        DBMS_TRANSFORM                 PACKAGE                             INVALID 30/10/2012 21:48:37
SYS        DBMS_TRANSFORM_EXIMP           PACKAGE                             INVALID 30/10/2012 21:48:37
SYS        DBMS_TRANSFORM_EXIMP           PACKAGE BODY                        INVALID 30/10/2012 21:48:39
SYS        DBMS_TRANSFORM_EXIMP_INTERNAL  PACKAGE                             INVALID 15/04/2012 01:47:24
SYS        DBMS_TRANSFORM_EXIMP_INTERNAL  PACKAGE BODY                        INVALID 31/10/2012 02:36:47
SYS        DBMS_TRANSFORM_INTERNAL        PACKAGE                             INVALID 15/04/2012 01:47:23
SYS        DBMS_TRANSFORM_INTERNAL        PACKAGE BODY                        INVALID 31/10/2012 02:36:47
SYS        DBMS_TTS                       PACKAGE BODY                        INVALID 30/10/2012 22:12:41
SYS        DBMS_TTS                       PACKAGE                             INVALID 30/10/2012 22:12:38
SYS        DBMS_TYPE_UTILITY              PACKAGE                             INVALID 30/10/2012 22:19:08
SYS        DBMS_TYPE_UTILITY              PACKAGE BODY                        INVALID 30/10/2012 22:19:08
SYS        DBMS_UADV_ARR                  TYPE                                INVALID 31/10/2012 00:11:14
SYS        DBMS_UNDO_ADV                  PACKAGE BODY                        INVALID 31/10/2012 01:52:01
SYS        DBMS_UNDO_ADV                  PACKAGE                             INVALID 31/10/2012 01:52:01
SYS        DBMS_WARNING                   PACKAGE BODY                        INVALID 31/10/2012 01:50:04
SYS        DBMS_WARNING                   PACKAGE                             INVALID 31/10/2012 01:50:04
SYS        DBMS_WARNING_INTERNAL          PACKAGE                             INVALID 31/10/2012 01:50:04
SYS        DBMS_WARNING_INTERNAL          PACKAGE BODY                        INVALID 31/10/2012 01:50:05
SYS        DBMS_WLM                       PACKAGE BODY                        INVALID 31/10/2012 02:36:45
SYS        DBMS_WLM                       PACKAGE                             INVALID 31/10/2012 01:50:33
SYS        DBMS_WORKLOAD_CAPTURE          PACKAGE BODY                        INVALID 31/10/2012 01:49:58
SYS        DBMS_WORKLOAD_CAPTURE          PACKAGE                             INVALID 31/10/2012 01:49:57
SYS        DBMS_WORKLOAD_REPLAY           PACKAGE BODY                        INVALID 31/10/2012 01:52:00
SYS        DBMS_WORKLOAD_REPOSITORY       PACKAGE BODY                        INVALID 31/10/2012 00:53:33
SYS        DBMS_WRR_INTERNAL              PACKAGE                             INVALID 29/12/2012 03:48:46
SYS        DBMS_WRR_INTERNAL              PACKAGE BODY                        INVALID 29/12/2012 03:48:47
SYS        DBMS_XA                        PACKAGE BODY                        INVALID 31/10/2012 02:07:40
SYS        DBMS_XA                        PACKAGE                             INVALID 31/10/2012 01:50:21
SYS        DBMS_XA_XID                    TYPE                                INVALID 31/10/2012 00:10:24
SYS        DBMS_XA_XID                    TYPE BODY                           INVALID 14/11/2012 22:33:31
SYS        DBMS_XA_XID_ARRAY              TYPE                                INVALID 31/10/2012 00:10:25
SYS        DBMS_XDS                       PACKAGE                             INVALID 31/10/2012 01:50:22
SYS        DBMS_XDS                       PACKAGE BODY                        INVALID 31/10/2012 02:07:40
SYS        DBMS_XDSUTL                    PACKAGE BODY                        INVALID 31/10/2012 02:07:41
SYS        DBMS_XDSUTL                    PACKAGE                             INVALID 31/10/2012 01:50:22
SYS        DBMS_XMLGEN                    PACKAGE BODY                        INVALID 30/10/2012 22:14:10

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        DBMS_XMLQUERY                  PACKAGE                             INVALID 31/10/2012 00:07:24
SYS        DBMS_XMLQUERY                  PACKAGE BODY                        INVALID 31/10/2012 00:07:25
SYS        DBMS_XMLSAVE                   PACKAGE BODY                        INVALID 31/10/2012 00:07:25
SYS        DBMS_XMLSAVE                   PACKAGE                             INVALID 31/10/2012 00:07:25
SYS        DBMS_XMLSTORE                  PACKAGE BODY                        INVALID 31/10/2012 02:07:41
SYS        DBMS_XPLAN                     PACKAGE BODY                        INVALID 29/12/2012 03:48:48
SYS        DBMS_XPLAN                     PACKAGE                             INVALID 30/12/2012 03:36:19
SYS        DBMS_XPLAN_TYPE                TYPE                                INVALID 14/04/2012 10:48:28
SYS        DBMS_XPLAN_TYPE_TABLE          TYPE                                INVALID 16/09/2007 01:06:26
SYS        DBMS_XQUERY                    PACKAGE                             INVALID 29/12/2012 03:48:48
SYS        DBMS_XQUERY                    PACKAGE BODY                        INVALID 29/12/2012 03:48:48
SYS        DBMS_XQUERYINT                 PACKAGE BODY                        INVALID 29/12/2012 03:48:48
SYS        DBMS_XQUERYINT                 PACKAGE                             INVALID 29/12/2012 03:48:48
SYS        DBMS_XRWMV                     PACKAGE                             INVALID 29/12/2012 00:57:19
SYS        DBMS_XRWMV                     PACKAGE BODY                        INVALID 29/12/2012 00:57:19
SYS        DBMS_XSTREAM_ADM               PACKAGE BODY                        INVALID 29/12/2012 03:48:48
SYS        DBMS_XSTREAM_ADM               PACKAGE                             INVALID 29/12/2012 03:48:48
SYS        DBMS_XSTREAM_ADM_INTERNAL      PACKAGE                             INVALID 15/04/2012 01:47:46
SYS        DBMS_XSTREAM_ADM_INTERNAL      PACKAGE BODY                        INVALID 31/10/2012 01:47:41
SYS        DBMS_XSTREAM_ADM_UTL           PACKAGE                             INVALID 29/12/2012 03:48:49
SYS        DBMS_XSTREAM_ADM_UTL           PACKAGE BODY                        INVALID 15/04/2012 03:17:13
SYS        DBMS_XSTREAM_AUTH              PACKAGE                             INVALID 31/10/2012 01:52:07
SYS        DBMS_XSTREAM_AUTH              PACKAGE BODY                        INVALID 31/10/2012 01:52:07
SYS        DBMS_XSTREAM_GG                PACKAGE                             INVALID 31/10/2012 01:52:12
SYS        DBMS_XSTREAM_GG                PACKAGE BODY                        INVALID 31/10/2012 01:52:12
SYS        DBMS_XSTREAM_GG_ADM            PACKAGE                             INVALID 29/12/2012 03:57:05
SYS        DBMS_XSTREAM_GG_ADM            PACKAGE BODY                        INVALID 29/12/2012 03:57:05
SYS        DBMS_XSTREAM_UTL_IVK           PACKAGE BODY                        INVALID 29/12/2012 03:57:06
SYS        DBMS_XSTREAM_UTL_IVK           PACKAGE                             INVALID 29/12/2012 03:57:05
SYS        DBMS_XS_DATA_SECURITY_EVENTS   PACKAGE                             INVALID 31/10/2012 01:50:18
SYS        DBMS_XS_DATA_SECURITY_EVENTS   PACKAGE BODY                        INVALID 31/10/2012 01:50:18
SYS        DBMS_XS_MTCACHE                PACKAGE                             INVALID 31/10/2012 01:50:17
SYS        DBMS_XS_MTCACHE                PACKAGE BODY                        INVALID 31/10/2012 01:50:17
SYS        DBMS_XS_MTCACHE_FFI            PACKAGE                             INVALID 31/10/2012 01:50:17
SYS        DBMS_XS_MTCACHE_FFI            PACKAGE BODY                        INVALID 31/10/2012 01:50:17
SYS        DBMS_XS_PRINCIPALS             PACKAGE BODY                        INVALID 31/10/2012 01:50:17
SYS        DBMS_XS_PRINCIPALS             PACKAGE                             INVALID 31/10/2012 01:50:16
SYS        DBMS_XS_PRINCIPALS_INT         PACKAGE                             INVALID 29/12/2012 03:57:07
SYS        DBMS_XS_PRINCIPALS_INT         PACKAGE BODY                        INVALID 29/12/2012 03:57:07
SYS        DBMS_XS_PRINCIPAL_EVENTS_INT   PACKAGE                             INVALID 31/10/2012 01:50:18
SYS        DBMS_XS_PRINCIPAL_EVENTS_INT   PACKAGE BODY                        INVALID 31/10/2012 01:50:18
SYS        DBMS_XS_PRIVID_LIST            TYPE                                INVALID 31/10/2012 00:40:16
SYS        DBMS_XS_ROLELIST               TYPE                                INVALID 31/10/2012 00:40:14
SYS        DBMS_XS_ROLESET_EVENTS_INT     PACKAGE                             INVALID 31/10/2012 01:50:17
SYS        DBMS_XS_ROLESET_EVENTS_INT     PACKAGE BODY                        INVALID 31/10/2012 01:50:17
SYS        DBMS_XS_SECCLASS_EVENTS        PACKAGE                             INVALID 31/10/2012 01:50:19
SYS        DBMS_XS_SECCLASS_EVENTS        PACKAGE BODY                        INVALID 31/10/2012 01:50:19
SYS        DBMS_XS_SECCLASS_INT           PACKAGE BODY                        INVALID 31/10/2012 02:36:44
SYS        DBMS_XS_SECCLASS_INT           PACKAGE                             INVALID 31/10/2012 02:36:43
SYS        DBMS_XS_SECCLASS_INT_FFI       PACKAGE                             INVALID 31/10/2012 02:36:43
SYS        DBMS_XS_SECCLASS_INT_FFI       PACKAGE BODY                        INVALID 31/10/2012 02:36:44
SYS        DBMS_XS_SESSIONS               PACKAGE                             INVALID 31/10/2012 02:36:42
SYS        DBMS_XS_SESSIONS               PACKAGE BODY                        INVALID 31/10/2012 02:36:43
SYS        DBMS_XS_SESSIONS_FFI           PACKAGE                             INVALID 31/10/2012 02:36:42
SYS        DBMS_XS_SESSIONS_FFI           PACKAGE BODY                        INVALID 31/10/2012 02:36:43
SYS        DBMS_ZHELP                     PACKAGE BODY                        INVALID 30/10/2012 21:47:48
SYS        DBMS_ZHELP                     PACKAGE                             INVALID 30/10/2012 21:47:48
SYS        DBMS_ZHELP_IR                  PACKAGE BODY                        INVALID 30/10/2012 21:47:48
SYS        DBMS_ZHELP_IR                  PACKAGE                             INVALID 30/10/2012 21:47:48
SYS        DBURITYPE                      TYPE BODY                           INVALID 29/12/2012 04:08:13
SYS        DB_STARTUP_KEEP                TRIGGER                             INVALID 30/10/2012 23:59:55
SYS        DDL_LCR85_T                    TYPE                                INVALID 14/11/2012 22:33:32
SYS        DEFCALL                        VIEW                                INVALID 29/12/2012 09:23:08
SYS        DEFSCHEDULE                    VIEW                                INVALID 29/12/2012 03:06:14
SYS        DES_ENCRYPTED_PASSWORD         FUNCTION                            INVALID 30/10/2012 22:13:40
SYS        DICTIONARY_OBJ_NAME            FUNCTION                            INVALID 30/10/2012 22:13:39
SYS        DICTIONARY_OBJ_NAME_LIST       FUNCTION                            INVALID 30/10/2012 22:13:40
SYS        DICTIONARY_OBJ_OWNER           FUNCTION                            INVALID 30/10/2012 22:13:39
SYS        DICTIONARY_OBJ_OWNER_LIST      FUNCTION                            INVALID 30/10/2012 22:13:40
SYS        DICTIONARY_OBJ_TYPE            FUNCTION                            INVALID 30/10/2012 22:13:39
SYS        DIRNAMESMH                     TYPE                                INVALID 14/11/2012 22:33:33
SYS        DMBANIMP                       TYPE                                INVALID 31/10/2012 00:12:45
SYS        DMBANIMP                       TYPE BODY                           INVALID 14/11/2012 22:33:33
SYS        DMBAO                          TYPE                                INVALID 31/10/2012 00:12:45
SYS        DMBAOS                         TYPE                                INVALID 31/10/2012 00:12:45
SYS        DMBAPIMP                       TYPE                                INVALID 31/10/2012 00:12:46
SYS        DMBAPIMP                       TYPE BODY                           INVALID 14/11/2012 22:33:33
SYS        DMBATIMP                       TYPE BODY                           INVALID 14/11/2012 22:33:34
SYS        DMBATIMP                       TYPE                                INVALID 31/10/2012 00:12:47
SYS        DMBCNIMP                       TYPE BODY                           INVALID 15/11/2012 00:17:52
SYS        DMBCNIMP                       TYPE                                INVALID 15/11/2012 00:17:52
SYS        DMBCO                          TYPE                                INVALID 14/11/2012 22:33:35
SYS        DMBCOS                         TYPE                                INVALID 14/11/2012 22:33:35
SYS        DMBGO                          TYPE                                INVALID 31/10/2012 00:12:45
SYS        DMBGOS                         TYPE                                INVALID 31/10/2012 00:12:45
SYS        DMBMNIMP                       TYPE BODY                           INVALID 14/11/2012 22:33:35
SYS        DMBMNIMP                       TYPE                                INVALID 31/10/2012 00:12:42
SYS        DMBMO                          TYPE                                INVALID 31/10/2012 00:12:42
SYS        DMBMOS                         TYPE                                INVALID 31/10/2012 00:12:42
SYS        DMBMPIMP                       TYPE                                INVALID 31/10/2012 00:12:43
SYS        DMBMPIMP                       TYPE BODY                           INVALID 14/11/2012 22:33:35
SYS        DMBMTIMP                       TYPE                                INVALID 31/10/2012 00:12:44
SYS        DMBMTIMP                       TYPE BODY                           INVALID 14/11/2012 22:33:36
SYS        DMCLAIMP                       TYPE                                INVALID 31/10/2012 01:48:23
SYS        DMCLAIMP                       TYPE BODY                           INVALID 14/11/2012 22:33:36
SYS        DMCLAO                         TYPE                                INVALID 31/10/2012 01:48:23
SYS        DMCLAOS                        TYPE                                INVALID 31/10/2012 01:48:23

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        DMCLBIMP                       TYPE                                INVALID 31/10/2012 01:48:22
SYS        DMCLBIMP                       TYPE BODY                           INVALID 14/11/2012 22:33:36
SYS        DMCLBO                         TYPE                                INVALID 31/10/2012 01:48:22
SYS        DMCLBOS                        TYPE                                INVALID 31/10/2012 01:48:22
SYS        DMGLMBIMP                      TYPE BODY                           INVALID 14/11/2012 22:33:36
SYS        DMGLMBIMP                      TYPE                                INVALID 31/10/2012 01:48:23
SYS        DMGLMBO                        TYPE                                INVALID 31/10/2012 01:48:23
SYS        DMGLMBOS                       TYPE                                INVALID 31/10/2012 01:48:23
SYS        DMMODBIMP                      TYPE                                INVALID 31/10/2012 01:48:21
SYS        DMMODBIMP                      TYPE BODY                           INVALID 14/11/2012 22:33:37
SYS        DMMODBO                        TYPE                                INVALID 31/10/2012 01:48:21
SYS        DMMODBOS                       TYPE                                INVALID 31/10/2012 01:48:21
SYS        DMNMFBIMP                      TYPE BODY                           INVALID 14/11/2012 22:33:37
SYS        DMNMFBIMP                      TYPE                                INVALID 31/10/2012 01:48:20
SYS        DMNMFBO                        TYPE                                INVALID 31/10/2012 01:48:20
SYS        DMNMFBOS                       TYPE                                INVALID 31/10/2012 01:48:20
SYS        DMP_SEC                        PACKAGE BODY                        INVALID 31/10/2012 01:47:53
SYS        DMP_SEC                        PACKAGE                             INVALID 29/12/2012 00:36:25
SYS        DMP_SYS                        PACKAGE                             INVALID 31/10/2012 01:47:51
SYS        DMP_SYS                        PACKAGE BODY                        INVALID 31/10/2012 01:47:55
SYS        DMSVMAIMP                      TYPE                                INVALID 31/10/2012 01:48:20
SYS        DMSVMAIMP                      TYPE BODY                           INVALID 14/11/2012 22:33:37
SYS        DMSVMAO                        TYPE                                INVALID 31/10/2012 01:48:20
SYS        DMSVMAOS                       TYPE                                INVALID 31/10/2012 01:48:20
SYS        DMSVMBIMP                      TYPE                                INVALID 31/10/2012 01:48:19
SYS        DMSVMBIMP                      TYPE BODY                           INVALID 14/11/2012 22:33:37
SYS        DMSVMBO                        TYPE                                INVALID 31/10/2012 01:48:19
SYS        DMSVMBOS                       TYPE                                INVALID 31/10/2012 01:48:19
SYS        DM_CL_APPLY                    FUNCTION                            INVALID 31/10/2012 01:48:23
SYS        DM_CL_BUILD                    FUNCTION                            INVALID 31/10/2012 01:48:22
SYS        DM_CL_CUR                      PACKAGE                             INVALID 31/10/2012 01:48:22
SYS        DM_GLM_BUILD                   FUNCTION                            INVALID 31/10/2012 01:48:23
SYS        DM_GLM_CUR                     PACKAGE                             INVALID 31/10/2012 01:48:23
SYS        DM_MODB_CUR                    PACKAGE                             INVALID 31/10/2012 01:48:21
SYS        DM_MOD_BUILD                   FUNCTION                            INVALID 31/10/2012 01:48:21
SYS        DM_NMF_BUILD                   FUNCTION                            INVALID 31/10/2012 01:48:20
SYS        DM_NMF_CUR                     PACKAGE                             INVALID 31/10/2012 01:48:20
SYS        DM_QGEN                        PACKAGE                             INVALID 31/10/2012 01:47:44
SYS        DM_QGEN                        PACKAGE BODY                        INVALID 31/10/2012 01:47:44
SYS        DM_SVM_APPLY                   FUNCTION                            INVALID 31/10/2012 01:48:20
SYS        DM_SVM_BUILD                   FUNCTION                            INVALID 31/10/2012 01:48:19
SYS        DM_SVM_CUR                     PACKAGE                             INVALID 31/10/2012 01:48:19
SYS        DM_XFORM                       PACKAGE                             INVALID 31/10/2012 01:47:55
SYS        DM_XFORM                       PACKAGE BODY                        INVALID 31/10/2012 01:47:57
SYS        DROPPED_XDB_INSTLL_TRIGGER     TRIGGER                             INVALID 29/12/2012 04:08:08
SYS        FINDOBJ_PKG                    PACKAGE BODY                        INVALID 31/10/2012 00:26:15
SYS        FINDOBJ_PKG                    PACKAGE                             INVALID 31/10/2012 00:26:14
SYS        FLASHBACKTBLIST                TYPE                                INVALID 31/10/2012 00:10:29
SYS        FTPURITYPE                     TYPE BODY                           INVALID 29/12/2012 04:08:13
SYS        GETXMLSCHEMADEPENDENCYLIST     FUNCTION                            INVALID 31/10/2012 01:49:59
SYS        GET_DEP_DT1                    TYPE                                INVALID 14/11/2012 22:33:38
SYS        GET_DEP_DT2                    TYPE                                INVALID 14/11/2012 22:33:38
SYS        GET_ERROR$                     PACKAGE                             INVALID 31/10/2012 01:49:03
SYS        GET_ERROR$                     PACKAGE BODY                        INVALID 31/10/2012 01:49:03
SYS        GET_FIXED_SGA_START            FUNCTION                            INVALID 31/10/2012 00:35:04
SYS        GET_MAX_CHECKPOINT             FUNCTION                            INVALID 29/12/2012 00:16:31
SYS        GET_OLDVERSION_HASHCODE        FUNCTION                            INVALID 31/10/2012 01:52:14
SYS        GET_STATS_EXTENSION            FUNCTION                            INVALID 31/10/2012 01:52:31
SYS        GET_TABLE_NAME                 FUNCTION                            INVALID 31/10/2012 01:49:55
SYS        GRANTEE                        FUNCTION                            INVALID 30/10/2012 22:13:40
SYS        GV_$SQL_BIND_CAPTURE           VIEW                                INVALID 06/12/2012 23:50:48
SYS        HAEN_TXFM_TEXT                 FUNCTION                            INVALID 31/10/2012 01:52:35
SYS        HM_SQLTK_INTERNAL              PACKAGE BODY                        INVALID 31/10/2012 02:36:46
SYS        HM_SQLTK_INTERNAL              PACKAGE                             INVALID 31/10/2012 02:36:45
SYS        HS$_DDTF_SQLCOLUMNS            FUNCTION                            INVALID 31/10/2012 01:48:47
SYS        HS$_DDTF_SQLCOLUMNS_O          TYPE                                INVALID 31/10/2012 01:48:47
SYS        HS$_DDTF_SQLCOLUMNS_T          TYPE                                INVALID 31/10/2012 01:48:47
SYS        HS$_DDTF_SQLFOREIGNKEYS        FUNCTION                            INVALID 31/10/2012 01:48:47
SYS        HS$_DDTF_SQLFOREIGNKEYS_O      TYPE                                INVALID 31/10/2012 01:48:47
SYS        HS$_DDTF_SQLFOREIGNKEYS_T      TYPE                                INVALID 31/10/2012 01:48:47
SYS        HS$_DDTF_SQLPRIMARYKEYS        FUNCTION                            INVALID 31/10/2012 01:48:47
SYS        HS$_DDTF_SQLPRIMARYKEYS_O      TYPE                                INVALID 31/10/2012 01:48:47
SYS        HS$_DDTF_SQLPRIMARYKEYS_T      TYPE                                INVALID 31/10/2012 01:48:47
SYS        HS$_DDTF_SQLPROCEDURES         FUNCTION                            INVALID 31/10/2012 01:48:48
SYS        HS$_DDTF_SQLPROCEDURES_O       TYPE                                INVALID 31/10/2012 01:48:48
SYS        HS$_DDTF_SQLPROCEDURES_T       TYPE                                INVALID 31/10/2012 01:48:48
SYS        HS$_DDTF_SQLSTATISTICS         FUNCTION                            INVALID 31/10/2012 01:48:48
SYS        HS$_DDTF_SQLSTATISTICS_O       TYPE                                INVALID 31/10/2012 01:48:48
SYS        HS$_DDTF_SQLSTATISTICS_T       TYPE                                INVALID 31/10/2012 01:48:48
SYS        HS$_DDTF_SQLTABFORKEYS         FUNCTION                            INVALID 31/10/2012 01:48:49
SYS        HS$_DDTF_SQLTABLES             FUNCTION                            INVALID 31/10/2012 01:48:46
SYS        HS$_DDTF_SQLTABLES_O           TYPE                                INVALID 31/10/2012 01:48:46
SYS        HS$_DDTF_SQLTABLES_T           TYPE                                INVALID 31/10/2012 01:48:46
SYS        HS$_DDTF_SQLTABPRIKEYS         FUNCTION                            INVALID 31/10/2012 01:48:48
SYS        HS$_DDTF_SQLTABSTATS           FUNCTION                            INVALID 31/10/2012 01:48:49
SYS        HSBLKNAMLST                    TYPE                                INVALID 31/10/2012 01:48:49
SYS        HSBLKVALARY                    TYPE                                INVALID 31/10/2012 01:48:49
SYS        HS_PARALLEL_METADATA           VIEW                                INVALID 15/04/2012 01:49:16
SYS        HS_PARALLEL_PARTITION_DATA     VIEW                                INVALID 15/04/2012 01:49:16
SYS        HS_PARTITION_OBJ               TYPE                                INVALID 31/10/2012 01:48:50
SYS        HS_PART_OBJ                    TYPE                                INVALID 31/10/2012 01:48:50
SYS        HS_SAMPLE_OBJ                  TYPE                                INVALID 31/10/2012 01:48:50
SYS        HTF                            PACKAGE BODY                        INVALID 30/10/2012 22:19:11
SYS        HTF                            PACKAGE                             INVALID 30/10/2012 22:19:11
SYS        HTMLDB_SYSTEM                  PACKAGE                             INVALID 31/10/2012 01:50:23
SYS        HTMLDB_SYSTEM                  PACKAGE BODY                        INVALID 31/10/2012 02:07:41
SYS        HTP                            PACKAGE                             INVALID 30/10/2012 22:19:14

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        HTP                            PACKAGE BODY                        INVALID 30/10/2012 22:19:14
SYS        HTTPURITYPE                    TYPE BODY                           INVALID 29/12/2012 04:08:13
SYS        INDEXREBUILDLIST               TYPE                                INVALID 30/10/2012 22:12:00
SYS        INDEXREBUILDRECORD             TYPE                                INVALID 30/10/2012 22:12:00
SYS        INITJVMAUX                     PACKAGE                             INVALID 30/10/2012 23:18:13
SYS        INITJVMAUX                     PACKAGE BODY                        INVALID 31/10/2012 00:07:05
SYS        INSTANCE_NUM                   FUNCTION                            INVALID 30/10/2012 22:13:39
SYS        ISXMLTYPETABLE                 FUNCTION                            INVALID 31/10/2012 01:49:55
SYS        IS_ALTER_COLUMN                FUNCTION                            INVALID 30/10/2012 22:13:40
SYS        IS_CREATING_NESTED_TABLE       FUNCTION                            INVALID 30/10/2012 22:13:40
SYS        IS_DROP_COLUMN                 FUNCTION                            INVALID 30/10/2012 22:13:40
SYS        IS_SERVERERROR                 FUNCTION                            INVALID 30/10/2012 22:13:39
SYS        IS_VPD_ENABLED                 FUNCTION                            INVALID 31/10/2012 01:49:55
SYS        JAVA_XA                        PACKAGE BODY                        INVALID 31/10/2012 01:49:04
SYS        JAVA_XA                        PACKAGE                             INVALID 31/10/2012 01:49:04
SYS        JDM_ATTR_NAMES                 TYPE                                INVALID 31/10/2012 01:49:00
SYS        JDM_NUM_VALS                   TYPE                                INVALID 31/10/2012 01:49:00
SYS        JDM_STR_VALS                   TYPE                                INVALID 31/10/2012 01:48:59
SYS        JOB                            TYPE BODY                           INVALID 29/12/2012 04:08:14
SYS        JOBARG                         TYPE BODY                           INVALID 29/12/2012 04:08:14
SYS        JOBATTR                        TYPE BODY                           INVALID 29/12/2012 04:08:14
SYS        JOB_DEFINITION                 TYPE BODY                           INVALID 29/12/2012 04:08:14
SYS        JVMFCB                         PACKAGE                             INVALID 31/10/2012 01:49:02
SYS        JVMFCB                         PACKAGE BODY                        INVALID 31/10/2012 01:49:02
SYS        JVMRJBC                        PACKAGE                             INVALID 31/10/2012 01:49:03
SYS        JVMRJBC                        PACKAGE BODY                        INVALID 31/10/2012 01:49:03
SYS        KCRV_INTERFACES                PACKAGE                             INVALID 31/10/2012 01:43:35
SYS        KU$_10_1_AUDIT_VIEW            VIEW                                INVALID 29/12/2012 09:38:10
SYS        KU$_10_1_COMMENT_VIEW          VIEW                                INVALID 29/12/2012 09:38:11
SYS        KU$_10_1_DBLINK_VIEW           VIEW                                INVALID 29/12/2012 09:38:11
SYS        KU$_10_1_FHTABLE_VIEW          VIEW                                INVALID 29/12/2012 09:38:12
SYS        KU$_10_1_HISTGRM_MAX_VIEW      VIEW                                INVALID 29/12/2012 09:38:12
SYS        KU$_10_1_HISTGRM_MIN_VIEW      VIEW                                INVALID 29/12/2012 09:38:12
SYS        KU$_10_1_HTABLE_VIEW           VIEW                                INVALID 29/12/2012 09:38:12
SYS        KU$_10_1_IND_STATS_VIEW        VIEW                                INVALID 29/12/2012 09:38:13
SYS        KU$_10_1_IOTABLE_VIEW          VIEW                                INVALID 29/12/2012 09:38:13
SYS        KU$_10_1_PFHTABLE_VIEW         VIEW                                INVALID 29/12/2012 09:38:13
SYS        KU$_10_1_PHTABLE_VIEW          VIEW                                INVALID 29/12/2012 09:38:14
SYS        KU$_10_1_PIND_STATS_VIEW       VIEW                                INVALID 29/12/2012 09:38:14
SYS        KU$_10_1_PIOTABLE_VIEW         VIEW                                INVALID 29/12/2012 09:38:14
SYS        KU$_10_1_PROXY_VIEW            VIEW                                INVALID 29/12/2012 09:38:14
SYS        KU$_10_1_PTAB_COL_STATS_VIEW   VIEW                                INVALID 29/12/2012 09:38:15
SYS        KU$_10_1_PTAB_STATS_VIEW       VIEW                                INVALID 29/12/2012 09:38:15
SYS        KU$_10_1_SPIND_STATS_VIEW      VIEW                                INVALID 29/12/2012 09:38:15
SYS        KU$_10_1_SYSGRANT_VIEW         VIEW                                INVALID 29/12/2012 09:38:15
SYS        KU$_10_1_TABLE_DATA_VIEW       VIEW                                INVALID 29/12/2012 09:38:16
SYS        KU$_10_1_TAB_COL_STATS_VIEW    VIEW                                INVALID 29/12/2012 09:38:16
SYS        KU$_10_1_TAB_ONLY_STATS_VIEW   VIEW                                INVALID 29/12/2012 09:38:16
SYS        KU$_10_1_TAB_STATS_VIEW        VIEW                                INVALID 29/12/2012 09:38:17
SYS        KU$_10_2_FHTABLE_VIEW          VIEW                                INVALID 29/12/2012 09:38:17
SYS        KU$_10_2_INDEX_VIEW            VIEW                                INVALID 29/12/2012 09:38:17
SYS        KU$_10_2_IND_STATS_VIEW        VIEW                                INVALID 29/12/2012 09:38:17
SYS        KU$_10_2_STRMCOLTYPE_VIEW      VIEW                                INVALID 29/12/2012 09:38:17
SYS        KU$_10_2_STRMCOL_VIEW          VIEW                                INVALID 29/12/2012 09:38:18
SYS        KU$_10_2_STRMSUBCOLTYPE_VIEW   VIEW                                INVALID 29/12/2012 09:38:18
SYS        KU$_10_2_STRMTABLE_VIEW        VIEW                                INVALID 29/12/2012 09:38:18
SYS        KU$_10_2_TABLE_DATA_VIEW       VIEW                                INVALID 29/12/2012 09:38:18
SYS        KU$_10_2_TAB_COL_VIEW          VIEW                                INVALID 29/12/2012 09:38:19
SYS        KU$_10_2_TAB_STATS_VIEW        VIEW                                INVALID 29/12/2012 09:38:19
SYS        KU$_10_2_TRIGGER_VIEW          VIEW                                INVALID 29/12/2012 09:38:20
SYS        KU$_11_1_OBJGRANT_VIEW         VIEW                                INVALID 29/12/2012 09:38:20
SYS        KU$_ACPTABLE_VIEW              VIEW                                INVALID 29/12/2012 09:38:20
SYS        KU$_ADD_SNAP_VIEW              VIEW                                INVALID 29/12/2012 09:38:20
SYS        KU$_ALL_INDEX_VIEW             VIEW                                INVALID 29/12/2012 09:38:20
SYS        KU$_ALTER_FUNC_VIEW            VIEW                                INVALID 29/12/2012 09:38:20
SYS        KU$_ALTER_PKGBDY_VIEW          VIEW                                INVALID 29/12/2012 09:38:20
SYS        KU$_ALTER_PKGSPC_VIEW          VIEW                                INVALID 29/12/2012 09:38:20
SYS        KU$_ALTER_PROC_VIEW            VIEW                                INVALID 29/12/2012 09:38:20
SYS        KU$_ARGUMENT_VIEW              VIEW                                INVALID 29/12/2012 09:38:21
SYS        KU$_ASSOC_VIEW                 VIEW                                INVALID 29/12/2012 09:38:21
SYS        KU$_AUDIT_DEFAULT_VIEW         VIEW                                INVALID 29/12/2012 09:38:21
SYS        KU$_AUDIT_OBJ_BASE_VIEW        VIEW                                INVALID 29/12/2012 09:38:21
SYS        KU$_AUDIT_OBJ_VIEW             VIEW                                INVALID 29/12/2012 09:38:21
SYS        KU$_AUDIT_VIEW                 VIEW                                INVALID 29/12/2012 09:38:21
SYS        KU$_BASE_PROC_VIEW             VIEW                                INVALID 29/12/2012 09:38:29
SYS        KU$_BYTES_ALLOC_VIEW           VIEW                                INVALID 29/12/2012 09:38:22
SYS        KU$_CLUSTER_VIEW               VIEW                                INVALID 29/12/2012 09:38:22
SYS        KU$_COLLECTION_VIEW            VIEW                                INVALID 29/12/2012 09:38:22
SYS        KU$_COLTYPE_VIEW               VIEW                                INVALID 29/12/2012 09:38:22
SYS        KU$_COLUMN_VIEW                VIEW                                INVALID 29/12/2012 09:38:22
SYS        KU$_COL_STATS_VIEW             VIEW                                INVALID 29/12/2012 09:38:22
SYS        KU$_COMMENT_VIEW               VIEW                                INVALID 29/12/2012 09:38:23
SYS        KU$_CONSTRAINT0_VIEW           VIEW                                INVALID 29/12/2012 09:38:23
SYS        KU$_CONSTRAINT1_VIEW           VIEW                                INVALID 29/12/2012 09:38:23
SYS        KU$_CONSTRAINT2_VIEW           VIEW                                INVALID 29/12/2012 09:38:23
SYS        KU$_CONSTRAINT_COL_VIEW        VIEW                                INVALID 29/12/2012 09:38:23
SYS        KU$_CONSTRAINT_VIEW            VIEW                                INVALID 29/12/2012 09:38:23
SYS        KU$_CONTEXT_VIEW               VIEW                                INVALID 29/12/2012 09:38:23
SYS        KU$_CUBE_TAB_VIEW              VIEW                                INVALID 29/12/2012 09:38:24
SYS        KU$_DBLINK_VIEW                VIEW                                INVALID 29/12/2012 09:38:24
SYS        KU$_DEFERRED_STG_VIEW          VIEW                                INVALID 29/12/2012 09:38:24
SYS        KU$_DEFROLE_LIST_VIEW          VIEW                                INVALID 29/12/2012 09:38:24
SYS        KU$_DEFROLE_VIEW               VIEW                                INVALID 29/12/2012 09:38:24
SYS        KU$_DEPTABLE_OBJNUM_VIEW       VIEW                                INVALID 29/12/2012 09:38:24
SYS        KU$_DEPTYPES_BASE_VIEW         VIEW                                INVALID 29/12/2012 09:38:24
SYS        KU$_DEPTYPES_VIEW              VIEW                                INVALID 29/12/2012 09:38:25
SYS        KU$_DIMENSION_VIEW             VIEW                                INVALID 29/12/2012 09:38:25

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        KU$_DIRECTORY_VIEW             VIEW                                INVALID 29/12/2012 09:38:25
SYS        KU$_DOMIDX_2NDTAB_VIEW         VIEW                                INVALID 29/12/2012 09:38:25
SYS        KU$_DOMIDX_OBJNUM_VIEW         VIEW                                INVALID 29/12/2012 09:38:25
SYS        KU$_DOMIDX_PLSQL_VIEW          VIEW                                INVALID 29/12/2012 09:38:25
SYS        KU$_DROPCOLLIST                TYPE                                INVALID 31/10/2012 00:10:47
SYS        KU$_DUMMY_COMMAND_RULE_VIEW    VIEW                                INVALID 29/12/2012 09:38:25
SYS        KU$_DUMMY_FACTOR_LINK_VIEW     VIEW                                INVALID 29/12/2012 09:38:25
SYS        KU$_DUMMY_FACTOR_TYPE_VIEW     VIEW                                INVALID 29/12/2012 09:38:26
SYS        KU$_DUMMY_FACTOR_VIEW          VIEW                                INVALID 29/12/2012 09:38:26
SYS        KU$_DUMMY_IDENTITY_MAP_VIEW    VIEW                                INVALID 29/12/2012 09:38:26
SYS        KU$_DUMMY_IDENTITY_VIEW        VIEW                                INVALID 29/12/2012 09:38:26
SYS        KU$_DUMMY_ISRM_VIEW            VIEW                                INVALID 29/12/2012 09:38:26
SYS        KU$_DUMMY_ISR_VIEW             VIEW                                INVALID 29/12/2012 09:38:26
SYS        KU$_DUMMY_REALM_AUTH_VIEW      VIEW                                INVALID 29/12/2012 09:38:26
SYS        KU$_DUMMY_REALM_MEMBER_VIEW    VIEW                                INVALID 29/12/2012 09:38:26
SYS        KU$_DUMMY_REALM_VIEW           VIEW                                INVALID 29/12/2012 09:38:26
SYS        KU$_DUMMY_ROLE_VIEW            VIEW                                INVALID 29/12/2012 09:38:26
SYS        KU$_DUMMY_RULE_SET_MEMBER_VIEW VIEW                                INVALID 29/12/2012 09:38:27
SYS        KU$_DUMMY_RULE_SET_VIEW        VIEW                                INVALID 29/12/2012 09:38:27
SYS        KU$_DUMMY_RULE_VIEW            VIEW                                INVALID 29/12/2012 09:38:27
SYS        KU$_EDITION_OBJ_VIEW           VIEW                                INVALID 29/12/2012 09:38:27
SYS        KU$_EDITION_SCHEMAOBJ_VIEW     VIEW                                INVALID 29/12/2012 09:38:27
SYS        KU$_END_PLUGTS_BLK_VIEW        VIEW                                INVALID 29/12/2012 09:38:27
SYS        KU$_EQNTABLE_BYTES_ALLOC_VIEW  VIEW                                INVALID 29/12/2012 09:38:27
SYS        KU$_EQNTABLE_DATA_VIEW         VIEW                                INVALID 29/12/2012 09:38:27
SYS        KU$_EXP_PKG_BODY_VIEW          VIEW                                INVALID 29/12/2012 09:38:28
SYS        KU$_EXP_TYPE_BODY_VIEW         VIEW                                INVALID 29/12/2012 09:38:28
SYS        KU$_EXP_XMLSCHEMA_VIEW         VIEW                                INVALID 29/12/2012 09:38:28
SYS        KU$_EXTTAB_VIEW                VIEW                                INVALID 29/12/2012 09:38:28
SYS        KU$_FBA_VIEW                   VIEW                                INVALID 29/12/2012 09:38:28
SYS        KU$_FGA_POLICY_VIEW            VIEW                                INVALID 29/12/2012 09:38:28
SYS        KU$_FHTABLE_VIEW               VIEW                                INVALID 29/12/2012 09:38:28
SYS        KU$_FILE_VIEW                  VIEW                                INVALID 29/12/2012 09:38:28
SYS        KU$_FIND_HIDDEN_CONS_VIEW      VIEW                                INVALID 29/12/2012 09:38:28
SYS        KU$_FIND_SGC_COLS_VIEW         VIEW                                INVALID 29/12/2012 09:38:29
SYS        KU$_FIND_SGC_VIEW              VIEW                                INVALID 29/12/2012 09:38:29
SYS        KU$_FIND_SGI_COLS_VIEW         VIEW                                INVALID 29/12/2012 09:38:29
SYS        KU$_FULL_PKG_VIEW              VIEW                                INVALID 29/12/2012 09:38:29
SYS        KU$_FULL_TYPE_VIEW             VIEW                                INVALID 29/12/2012 09:38:29
SYS        KU$_FUNC_VIEW                  VIEW                                INVALID 29/12/2012 09:38:29
SYS        KU$_HDEPTABLE_OBJNUM_VIEW      VIEW                                INVALID 29/12/2012 09:38:30
SYS        KU$_HISTGRM_VIEW               VIEW                                INVALID 29/12/2012 09:38:30
SYS        KU$_HNTP_VIEW                  VIEW                                INVALID 29/12/2012 09:38:30
SYS        KU$_HNT_VIEW                   VIEW                                INVALID 29/12/2012 09:38:30
SYS        KU$_HTABLE_BYTES_ALLOC_VIEW    VIEW                                INVALID 29/12/2012 09:38:30
SYS        KU$_HTABLE_DATA_VIEW           VIEW                                INVALID 29/12/2012 09:38:30
SYS        KU$_HTABLE_OBJNUM_VIEW         VIEW                                INVALID 29/12/2012 09:39:06
SYS        KU$_HTABLE_VIEW                VIEW                                INVALID 29/12/2012 09:38:30
SYS        KU$_HTPART_BYTES_ALLOC_VIEW    VIEW                                INVALID 29/12/2012 09:38:30
SYS        KU$_HTPART_DATA_VIEW           VIEW                                INVALID 29/12/2012 09:38:30
SYS        KU$_HTSPART_BYTES_ALLOC_VIEW   VIEW                                INVALID 29/12/2012 09:38:31
SYS        KU$_HTSPART_DATA_VIEW          VIEW                                INVALID 29/12/2012 09:38:31
SYS        KU$_INC_TYPE_VIEW              VIEW                                INVALID 29/12/2012 09:38:31
SYS        KU$_INDARRAYTYPE_VIEW          VIEW                                INVALID 29/12/2012 09:38:31
SYS        KU$_INDEXOP_VIEW               VIEW                                INVALID 29/12/2012 09:38:31
SYS        KU$_INDEXTYPE_VIEW             VIEW                                INVALID 29/12/2012 09:38:31
SYS        KU$_INDEX_COL_VIEW             VIEW                                INVALID 29/12/2012 09:38:31
SYS        KU$_INDEX_VIEW                 VIEW                                INVALID 29/12/2012 09:38:31
SYS        KU$_IND_CACHE_STATS_VIEW       VIEW                                INVALID 29/12/2012 09:38:32
SYS        KU$_IND_COL_VIEW               VIEW                                INVALID 29/12/2012 09:38:32
SYS        KU$_IND_COMPART_VIEW           VIEW                                INVALID 29/12/2012 09:38:32
SYS        KU$_IND_PARTOBJ_VIEW           VIEW                                INVALID 29/12/2012 09:38:32
SYS        KU$_IND_PART_COL_VIEW          VIEW                                INVALID 29/12/2012 09:38:32
SYS        KU$_IND_PART_VIEW              VIEW                                INVALID 29/12/2012 09:38:32
SYS        KU$_IND_STATS_VIEW             VIEW                                INVALID 29/12/2012 09:38:32
SYS        KU$_IND_SUBNAME_VIEW           VIEW                                INVALID 29/12/2012 09:38:33
SYS        KU$_IND_SUBPART_COL_VIEW       VIEW                                INVALID 29/12/2012 09:38:33
SYS        KU$_IND_SUBPART_VIEW           VIEW                                INVALID 29/12/2012 09:38:33
SYS        KU$_INSERT_TS_VIEW             VIEW                                INVALID 29/12/2012 09:38:33
SYS        KU$_INSTANCE_CALLOUT_VIEW      VIEW                                INVALID 29/12/2012 09:38:33
SYS        KU$_IONT_VIEW                  VIEW                                INVALID 29/12/2012 09:38:33
SYS        KU$_IOTABLE_BYTES_ALLOC_VIEW   VIEW                                INVALID 29/12/2012 09:38:33
SYS        KU$_IOTABLE_DATA_VIEW          VIEW                                INVALID 29/12/2012 09:38:33
SYS        KU$_IOTABLE_VIEW               VIEW                                INVALID 29/12/2012 09:38:34
SYS        KU$_IOTPART_BYTES_ALLOC_VIEW   VIEW                                INVALID 29/12/2012 09:38:34
SYS        KU$_IOTPART_DATA_VIEW          VIEW                                INVALID 29/12/2012 09:38:34
SYS        KU$_IOT_PARTOBJ_VIEW           VIEW                                INVALID 29/12/2012 09:38:34
SYS        KU$_JAVA_CLASS_VIEW            VIEW                                INVALID 29/12/2012 09:38:34
SYS        KU$_JAVA_OBJNUM_VIEW           VIEW                                INVALID 29/12/2012 09:38:34
SYS        KU$_JAVA_RESOURCE_VIEW         VIEW                                INVALID 29/12/2012 09:38:34
SYS        KU$_JAVA_SOURCE_VIEW           VIEW                                INVALID 29/12/2012 09:38:34
SYS        KU$_JIJOIN_TABLE_VIEW          VIEW                                INVALID 29/12/2012 09:38:35
SYS        KU$_JIJOIN_VIEW                VIEW                                INVALID 29/12/2012 09:38:35
SYS        KU$_JOB_VIEW                   VIEW                                INVALID 29/12/2012 09:38:35
SYS        KU$_LIBRARY_VIEW               VIEW                                INVALID 29/12/2012 09:38:35
SYS        KU$_LOBCOMPPART_VIEW           VIEW                                INVALID 29/12/2012 09:38:35
SYS        KU$_LOBFRAGINDEX_VIEW          VIEW                                INVALID 29/12/2012 09:38:35
SYS        KU$_LOBFRAG_VIEW               VIEW                                INVALID 29/12/2012 09:38:36
SYS        KU$_LOBINDEX_VIEW              VIEW                                INVALID 29/12/2012 09:38:36
SYS        KU$_LOB_VIEW                   VIEW                                INVALID 29/12/2012 09:38:36
SYS        KU$_MAP_TABLE_VIEW             VIEW                                INVALID 29/12/2012 09:38:36
SYS        KU$_METHOD_VIEW                VIEW                                INVALID 29/12/2012 09:38:36
SYS        KU$_MONITOR_VIEW               VIEW                                INVALID 29/12/2012 09:38:36
SYS        KU$_MV_DEPTBL_OBJNUM_VIEW      VIEW                                INVALID 29/12/2012 09:38:36
SYS        KU$_M_VIEW_FH_VIEW             VIEW                                INVALID 29/12/2012 09:38:37
SYS        KU$_M_VIEW_H_VIEW              VIEW                                INVALID 29/12/2012 09:38:37
SYS        KU$_M_VIEW_IOT_VIEW            VIEW                                INVALID 29/12/2012 09:38:37

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        KU$_M_VIEW_LOG_FH_VIEW         VIEW                                INVALID 29/12/2012 09:38:37
SYS        KU$_M_VIEW_LOG_H_VIEW          VIEW                                INVALID 29/12/2012 09:38:37
SYS        KU$_M_VIEW_LOG_PFH_VIEW        VIEW                                INVALID 29/12/2012 09:38:37
SYS        KU$_M_VIEW_LOG_PH_VIEW         VIEW                                INVALID 29/12/2012 09:38:37
SYS        KU$_M_VIEW_LOG_VIEW            VIEW                                INVALID 29/12/2012 09:38:37
SYS        KU$_M_VIEW_PFH_VIEW            VIEW                                INVALID 29/12/2012 09:38:37
SYS        KU$_M_VIEW_PH_VIEW             VIEW                                INVALID 29/12/2012 09:38:37
SYS        KU$_M_VIEW_PIOT_VIEW           VIEW                                INVALID 29/12/2012 09:38:37
SYS        KU$_M_VIEW_VIEW                VIEW                                INVALID 29/12/2012 09:38:37
SYS        KU$_NDEPTABLE_OBJNUM_VIEW      VIEW                                INVALID 29/12/2012 09:38:38
SYS        KU$_NTABLE_BYTES_ALLOC_VIEW    VIEW                                INVALID 29/12/2012 09:38:38
SYS        KU$_NTABLE_DATA_VIEW           VIEW                                INVALID 29/12/2012 09:38:38
SYS        KU$_NTABLE_OBJNUM_VIEW         VIEW                                INVALID 29/12/2012 09:38:38
SYS        KU$_NTPART_PARENT_VIEW         VIEW                                INVALID 29/12/2012 09:38:38
SYS        KU$_NTPART_VIEW                VIEW                                INVALID 29/12/2012 09:38:38
SYS        KU$_NT_PARENT_VIEW             VIEW                                INVALID 29/12/2012 09:38:38
SYS        KU$_OBJGRANT_VIEW              VIEW                                INVALID 29/12/2012 09:38:38
SYS        KU$_OBJPKG_VIEW                VIEW                                INVALID 29/12/2012 09:38:38
SYS        KU$_OIDINDEX_VIEW              VIEW                                INVALID 29/12/2012 09:38:38
SYS        KU$_OPANCILLARY_VIEW           VIEW                                INVALID 29/12/2012 09:38:39
SYS        KU$_OPBINDING_VIEW             VIEW                                INVALID 29/12/2012 09:38:39
SYS        KU$_OPERATOR_VIEW              VIEW                                INVALID 29/12/2012 09:38:39
SYS        KU$_OPQTYPE_VIEW               VIEW                                INVALID 29/12/2012 09:38:55
SYS        KU$_OUTLINE_VIEW               VIEW                                INVALID 29/12/2012 09:38:55
SYS        KU$_OV_TABLE_VIEW              VIEW                                INVALID 29/12/2012 09:38:56
SYS        KU$_OV_TABPART_VIEW            VIEW                                INVALID 29/12/2012 09:38:56
SYS        KU$_PARTLOB_VIEW               VIEW                                INVALID 29/12/2012 09:38:56
SYS        KU$_PARTOBJ_VIEW               VIEW                                INVALID 29/12/2012 09:38:56
SYS        KU$_PCOLUMN_VIEW               VIEW                                INVALID 29/12/2012 09:38:56
SYS        KU$_PFHTABLE_VIEW              VIEW                                INVALID 29/12/2012 09:38:56
SYS        KU$_PHTABLE_VIEW               VIEW                                INVALID 29/12/2012 09:38:56
SYS        KU$_PIND_STATS_VIEW            VIEW                                INVALID 29/12/2012 09:38:56
SYS        KU$_PIOTABLE_VIEW              VIEW                                INVALID 29/12/2012 09:38:56
SYS        KU$_PIOTLOBFRAG_VIEW           VIEW                                INVALID 29/12/2012 09:38:56
SYS        KU$_PIOT_PART_VIEW             VIEW                                INVALID 29/12/2012 09:38:56
SYS        KU$_PKGBDY_VIEW                VIEW                                INVALID 29/12/2012 09:38:57
SYS        KU$_PKG_VIEW                   VIEW                                INVALID 29/12/2012 09:38:57
SYS        KU$_PKREF_CONSTRAINT_VIEW      VIEW                                INVALID 29/12/2012 09:38:57
SYS        KU$_PLUGTS_BEGIN_VIEW          VIEW                                INVALID 29/12/2012 09:38:57
SYS        KU$_PLUGTS_BLK_VIEW            VIEW                                INVALID 29/12/2012 09:38:57
SYS        KU$_PLUGTS_CHECKPL_VIEW        VIEW                                INVALID 29/12/2012 09:38:57
SYS        KU$_PLUGTS_TSNAME_INDEXP_VIEW  VIEW                                INVALID 29/12/2012 09:38:57
SYS        KU$_PLUGTS_TSNAME_INDEX_VIEW   VIEW                                INVALID 29/12/2012 09:38:57
SYS        KU$_PLUGTS_TSNAME_TABLE_VIEW   VIEW                                INVALID 29/12/2012 09:38:58
SYS        KU$_PLUGTS_TSNAME_VIEW         VIEW                                INVALID 29/12/2012 09:38:58
SYS        KU$_POST_DATA_TABLE_VIEW       VIEW                                INVALID 29/12/2012 09:38:58
SYS        KU$_POST_TABLE_VIEW            VIEW                                INVALID 29/12/2012 09:38:58
SYS        KU$_PRE_TABLE_VIEW             VIEW                                INVALID 29/12/2012 09:38:58
SYS        KU$_PRIM_COLUMN_VIEW           VIEW                                INVALID 29/12/2012 09:38:58
SYS        KU$_PROCACT_INSTANCE_VIEW      VIEW                                INVALID 29/12/2012 09:38:58
SYS        KU$_PROCACT_SCHEMA_VIEW        VIEW                                INVALID 29/12/2012 09:38:58
SYS        KU$_PROCACT_SYS_VIEW           VIEW                                INVALID 29/12/2012 09:38:59
SYS        KU$_PROCC_VIEW                 VIEW                                INVALID 29/12/2012 09:38:59
SYS        KU$_PROCDEPOBJ_AUDIT_VIEW      VIEW                                INVALID 29/12/2012 09:38:59
SYS        KU$_PROCDEPOBJ_GRANT_VIEW      VIEW                                INVALID 29/12/2012 09:38:59
SYS        KU$_PROCDEPOBJ_VIEW            VIEW                                INVALID 29/12/2012 09:38:59
SYS        KU$_PROCINFO_VIEW              VIEW                                INVALID 29/12/2012 09:38:59
SYS        KU$_PROCJAVA_VIEW              VIEW                                INVALID 29/12/2012 09:38:59
SYS        KU$_PROCOBJACT_T               TYPE                                INVALID 14/11/2012 22:34:33
SYS        KU$_PROCOBJACT_VIEW            VIEW                                INVALID 15/11/2012 03:17:03
SYS        KU$_PROCOBJ_AUDIT_VIEW         VIEW                                INVALID 29/12/2012 09:38:59
SYS        KU$_PROCOBJ_GRANT_VIEW         VIEW                                INVALID 29/12/2012 09:38:59
SYS        KU$_PROCOBJ_OBJNUM_VIEW        VIEW                                INVALID 29/12/2012 09:39:00
SYS        KU$_PROCOBJ_VIEW               VIEW                                INVALID 29/12/2012 09:39:00
SYS        KU$_PROCPLSQL_VIEW             VIEW                                INVALID 29/12/2012 09:39:00
SYS        KU$_PROC_AUDIT_VIEW            VIEW                                INVALID 29/12/2012 09:39:00
SYS        KU$_PROC_GRANT_VIEW            VIEW                                INVALID 29/12/2012 09:39:00
SYS        KU$_PROC_VIEW                  VIEW                                INVALID 29/12/2012 09:39:00
SYS        KU$_PROFILE_ATTR_VIEW          VIEW                                INVALID 29/12/2012 09:39:00
SYS        KU$_PROFILE_VIEW               VIEW                                INVALID 29/12/2012 09:39:00
SYS        KU$_PROXY_ROLE_LIST_VIEW       VIEW                                INVALID 29/12/2012 09:39:00
SYS        KU$_PROXY_VIEW                 VIEW                                INVALID 29/12/2012 09:39:01
SYS        KU$_PSW_HIST_LIST_VIEW         VIEW                                INVALID 29/12/2012 09:39:01
SYS        KU$_PSW_HIST_VIEW              VIEW                                INVALID 29/12/2012 09:39:01
SYS        KU$_PTAB_STATS_VIEW            VIEW                                INVALID 29/12/2012 09:39:01
SYS        KU$_PWDVFC_VIEW                VIEW                                INVALID 29/12/2012 09:39:01
SYS        KU$_QTAB_STORAGE_VIEW          VIEW                                INVALID 29/12/2012 09:39:01
SYS        KU$_QTRANS_VIEW                VIEW                                INVALID 29/12/2012 09:39:01
SYS        KU$_QUEUES_VIEW                VIEW                                INVALID 29/12/2012 09:39:01
SYS        KU$_QUEUE_TABLE_VIEW           VIEW                                INVALID 29/12/2012 09:39:01
SYS        KU$_REFGROUP_VIEW              VIEW                                INVALID 29/12/2012 09:39:02
SYS        KU$_REFPAR_LEVEL               VIEW                                INVALID 29/12/2012 09:39:02
SYS        KU$_REF_CONSTRAINT_VIEW        VIEW                                INVALID 29/12/2012 09:39:02
SYS        KU$_RESOCOST_LIST_VIEW         VIEW                                INVALID 29/12/2012 09:39:02
SYS        KU$_RESOCOST_VIEW              VIEW                                INVALID 29/12/2012 09:39:02
SYS        KU$_RLS_CONTEXT_VIEW           VIEW                                INVALID 29/12/2012 09:39:02
SYS        KU$_RLS_GROUP_VIEW             VIEW                                INVALID 29/12/2012 09:39:02
SYS        KU$_RLS_POLICY_OBJNUM_VIEW     VIEW                                INVALID 29/12/2012 09:39:02
SYS        KU$_RLS_POLICY_VIEW            VIEW                                INVALID 29/12/2012 09:39:02
SYS        KU$_RMGR_CONSUMER_VIEW         VIEW                                INVALID 29/12/2012 09:39:03
SYS        KU$_RMGR_INIT_CONSUMER_VIEW    VIEW                                INVALID 29/12/2012 09:39:03
SYS        KU$_RMGR_PLAN_DIRECT_VIEW      VIEW                                INVALID 29/12/2012 09:39:03
SYS        KU$_RMGR_PLAN_VIEW             VIEW                                INVALID 29/12/2012 09:39:03
SYS        KU$_ROGRANT_VIEW               VIEW                                INVALID 29/12/2012 09:39:03
SYS        KU$_ROLE_VIEW                  VIEW                                INVALID 29/12/2012 09:39:03
SYS        KU$_ROLLBACK_VIEW              VIEW                                INVALID 29/12/2012 09:39:03
SYS        KU$_SCHEMAOBJNUM_VIEW          VIEW                                INVALID 29/12/2012 09:39:03

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        KU$_SCHEMAOBJ_VIEW             VIEW                                INVALID 29/12/2012 09:39:04
SYS        KU$_SCHEMA_CALLOUT_VIEW        VIEW                                INVALID 29/12/2012 09:39:04
SYS        KU$_SEQUENCE_VIEW              VIEW                                INVALID 29/12/2012 09:39:04
SYS        KU$_SGR_SGE_VIEW               VIEW                                INVALID 29/12/2012 09:39:04
SYS        KU$_SIMPLE_COL_VIEW            VIEW                                INVALID 29/12/2012 09:39:04
SYS        KU$_SIMPLE_PKREF_COL_VIEW      VIEW                                INVALID 29/12/2012 09:39:04
SYS        KU$_SIMPLE_SETID_COL_VIEW      VIEW                                INVALID 29/12/2012 09:39:04
SYS        KU$_SIMPLE_TYPE_VIEW           VIEW                                INVALID 29/12/2012 09:39:04
SYS        KU$_SPIND_STATS_VIEW           VIEW                                INVALID 29/12/2012 09:39:04
SYS        KU$_STORAGE_VIEW               VIEW                                INVALID 29/12/2012 09:39:05
SYS        KU$_STRMCOLTYPE_VIEW           VIEW                                INVALID 29/12/2012 09:39:05
SYS        KU$_STRMCOL_VIEW               VIEW                                INVALID 29/12/2012 09:39:05
SYS        KU$_STRMSUBCOLTYPE_VIEW        VIEW                                INVALID 29/12/2012 09:39:05
SYS        KU$_STRMTABLE_VIEW             VIEW                                INVALID 29/12/2012 09:39:05
SYS        KU$_SUBCOLTYPE_VIEW            VIEW                                INVALID 29/12/2012 09:39:05
SYS        KU$_SUBLOBFRAGINDEX_VIEW       VIEW                                INVALID 29/12/2012 09:39:05
SYS        KU$_SUBLOBFRAG_VIEW            VIEW                                INVALID 29/12/2012 09:39:05
SYS        KU$_SWITCH_COMPILER_VIEW       VIEW                                INVALID 29/12/2012 09:39:05
SYS        KU$_SYNONYM_VIEW               VIEW                                INVALID 29/12/2012 09:39:06
SYS        KU$_SYSCALLOUT_VIEW            VIEW                                INVALID 29/12/2012 09:39:06
SYS        KU$_SYSGRANT_VIEW              VIEW                                INVALID 29/12/2012 09:39:06
SYS        KU$_TABCLUSTER_COL_VIEW        VIEW                                INVALID 29/12/2012 09:39:06
SYS        KU$_TABCLUSTER_VIEW            VIEW                                INVALID 29/12/2012 09:39:06
SYS        KU$_TABLESPACE_VIEW            VIEW                                INVALID 29/12/2012 09:39:06
SYS        KU$_TABLE_DATA_VIEW            VIEW                                INVALID 29/12/2012 09:39:06
SYS        KU$_TABLE_OBJNUM_VIEW          VIEW                                INVALID 29/12/2012 09:39:06
SYS        KU$_TABLE_XMLSCHEMA_VIEW       VIEW                                INVALID 29/12/2012 09:39:06
SYS        KU$_TAB_CACHE_STATS_VIEW       VIEW                                INVALID 29/12/2012 09:39:06
SYS        KU$_TAB_COL_VIEW               VIEW                                INVALID 29/12/2012 09:39:07
SYS        KU$_TAB_COMPART_VIEW           VIEW                                INVALID 29/12/2012 09:39:07
SYS        KU$_TAB_ONLY_STATS_VIEW        VIEW                                INVALID 29/12/2012 09:39:07
SYS        KU$_TAB_PARTOBJ_VIEW           VIEW                                INVALID 29/12/2012 09:39:07
SYS        KU$_TAB_PART_COL_VIEW          VIEW                                INVALID 29/12/2012 09:39:07
SYS        KU$_TAB_PART_VIEW              VIEW                                INVALID 29/12/2012 09:39:07
SYS        KU$_TAB_STATS_VIEW             VIEW                                INVALID 29/12/2012 09:39:07
SYS        KU$_TAB_SUBNAME_VIEW           VIEW                                INVALID 29/12/2012 09:39:07
SYS        KU$_TAB_SUBPART_COL_VIEW       VIEW                                INVALID 29/12/2012 09:39:07
SYS        KU$_TAB_SUBPART_VIEW           VIEW                                INVALID 29/12/2012 09:39:07
SYS        KU$_TAB_TSUBPART_VIEW          VIEW                                INVALID 29/12/2012 09:39:07
SYS        KU$_TEMP_SUBPARTDATA_VIEW      VIEW                                INVALID 29/12/2012 09:39:08
SYS        KU$_TEMP_SUBPARTLOBFRG_VIEW    VIEW                                INVALID 29/12/2012 09:39:08
SYS        KU$_TEMP_SUBPARTLOB_VIEW       VIEW                                INVALID 29/12/2012 09:39:08
SYS        KU$_TEMP_SUBPART_VIEW          VIEW                                INVALID 29/12/2012 09:39:08
SYS        KU$_TLOB_COMPPART_VIEW         VIEW                                INVALID 29/12/2012 09:39:08
SYS        KU$_TRIGGERCOL_VIEW            VIEW                                INVALID 29/12/2012 09:39:08
SYS        KU$_TRIGGERDEP_VIEW            VIEW                                INVALID 29/12/2012 09:39:08
SYS        KU$_TRIGGER_VIEW               VIEW                                INVALID 29/12/2012 09:39:08
SYS        KU$_TRLINK_VIEW                VIEW                                INVALID 29/12/2012 09:39:08
SYS        KU$_TSQUOTA_VIEW               VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TTSP_IDX_TABLESPACE_VIEW   VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TTSP_INDPARTVIEW           VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TTSP_INDSUBPARTVIEW        VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TTS_PARTLOBVIEW            VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TTS_SUBPARTLOBVIEW         VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TTS_TABPARTVIEW            VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TTS_TABSUBPARTVIEW         VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TTS_TABVIEW                VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TTS_TAB_TABLESPACE_VIEW    VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TTS_TYPES_VIEW             VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TYPE_ATTR_VIEW             VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TYPE_BODY_VIEW             VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_TYPE_VIEW                  VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_UNLOAD_METHOD_VIEW         VIEW                                INVALID 29/12/2012 09:39:09
SYS        KU$_UP_STATS_VIEW              VIEW                                INVALID 29/12/2012 09:39:10
SYS        KU$_USER_PREF_STATS_VIEW       VIEW                                INVALID 29/12/2012 09:39:10
SYS        KU$_USER_VIEW                  VIEW                                INVALID 29/12/2012 09:39:10
SYS        KU$_VIEW_OBJNUM_VIEW           VIEW                                INVALID 29/12/2012 09:39:10
SYS        KU$_VIEW_VIEW                  VIEW                                INVALID 29/12/2012 09:39:10
SYS        KU$_XDB_NTABLE_OBJNUM_VIEW     VIEW                                INVALID 29/12/2012 09:39:10
SYS        KU$_XMLSCHEMA_ELMT_VIEW        VIEW                                INVALID 29/12/2012 09:39:16
SYS        KU$_XMLSCHEMA_TYPES_VIEW       VIEW                                INVALID 29/12/2012 09:39:16
SYS        KU$_XMLSCHEMA_VIEW             VIEW                                INVALID 29/12/2012 09:39:16
SYS        KUPC$DATAPUMP_QUETAB           TABLE                               INVALID 14/04/2012 17:30:51
SYS        KUPC$DATAPUMP_QUETAB_1         TABLE                               INVALID 20/06/2012 19:28:13
SYS        KUPC$QUEUE                     PACKAGE BODY                        INVALID 29/12/2012 03:57:07
SYS        KUPC$QUEUE                     PACKAGE                             INVALID 29/12/2012 03:57:07
SYS        KUPC$QUEUE_INT                 PACKAGE BODY                        INVALID 29/12/2012 03:57:07
SYS        KUPC$QUEUE_INT                 PACKAGE                             INVALID 29/12/2012 03:57:07
SYS        KUPC$QUE_INT                   PACKAGE                             INVALID 29/12/2012 03:57:07
SYS        KUPC$QUE_INT                   PACKAGE BODY                        INVALID 29/12/2012 03:57:07
SYS        KUPC$_MDFILEPIECE              TYPE                                INVALID 30/10/2012 22:12:35
SYS        KUPC$_MDFILEPIECE              TYPE BODY                           INVALID 14/11/2012 22:34:54
SYS        KUPC$_MDFILEPIECELIST          TYPE                                INVALID 30/10/2012 22:12:35
SYS        KUPC$_MT_INFO                  TYPE                                INVALID 30/10/2012 22:12:28
SYS        KUPC$_MT_INFO_LIST             TYPE                                INVALID 30/10/2012 22:12:28
SYS        KUPCC                          PACKAGE                             INVALID 29/12/2012 03:57:07
SYS        KUPD$DATA                      PACKAGE                             INVALID 31/10/2012 01:50:39
SYS        KUPD$DATA                      PACKAGE BODY                        INVALID 31/10/2012 01:50:40
SYS        KUPD$DATA_INT                  PACKAGE                             INVALID 31/10/2012 01:50:40
SYS        KUPD$DATA_INT                  PACKAGE BODY                        INVALID 31/10/2012 01:50:41
SYS        KUPF$FILE                      PACKAGE BODY                        INVALID 29/12/2012 03:57:08
SYS        KUPF$FILE                      PACKAGE                             INVALID 29/12/2012 03:57:08
SYS        KUPF$FILE_INT                  PACKAGE BODY                        INVALID 29/12/2012 03:57:09
SYS        KUPF$FILE_INT                  PACKAGE                             INVALID 29/12/2012 03:57:09
SYS        KUPM$MCP                       PACKAGE                             INVALID 29/12/2012 03:57:09
SYS        KUPM$MCP                       PACKAGE BODY                        INVALID 29/12/2012 03:57:09
SYS        KUPP$PROC                      PACKAGE                             INVALID 15/04/2012 01:47:26

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        KUPP$PROC                      PACKAGE BODY                        INVALID 31/10/2012 00:53:08
SYS        KUPU$UTILITIES                 PACKAGE                             INVALID 15/04/2012 01:48:13
SYS        KUPU$UTILITIES                 PACKAGE BODY                        INVALID 31/10/2012 00:52:29
SYS        KUPU$UTILITIES_INT             PACKAGE BODY                        INVALID 31/10/2012 01:52:42
SYS        KUPU$UTILITIES_INT             PACKAGE                             INVALID 31/10/2012 01:52:42
SYS        KUPV$FT                        PACKAGE BODY                        INVALID 31/10/2012 01:52:43
SYS        KUPV$FT                        PACKAGE                             INVALID 31/10/2012 01:52:42
SYS        KUPV$FT_INT                    PACKAGE                             INVALID 31/10/2012 01:50:41
SYS        KUPV$FT_INT                    PACKAGE BODY                        INVALID 31/10/2012 01:50:42
SYS        KUPW$WORKER                    PACKAGE                             INVALID 31/10/2012 01:52:44
SYS        KUPW$WORKER                    PACKAGE BODY                        INVALID 31/10/2012 01:52:46
SYS        LCR$_DDL_RECORD                TYPE BODY                           INVALID 29/12/2012 04:08:16
SYS        LCR$_DDL_RECORD                TYPE                                INVALID 29/12/2012 04:08:15
SYS        LCR$_PARAMETER_LIST            TYPE                                INVALID 29/12/2012 04:08:16
SYS        LCR$_PROCEDURE_PARAMETER       TYPE                                INVALID 29/12/2012 04:08:16
SYS        LCR$_PROCEDURE_RECORD          TYPE                                INVALID 29/12/2012 04:08:16
SYS        LCR$_PROCEDURE_RECORD          TYPE BODY                           INVALID 29/12/2012 04:08:16
SYS        LCR$_ROW_LIST                  TYPE                                INVALID 29/12/2012 03:29:51
SYS        LCR$_ROW_LIST                  TYPE                                INVALID 14/04/2012 10:46:59
SYS        LCR$_ROW_RECORD                TYPE                                INVALID 29/12/2012 03:29:51
SYS        LCR$_ROW_RECORD                TYPE BODY                           INVALID 29/12/2012 04:08:17
SYS        LCR$_ROW_UNIT                  TYPE                                INVALID 29/12/2012 04:08:17
SYS        LCR$_ROW_UNIT                  TYPE BODY                           INVALID 29/12/2012 04:08:17
SYS        LCR$_ROW_UNIT                  TYPE                                INVALID 14/04/2012 10:46:59
SYS        LCR$_XML_SCHEMA                PACKAGE                             INVALID 31/10/2012 01:50:14
SYS        LOAD_UNDO_STAT                 PROCEDURE                           INVALID 29/12/2012 04:07:54
SYS        LOGIN_USER                     FUNCTION                            INVALID 30/10/2012 22:13:39
SYS        LOGMNR_DICT_CACHE              PACKAGE BODY                        INVALID 30/10/2012 22:13:48
SYS        LOGMNR_DICT_CACHE              PACKAGE                             INVALID 30/10/2012 22:13:43
SYS        LOGMNR_EM_SUPPORT              PACKAGE                             INVALID 31/10/2012 01:50:23
SYS        LOGMNR_EM_SUPPORT              PACKAGE BODY                        INVALID 31/10/2012 01:50:23
SYS        LOGMNR_GTLO3                   PROCEDURE                           INVALID 30/10/2012 22:13:46
SYS        LOGMNR_KRVRDA_TEST_APPLY       PROCEDURE                           INVALID 30/10/2012 22:14:03
SYS        LOGMNR_KRVRDLUID3              PROCEDURE                           INVALID 29/12/2012 04:07:55
SYS        LOGMNR_KRVRDREPDICT3           PROCEDURE                           INVALID 29/12/2012 04:07:55
SYS        LOGSTDBY$SREC                  TYPE                                INVALID 31/10/2012 00:12:51
SYS        LOGSTDBY$SRECS                 TYPE                                INVALID 31/10/2012 00:12:51
SYS        LOGSTDBY$TABF                  FUNCTION                            INVALID 31/10/2012 01:53:03
SYS        LOGSTDBY$UREC                  TYPE                                INVALID 31/10/2012 00:12:51
SYS        LOGSTDBY$URECS                 TYPE                                INVALID 31/10/2012 00:12:51
SYS        LOGSTDBY$UTABF                 FUNCTION                            INVALID 31/10/2012 01:53:03
SYS        LOGSTDBY_INTERNAL              PACKAGE BODY                        INVALID 31/10/2012 00:53:16
SYS        LOGSTDBY_SUPPORT               VIEW                                INVALID 15/11/2012 03:18:17
SYS        MONITORA_SESSOES               PROCEDURE                           INVALID 31/10/2012 01:48:21
SYS        MOVEXDB_TABLE                  PROCEDURE                           INVALID 29/12/2012 04:07:55
SYS        MOVEXDB_TABLE_PART2            PROCEDURE                           INVALID 29/12/2012 04:07:55
SYS        MSG_PROP_T                     TYPE                                INVALID 29/12/2012 04:08:17
SYS        MSG_PROP_T                     TYPE                                INVALID 14/04/2012 10:48:13
SYS        MVAGGRAWBITOR_TYP              TYPE BODY                           INVALID 29/12/2012 04:08:17
SYS        MVREFRESHSCHEDULE              TYPE                                INVALID 30/10/2012 22:11:59
SYS        MVSCHEDULEDEPENDENCIES         TYPE                                INVALID 30/10/2012 22:11:59
SYS        MVSCHEDULEENTRY                TYPE                                INVALID 30/10/2012 22:11:59
SYS        NameFromLastDDL                FUNCTION                            INVALID 15/04/2012 01:29:28
SYS        ODCIANYDATADUMP                PROCEDURE                           INVALID 29/12/2012 04:07:56
SYS        ODCIARGDESC                    TYPE                                INVALID 14/11/2012 22:35:00
SYS        ODCIARGDESCLIST                TYPE                                INVALID 14/11/2012 22:35:00
SYS        ODCIBFILELIST                  TYPE                                INVALID 14/11/2012 22:35:01
SYS        ODCICOLARRAYVALLIST            TYPE                                INVALID 29/12/2012 03:16:18
SYS        ODCICOLINFO                    TYPE                                INVALID 14/04/2012 10:51:27
SYS        ODCICOLINFODUMP                PROCEDURE                           INVALID 29/12/2012 04:07:57
SYS        ODCICOLINFOFLAGSDUMP           PROCEDURE                           INVALID 15/04/2012 01:47:16
SYS        ODCICOLINFOLIST                TYPE                                INVALID 16/09/2007 01:06:30
SYS        ODCICOLINFOLIST2               TYPE                                INVALID 29/12/2012 04:08:18
SYS        ODCICOLINFOLIST2               TYPE                                INVALID 16/09/2007 01:06:30
SYS        ODCICOLVALLIST                 TYPE                                INVALID 29/12/2012 03:16:18
SYS        ODCICOMPQUERYINFO              TYPE                                INVALID 29/12/2012 04:08:18
SYS        ODCICOST                       TYPE                                INVALID 14/11/2012 22:35:01
SYS        ODCIDATELIST                   TYPE                                INVALID 14/11/2012 22:35:01
SYS        ODCIENVDUMP                    PROCEDURE                           INVALID 29/12/2012 04:07:57
SYS        ODCIEXTTABLEINFO               TYPE                                INVALID 29/12/2012 04:08:18
SYS        ODCIEXTTABLEQCINFO             TYPE                                INVALID 14/11/2012 22:35:03
SYS        ODCIFILTERINFO                 TYPE                                INVALID 29/12/2012 04:08:18
SYS        ODCIFILTERINFO                 TYPE                                INVALID 14/04/2012 10:51:27
SYS        ODCIFILTERINFOLIST             TYPE                                INVALID 29/12/2012 04:08:18
SYS        ODCIFILTERINFOLIST             TYPE                                INVALID 14/04/2012 10:51:27
SYS        ODCIFUNCCALLINFO               TYPE                                INVALID 29/12/2012 04:08:18
SYS        ODCIFUNCINFO                   TYPE                                INVALID 14/11/2012 22:35:02
SYS        ODCIGRANULELIST                TYPE                                INVALID 14/11/2012 22:35:03
SYS        ODCIINDEXALTEROPTIONDUMP       PROCEDURE                           INVALID 29/12/2012 04:07:57
SYS        ODCIINDEXCALLPROPERTYDUMP      PROCEDURE                           INVALID 29/12/2012 04:07:57
SYS        ODCIINDEXCTX                   TYPE                                INVALID 01/01/2013 22:21:43
SYS        ODCIINDEXINFODUMP              PROCEDURE                           INVALID 29/12/2012 00:26:15
SYS        ODCIINDEXINFOFLAGSDUMP         PROCEDURE                           INVALID 30/10/2012 21:46:21
SYS        ODCINUMBERLIST                 TYPE                                INVALID 30/10/2012 23:32:05
SYS        ODCIORDERBYINFO                TYPE                                INVALID 30/10/2012 21:46:23
SYS        ODCIORDERBYINFOLIST            TYPE                                INVALID 30/10/2012 21:46:23
SYS        ODCIPARTINFO                   TYPE                                INVALID 14/04/2012 10:51:30
SYS        ODCIPARTINFO                   TYPE                                INVALID 29/12/2012 04:08:18
SYS        ODCIPARTINFODUMP               PROCEDURE                           INVALID 29/12/2012 04:07:58
SYS        ODCIPARTINFOLIST               TYPE                                INVALID 06/12/2012 20:01:38
SYS        ODCIPARTINFOLISTDUMP           PROCEDURE                           INVALID 29/12/2012 04:07:58
SYS        ODCIPREDINFO                   TYPE                                INVALID 30/10/2012 21:46:22
SYS        ODCIPREDINFODUMP               PROCEDURE                           INVALID 29/12/2012 04:07:58
SYS        ODCIQUERYINFO                  TYPE                                INVALID 14/04/2012 10:51:30
SYS        ODCIQUERYINFO                  TYPE                                INVALID 29/12/2012 04:08:19
SYS        ODCIQUERYINFODUMP              PROCEDURE                           INVALID 29/12/2012 04:07:58
SYS        ODCIRAWLIST                    TYPE                                INVALID 14/11/2012 22:35:03

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        ODCIRIDLIST                    TYPE                                INVALID 30/10/2012 23:32:08
SYS        ODCISECOBJ                     TYPE                                INVALID 30/10/2012 21:46:25
SYS        ODCISECOBJTABLE                TYPE                                INVALID 30/10/2012 21:46:25
SYS        ODCISTATSOPTIONSDUMP           PROCEDURE                           INVALID 29/12/2012 04:07:58
SYS        ODCITABFUNCINFO                TYPE                                INVALID 31/10/2012 00:10:21
SYS        ODCITABFUNCINFODUMP            PROCEDURE                           INVALID 29/12/2012 04:07:58
SYS        ODCITABFUNCSTATS               TYPE                                INVALID 14/11/2012 22:35:03
SYS        ODM_ABN_MODEL                  PACKAGE                             INVALID 31/10/2012 01:48:02
SYS        ODM_ABN_MODEL                  PACKAGE BODY                        INVALID 31/10/2012 01:48:09
SYS        ODM_ASSOCIATION_RULE_MODEL     PACKAGE                             INVALID 31/10/2012 01:48:10
SYS        ODM_ASSOCIATION_RULE_MODEL     PACKAGE BODY                        INVALID 31/10/2012 01:48:10
SYS        ODM_CLUSTERING_UTIL            PACKAGE                             INVALID 31/10/2012 01:48:10
SYS        ODM_CLUSTERING_UTIL            PACKAGE BODY                        INVALID 31/10/2012 01:48:13
SYS        ODM_MODEL_UTIL                 PACKAGE                             INVALID 31/10/2012 01:47:44
SYS        ODM_MODEL_UTIL                 PACKAGE BODY                        INVALID 31/10/2012 01:47:45
SYS        ODM_OC_CLUSTERING_MODEL        PACKAGE                             INVALID 31/10/2012 01:48:13
SYS        ODM_OC_CLUSTERING_MODEL        PACKAGE BODY                        INVALID 31/10/2012 01:48:19
SYS        ODM_UTIL                       PACKAGE                             INVALID 31/10/2012 01:48:02
SYS        ODM_UTIL                       PACKAGE BODY                        INVALID 31/10/2012 01:48:02
SYS        OEMGETNEXTEXTEND               FUNCTION                            INVALID 30/10/2012 22:13:36
SYS        OLAPIMPL_P                     TYPE                                INVALID 14/11/2012 22:35:03
SYS        OLAPIMPL_P                     TYPE BODY                           INVALID 14/11/2012 22:35:03
SYS        OLAPIMPL_T                     TYPE                                INVALID 30/10/2012 22:19:27
SYS        OLAPRANCURIMPL_T               TYPE                                INVALID 29/12/2012 04:08:19
SYS        OLAPRC_TABLE                   FUNCTION                            INVALID 29/12/2012 10:25:28
SYS        OLAP_BOOL_SRF                  FUNCTION                            INVALID 29/12/2012 03:26:03
SYS        OLAP_CONDITION                 FUNCTION                            INVALID 31/10/2012 01:48:58
SYS        OLAP_DATE_SRF                  FUNCTION                            INVALID 29/12/2012 03:26:03
SYS        OLAP_EXPRESSION                OPERATOR                            INVALID 29/12/2012 03:26:09
SYS        OLAP_EXPRESSION_BOOL           OPERATOR                            INVALID 29/12/2012 03:26:09
SYS        OLAP_EXPRESSION_DATE           OPERATOR                            INVALID 29/12/2012 03:26:09
SYS        OLAP_EXPRESSION_TEXT           OPERATOR                            INVALID 29/12/2012 03:26:09
SYS        OLAP_NUMBER_SRF                FUNCTION                            INVALID 29/12/2012 03:26:03
SYS        OLAP_SRF_T                     TYPE                                INVALID 30/10/2012 22:19:26
SYS        OLAP_TABLE                     FUNCTION                            INVALID 29/12/2012 03:26:04
SYS        OLAP_TEXT_SRF                  FUNCTION                            INVALID 29/12/2012 03:26:04
SYS        ON_LOGON_SNGUSRA               TRIGGER                             INVALID 31/10/2012 00:08:46
SYS        ORACLE_DATAPUMP                TYPE BODY                           INVALID 29/12/2012 04:08:20
SYS        ORACLE_DATAPUMP                TYPE                                INVALID 29/12/2012 04:08:19
SYS        ORACLE_LOADER                  TYPE BODY                           INVALID 29/12/2012 04:08:20
SYS        ORACLE_LOADER                  TYPE                                INVALID 29/12/2012 04:08:20
SYS        ORA_DMSB_NODE                  TYPE                                INVALID 31/10/2012 00:40:13
SYS        ORA_DMSB_NODES                 TYPE                                INVALID 31/10/2012 00:40:13
SYS        ORA_DM_TREE_NODE               TYPE                                INVALID 31/10/2012 00:40:12
SYS        ORA_DM_TREE_NODES              TYPE                                INVALID 31/10/2012 00:40:12
SYS        ORA_FI_DECISION_TREE_HORIZ     FUNCTION                            INVALID 31/10/2012 02:36:40
SYS        ORA_FI_IMP_T                   TYPE                                INVALID 31/10/2012 00:10:30
SYS        ORA_FI_SUPERVISED_BINNING      FUNCTION                            INVALID 31/10/2012 02:36:41
SYS        OUTLN_EDIT_PKG                 PACKAGE                             INVALID 30/10/2012 22:13:37
SYS        OUTLN_EDIT_PKG                 PACKAGE BODY                        INVALID 30/10/2012 22:13:38
SYS        OUTLN_PKG                      PACKAGE                             INVALID 30/10/2012 22:13:36
SYS        OUTLN_PKG                      PACKAGE BODY                        INVALID 30/10/2012 22:13:37
SYS        OWA                            PACKAGE                             INVALID 30/10/2012 22:19:20
SYS        OWA                            PACKAGE BODY                        INVALID 30/10/2012 22:19:20
SYS        OWA_CACHE                      PACKAGE BODY                        INVALID 30/10/2012 22:19:23
SYS        OWA_CACHE                      PACKAGE                             INVALID 30/10/2012 22:19:23
SYS        OWA_COOKIE                     PACKAGE                             INVALID 30/10/2012 22:19:22
SYS        OWA_COOKIE                     PACKAGE BODY                        INVALID 30/10/2012 22:19:22
SYS        OWA_CUSTOM                     PACKAGE                             INVALID 30/10/2012 22:19:11
SYS        OWA_CUSTOM                     PACKAGE BODY                        INVALID 30/10/2012 22:19:11
SYS        OWA_CX                         PACKAGE                             INVALID 15/04/2012 01:49:21
SYS        OWA_IMAGE                      PACKAGE                             INVALID 30/10/2012 22:19:22
SYS        OWA_IMAGE                      PACKAGE BODY                        INVALID 30/10/2012 22:19:22
SYS        OWA_MATCH                      PACKAGE                             INVALID 31/10/2012 00:34:41
SYS        OWA_MATCH                      PACKAGE BODY                        INVALID 31/10/2012 00:51:24
SYS        OWA_OPT_LOCK                   PACKAGE                             INVALID 30/10/2012 22:19:22
SYS        OWA_OPT_LOCK                   PACKAGE BODY                        INVALID 30/10/2012 22:19:22
SYS        OWA_PATTERN                    PACKAGE                             INVALID 30/10/2012 22:19:20
SYS        OWA_PATTERN                    PACKAGE BODY                        INVALID 30/10/2012 22:19:20
SYS        OWA_SEC                        PACKAGE BODY                        INVALID 30/10/2012 22:19:19
SYS        OWA_SEC                        PACKAGE                             INVALID 30/10/2012 22:19:19
SYS        OWA_TEXT                       PACKAGE                             INVALID 30/10/2012 22:19:20
SYS        OWA_TEXT                       PACKAGE BODY                        INVALID 30/10/2012 22:19:20
SYS        OWA_UTIL                       PACKAGE                             INVALID 30/10/2012 22:19:16
SYS        OWA_UTIL                       PACKAGE BODY                        INVALID 31/12/2012 13:06:05
SYS        PARTITION_POS                  FUNCTION                            INVALID 30/10/2012 22:13:41
SYS        PBREAK                         PACKAGE                             INVALID 30/10/2012 22:11:53
SYS        PBREAK                         PACKAGE BODY                        INVALID 30/10/2012 22:11:56
SYS        PBRPH                          PACKAGE                             INVALID 30/10/2012 22:11:52
SYS        PBRPH                          PACKAGE BODY                        INVALID 30/10/2012 22:11:57
SYS        PBSDE                          PACKAGE BODY                        INVALID 30/10/2012 22:11:56
SYS        PBSDE                          PACKAGE                             INVALID 30/10/2012 22:11:54
SYS        PBUTL                          PACKAGE                             INVALID 30/10/2012 22:11:52
SYS        PRECISE_KILL_TUNER_SESSION     PROCEDURE                           INVALID 29/12/2012 04:07:58
SYS        PRECISE_KILL_TUNER_SESSIONS    PROCEDURE                           INVALID 29/12/2012 04:07:58
SYS        PRIVATE_JDBC                   PACKAGE BODY                        INVALID 31/10/2012 01:50:43
SYS        PRIVATE_JDBC                   PACKAGE                             INVALID 31/10/2012 01:50:43
SYS        PRIVILEGE_LIST                 FUNCTION                            INVALID 30/10/2012 22:13:40
SYS        PROC_PKGS_KEEP                 PROCEDURE                           INVALID 31/10/2012 01:43:51
SYS        PRVT_ACCESS_ADVISOR            PACKAGE BODY                        INVALID 31/10/2012 01:53:04
SYS        PRVT_ACCESS_ADVISOR            PACKAGE                             INVALID 31/10/2012 01:53:03
SYS        PRVT_ADVISOR                   PACKAGE BODY                        INVALID 04/01/2013 19:59:53
SYS        PRVT_COMPRESSION               PACKAGE BODY                        INVALID 31/10/2012 01:48:28
SYS        PRVT_COMPRESSION               PACKAGE                             INVALID 31/10/2012 01:48:27
SYS        PRVT_DIMENSION_SYS_UTIL        PACKAGE                             INVALID 15/04/2012 01:47:28
SYS        PRVT_DIMENSION_SYS_UTIL        PACKAGE BODY                        INVALID 31/10/2012 00:53:17
SYS        PRVT_EGUTL                     PACKAGE BODY                        INVALID 30/10/2012 22:19:10

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        PRVT_EGUTL                     PACKAGE                             INVALID 30/10/2012 22:19:09
SYS        PRVT_EPGC                      PACKAGE                             INVALID 30/10/2012 22:19:10
SYS        PRVT_EPGC                      PACKAGE BODY                        INVALID 30/10/2012 22:19:11
SYS        PRVT_HDM                       PACKAGE BODY                        INVALID 04/01/2013 20:10:09
SYS        PRVT_PARTREC_NOPRIV            PACKAGE                             INVALID 31/10/2012 01:53:08
SYS        PRVT_PARTREC_NOPRIV            PACKAGE BODY                        INVALID 31/10/2012 01:53:08
SYS        PRVT_REPORT_REGISTRY           PACKAGE BODY                        INVALID 31/10/2012 02:36:38
SYS        PRVT_REPORT_REGISTRY           PACKAGE                             INVALID 31/10/2012 02:36:38
SYS        PRVT_REPORT_TAGS               PACKAGE                             INVALID 30/12/2012 03:36:22
SYS        PRVT_REPORT_TAGS               PACKAGE BODY                        INVALID 29/12/2012 03:57:10
SYS        PRVT_SMGUTIL                   PACKAGE BODY                        INVALID 15/04/2012 02:02:21
SYS        PRVT_SQLADV_INFRA              PACKAGE BODY                        INVALID 29/12/2012 03:57:10
SYS        PRVT_SQLADV_INFRA              PACKAGE                             INVALID 04/01/2013 03:29:44
SYS        PRVT_SQLPA                     PACKAGE BODY                        INVALID 29/12/2012 03:57:11
SYS        PRVT_SQLPA                     PACKAGE                             INVALID 29/12/2012 03:57:10
SYS        PRVT_SQLPROF_INFRA             PACKAGE BODY                        INVALID 31/10/2012 00:53:44
SYS        PRVT_SQLSET_INFRA              PACKAGE BODY                        INVALID 31/10/2012 01:51:57
SYS        PRVT_SYS_TUNE_MVIEW            PACKAGE                             INVALID 29/12/2012 00:57:26
SYS        PRVT_SYS_TUNE_MVIEW            PACKAGE BODY                        INVALID 29/12/2012 00:57:26
SYS        PRVT_TUNE_MVIEW                PACKAGE                             INVALID 29/12/2012 00:57:27
SYS        PRVT_TUNE_MVIEW                PACKAGE BODY                        INVALID 29/12/2012 00:57:28
SYS        PRVT_UADV                      PACKAGE BODY                        INVALID 31/10/2012 01:13:22
SYS        PRVT_UADV                      PACKAGE                             INVALID 31/10/2012 01:13:22
SYS        PRVT_WORKLOAD                  PACKAGE BODY                        INVALID 31/10/2012 01:53:07
SYS        PRVT_WORKLOAD                  PACKAGE                             INVALID 31/10/2012 01:53:06
SYS        PRVT_WORKLOAD_NOPRIV           PACKAGE BODY                        INVALID 31/10/2012 01:53:08
SYS        PRVT_WORKLOAD_NOPRIV           PACKAGE                             INVALID 31/10/2012 01:53:07
SYS        RE$NV_LIST                     TYPE BODY                           INVALID 29/12/2012 04:08:20
SYS        REPCAT_REPCOLUMN_BASE          VIEW                                INVALID 29/12/2012 03:06:25
SYS        REPCAT_REPFLAVOR_COLUMNS       VIEW                                INVALID 29/12/2012 03:06:46
SYS        REPCAT_REPOBJECT               VIEW                                INVALID 29/12/2012 03:06:20
SYS        REPCAT_REPOBJECT_BASE          VIEW                                INVALID 29/12/2012 03:06:19
SYS        REPORT_COMPONENTS              VIEW                                INVALID 15/04/2012 01:47:02
SYS        REPORT_FILES                   VIEW                                INVALID 15/04/2012 01:47:02
SYS        REPORT_FORMATS                 VIEW                                INVALID 15/04/2012 01:47:02
SYS        RESET_UNDO_STAT                PROCEDURE                           INVALID 31/10/2012 01:52:02
SYS        REVOKEE                        FUNCTION                            INVALID 30/10/2012 22:13:40
SYS        REWRITEARRAYTYPE               TYPE                                INVALID 16/09/2007 01:08:50
SYS        REWRITEMESSAGE                 TYPE                                INVALID 14/04/2012 10:52:26
SYS        RMJVM                          PACKAGE                             INVALID 30/10/2012 23:18:14
SYS        RMJVM                          PACKAGE BODY                        INVALID 31/10/2012 00:07:05
SYS        ROW_LCR88_T                    TYPE                                INVALID 14/11/2012 22:35:06
SYS        SCHEDULER$_BATCHERR_PIPE       FUNCTION                            INVALID 31/10/2012 01:52:41
SYS        SCHEDULER$_BATCHERR_VIEW_T     TYPE                                INVALID 31/10/2012 00:11:58
SYS        SCHEDULER$_BATCHERR_VIEW_T     TYPE BODY                           INVALID 29/12/2012 04:08:21
SYS        SCHEDULER$_DEST_LIST           TYPE                                INVALID 14/11/2012 22:35:07
SYS        SCHEDULER$_EVENT_INFO          TYPE BODY                           INVALID 14/11/2012 22:35:07
SYS        SCHEDULER$_JOB_EVENT_HANDLER   PROCEDURE                           INVALID 29/12/2012 04:07:59
SYS        SCHEDULER$_JOB_STEP_TYPE       TYPE                                INVALID 30/10/2012 21:47:22
SYS        SCHEDULER$_REMOTE_ARG          TYPE                                INVALID 29/12/2012 04:08:21
SYS        SCHEDULER$_REMOTE_ARG_LIST     TYPE                                INVALID 29/12/2012 04:08:21
SYS        SCHEDULER$_REMOTE_DB_JOB_INFO  TYPE                                INVALID 29/12/2012 04:08:21
SYS        SCHEDULER$_VARIABLE_VALUE      TYPE                                INVALID 30/10/2012 21:47:22
SYS        SCHEDULER$_VAR_VALUE_LIST      TYPE                                INVALID 30/10/2012 21:47:22
SYS        SCHEDULER_BATCH_ERRORS         VIEW                                INVALID 15/11/2012 03:19:14
SYS        SCHEDULER_FILEWATCHER_HISTORY  TYPE                                INVALID 30/10/2012 21:47:22
SYS        SCHEDULER_FILEWATCHER_HST_LIST TYPE                                INVALID 29/12/2012 00:15:00
SYS        SCHEDULER_FILEWATCHER_REQUEST  TYPE                                INVALID 29/12/2012 03:05:27
SYS        SCHEDULER_FILEWATCHER_REQ_LIST TYPE                                INVALID 29/12/2012 03:05:27
SYS        SCHEDULER_FILEWATCHER_RESULT   TYPE                                INVALID 29/12/2012 03:05:27
SYS        SCHEDULER_FILEWATCHER_RES_LIST TYPE                                INVALID 29/12/2012 03:05:27
SYS        SCN_TO_TIMESTAMP               FUNCTION                            INVALID 31/10/2012 01:50:20
SYS        SERVER_ERROR                   FUNCTION                            INVALID 30/10/2012 22:13:39
SYS        SERVER_ERROR_DEPTH             FUNCTION                            INVALID 30/10/2012 22:13:41
SYS        SERVER_ERROR_MSG               FUNCTION                            INVALID 30/10/2012 22:13:41
SYS        SERVER_ERROR_NUM_PARAMS        FUNCTION                            INVALID 30/10/2012 22:13:41
SYS        SERVER_ERROR_PARAM             FUNCTION                            INVALID 30/10/2012 22:13:41
SYS        SETMODFLG                      PROCEDURE                           INVALID 31/10/2012 01:49:55
SYS        SET_TABLESPACE                 PROCEDURE                           INVALID 29/12/2012 04:07:59
SYS        SPACE_ERROR_INFO               FUNCTION                            INVALID 30/10/2012 22:19:24
SYS        SQLJUTL                        PACKAGE BODY                        INVALID 29/12/2012 03:57:11
SYS        SQLJUTL                        PACKAGE                             INVALID 29/12/2012 03:57:11
SYS        SQLJUTL2                       PACKAGE                             INVALID 31/10/2012 01:49:04
SYS        SQLJUTL2                       PACKAGE BODY                        INVALID 31/10/2012 01:49:04
SYS        SQLSET_ROW                     TYPE BODY                           INVALID 29/12/2012 04:08:21
SYS        SQL_PLAN_ALLSTAT_ROW_TYPE      TYPE BODY                           INVALID 14/11/2012 22:35:08
SYS        SQL_SHARED_CURSOR              VIEW                                INVALID 29/12/2012 10:02:46
SYS        SQL_TXT                        FUNCTION                            INVALID 30/10/2012 22:13:40
SYS        STRAGG                         FUNCTION                            INVALID 31/10/2012 01:50:06
SYS        STREAMS$NV_ARRAY               TYPE                                INVALID 15/11/2012 00:18:12
SYS        STREAMS$NV_NODE                TYPE                                INVALID 14/11/2012 22:35:09
SYS        STREAMS$TRANSFORMATION_INFO    TYPE                                INVALID 30/10/2012 22:51:17
SYS        STREAMS$_ANYDATA_ARRAY         TYPE                                INVALID 29/12/2012 04:08:21
SYS        STREAMS$_EVALUATION_CONTEXT    EVALUATION CONTEXT                  INVALID 15/04/2012 01:29:25
SYS        STRING_AGG_TYPE                TYPE                                INVALID 31/10/2012 01:50:06
SYS        SYS$RLBTYP                     TYPE                                INVALID 14/11/2012 22:35:08
SYS        SYSEVENT                       FUNCTION                            INVALID 30/10/2012 22:13:39
SYS        SYSNTvakuQggDZM/gRAAhKN7SrQ==  TABLE                               INVALID 14/04/2012 17:24:14
SYS        SYSNTvakuQggFZM/gRAAhKN7SrQ==  TABLE                               INVALID 14/04/2012 17:24:15
SYS        SYSNTvakuQggHZM/gRAAhKN7SrQ==  TABLE                               INVALID 14/04/2012 17:24:15
SYS        SYSNTwu/p9q/5CUbgRAAhKMG/Kg==  TABLE                               INVALID 20/06/2012 19:28:13
SYS        SYSNTwu/p9q/7CUbgRAAhKMG/Kg==  TABLE                               INVALID 20/06/2012 19:28:14
SYS        SYSNTwu/p9q/9CUbgRAAhKMG/Kg==  TABLE                               INVALID 20/06/2012 19:28:14
SYS        SYSNTwu/p9rACCUbgRAAhKMG/Kg==  TABLE                               INVALID 20/06/2012 19:28:20
SYS        SYSNTwu/p9rAECUbgRAAhKMG/Kg==  TABLE                               INVALID 20/06/2012 19:28:21
SYS        SYSNTwu/p9rAGCUbgRAAhKMG/Kg==  TABLE                               INVALID 20/06/2012 19:28:21
SYS        SYS_NT_COLLECT                 FUNCTION                            INVALID 29/12/2012 10:25:29

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        SYS_NT_COLLECT_IMP             TYPE                                INVALID 29/12/2012 04:08:21
SYS        SYS_PLSQL_23516_19_1           TYPE                                INVALID 31/10/2012 00:07:20
SYS        SYS_PLSQL_23516_9_1            TYPE                                INVALID 31/10/2012 00:07:19
SYS        SYS_PLSQL_23516_DUMMY_1        TYPE                                INVALID 31/10/2012 00:07:20
SYS        SYS_PLSQL_3342_1029_1          TYPE                                INVALID 30/10/2012 21:45:38
SYS        SYS_PLSQL_3342_533_1           TYPE                                INVALID 30/10/2012 21:45:37
SYS        SYS_PLSQL_3342_541_1           TYPE                                INVALID 30/10/2012 21:45:37
SYS        SYS_PLSQL_3342_657_1           TYPE                                INVALID 30/10/2012 21:45:37
SYS        SYS_PLSQL_3342_675_1           TYPE                                INVALID 30/10/2012 21:45:37
SYS        SYS_PLSQL_3342_724_1           TYPE                                INVALID 30/10/2012 21:45:37
SYS        SYS_PLSQL_3342_835_1           TYPE                                INVALID 30/10/2012 21:45:37
SYS        SYS_PLSQL_3342_880_1           TYPE                                INVALID 30/10/2012 21:45:37
SYS        SYS_PLSQL_3342_925_1           TYPE                                INVALID 30/10/2012 21:45:37
SYS        SYS_PLSQL_3342_954_1           TYPE                                INVALID 30/10/2012 21:45:37
SYS        SYS_PLSQL_3342_981_1           TYPE                                INVALID 30/10/2012 21:45:37
SYS        SYS_PLSQL_3342_989_1           TYPE                                INVALID 30/10/2012 21:45:37
SYS        SYS_PLSQL_3342_DUMMY_1         TYPE                                INVALID 30/10/2012 21:45:37
SYS        SYS_PLSQL_3409_155_1           TYPE                                INVALID 30/10/2012 21:46:26
SYS        SYS_PLSQL_3409_168_1           TYPE                                INVALID 30/10/2012 21:46:26
SYS        SYS_PLSQL_3409_DUMMY_1         TYPE                                INVALID 30/10/2012 21:46:26
SYS        SYS_PLSQL_4089091_198_1        TYPE                                INVALID 31/10/2012 01:49:56
SYS        SYS_PLSQL_4089091_216_1        TYPE                                INVALID 31/10/2012 01:49:57
SYS        SYS_PLSQL_4089091_DUMMY_1      TYPE                                INVALID 31/10/2012 01:49:56
SYS        SYS_PLSQL_4102973_32_1         TYPE                                INVALID 31/10/2012 01:50:04
SYS        SYS_PLSQL_4102973_9_1          TYPE                                INVALID 31/10/2012 01:50:04
SYS        SYS_PLSQL_4102973_DUMMY_1      TYPE                                INVALID 31/10/2012 01:50:04
SYS        SYS_PLSQL_4103123_46_1         TYPE                                INVALID 31/10/2012 01:50:29
SYS        SYS_PLSQL_4103123_9_1          TYPE                                INVALID 31/10/2012 01:50:29
SYS        SYS_PLSQL_4103123_DUMMY_1      TYPE                                INVALID 31/10/2012 01:50:29
SYS        SYS_PLSQL_4103319_52_1         TYPE                                INVALID 31/10/2012 01:50:43
SYS        SYS_PLSQL_4103319_9_1          TYPE                                INVALID 31/10/2012 01:50:43
SYS        SYS_PLSQL_4103319_DUMMY_1      TYPE                                INVALID 31/10/2012 01:50:43
SYS        SYS_PLSQL_4103347_673_1        TYPE                                INVALID 31/10/2012 01:51:57
SYS        SYS_PLSQL_4103347_691_1        TYPE                                INVALID 31/10/2012 01:51:57
SYS        SYS_PLSQL_4103347_DUMMY_1      TYPE                                INVALID 31/10/2012 01:51:57
SYS        SYS_PLSQL_4103456_2439_1       TYPE                                INVALID 29/12/2012 00:36:34
SYS        SYS_PLSQL_4103456_2598_1       TYPE                                INVALID 29/12/2012 00:36:34
SYS        SYS_PLSQL_4103456_2606_1       TYPE                                INVALID 29/12/2012 00:36:34
SYS        SYS_PLSQL_4103456_2639_1       TYPE                                INVALID 29/12/2012 00:36:34
SYS        SYS_PLSQL_4103456_707_1        TYPE                                INVALID 29/12/2012 00:36:34
SYS        SYS_PLSQL_4103456_765_1        TYPE                                INVALID 29/12/2012 00:36:34
SYS        SYS_PLSQL_4103456_773_1        TYPE                                INVALID 29/12/2012 00:36:34
SYS        SYS_PLSQL_4103456_841_1        TYPE                                INVALID 29/12/2012 00:36:34
SYS        SYS_PLSQL_4103456_950_1        TYPE                                INVALID 29/12/2012 00:36:34
SYS        SYS_PLSQL_4103456_972_1        TYPE                                INVALID 29/12/2012 00:36:34
SYS        SYS_PLSQL_4103456_DUMMY_1      TYPE                                INVALID 29/12/2012 00:36:34
SYS        SYS_PLSQL_4103473_161_1        TYPE                                INVALID 29/12/2012 00:37:05
SYS        SYS_PLSQL_4103473_89_1         TYPE                                INVALID 29/12/2012 00:37:05
SYS        SYS_PLSQL_4103473_DUMMY_1      TYPE                                INVALID 29/12/2012 00:37:05
SYS        SYS_PLSQL_4103478_144_1        TYPE                                INVALID 29/12/2012 00:36:45
SYS        SYS_PLSQL_4103478_152_1        TYPE                                INVALID 29/12/2012 00:36:45
SYS        SYS_PLSQL_4103478_190_1        TYPE                                INVALID 29/12/2012 00:36:45
SYS        SYS_PLSQL_4103478_198_1        TYPE                                INVALID 29/12/2012 00:36:45
SYS        SYS_PLSQL_4103478_243_1        TYPE                                INVALID 29/12/2012 00:36:45
SYS        SYS_PLSQL_4103478_251_1        TYPE                                INVALID 29/12/2012 00:36:45
SYS        SYS_PLSQL_4103478_323_1        TYPE                                INVALID 29/12/2012 00:36:45
SYS        SYS_PLSQL_4103478_331_1        TYPE                                INVALID 29/12/2012 00:36:45
SYS        SYS_PLSQL_4103478_41_1         TYPE                                INVALID 29/12/2012 00:36:45
SYS        SYS_PLSQL_4103478_91_1         TYPE                                INVALID 29/12/2012 00:36:45
SYS        SYS_PLSQL_4103478_99_1         TYPE                                INVALID 29/12/2012 00:36:45
SYS        SYS_PLSQL_4103478_DUMMY_1      TYPE                                INVALID 29/12/2012 00:36:45
SYS        SYS_PLSQL_4105599_100_1        TYPE                                INVALID 31/10/2012 00:53:19
SYS        SYS_PLSQL_4105599_9_1          TYPE                                INVALID 31/10/2012 00:53:19
SYS        SYS_PLSQL_4105599_DUMMY_1      TYPE                                INVALID 31/10/2012 00:53:19
SYS        SYS_PLSQL_4135243_9_1          TYPE                                INVALID 31/10/2012 01:50:20
SYS        SYS_PLSQL_4135243_DUMMY_1      TYPE                                INVALID 31/10/2012 01:50:20
SYS        SYS_YOID0004104653$            TYPE                                INVALID 14/11/2012 22:35:34
SYS        TABLESPACE_LIST                TYPE                                INVALID 30/10/2012 21:45:36
SYS        TBLAST_ALIGN                   FUNCTION                            INVALID 31/10/2012 01:53:02
SYS        TBLAST_MATCH                   FUNCTION                            INVALID 31/10/2012 01:53:01
SYS        TIMESTAMP_TO_SCN               FUNCTION                            INVALID 15/04/2012 02:15:24
SYS        TRUNC_AUDIT                    PROCEDURE                           INVALID 31/10/2012 01:43:23
SYS        URIFACTORY                     PACKAGE BODY                        INVALID 30/10/2012 22:14:09
SYS        URITYPE                        TYPE BODY                           INVALID 29/12/2012 04:08:22
SYS        USER_ADDM_FDG_BREAKDOWN        VIEW                                INVALID 15/04/2012 02:40:32
SYS        USER_ADDM_FINDINGS             VIEW                                INVALID 15/04/2012 02:15:48
SYS        USER_ADDM_TASKS                VIEW                                INVALID 15/04/2012 02:15:48
SYS        USER_ADDM_TASK_DIRECTIVES      VIEW                                INVALID 15/04/2012 02:15:48
SYS        USER_ADVISOR_ACTIONS           VIEW                                INVALID 15/04/2012 01:48:08
SYS        USER_ADVISOR_EXECUTIONS        VIEW                                INVALID 15/04/2012 01:48:07
SYS        USER_ADVISOR_EXEC_PARAMETERS   VIEW                                INVALID 15/04/2012 01:48:07
SYS        USER_ADVISOR_FDG_BREAKDOWN     VIEW                                INVALID 15/04/2012 02:15:47
SYS        USER_ADVISOR_FINDINGS          VIEW                                INVALID 15/04/2012 01:48:07
SYS        USER_ADVISOR_JOURNAL           VIEW                                INVALID 15/04/2012 01:48:08
SYS        USER_ADVISOR_LOG               VIEW                                INVALID 15/04/2012 01:48:07
SYS        USER_ADVISOR_PARAMETERS        VIEW                                INVALID 15/04/2012 01:48:07
SYS        USER_ADVISOR_RATIONALE         VIEW                                INVALID 15/04/2012 01:48:08
SYS        USER_ADVISOR_RECOMMENDATIONS   VIEW                                INVALID 15/04/2012 01:48:08
SYS        USER_ADVISOR_SQLW_JOURNAL      VIEW                                INVALID 15/04/2012 01:48:26
SYS        USER_ADVISOR_SQLW_PARAMETERS   VIEW                                INVALID 15/04/2012 01:48:26
SYS        USER_ADVISOR_TASKS             VIEW                                INVALID 15/04/2012 01:48:07
SYS        USER_DBFS_HS_FILES             VIEW                                INVALID 29/12/2012 10:02:46
SYS        USER_IND_STATISTICS            VIEW                                INVALID 15/11/2012 03:19:15
SYS        USER_JAVA_COMPILER_OPTIONS     VIEW                                INVALID 15/11/2012 03:19:15
SYS        USER_PARALLEL_EXECUTE_TASKS    VIEW                                INVALID 15/04/2012 02:16:12
SYS        USER_QUEUE_SUBSCRIBERS         VIEW                                INVALID 29/12/2012 10:10:37
SYS        USER_REGISTRY                  VIEW                                INVALID 29/12/2012 03:05:35

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        USER_REPCAT                    VIEW                                INVALID 29/12/2012 03:06:22
SYS        USER_REPCOLUMN                 VIEW                                INVALID 29/12/2012 03:06:27
SYS        USER_REPFLAVOR_COLUMNS         VIEW                                INVALID 29/12/2012 03:06:47
SYS        USER_REPGROUP                  VIEW                                INVALID 29/12/2012 03:06:22
SYS        USER_REPOBJECT                 VIEW                                INVALID 29/12/2012 03:06:24
SYS        USER_REPPROP                   VIEW                                INVALID 29/12/2012 03:06:27
SYS        USER_RULES                     VIEW                                INVALID 15/04/2012 01:27:58
SYS        USER_SCHEDULER_JOB_ARGS        VIEW                                INVALID 15/04/2012 01:48:10
SYS        USER_SCHEDULER_PROGRAM_ARGS    VIEW                                INVALID 15/04/2012 01:48:10
SYS        USER_SQLSET_BINDS              VIEW                                INVALID 15/04/2012 01:48:23
SYS        USER_SQLTUNE_BINDS             VIEW                                INVALID 15/04/2012 01:48:23
SYS        USER_SUBSCR_REGISTRATIONS      VIEW                                INVALID 15/04/2012 01:47:04
SYS        USER_TAB_STATISTICS            VIEW                                INVALID 15/11/2012 03:21:30
SYS        USER_WARNING_SETTINGS          VIEW                                INVALID 15/11/2012 03:21:31
SYS        USER_XDS_ATTRIBUTE_SECS        VIEW                                INVALID 07/12/2012 00:03:54
SYS        USER_XDS_INSTANCE_SETS         VIEW                                INVALID 07/12/2012 00:03:54
SYS        USER_XML_INDEXES               VIEW                                INVALID 15/11/2012 03:21:32
SYS        USER_XML_PARTITIONED_TABLE_OK  FUNCTION                            INVALID 31/10/2012 01:49:57
SYS        USER_XML_SCHEMAS               VIEW                                INVALID 07/12/2012 00:03:54
SYS        UTL_COLL                       PACKAGE                             INVALID 30/10/2012 22:12:42
SYS        UTL_COLL                       PACKAGE BODY                        INVALID 30/10/2012 22:12:42
SYS        UTL_COMPRESS                   PACKAGE                             INVALID 31/10/2012 01:50:03
SYS        UTL_COMPRESS                   PACKAGE BODY                        INVALID 31/10/2012 02:07:26
SYS        UTL_ENCODE                     PACKAGE BODY                        INVALID 30/10/2012 21:45:25
SYS        UTL_FILE                       PACKAGE BODY                        INVALID 30/10/2012 21:45:18
SYS        UTL_GDK                        PACKAGE BODY                        INVALID 30/10/2012 21:45:25
SYS        UTL_GDK                        PACKAGE                             INVALID 30/10/2012 21:45:25
SYS        UTL_HTTP                       PACKAGE BODY                        INVALID 30/10/2012 21:45:24
SYS        UTL_I18N                       PACKAGE                             INVALID 31/10/2012 01:50:03
SYS        UTL_I18N                       PACKAGE BODY                        INVALID 31/10/2012 02:07:26
SYS        UTL_INADDR                     PACKAGE BODY                        INVALID 30/10/2012 21:45:19
SYS        UTL_INADDR                     PACKAGE                             INVALID 30/10/2012 21:45:19
SYS        UTL_LMS                        PACKAGE BODY                        INVALID 31/10/2012 02:07:26
SYS        UTL_LMS                        PACKAGE                             INVALID 31/10/2012 01:50:04
SYS        UTL_MATCH                      PACKAGE                             INVALID 31/10/2012 01:50:28
SYS        UTL_NLA                        PACKAGE                             INVALID 31/10/2012 01:50:05
SYS        UTL_NLA                        PACKAGE BODY                        INVALID 31/10/2012 02:07:35
SYS        UTL_NLA_ARRAY_DBL              TYPE                                INVALID 31/10/2012 00:10:08
SYS        UTL_NLA_ARRAY_FLT              TYPE                                INVALID 31/10/2012 00:10:08
SYS        UTL_NLA_ARRAY_INT              TYPE                                INVALID 31/10/2012 00:10:08
SYS        UTL_RAW                        PACKAGE BODY                        INVALID 30/10/2012 21:45:18
SYS        UTL_RECOMP                     PACKAGE BODY                        INVALID 04/01/2013 20:08:08
SYS        UTL_REF                        PACKAGE                             INVALID 30/10/2012 22:12:42
SYS        UTL_REF                        PACKAGE BODY                        INVALID 30/10/2012 22:12:42
SYS        UTL_URL                        PACKAGE                             INVALID 30/10/2012 21:45:24
SYS        UTL_URL                        PACKAGE BODY                        INVALID 30/10/2012 21:45:25
SYS        UTL_XML                        PACKAGE                             INVALID 30/10/2012 22:14:10
SYS        UTL_XML                        PACKAGE BODY                        INVALID 30/10/2012 22:14:11
SYS        VALIDATE_CONTEXT               PROCEDURE                           INVALID 29/12/2012 00:20:31
SYS        VALIDATE_OWM                   PROCEDURE                           INVALID 31/10/2012 02:06:23
SYS        VERIFY_FUN_ADM                 FUNCTION                            INVALID 31/10/2012 00:07:27
SYS        VERIFY_FUN_OWNER               FUNCTION                            INVALID 31/10/2012 00:07:27
SYS        VERIFY_FUN_USU                 FUNCTION                            INVALID 31/10/2012 00:07:26
SYS        VERSION_RPT                    FUNCTION                            INVALID 31/10/2012 01:43:42
SYS        VERSION_SCRIPT                 FUNCTION                            INVALID 31/10/2012 01:50:00
SYS        V_$BACKUP_ARCHIVELOG_DETAILS   VIEW                                INVALID 15/11/2012 03:21:33
SYS        V_$BACKUP_ARCHIVELOG_SUMMARY   VIEW                                INVALID 15/11/2012 03:21:34
SYS        V_$BACKUP_CONTROLFILE_DETAILS  VIEW                                INVALID 15/11/2012 03:21:35
SYS        V_$BACKUP_CONTROLFILE_SUMMARY  VIEW                                INVALID 15/11/2012 03:21:35
SYS        V_$BACKUP_COPY_DETAILS         VIEW                                INVALID 15/11/2012 03:21:35
SYS        V_$BACKUP_COPY_SUMMARY         VIEW                                INVALID 15/11/2012 03:21:36
SYS        V_$BACKUP_DATAFILE_DETAILS     VIEW                                INVALID 15/11/2012 03:21:36
SYS        V_$BACKUP_DATAFILE_SUMMARY     VIEW                                INVALID 15/11/2012 03:21:37
SYS        V_$BACKUP_FILES                VIEW                                INVALID 15/11/2012 03:21:38
SYS        V_$BACKUP_PIECE_DETAILS        VIEW                                INVALID 15/11/2012 03:21:39
SYS        V_$BACKUP_SET_DETAILS          VIEW                                INVALID 15/11/2012 03:21:39
SYS        V_$BACKUP_SET_SUMMARY          VIEW                                INVALID 15/11/2012 03:21:39
SYS        V_$BACKUP_SPFILE_DETAILS       VIEW                                INVALID 15/11/2012 03:21:40
SYS        V_$BACKUP_SPFILE_SUMMARY       VIEW                                INVALID 15/11/2012 03:21:40
SYS        V_$PROXY_ARCHIVELOG_DETAILS    VIEW                                INVALID 15/11/2012 03:21:40
SYS        V_$PROXY_ARCHIVELOG_SUMMARY    VIEW                                INVALID 15/11/2012 03:21:41
SYS        V_$PROXY_COPY_DETAILS          VIEW                                INVALID 15/11/2012 03:21:41
SYS        V_$PROXY_COPY_SUMMARY          VIEW                                INVALID 15/11/2012 03:21:41
SYS        V_$RMAN_BACKUP_JOB_DETAILS     VIEW                                INVALID 15/11/2012 03:21:41
SYS        V_$RMAN_BACKUP_SUBJOB_DETAILS  VIEW                                INVALID 15/11/2012 03:21:42
SYS        V_$UNUSABLE_BACKUPFILE_DETAILS VIEW                                INVALID 15/11/2012 03:21:42
SYS        V_LBRECSETIMPL_T               TYPE                                INVALID 15/11/2012 03:21:37
SYS        V_LBRECSETIMPL_T               TYPE BODY                           INVALID 04/12/2012 07:02:07
SYS        V_LBRECSET_T                   TYPE                                INVALID 15/11/2012 00:18:14
SYS        V_LBREC_T                      TYPE                                INVALID 14/11/2012 22:35:37
SYS        V_LISTBACKUPPIPE               FUNCTION                            INVALID 15/11/2012 03:21:38
SYS        WITH_GRANT_OPTION              FUNCTION                            INVALID 30/10/2012 22:13:40
SYS        WPG_DOCLOAD                    PACKAGE BODY                        INVALID 30/10/2012 22:19:23
SYS        WPG_DOCLOAD                    PACKAGE                             INVALID 30/10/2012 22:19:23
SYS        WPIUTL                         PACKAGE BODY                        INVALID 30/10/2012 22:19:09
SYS        WPIUTL                         PACKAGE                             INVALID 30/10/2012 22:19:09
SYS        WRI$_ADV_ABSTRACT_T            TYPE BODY                           INVALID 14/11/2012 22:35:38
SYS        WRI$_ADV_COMPRESSION_T         TYPE BODY                           INVALID 14/11/2012 22:35:38
SYS        WRI$_ADV_HDM_T                 TYPE BODY                           INVALID 29/12/2012 04:08:22
SYS        WRI$_ADV_OBJSPACE_TREND_T      TYPE BODY                           INVALID 29/12/2012 04:08:22
SYS        WRI$_ADV_SQLACCESS_ADV         TYPE BODY                           INVALID 14/11/2012 22:35:41
SYS        WRI$_ADV_SQLTUNE               TYPE BODY                           INVALID 29/12/2012 04:08:24
SYS        WRI$_ADV_TUNEMVIEW_ADV         TYPE BODY                           INVALID 14/11/2012 22:35:42
SYS        WRI$_ADV_UNDO_ADV              TYPE BODY                           INVALID 14/11/2012 22:35:42
SYS        WRI$_ADV_WORKLOAD              TYPE BODY                           INVALID 14/11/2012 22:35:42
SYS        WRI$_REPT_DBREPLAY             TYPE                                INVALID 29/12/2012 10:26:50
SYS        WRI$_REPT_PLAN_DIFF            TYPE                                INVALID 29/12/2012 10:26:50

OWNER      OBJECT_NAME                    OBJECT_TYPE                         STATUS  LAST_DDL_TIME
---------- ------------------------------ ----------------------------------- ------- -------------------
SYS        WRI$_REPT_PLAN_DIFF            TYPE BODY                           INVALID 06/12/2012 20:01:39
SYS        WRI$_REPT_SQLMONITOR           TYPE BODY                           INVALID 14/11/2012 22:35:43
SYS        WRI$_REPT_SQLMONITOR           TYPE                                INVALID 29/12/2012 10:26:49
SYS        WRI$_REPT_SQLPI                TYPE                                INVALID 29/12/2012 10:26:49
SYS        WRI$_REPT_SQLPI                TYPE BODY                           INVALID 14/11/2012 22:35:43
SYS        WRI$_REPT_SQLT                 TYPE BODY                           INVALID 14/11/2012 22:35:43
SYS        WRI$_REPT_SQLT                 TYPE                                INVALID 29/12/2012 10:26:49
SYS        WRI$_REPT_XPLAN                TYPE BODY                           INVALID 06/12/2012 20:01:39
SYS        WRI$_REPT_XPLAN                TYPE                                INVALID 29/12/2012 10:26:49
SYS        XDBURITYPE                     TYPE BODY                           INVALID 29/12/2012 04:08:25
SYS        XDB_INSTALLATION_TRIGGER       TRIGGER                             INVALID 29/12/2012 04:08:08
SYS        XDB_PI_TRIG                    TRIGGER                             INVALID 31/10/2012 01:49:55
SYS        XDS_ACE                        VIEW                                INVALID 07/12/2012 00:03:54
SYS        XDS_ACL                        VIEW                                INVALID 15/11/2012 03:21:43
SYS        XMLBINARYINPUTSTREAM           TYPE BODY                           INVALID 14/11/2012 22:35:44
SYS        XMLBINARYINPUTSTREAM           TYPE                                INVALID 14/11/2012 20:44:26
SYS        XMLBINARYOUTPUTSTREAM          TYPE BODY                           INVALID 14/11/2012 22:35:44
SYS        XMLBINARYOUTPUTSTREAM          TYPE                                INVALID 14/11/2012 20:44:27
SYS        XMLCHARACTERINPUTSTREAM        TYPE BODY                           INVALID 14/11/2012 22:35:44
SYS        XMLCHARACTERINPUTSTREAM        TYPE                                INVALID 14/11/2012 20:44:27
SYS        XMLCHARACTEROUTPUTSTREAM       TYPE BODY                           INVALID 14/11/2012 22:35:45
SYS        XMLCHARACTEROUTPUTSTREAM       TYPE                                INVALID 14/11/2012 20:44:27
SYS        XMLGENFORMATTYPE               TYPE                                INVALID 14/04/2012 10:46:58
SYS        XMLGENFORMATTYPE               TYPE BODY                           INVALID 29/12/2012 04:08:25
SYS        XMLTYPE                        TYPE BODY                           INVALID 31/12/2012 11:31:44
SYS        XMLVALIDATE                    PROCEDURE                           INVALID 31/10/2012 00:07:25
SYS        XS$CATVIEW_UTIL                PACKAGE                             INVALID 29/12/2012 03:57:11
SYS        XS$CATVIEW_UTIL                PACKAGE BODY                        INVALID 29/12/2012 03:57:11
SYS        _ALL_REPCOLUMN                 VIEW                                INVALID 29/12/2012 03:06:27
SYS        _ALL_REPCOLUMN_GROUP           VIEW                                INVALID 29/12/2012 03:06:36
SYS        _ALL_REPCONFLICT               VIEW                                INVALID 29/12/2012 03:06:42
SYS        _ALL_REPFLAVOR_OBJECTS         VIEW                                INVALID 29/12/2012 03:06:45
SYS        _ALL_REPGROUPED_COLUMN         VIEW                                INVALID 29/12/2012 03:06:35
SYS        _ALL_REPL_NESTED_TABLE_NAMES   VIEW                                INVALID 29/12/2012 03:06:25
SYS        _ALL_REPPARAMETER_COLUMN       VIEW                                INVALID 29/12/2012 03:06:41
SYS        _ALL_REPRESOLUTION             VIEW                                INVALID 29/12/2012 03:06:39
SYS        _ALL_STREAMS_PROCESSES         VIEW                                INVALID 29/12/2012 05:09:42
SYS        _DBA_APPLY_ERROR_TXN           VIEW                                INVALID 15/04/2012 01:48:27
SYS        _DBA_STREAMS_MSG_NOTIFICATIONS VIEW                                INVALID 15/04/2012 01:48:29
SYS        _DBA_STREAMS_TRANSFM_FUNCTION  VIEW                                INVALID 29/12/2012 09:08:06
SYS        _DBA_STREAMS_TRANSFORMATIONS   VIEW                                INVALID 15/04/2012 01:48:29
SYS        _DBA_XSTREAM_OUTBOUND          VIEW                                INVALID 15/04/2012 03:13:52
SYS        _DEFSCHEDULE                   VIEW                                INVALID 29/12/2012 03:06:14
SYS        _REPORT_COMPONENT_OBJECTS      VIEW                                INVALID 03/01/2013 23:42:13
SYS        anydata82_T                    TYPE                                INVALID 14/11/2012 22:33:32
SYS        column_value84_T               TYPE                                INVALID 14/11/2012 22:35:06
SYS        datetime_format83_T            TYPE                                INVALID 14/11/2012 22:33:32
SYS        extra_attribute81_T            TYPE                                INVALID 14/11/2012 22:33:32
SYS        extra_attribute_valu87_COLL    TYPE                                INVALID 14/11/2012 22:33:32
SYS        extra_attribute_values86_T     TYPE                                INVALID 14/11/2012 22:33:32
SYS        extra_attribute_values92_T     TYPE                                INVALID 14/11/2012 22:35:06
SYS        new_values91_T                 TYPE                                INVALID 14/11/2012 22:35:06
SYS        old_value90_COLL               TYPE                                INVALID 14/11/2012 22:35:06
SYS        old_values89_T                 TYPE                                INVALID 14/11/2012 22:35:06
SYSTEM     DBMS_REPCAT_AUTH               PACKAGE BODY                        INVALID 30/10/2012 22:20:43
SYSTEM     DBMS_REPCAT_AUTH               PACKAGE                             INVALID 30/10/2012 22:20:43
SYSTEM     DEF$_PROPAGATOR_TRIG           TRIGGER                             INVALID 30/10/2012 22:11:40
SYSTEM     ORA$_SYS_REP_AUTH              PROCEDURE                           INVALID 30/10/2012 22:19:34
SYSTEM     REPCAT$_OBJECT_NULL_VECTOR     TYPE                                INVALID 30/10/2012 22:11:42
SYSTEM     REPCATLOGTRIG                  TRIGGER                             INVALID 30/10/2012 23:18:26

2291 rows selected.

20:21:51 A3NXTL01.IT_PPNETO>spool off;
