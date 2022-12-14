CREATE OR REPLACE VIEW AVOIRFCFILLE_FACTURE
AS
   SELECT fc.ID,
          fc.IDMERE,
          fc.IDDETAILFACTURE,
          fc.MONTANT,
          fcf.COMPTE,
          fc.REMISE,
          fc.DATY,
          fc.IDFACTURE,
          fc.ETAT,
          fc.DESIGNATION,
          fc.CODE,
          
          fc.CATEGORIE,
          fc.MOTIF,
          fc.TYPE,
          fcf.RUBRIQUE,
          MONTANTAVOIRAVECTAUX AS montantAR,
          fcf.daty as datyFact
     FROM AVOIRFCFILLE_FM fc
          LEFT JOIN FACTURE_CLIENT_MONTANT fcf ON fc.IDDETAILFACTURE = fcf.ID;


CREATE OR REPLACE VIEW COMPTECAAVOIR

AS
   SELECT fdc.ID,
          IDMERE,
          IDDETAILFACTURE,
          fdc.MONTANTAR AS MONTANT,
          --COMPTE,
          REMISE,
          DATY,
          IDFACTURE,
          ETAT,
          DESIGNATION,
          CODE,
          CATEGORIE,
          MOTIF,
          TYPE,
          EXTRACT (MONTH FROM fdc.daty) AS mois,
          EXTRACT (YEAR FROM fdc.daty) AS annee,
          cca.val AS compte,
          fdc.RUBRIQUE,
          cca.desce,
          CCA.ID as idCA,
          EXTRACT (MONTH FROM fdc.datyfact) AS moisFact,
          EXTRACT (YEAR FROM fdc.datyfact) AS anneeFact
     FROM CompteCA cca, MereCA mca, AVOIRFCFILLE_FACTURE fdc
    WHERE     fdc.compte LIKE cca.val || '%'
          AND fdc.compte IS NOT NULL
          AND cca.desce = mca.id
          AND fdc.TYPE != 1;


CREATE OR REPLACE VIEW COMPTECAAVOIRMOISAN
AS
     SELECT cca.rubrique,
            cca.compte,
            cca.DESCE AS mere,
            CAST (SUM (MONTANT) AS NUMBER (32, 3)) AS montant,
            cca.mois,
            cca.annee,
            cca.idca,
            cca.moisFact,
            cca.anneeFact
       FROM CompteCAAvoir cca
       where cca.etat>=11
   GROUP BY cca.rubrique,
            cca.DESCE,
            cca.mois,
            cca.annee,
            cca.compte,
            cca.idca,
            cca.moisFact,
            cca.anneeFact;
          
CREATE OR REPLACE VIEW COMPTECAFACTAVOIR
AS
   SELECT nvl(cca."RUBRIQUE",CCAVOIR.RUBRIQUE) as rubrique,
          nvl(cca."RUBRIQUELIB",ra.designation) as RUBRIQUELIB,
          nvl(cca."COMPTE",CCAVOIR.COMPTE) as compte,
          nvl(cca."LIBELLE",coa.libelle) as libelle,
          nvl(cca."COMPTEMERE",mca.val )as comptemere,
          nvl(cca."COMPTEMERELIB",mca.desce) as COMPTEMERELIB,
          nvl(cca."MERE",CCAVOIR.MERE) as mere,
          nvl(cca."MOIS",ccavoir.mois) as mois,
          nvl(cca."ANNEE",ccavoir.annee) as annee,
          CAST (nvl(cca."NBREACREDIT",0) AS NUMBER (10)) AS nbCredit,
          CAST (nvl(cca."AUCOMPTANT",0) AS NUMBER (10)) AS nbComptant,
          CAST (nvl(cca."MONTANTACREDIT",0) AS NUMBER (30, 3)) AS credit,
          CAST (nvl(cca."MONTANTAUCOMPTANT",0) AS NUMBER (30, 3)) comptant,
          CAST (nvl(cca."MONTANT",0) AS NUMBER (30, 3)) AS MONTANT,
          CAST (NVL (ccavoir.montant, 0) AS NUMBER (30, 3)) AS avoir,
          nvl(ccavoir.moisfact,cca.mois) as moisFact,
          nvl(ccavoir.anneefact,cca.annee) as anneeFact
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

         
         
CREATE OR REPLACE VIEW COMPTECAFACTAVOIR_GRP
(
   RUBRIQUE,
   RUBRIQUELIB,
   COMPTE,
   LIBELLE,
   COMPTEMERE,
   COMPTEMERELIB,
   MERE,
   MOIS,
   ANNEE,
   moisFact,
   anneeFact,
   NBCREDIT,
   NBCOMPTANT,
   CREDIT,
   COMPTANT,
   MONTANT,
   AVOIR
)
AS
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
            CAST (SUM (AVOIR) AS NUMBER (30, 3)) AS AVOIR
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
            AnneeFact;