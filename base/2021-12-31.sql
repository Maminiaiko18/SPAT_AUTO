CREATE OR REPLACE VIEW COMPTECAFACTAVOIR_GRP
            (RUBRIQUE, RUBRIQUELIB, COMPTE, LIBELLE, COMPTEMERE, COMPTEMERELIB, MERE, MOIS, ANNEE, NBCREDIT, NBCOMPTANT,
             CREDIT, COMPTANT, MONTANT, AVOIR)
AS
select cast('-' as VARCHAR2(100)) as RUBRIQUE,
       cast('-' as varchar2(100))    RUBRIQUELIB,
       COMPTE,
       LIBELLE,
       COMPTEMERE,
       COMPTEMERELIB,
       MERE,
       MOIS,
       ANNEE,
       cast(sum(NBCREDIT) as number(30,3))              as NBCREDIT,
       cast(sum(NBCOMPTANT) as number(30,3))            as NBCOMPTANT,
       cast(sum(CREDIT) as number(30,3))                as CREDIT,
       cast(sum(COMPTANT) as NUMBER(30,3))              as COMPTANT,
       cast(sum(MONTANT) as NUMBER(30,3))               as MONTANT,
       cast(sum(AVOIR) as NUMBER(30,3))                 as AVOIR
from CompteCAFactAvoir
group by cast('-' as VARCHAR2(100)), cast('-' as varchar2(100)), COMPTE, LIBELLE, COMPTEMERE, COMPTEMERELIB, MERE, MOIS,
         ANNEE;

		 
	
  CREATE OR REPLACE  VIEW COMPTECAFACTAVOIR_GRP ("RUBRIQUE", "RUBRIQUELIB", "COMPTE", "LIBELLE", "COMPTEMERE", "COMPTEMERELIB", "MERE", "MOIS", "ANNEE", "NBCREDIT", "NBCOMPTANT", "CREDIT", "COMPTANT", "MONTANT", "AVOIR") AS
  select cast('-' as VARCHAR2(100)) as RUBRIQUE,
       cast('-' as varchar2(100))    RUBRIQUELIB,
       COMPTE,
       LIBELLE,
       COMPTEMERE,
       COMPTEMERELIB,
       MERE,
         cast(MOIS as NUMBER(10)),
         cast(ANNEE as number(10)),
       cast(sum(NBCREDIT) as number(10))              as NBCREDIT,
       cast(sum(NBCOMPTANT) as number(10))            as NBCOMPTANT,
       cast(sum(CREDIT) as number(30,3))                as CREDIT,
       cast(sum(COMPTANT) as NUMBER(30,3))              as COMPTANT,
       cast(sum(MONTANT) as NUMBER(30,3))               as MONTANT,
       cast(sum(AVOIR) as NUMBER(30,3))                 as AVOIR
from CompteCAFactAvoir
group by cast('-' as VARCHAR2(100)), cast('-' as varchar2(100)), COMPTE, LIBELLE, COMPTEMERE, COMPTEMERELIB, MERE, MOIS,
         ANNEE;

create or replace view COMPTECAFACTURE as
select fdc.ID,
       cca.VAL,
       cca.DESCE,
       IDMERE,
       DESIGNATION,
       QUANTITE,
       PU,
       IDPRODUIT,
       DEVISE,
       TAUX,
       QTELIVREE,
       RESTEALIVRER,
       MONTANTTAUX,
       MONTANT,
       MONTANTAVOIRSANSTAUX,
       MONTANTAVOIRAVECTAUX,
       TVA,
       IDACTIVITE,
       ACTIVITELIB,
       HEUREDEBUT,
       HEUREFIN,
       MOISLIB,
       TAUXEURO,
       MONTANTHTEURO,
       MONTANTTVAEURO,
       MONTANTTAXE,
       MAJORATION,
       REDUCTION,
       DATEFACT,
       RUBRIQUE,
       RANG,
       DATY,
       mca.val                      as valMereCA,
       mca.desce                    as desceMereCA,
       extract(month from fdc.daty) as mois,
       extract(year from fdc.daty)  as annee,
       cca.val                      as compte,
       TYPE,
       cca.DESCE as mereca
from CompteCA cca,
     MereCA mca,
     FACT_CLT_FILL_LIB_REST_TAXE fdc
where fdc.compte like cca.val || '%'
  and fdc.compte is not null;