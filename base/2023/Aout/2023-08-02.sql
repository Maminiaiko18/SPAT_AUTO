
  -------add column devisemere
ALTER TABLE 
as_bondecommande ADD devisemere varchar(100) ;

  -------add column devisemere
CREATE OR REPLACE  VIEW AS_BONDECOMMANDE_LIB_FICHE (ID, DATY, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, NUMBC, PROJET, CODE_ETAB, CODEETABLISSEMENT, IDENGAGEMENTLIB, IDENGAGEMENT, ETAT, ETATLIB, MONTANTHTSANSREMISE, MONTANTREMISE, MONTANT, TVA, MONTANTTVA, MONTANTTTC, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, MONTANTFACTURE, COMPTEBDG, IDFACTURE, IDPROJET, IDFOURNISSEUR,devisemere) AS 
 SELECT
	al.ID,
	al.DATY,
	al.REMARQUE,
	al.DESIGNATION,
	al.MODEPAIEMENT,
	al.FOURNISSEUR,
	al.NUMBC,
	al.PROJET,
	al.CODE_ETAB,
	al.CODEETABLISSEMENT,
	al.IDENGAGEMENTLIB,
	al.IDENGAGEMENT,
	al.ETAT,
	al.ETATLIB,
	CAST(al.MONTANTHTSANSREMISE AS NUMBER(30,2)),
	CAST(al.MONTANTREMISE AS NUMBER(30,2)),
	CAST(al.MONTANT AS NUMBER(30,2)),
	al.TVA,
	CAST(al.MONTANTTVA AS NUMBER(30,2)),
	CAST(al.MONTANTTTC AS NUMBER(30,2)),
	CAST(al.MONTANT_PAYE_REEL AS NUMBER(30,2)),
	CAST(al.RESTEPAYERGENERAL AS NUMBER(30,2)),
	CAST(al.RESTEAPAYERREEL AS NUMBER(30,2)),
	CAST(al.MONTANT_A_PAYER AS NUMBER(30,2)),
	CAST(al.MONTANTFACTURE AS NUMBER(30,2)),
	al.COMPTEBDG,
	al.IDFACTURE,
	ab.PROJET AS idprojet,
	ab.FOURNISSEUR AS idfournisseur,
	ab.devisemere
FROM
	AS_BONDECOMMANDE_LIBELLE_lib al
	LEFT JOIN AS_BONDECOMMANDE ab ON ab.ID =al.ID ;

CREATE OR REPLACE  VIEW UNION_BC_SPAT_CEMEDI (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, PROJET, CODE_ETAB, DELAIPAIEMENT, DELAILIVRAISON, TYPEPAIEMENT, IDENGAGEMENT,devisemere) AS 
  select ID,
       DATY,
       ETAT,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       NUMBC,
       PROJET,
       CODE_ETAB,
       DELAIPAIEMENT,
       DELAILIVRAISON,
       TYPEPAIEMENT,IDENGAGEMENT,
       devisemere
from AS_BONDECOMMANDE
union
select id,
       daty,
       etat,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       REFERENCE as          NUMBC,
       ''        as          PROJET,
       ''        as          CODE_ETAB,
       cast(0 as number(10)) DELAIPAIEMENT,
       ''        as          DELAILIVRAISON,
       ''        as          TYPEPAIEMENT,
       ''        as          IDENGAGEMENT,
       ''        AS           devisemere
from bc_cemedi_vue;


  -------add column devisemere
CREATE OR REPLACE  VIEW AS_BONDECOMMANDE_LIBELLE (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, CODE_ETAB, PROJET, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT,devisemere) AS 
  select
  bc.id,
  bc.daty,
  bc.etat,
  bc.remarque,
  bc.designation,
  mp.val as modepaiement,
  bc.fournisseur,
  bc.tva,
  bc.NUMBC,
  ce.val as CODE_ETAB,
  pe.designation as PROJET,
  IDENGAGEMENT,
  en.DESIGNATION as idengagementlib,
  bc.CODE_ETAB as codeetablissement,
   bc.devisemere
  from
  union_bc_spat_cemedi bc
  join modepaiement mp on bc.modepaiement = mp.id
  left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
  left join PROJET pe on pe.id = bc.projet
  left join ENGAGEMENT en on bc.IDENGAGEMENT = en.ID;

  
  -------add column devisemere
