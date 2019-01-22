spool getavgcol
select 'SQLN_EXPLAIN_PLAN' TB, round(avg(nvl(vsize(STATEMENT_ID),0)),0) +
        round(avg(nvl(vsize(TIMESTAMP),0)),0) +
        round(avg(nvl(vsize(REMARKS),0)),0) +
        round(avg(nvl(vsize(OPERATION),0)),0) +
        round(avg(nvl(vsize(OPTIONS),0)),0) +
        round(avg(nvl(vsize(OBJECT_NODE),0)),0) +
        round(avg(nvl(vsize(OBJECT_OWNER),0)),0) +
        round(avg(nvl(vsize(OBJECT_NAME),0)),0) +
        round(avg(nvl(vsize(OBJECT_INSTANCE),0)),0) +
        round(avg(nvl(vsize(OBJECT_TYPE),0)),0) +
        round(avg(nvl(vsize(OPTIMIZER),0)),0) +
        round(avg(nvl(vsize(SEARCH_COLUMNS),0)),0) +
        round(avg(nvl(vsize(ID),0)),0) +
        round(avg(nvl(vsize(PARENT_ID),0)),0) +
        round(avg(nvl(vsize(POSITION),0)),0) +
        round(avg(nvl(vsize(COST),0)),0) +
        round(avg(nvl(vsize(CARDINALITY),0)),0) +
        round(avg(nvl(vsize(BYTES),0)),0) +
        round(avg(nvl(vsize(OTHER_TAG),0)),0) +
        round(avg(nvl(vsize(PARTITION_START),0)),0) +
        round(avg(nvl(vsize(PARTITION_STOP),0)),0) +
        round(avg(nvl(vsize(PARTITION_ID),0)),0) +
        round(avg(nvl(vsize(DISTRIBUTION),0)),0) row_size from SQLN_EXPLAIN_PLAN
;

spool off
