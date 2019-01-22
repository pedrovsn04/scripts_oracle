prompt MOSTRA AS CONSTRAINTS DE UMA TABELA
 select
 SUBSTR(a.OWNER,1,15) OWNER,
 A.table_name,
 a.CONSTRAINT_TYPE TIPO_CONS,
 substr(a.constraint_name,1,30) Nome_Const ,
 substr(b.column_name,1,30) column_name,
 substr(b.position,1,2) Position,
 substr(a.R_constraint_name,1,30) Nome_REF_CONSTR 
 --,SEARCH_CONDITIOn
 from all_constraints a, dba_cons_columns b
 where a.table_name = nvl(upper('&tabela'),a.table_name)
 AND a.OWNER = NVL(UPPER('&owner1'),A.OWNER)
and a.constraint_name = NVL(UPPER('&CONST1'),A.constraint_name)
 and a.table_name = b.table_name
 and a.owner=b.owner
 and a.constraint_name = b.constraint_name
 ORDER BY 1,4,6, 3
/