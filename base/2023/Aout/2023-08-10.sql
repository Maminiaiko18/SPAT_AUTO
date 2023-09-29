CREATE OR REPLACE FORCE VIEW "SPAT_DEVELOP"."FACTUREFOURNVALIDE_TOUS" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDPREVISION", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "MONTANTPAYE", "MONTANTRESTE", "TIERSLIB", "CONTACT", "ADRESSE", "ESCALE", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "ESTDDPMICTSL", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "MONTANTTTCVRAI", "ETATLIB", "IDBL", "NUMEROOP", "PROJET", "CODE_ETABLISSEMENT", "PROJETLIB", "CODE_ETABLISSEMENTLIB", "NATURE", "NATURELIB", "IDBC", "NUMOP", "EXERCICE", "IDENGAGEMENT", "IDENGAGEMENTLIB", "CODEETABLISSEMENT", "IDOP", "IDREFPMT", "VALCAISSEREFPMT", "NUMPIECEREFPMT", "DATEEFFETREFPMT", "LIBELLEREFPMT", "DEBITREFPMT", "NUMCHEQUEREFPMT", "DATEFACTURE", "NUMBC", "NUMBED", "NUMFSB", "MODEPAIEMENT", "DATEREGUL") AS 
  SELECT
  ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, 
  cast(MONTANT as number(30, 2)) AS MONTANT,
  cast(MONTANTTVA as number(30, 2)) AS MONTANTTVA,
  cast(MONTANTAVOIR as NUMBER(30, 2)) AS MONTANTAVOIR,
  cast(MONTANTTTC as number(30, 2)) as MONTANTTTC,
  cast(MONTANTPAYE as number(30, 2)) AS MONTANTPAYE,
  cast(MONTANTRESTE as number(30, 2)) AS MONTANTRESTE,
  TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION,
   IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL,
    CODEPROVISION,   cast(MONTANTTTCVRAI as number(30, 2)) AS MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, 
    CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT, 
    IDOP, IDREFPMT, VALCAISSEREFPMT, NUMPIECEREFPMT, DATEEFFETREFPMT, LIBELLEREFPMT, cast(DEBITREFPMT as number(30, 2)) AS DEBITREFPMT, NUMCHEQUEREFPMT, DATEFACTURE, NUMBC, NUMBED,NUMFSB, MODEPAIEMENT,dateregul
  from(select ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       ETAT,
       IDPREVISION,
         cast(MONTANT as number(30, 2)) AS MONTANT,
  cast(MONTANTTVA as number(30, 2)) AS MONTANTTVA,
  cast(MONTANTAVOIR as NUMBER(30, 2)) AS MONTANTAVOIR,
  cast(MONTANTTTC as number(30, 2)) as MONTANTTTC,
  cast(MONTANTPAYE as number(30, 2)) AS MONTANTPAYE,
  cast(MONTANTRESTE as number(30, 2)) AS MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       ESTDDPMICTSL,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       cast(MONTANTTTCVRAI as number(30, 3)) AS MONTANTTTCVRAI,
       ETATLIB,
       IDBL,
       NUMEROOP,
       PROJET,
       CODE_ETABLISSEMENT,
       PROJETLIB,
       CODE_ETABLISSEMENTLIB,
       NATURE,
       NATURELIB,
       IDBC,
       numop,
       exercice,
      IDENGAGEMENT,
       IDENGAGEMENTLIB,
       codeetablissement,
       idop
,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt
 ,numchequerefpmt
 ,DATEFACTURE,
NUMBC 
, numBed
,numFSB
,MODEPAIEMENT
,dateregul
from (
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                ETAT,
                IDPREVISION,
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                ESTDDPMICTSL,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                'CREE'             as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
               IDENGAGEMENT,
                IDENGAGEMENTLIB,
                CODE_ETABLISSEMENT as codeetablissement,
                idop
,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt
 ,numchequerefpmt
  ,DATEFACTURE,
NUMBC 
, numBed
,numFSB
,MODEPAIEMENT
,dateregul
       from FACTUREFOURNVALIDE_C
         union
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                ETAT,
                IDPREVISION,
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                ESTDDPMICTSL,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                'VISE'             as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
               IDENGAGEMENT,
                IDENGAGEMENTLIB,
                CODE_ETABLISSEMENT as codeetablissement,
                idop
                ,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt
 ,numchequerefpmt
 ,DATEFACTURE,
NUMBC 
, numBed
,numFSB
,MODEPAIEMENT
,dateregul
        from FACTUREFOURNVALIDE_V
         union
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                ETAT,
                IDPREVISION,
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                ESTDDPMICTSL,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                'EN ATTENTE DE PAYEMENT'             as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
               IDENGAGEMENT,
                IDENGAGEMENTLIB,
                CODE_ETABLISSEMENT as codeetablissement,
                idop
                ,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt
 ,numchequerefpmt
  ,DATEFACTURE,
NUMBC 
, numBed
,numFSB
,MODEPAIEMENT
,dateregul
       from FACTUREFOURNVALIDE_ep
         union
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                ETAT,
                IDPREVISION,
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                ESTDDPMICTSL,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                'PAYE'             as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
               IDENGAGEMENT,
                IDENGAGEMENTLIB,
                CODE_ETABLISSEMENT as codeetablissement,
                idop
                ,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt
 ,numchequerefpmt
  ,DATEFACTURE,
NUMBC 
, numBed
,numFSB
,MODEPAIEMENT
,dateregul
       from FACTUREFOURNVALIDE_p))
         

;
