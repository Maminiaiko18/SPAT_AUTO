CREATE OR REPLACE VIEW CAFCFILLECOMPLET (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT) AS 
  SELECT ff.ID,
          IDMERE,
          DESIGNATION,
          QUANTITE,
          PU,
          COMPTE,
          IDPRODUIT,
          DEVISE,
          TAUX,
          IDACTIVITE,
          TVA,
          DATEFACT,
          RUBRIQUE,
         cast(MOIS as NUMBER(10)),
         cast(ANNEE as NUMBER(10)),
          HEUREDEBUT,
          HEUREFIN,
          REDUCTION,
          MAJORATION,
          TEST,
          RANG,
          DUREE,
         cast(MONTANTAV as NUMBER(30,3)),
          RUBRIQUECPL,
          DATY,
          TIERS,
          IDCATEGORIE,
          ff.TYPE,
          DEVISEMERE,
          EXERCICE,
          IDAVOIR,
          ff.ETAT,
         cast(MTAVOIR as NUMBER(30,2)),
         cast(MONTANTREDUCTION as NUMBER(30,2)),
         cast(MONTANTMAJORATION as NUMBER(30,2)),
         cast(MONTANT as NUMBER(30,2)),
         cast(MONTANTTVA as NUMBER(30,2)),
         cast(MONTANTTTC as number(30,2)),
          moislib,
         cast(MONTANTHTSIMPLE as NUMBER(30,2)),
          ff.client
     FROM fcfillecomplet ff
     WHERE FF.IDCATEGORIE <> 'CATFCO2' AND FF.IDCATEGORIE <> 'CATFCO1'  and etat>=11;


ALTER TABLE engagement ADD num  varchar(50) ; 



CREATE OR REPLACE  VIEW "SPAT_CAPITAINERIE"."ENGAGEMENTLIB" ("ID", "DESIGNATION", "CODEETABLISSEMENT", "PROJET", "MONTANT", "DISPOAVANT", "DISPOAPRES", "COMPTE", "ETAT", "CODEETABLISSEMENTLIB", "PROJETLIB", "IDLC", "IDLCLIB", "DATY", "AVECFACTURE", "AVECFACTURELIB", "MONTANTOP", "DISPONIBLE", "TIERS", "TIERSLIB" , "NUM") AS 
  select e."ID",
       e."DESIGNATION",
       nvl(e."CODEETABLISSEMENT", lp.CODEETABLISSEMENT) as CODEETABLISSEMENT,
       nvl(e."PROJET", lp.PROJET)                       as PROJET,
       e."MONTANT",
       --e."DISPONIBLE",
       e."DISPOAVANT",
       e."DISPOAPRES",
       e."COMPTE",
       e."ETAT",
       nvl(ce.VAL, ce1.val)                             as codeetablissementlib,
       nvl(p.DESIGNATION, p1.designation)               as projetlib,
       e.IDLC,
       lp.DESIGNATION                                   as idLClib,
       DATY,
       AVECFACTURE,
       case
           when avecFacture = 0 then 'NON'
           when avecFacture = 1 then 'OUI'
           end                                          as avecFacturelib,
       cast(nvl(gr.montant, 0) as NUMBER(30, 2))        as montantop,
       cast(e.MONTANT- nvl(eng.MONTANTTAUX,0)-nvl(lib.montant, 0) as NUMBER(30, 2))        as disponible , 
       e.tiers , 
       t.NOM AS tierslib , 
       e.num
from engagement e
         left join CODEETABLISSEMENT ce on ce.ID = e.CODEETABLISSEMENT
         left join PROJET p on p.ID = e.PROJET
         left join LIGNECREDITDEPENSE lp on e.IDLC = lp.ID
         left join CODEETABLISSEMENT ce1 on ce1.ID = lp.CODEETABLISSEMENT
         left join PROJET p1 on p1.ID = lp.PROJET
         left join engagementOPMontant gr on gr.idengagement = e.ID
         left join FACTFOURN_ENGAGEMENT eng on eng.IDENGAGEMENT=e.id
         left join LIBERER_MONTANT lib on lib.IDENGAGEMENT=e.ID
    	 LEFT JOIN TIERS t ON t.id = e.tiers;

    	
    	
CREATE SEQUENCE   seqNumeroEngagement
 	INCREMENT  BY  1 
    MINVALUE 1 
    MAXVALUE 999999999999999
    START  WITH  1  
    CACHE 20  ;
    
   
CREATE OR REPLACE FUNCTION getseqNumeroEngagement          		
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqNumeroEngagement.nextval INTO retour FROM dual;
  return retour;	
END;  	