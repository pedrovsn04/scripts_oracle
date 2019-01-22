accept GEMUSER  CHAR prompt 'Informe LOGIN A SER CRIADO Exp.: GEM166 ..: '

CREATE USER &GEMUSER  PROFILE DEFAULT 
    IDENTIFIED BY &GEMUSER DEFAULT TABLESPACE LOGIN 
    TEMPORARY TABLESPACE TEMP 
    ACCOUNT UNLOCK;

grant RGEM_USERS  TO &GEMUSER;
grant RGEM_SELECT TO &GEMUSER;
grant RUSER_PRIVS TO &GEMUSER;

insert into GEM.USUARIOBD_CODFIL values (UPPER('&GEMUSER'),SUBSTR('&GEMUSER', 4 ),null,null,null,null)
/

create synonym &GEMUSER .SEQNRRECRET for gem.SEQNRRECRET
/

insert into gem.ger_pdv (
FLSENDESC                                      ,
FLLOCAL                                        ,
DESCMAX                                        ,
TSULTALT                                       ,
CODITPROD                                      ,
CHQPRO                                         ,
FLCODCLI                                       ,
FLPRODLOC                                      ,
FLCODFIL                                       ,
FLNOMCHQ                                       ,
FLEXPLOSAO                                     ,
FLEXPORTACAO                                   ,
CTRLEXPMOV                                     ,
FLREPLICA                                      ,
FLINT                                          ,
FLBALANCA                                      ,
FLCMC7                                         ,
FLCONECTABOMBA                                 ,
FLCUPOMRES                                     ,
FLDESCTOTAL                                    ,
FLGAVETA                                       ,
FLGAVETAOPER                                   ,
FLGAVETASUP                                    ,
FLHRVERAO                                      ,
FLIMPRCHQ                                      ,
FLLOGPISTA                                     ,
FLOFFRED                                       ,
FLRECONC                                       ,
FLREDAUT                                       ,
FLREGNFISC                                     ,
FLREPETEFORMA                                  ,
FLSUPCANCCUP                                   ,
FLSUPCANCITEM                                  ,
FLTECLADOPC                                    ,
HRHORAMAXRED                                   ,
HRHORAMINRED                                   ,
NRMAXCUPOMACUM                                 ,
STRINGAUTENT                                   ,
CODFIL                                         ,
FLSELF                                         ,
NRCUPSELF                                      ,
NUMCXA                                         ,
FLAUTCHQ                                       ,
FLCONVENIO                                     ,
FLTECLAVENDA                                   ,
CAMINHOBANNER                                  ,
LOCALSERVIDORBOMBA                             ,
PORTACOMIMP                                    ,
PORTACOMSCAN                                   ,
TPNOTA_AFERICAO                                ,
TPNOTA_FUGA                                    ,
FLFIDELI                                       ,
FLAGRUPACUPOM                                  ,
FLAGRUPAIMPRESSAO                              ,
HRMAXCUPOMACUM                                 ,
FLVALCLI                                       ,
FLDESCONTOITEM                                 ,
FLDESCONTOTOTAL                                ,
FLVENDORITEM                                   ,
FLRELFUGA                                      ,
FLRELAFERICAO                                  ,
PORTACOMPIN                                    ,
PORTACOMCMC7                                   ,
FLVALIDAESTOQUE                                ,
TPEMISSTOTNFISCAL                              ,
TPIMPRESSORA                                   ,
FLPEDIDOENC                                    ,
FLSUPEROPER                                    ,
FLSERIEPDV                                     ,
FLTECLADOEPROMNOVA                             ,
FLPEDRECOUTRAFILIAL                            ,
FLCANCCUPOMANT                                 ,
FLCMC7IMP                                      ,
FLIMPRELTROCAOPERADOR                          ,
NRDIASLIMPEZA                                  ,
FLPROMOCAO                                     ,
FLPROIBEOFFLINE                                ,
PORTACOMGAVETA                                 ,
FLMOTIVODESCONTO                               ,
FLALTVLRECEBIDO                                ,
PORTACOMBALANCA                                ,
IDENTPESAVEL                                   ,
FLMOVTOOFFLINE                                 ,
PATHMOVTOOFFLINE                               ,
FLSUPERENTSAI                                  ,
FLVALVENDEDOR                                  ,
FLIMPPRODREDUMALINHA                           ,
FLSUPERAUTTEF                                  ,
FLIMPCNFCANCCUPOM                              ,
FLEMITERELCHEQUE                               ,
FLDESCAUTOITEM                                 ,
FLOPERA                                        ,
FLLIBTIT                                       ,
CONDPGTOCB                                     ,
FLGRAVARVENDAOFFLINE                           ,
FLCONFERECHEQUE                                ,
FLMOSTRASALDOSANGRIA                           ,
FLATALHOPROD                                   ,
FLIMPITEMPED                                   ,
FLIMPCODPESADO                            
)
select 
FLSENDESC                                      ,
FLLOCAL                                        ,
DESCMAX                                        ,
TSULTALT                                       ,
CODITPROD                                      ,
CHQPRO                                         ,
FLCODCLI                                       ,
FLPRODLOC                                      ,
FLCODFIL                                       ,
FLNOMCHQ                                       ,
FLEXPLOSAO                                     ,
FLEXPORTACAO                                   ,
CTRLEXPMOV                                     ,
FLREPLICA                                      ,
FLINT                                          ,
FLBALANCA                                      ,
FLCMC7                                         ,
FLCONECTABOMBA                                 ,
FLCUPOMRES                                     ,
FLDESCTOTAL                                    ,
FLGAVETA                                       ,
FLGAVETAOPER                                   ,
FLGAVETASUP                                    ,
FLHRVERAO                                      ,
FLIMPRCHQ                                      ,
FLLOGPISTA                                     ,
FLOFFRED                                       ,
FLRECONC                                       ,
FLREDAUT                                       ,
FLREGNFISC                                     ,
FLREPETEFORMA                                  ,
FLSUPCANCCUP                                   ,
FLSUPCANCITEM                                  ,
FLTECLADOPC                                    ,
HRHORAMAXRED                                   ,
HRHORAMINRED                                   ,
NRMAXCUPOMACUM                                 ,
STRINGAUTENT                                   ,
SUBSTR('&GEMUSER', 4 )                         ,
FLSELF                                         ,
NRCUPSELF                                      ,
NUMCXA                                         ,
FLAUTCHQ                                       ,
FLCONVENIO                                     ,
FLTECLAVENDA                                   ,
CAMINHOBANNER                                  ,
LOCALSERVIDORBOMBA                             ,
PORTACOMIMP                                    ,
PORTACOMSCAN                                   ,
TPNOTA_AFERICAO                                ,
TPNOTA_FUGA                                    ,
FLFIDELI                                       ,
FLAGRUPACUPOM                                  ,
FLAGRUPAIMPRESSAO                              ,
HRMAXCUPOMACUM                                 ,
FLVALCLI                                       ,
FLDESCONTOITEM                                 ,
FLDESCONTOTOTAL                                ,
FLVENDORITEM                                   ,
FLRELFUGA                                      ,
FLRELAFERICAO                                  ,
PORTACOMPIN                                    ,
PORTACOMCMC7                                   ,
FLVALIDAESTOQUE                                ,
TPEMISSTOTNFISCAL                              ,
TPIMPRESSORA                                   ,
FLPEDIDOENC                                    ,
FLSUPEROPER                                    ,
FLSERIEPDV                                     ,
FLTECLADOEPROMNOVA                             ,
FLPEDRECOUTRAFILIAL                            ,
FLCANCCUPOMANT                                 ,
FLCMC7IMP                                      ,
FLIMPRELTROCAOPERADOR                          ,
NRDIASLIMPEZA                                  ,
FLPROMOCAO                                     ,
FLPROIBEOFFLINE                                ,
PORTACOMGAVETA                                 ,
FLMOTIVODESCONTO                               ,
FLALTVLRECEBIDO                                ,
PORTACOMBALANCA                                ,
IDENTPESAVEL                                   ,
FLMOVTOOFFLINE                                 ,
PATHMOVTOOFFLINE                               ,
FLSUPERENTSAI                                  ,
FLVALVENDEDOR                                  ,
FLIMPPRODREDUMALINHA                           ,
FLSUPERAUTTEF                                  ,
FLIMPCNFCANCCUPOM                              ,
FLEMITERELCHEQUE                               ,
FLDESCAUTOITEM                                 ,
FLOPERA                                        ,
FLLIBTIT                                       ,
CONDPGTOCB                                     ,
FLGRAVARVENDAOFFLINE                           ,
FLCONFERECHEQUE                                ,
FLMOSTRASALDOSANGRIA                           ,
FLATALHOPROD                                   ,
FLIMPITEMPED                                   ,
FLIMPCODPESADO                            
from gem.ger_pdv
where codfil = 150
 and nuMcxa in (1,2,3)
/

UPDATE GEM.CAD_FILIAL_COMPL 
SET DTVERSAOSP4 = SYSDATE
WHERE CODFIL = substr('&GEMUSER',4,6) 
AND DTVERSAOSP4 IS NULL 
/

SET PAGES 0
SET FEED  OFF
SPOOL SYNONYM_GEM.LST
select 'create or replace synonym &GEMUSER'||'.'|| OBJECT_NAME|| ' FOR '||OWNER||'.'||OBJECT_NAME||';'
	FROM DBA_OBJECTS 
	WHERE OWNER = 'GEM' 
	AND 	OBJECT_TYPE IN ('PACKAGE','FUNCTION','PROCEDURE','SEQUENCE','TABLE','VIEW')
/
SPOOL OFF
 
SET FEED ON
SET PAGES 24
 START SYNONYM_GEM.LST
set pages 1000


