--create view 
CREATE OR REPLACE  VIEW DEVISEDEMAT (ID, VAL, DESCE) AS 
  select id,val,desce
from devise;

----create view 
CREATE OR REPLACE  VIEW SOLDECAISSE (DATEEFFET, CAISSE, SOLDE) AS 
  select dateEffet, caisse, sum(CREDIT)-sum(DEBIT) as solde from journalCaisse group by dateEffet,caisse;
  
  
  
  ----create table grandrubrique
CREATE TABLE grandrubrique (
id varchar(100) CONSTRAINT grandrubrique_pk PRIMARY KEY,
val varchar(100),
desce varchar(100) 
);



CREATE SEQUENCE seqgrandrubrique INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999999999 NOCYCLE CACHE 20 NOORDER; 

CREATE OR REPLACE FUNCTION getSeqgrandrubrique
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqgrandrubrique.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;



-----ajout column idgrandrubrique
ALTER TABLE mereca ADD idgrandrubrique varchar(100) CONSTRAINT mereca_grandrub_fk REFERENCES grandrubrique(id);

CREATE OR REPLACE  VIEW COMPTECAFACTAVOIR (RUBRIQUE, RUBRIQUELIB, COMPTE, LIBELLE, COMPTEMERE, COMPTEMERELIB, MERE, MOIS, ANNEE, NBCREDIT, NBCOMPTANT, CREDIT, COMPTANT, MONTANT, AVOIR, MOISFACT, ANNEEFACT,IDGRANDRUBRIQUE) AS 
  SELECT nvl(cca.RUBRIQUE,CCAVOIR.RUBRIQUE) as rubrique,
          nvl(cca.RUBRIQUELIB,ra.designation) as RUBRIQUELIB,
          nvl(cca.COMPTE,CCAVOIR.COMPTE) as compte,
          nvl(cca.LIBELLE,coa.libelle) as libelle,
          nvl(cca.COMPTEMERE,mca.val )as comptemere,
          nvl(cca.COMPTEMERELIB,mca.desce) as COMPTEMERELIB,
          nvl(cca.MERE,CCAVOIR.MERE) as mere,
          nvl(cca.MOIS,ccavoir.mois) as mois,
          nvl(cca.ANNEE,ccavoir.annee) as annee,
          CAST (nvl(cca.NBREACREDIT,0) AS NUMBER (10)) AS nbCredit,
          CAST (nvl(cca.AUCOMPTANT,0) AS NUMBER (10)) AS nbComptant,
          CAST (nvl(cca.MONTANTACREDIT,0) AS NUMBER (30, 3)) AS credit,
          CAST (nvl(cca.MONTANTAUCOMPTANT,0) AS NUMBER (30, 3)) comptant,
          CAST (nvl(cca.MONTANT,0) AS NUMBER (30, 3)) AS MONTANT,
          CAST (NVL (ccavoir.montant, 0) AS NUMBER (30, 3)) AS avoir,
          nvl(ccavoir.moisfact,cca.mois) as moisFact,
          nvl(ccavoir.anneefact,cca.annee) as anneeFact,
          mca.IDGRANDRUBRIQUE 
     FROM CompteCAFactureMoisAn cca
         FULL OUTER  JOIN CompteCAAvoirMoisAn ccavoir
             ON     cca.mois = ccavoir.mois
                AND cca.annee = ccavoir.annee
                AND cca.compte = ccavoir.compte
                AND cca.mere = ccavoir.mere
                AND cca.RUBRIQUE = ccavoir.RUBRIQUE
                and cca.mois=ccavoir.moisfact
                and cca.annee=ccavoir.annee
    left join compteca coa on coa.id=ccavoir.idca
    left join mereca mca on mca.id=ccavoir.mere 
    left join rubrique_activite ra on ra.id=ccavoir.rubrique;


CREATE OR REPLACE  VIEW COMPTECAFACTAVOIR_GRP (RUBRIQUE, RUBRIQUELIB, COMPTE, LIBELLE, COMPTEMERE, COMPTEMERELIB, MERE, MOIS, ANNEE, MOISFACT, ANNEEFACT, NBCREDIT, NBCOMPTANT, CREDIT, COMPTANT, MONTANT, AVOIR,IDGRANDRUBRIQUE) AS 
  SELECT CAST ('-' AS VARCHAR2 (100)) AS RUBRIQUE,
            CAST ('-' AS VARCHAR2 (100)) RUBRIQUELIB,
            COMPTE,
            LIBELLE,
            COMPTEMERE,
            COMPTEMERELIB,
            MERE,
            CAST (MOIS AS NUMBER (10)),
            CAST (ANNEE AS NUMBER (10)),
            CAST (MOISFact AS NUMBER (10)),
            CAST (ANNEEFact AS NUMBER (10)),
            CAST (SUM (NBCREDIT) AS NUMBER (10)) AS NBCREDIT,
            CAST (SUM (NBCOMPTANT) AS NUMBER (10)) AS NBCOMPTANT,
            CAST (SUM (CREDIT) AS NUMBER (30, 3)) AS CREDIT,
            CAST (SUM (COMPTANT) AS NUMBER (30, 3)) AS COMPTANT,
            CAST (SUM (MONTANT) AS NUMBER (30, 3)) AS MONTANT,
            CAST (SUM (AVOIR) AS NUMBER (30, 3)) AS AVOIR,
            IDGRANDRUBRIQUE
       FROM CompteCAFactAvoir
   GROUP BY CAST ('-' AS VARCHAR2 (100)),
            CAST ('-' AS VARCHAR2 (100)),
            COMPTE,
            LIBELLE,
            COMPTEMERE,
            COMPTEMERELIB,
            MERE,
            MOIS,
            ANNEE,
            moisFact,
            AnneeFact,
           IDGRANDRUBRIQUE;
		   	  
		   