CREATE OR REPLACE  VIEW AS_BONDECOMMANDE_LIBELLE_LIB (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA, MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET, CODE_ETAB, MONTANTFACTURE, ETATLIB, MONTANTREMISE, IDENGAGEMENTLIB, IDENGAGEMENT, CODEETABLISSEMENT, COMPTEBDG, MONTANTHTSANSREMISE,devisemere) AS 
  select
  bc.id,
  bc.daty,
  bc.etat,
  bc.remarque,
  bc.designation,
  bc.modepaiement,
  ti.NOM as fournisseur,
  cast(bc.tva as NUMBER (10)),
  bc.NUMBC,
  cast(nvl (c.montantht, 0) as number (32, 2)),
  cast(nvl (c.montanttva, 0) as number (32, 2)),
  cast(nvl (c.montantttc, 0) as NUMBER (32, 2)),
  '' as idfacture,
  cast(nvl (lfac.montantpayer, 0) as number (32, 2)) as montant_paye_reel,
  cast(
    (nvl (c.montantttc, 0) - nvl ((bl.MONTANTTTC), 0)) as NUMBER (32, 2)
  ) as resteapayegeneral,
  cast(
    (
      nvl (c.montantttc, 0) - nvl ((lfac.montantpayer), 0)
    ) as NUMBER (32, 2)
  ) as resteapayerreel,
  cast(nvl (bl.montantttc, 0) as NUMBER (32, 2)) as montant_a_payer,
  bc.PROJET,
  bc.CODE_ETAB,
  cast(lfac.montantttc as NUMBER (32, 2)) as montantfacture,
  case
    when bc.etat = 0 then 'ANNULE(E)'
    when bcf.RESTELIVRE > 0 then 'VISE(E)'
    WHEN Bcf.restelivre = 0
    AND Bcf.restefacture > 0 THEN 'LIVRE(E)'
    WHEN bcf.restelivre = 0
    AND Bcf.restefacture = 0
    and (
      lfac.montantttc - nvl (lfac.montantpayer, 0) is not null
    ) THEN 'FACTURE(E)'
    WHEN Bcf.restelivre = 0
    AND Bcf.restefacture = 0
    and lfac.montantttc - nvl (lfac.montantpayer, 0) > 0 THEN 'EN ATTENTE'
    WHEN Bcf.restelivre = 0
    AND Bcf.restefacture = 0
    and lfac.montantttc - nvl (lfac.montantpayer, 0) = 0 THEN 'PAYE(E)'
    else 'CREE(E)'
  END as etatlib,
  cast(MONTANTREMISE as NUMBER (32, 2)),
  idengagementlib,
  bc.IDENGAGEMENT,
  CODEETABLISSEMENT,
  CODE_ETAB || PROJET as comptebdg,
  CAST((c.montantht + montantremise) AS number (30, 3)) AS montantHTSansRemise,
  bc.devisemere
from
  AS_BONDECOMMANDE_LIBELLE bc
  left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
  left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
  left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
  LEFT JOIN AS_BONDELIVRAISON_BC bl on bl.id_bc = bc.id
  left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur;

  
  ---------------rectif devisemere
 CREATE OR REPLACE  VIEW FACTUREFOURNVALIDE_P (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT, IDOP, IDREFPMT, VALCAISSEREFPMT, NUMPIECEREFPMT, DATEEFFETREFPMT, LIBELLEREFPMT, DEBITREFPMT, NUMCHEQUEREFPMT, DATEFACTURE, NUMBC, NUMBED, NUMFSB, MODEPAIEMENT, DATEREGUL) AS 
  select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       ff.TVA,
       ff.REMARQUE,
       ff.IDUSER,
       DATE_ECHEANCE,
       ff.ETAT,
       IDPREVISION,
       ff.MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       ff.TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       ff.TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       ESTDDPMICTSL,
      ff.DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       MONTANTTTCVRAI,
       'PAYE'       as ETATLIB,
       ff.IDBL,
       ff.NUMEROOP,
       ff.projet,
       code_etablissement,
       projetlib,
       code_etablissementlib,
       NATURE,
       NATURELIB,
       IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
      ff.IDENGAGEMENT,
       IDENGAGEMENTLIB,
       CODE_ETABLISSEMENT,
       ord.id AS idop
            ,p.id AS idrefpmt
,p.valcaisse AS valcaisserefpmt
,p.numpiece AS numpiecerefpmt
,p.dateeffet AS dateeffetrefpmt
,p.libelle AS libellerefpmt
,p.debit AS debitrefpmt
,p.numcheque as numchequerefpmt
,ff.DATEFACTURE
,ab.NUMBC 
,bd.numero AS numBed
,
	CASE
		WHEN bd.NUMFSB IS NOT NULL THEN bd.NUMFSB
		ELSE e.num
	END AS NUMFSB
