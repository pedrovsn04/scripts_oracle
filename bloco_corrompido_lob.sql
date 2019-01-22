SELECT	segment_name ,  segment_type ,  owner , tablespace_name
FROM  	sys.dba_extents
WHERE 	file_id = &bad_file_id
AND  	&bad_block_id BETWEEN block_id and block_id + blocks -1

				
178
480522

Informe o valor para bad_file_id: 178
antigo   3: WHERE  file_id = &bad_file_id
novo   3: WHERE  file_id = 178
Informe o valor para bad_block_id: 480522
antigo   4: AND   &bad_block_id BETWEEN block_id and block_id + blocks -1
novo   4: AND   480522 BETWEEN block_id and block_id + blocks -1

SEGMENT_NAME                   SEGMENT_TYPE       OWNER            TABLESPACE_NAME
------------------------------ ------------------ ---------------- ------------------------------
SYS_LOB0000630167C00003$$      LOBSEGMENT         WLI              WLI_DAT

1 linha selecionada.


	set serverout on
		exec dbms_output.enable(100000);
		declare
		 error_1578 exception;
		 pragma exception_init(error_1578,-1578);
		 n number;
		 cnt number:=0;
		 badcnt number:=0;
		begin
		  for cursor_lob in
		        (select rowid r, &LOB_COLUMN_NAME L from &OWNER..&TABLE_NAME)
		  loop
		    begin
		      n:=dbms_lob.instr(cursor_lob.L,hextoraw('AA25889911'),1,999999) ;
		    exception
		     when error_1578 then
		       dbms_output.put_line('Got ORA-1578 reading LOB at '||cursor_lob.R);
		       badcnt:=badcnt+1;
		    end;
		    cnt:=cnt+1;
		  end loop;
		  dbms_output.put_line('Scanned '||cnt||' rows - saw '||badcnt||' errors');
		end;
		/


		18:45:14 A1NXTL01.OP_PNET2>select * from dba_lobs where segment_name ='SYS_LOB0000630167C00003$$' and owner ='WLI';

OWNER      TABLE_NAME                     COLUMN_NAME                    SEGMENT_NAME                   INDEX_NAME                          CHUNK PCTVERSION  RETENTION  FREEPOOLS CACHE      LOGGING IN_
---------- ------------------------------ ------------------------------ ------------------------------ ------------------------------ ---------- ---------- ---------- ---------- ---------- ------- ---
WLI        JPD_ROFLUXOAPROVACAOSFAPROCESS CG_DATA                        SYS_LOB0000630167C00003$$      SYS_IL0000630167C00003$$             8192          0      10800            NO         NO      YES

1 linha selecionada.



Informe o valor para lob_column_name: CG_DATA
Informe o valor para owner: WLI
Informe o valor para table_name: JPD_ROFLUXOAPROVACAOSFAPROCESS
antigo   9:           (select rowid r, &LOB_COLUMN_NAME L from &OWNER..&TABLE_NAME)
novo   9:           (select rowid r, CG_DATA L from WLI.JPD_ROFLUXOAPROVACAOSFAPROCESS)
Got ORA-1578 reading LOB at AADFOuACyAAB1RLAAE
Got ORA-1578 reading LOB at AADFOuACyAAB1RQAAF
Got ORA-1578 reading LOB at AADFOuACyAAB1RQAAJ
Got ORA-1578 reading LOB at AADFOuACyAAB1RVAAI
Got ORA-1578 reading LOB at AADFOuACyAAB1RZAAB
Got ORA-1578 reading LOB at AADFOuACyAAB1ReAAC
Got ORA-1578 reading LOB at AADFOuACyAAB1ReAAE
Scanned 99 rows - saw 7 errors


update wli.JPD_ROFLUXOAPROVACAOSFAPROCESS
set CG_DATA = NULL
where rowid in ('AADFOuACyAAB1RLAAE', 'AADFOuACyAAB1RQAAF', 'AADFOuACyAAB1RQAAJ', 'AADFOuACyAAB1RVAAI','AADFOuACyAAB1RZAAB','AADFOuACyAAB1ReAAC','AADFOuACyAAB1ReAAE')
/