CREATE OR REPLACE  VIEW COMPTECAFACTUREMOISAN (RUBRIQUE, RUBRIQUELIB, COMPTE, LIBELLE, COMPTEMERE, COMPTEMERELIB, MERE, MOIS, ANNEE, NBREACREDIT, AUCOMPTANT, MONTANTACREDIT, MONTANTAUCOMPTANT, MONTANT,idgrandrubrique) AS 
  select cca.rubrique,
       r.DESIGNATION                                              as rubriquelib,
       cca.compte,
       cc.LIBELLE,
       c.VAL as comptemere,
       c.DESCE comptemerelib,
       cca.DESCE as mere,
       mois,
       ANNEE,
       -- mereca,
       sum(case when TYPE = 'TFC001' then 1 else 0 end)           as nbreacredit,
       sum(case when TYPE = 'TFC002' then 1 else 0 end)           as aucomptant,
       sum(case when TYPE = 'TFC001' then MONTANTTAUX else 0 end) as montantacredit,
       sum(case when TYPE = 'TFC002' then MONTANTTAUx else 0 end) as montantaucomptant,
       sum(case when TYPE = 'TFC001' then MONTANTTAUX else 0 end) +
       sum(case when TYPE = 'TFC002' then MONTANTTAUx else 0 end) as montant,
       c.IDGRANDRUBRIQUE 
from CompteCAFacture cca
         left join MERECA c on c.ID = cca.DESCE
         left join COMPTECA cc on cc.VAL = cca.VAL
         left join RUBRIQUE_ACTIVITE r on r.id = cca.RUBRIQUE
group by cca.rubrique,
         cca.compte,
         cca.DESCE, mois, ANNEE, c.VAL, c.DESCE, r.DESIGNATION,cc.LIBELLE,c.IDGRANDRUBRIQUE;
CREATE OR REPLACE  VIEW COMPTECAFACTAVOIR (RUBRIQUE, RUBRIQUELIB, COMPTE, LIBELLE, COMPTEMERE, COMPTEMERELIB, MERE, MOIS, ANNEE, NBCREDIT, NBCOMPTANT, CREDIT, COMPTANT, MONTANT, AVOIR, MOISFACT, ANNEEFACT, IDGRANDRUBRIQUE) AS 
  SELECT nvl(cca.RUBRIQUE,CCAVOIR.RUBRIQUE) as rubrique,
          nvl(cca.RUBRIQUELIB,ra.designation) as RUBRIQUELIB,
          nvl(cca.COMPTE,CCAVOIR.COMPTE) as compte,
          nvl(cca.LIBELLE,coa.libelle) as libelle,
          nvl(cca.COMPTEMERE,mca.val )as comptemere,
          nvl(cca.COMPTEMERELIB,mca.desce) as COMPTEMERELIB,
          nvl(cca.MERE,CCAVOIR.MERE) as mere,
          nvl(cca.MOIS,ccavoir.mois) as mois,
          nvl(cca.ANNEE,ccavoir.annee) as annee,
          CAST (nvl(cca.NBREACREDIT,0) AS NUMBER (10)) AS nbCredit,
          CAST (nvl(cca.AUCOMPTANT,0) AS NUMBER (10)) AS nbComptant,
          CAST (nvl(cca.MONTANTACREDIT,0) AS NUMBER (30, 3)) AS credit,
          CAST (nvl(cca.MONTANTAUCOMPTANT,0) AS NUMBER (30, 3)) comptant,
          CAST (nvl(cca.MONTANT,0) AS NUMBER (30, 3)) AS MONTANT,
          CAST (NVL (ccavoir.montant, 0) AS NUMBER (30, 3)) AS avoir,
          nvl(ccavoir.moisfact,cca.mois) as moisFact,
          nvl(ccavoir.anneefact,cca.annee) as anneeFact,
          nvl(cca.idgrandrubrique,mca.IDGRANDRUBRIQUE) AS idgrandrubrique 
     FROM CompteCAFactureMoisAn cca
         FULL OUTER  JOIN CompteCAAvoirMoisAn ccavoir
             ON     cca.mois = ccavoir.mois
                AND cca.annee = ccavoir.annee
                AND cca.compte = ccavoir.compte
                AND cca.mere = ccavoir.mere
                AND cca.RUBRIQUE = ccavoir.RUBRIQUE
                and cca.mois=ccavoir.moisfact
                and cca.annee=ccavoir.annee
    left join compteca coa on coa.id=ccavoir.idca
    left join mereca mca on mca.id=ccavoir.mere 
    left join rubrique_activite ra on ra.id=ccavoir.rubrique

;