,mod.val as MODEPAIEMENT,
ff.dateregul
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
         left join ORDONNERPAYEMENT ord on li.ID2 = ord.id
         left join PAIEMENTFACTUREF_GRP gr on gr.IDFACT = ff.id
LEFT JOIN PaiementOPJCUnion_op p ON p.idordre=ord.id
LEFT JOIN AS_BONDECOMMANDE ab ON ab.ID = ff.IDBC 
left join modepaiement mod on mod.id=ord.MODEPAIEMENT
LEFT JOIN LIAISONBORDEREAUFF l ON
	l.IDOP = ff.id
LEFT JOIN BORDEREAUFF bd ON
	bd.ID = l.IDBORDEREAU
LEFT JOIN ENGAGEMENT e ON
	e.ID = ff.IDENGAGEMENT
where li.IDJOURNAL is not null
  and li.ETATJC = 11
;

---rectif devisemere
CREATE OR REPLACE  VIEW FACTUREFOURNVALIDE_EP (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT, IDOP, IDREFPMT, VALCAISSEREFPMT, NUMPIECEREFPMT, DATEEFFETREFPMT, LIBELLEREFPMT, DEBITREFPMT, NUMCHEQUEREFPMT, DATEFACTURE, NUMBC, NUMBED, NUMFSB, MODEPAIEMENT, DATEREGUL) AS 
  select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       ff.TVA,
       ff.REMARQUE,
       ff.IDUSER,
       DATE_ECHEANCE,
       ff.ETAT,
       IDPREVISION,
       ff.MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       ff.TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       ff.TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       ESTDDPMICTSL,
       ff.DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       MONTANTTTCVRAI,
       'ATTENTE DE PAIEMENT' as ETATLIB,
       ff.IDBL,
       ff.NUMEROOP,
       ff.projet,
       code_etablissement,
       projetlib,
       code_etablissementlib,
       NATURE,
       NATURELIB,
       IDBC,
       ord.NUMEROOP          as numop,
       ff.exercice,
      ff.IDENGAGEMENT,
       IDENGAGEMENTLIB,
       CODE_ETABLISSEMENT,
       ord.id AS idop
            ,p.id AS idrefpmt
,p.valcaisse AS valcaisserefpmt
,p.numpiece AS numpiecerefpmt
,p.dateeffet AS dateeffetrefpmt
,p.libelle AS libellerefpmt
,p.debit AS debitrefpmt
,p.numcheque as numchequerefpmt
,ff.DATEFACTURE
,ab.NUMBC 
,bd.numero AS numBed
,
	CASE
		WHEN bd.NUMFSB IS NOT NULL THEN bd.NUMFSB
		ELSE e.num
	END AS NUMFSB
,mod.val as MODEPAIEMENT,
ff.dateregul
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
         left join ORDONNERPAYEMENT ord on li.ID2 = ord.id
LEFT JOIN PaiementOPJCUnion_op p ON p.idordre=ord.id
LEFT JOIN AS_BONDECOMMANDE ab ON ab.ID = ff.IDBC 
left join modepaiement mod on mod.id=ord.MODEPAIEMENT
LEFT JOIN LIAISONBORDEREAUFF l ON
	l.IDOP = ff.id
LEFT JOIN BORDEREAUFF bd ON
	bd.ID = l.IDBORDEREAU
LEFT JOIN ENGAGEMENT e ON
	e.ID = ff.IDENGAGEMENT
where (li.IDJOURNAL is not null
    and li.ETATJC = 1)
   or (li.IDJOURNAL is null);

  
  
  -----------rectif devisemere
 CREATE OR REPLACE  VIEW FACTUREFOURNVALIDE_TOUS (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT, IDOP, IDREFPMT, VALCAISSEREFPMT, NUMPIECEREFPMT, DATEEFFETREFPMT, LIBELLEREFPMT, DEBITREFPMT, NUMCHEQUEREFPMT, DATEFACTURE, NUMBC, NUMBED, NUMFSB, MODEPAIEMENT, DATEREGUL) AS 
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




---------add column checkreport
CREATE OR REPLACE  VIEW COMPTECAFACTAVOIR_GRP (RUBRIQUE, RUBRIQUELIB, COMPTE, LIBELLE, COMPTEMERE, COMPTEMERELIB, MERE, MOIS, ANNEE, MOISFACT, ANNEEFACT, NBCREDIT, NBCOMPTANT, CREDIT, COMPTANT, MONTANT, AVOIR,checkreport) AS 
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
            CASE WHEN ANNEE =ANNEEFACT THEN 0 
            ELSE 1 END AS checkreport
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
