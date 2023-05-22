
 CREATE OR REPLACE  VIEW PaiementOPJCUnion_op AS SELECT * FROM PaiementOPJCUnion WHERE IDORDRE IS NOT NULL AND etat=11;

CREATE OR REPLACE  VIEW FACTUREFOURNVALIDE_C (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT,idop,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt) AS 
  select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       ff.TVA,
       ff.REMARQUE,
       ff.IDUSER,
       ff.DATE_ECHEANCE,
       ff.ETAT,
       ff.IDPREVISION,
       ff.MONTANT,
       ff.MONTANTTVA,
       ff.MONTANTAVOIR,
       ff.MONTANTTTC,
       ff.MONTANTPAYE,
       ff.MONTANTRESTE,
       ff.TIERSLIB,
       ff.CONTACT,
       ff.ADRESSE,
       ff.ESCALE,
       ff.TYPELIB,
       ff.IDCATEGORIE,
       ff.CATEGORIELIB,
       ff.IDPROVISION,
       ff.IDPROVISIONLIB,
       ff.ESTDDPMICTSL,
       ff.DEVISEMERE,
       ff.CODEPRESTATION,
       ff.CODEPRESTATIONLIB,
       ff.CODE,
       ff.ESTMICTSL,
       ff.CODEPROVISION,
       ff.ETATLIB,
       ff.MONTANTTTCVRAI,
       ff.IDBL,
       ff.NUMEROOP,
       ff.projet,
       ff.code_etablissement,
       ff.projetlib,
       ff.code_etablissementlib,
       ff.NATURE,
       ff.NATURELIB,
       ff.IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
       IDENGAGEMENT,
       idengagementlib,
       CODE_ETABLISSEMENT as CODEETABLISSEMENT,
       ord.id AS idop
       ,p.id AS idrefpmt
,p.valcaisse AS valcaisserefpmt
,p.numpiece AS numpiecerefpmt
,p.dateeffet AS dateeffetrefpmt
,p.libelle AS libellerefpmt
,p.debit AS debitrefpmt
,p.numcheque as numchequerefpmt
from FACTUREFOURNVALIDE ff
         left join LIAISONINTRATABLE op on op.ID1 = ff.id
         left join ORDONNERPAYEMENT ord on op.ID2 = ord.id
LEFT JOIN PaiementOPJCUnion_op p ON p.idordre=ord.id
where ff.etat = 1
;

CREATE OR REPLACE  VIEW FACTUREFOURNVALIDE_V (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, PROJET, NUMEROOP, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT,idop,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt) AS 
  select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       ff.TVA,
       ff.REMARQUE,
       ff.IDUSER,
       ff.DATE_ECHEANCE,
       ff.ETAT,
       ff.IDPREVISION,
       ff.MONTANT,
       ff.MONTANTTVA,
       ff.MONTANTAVOIR,
       ff.MONTANTTTC,
       ff.MONTANTPAYE,
       ff.MONTANTRESTE,
       ff.TIERSLIB,
       ff.CONTACT,
       ff.ADRESSE,
       ff.ESCALE,
       ff.TYPELIB,
       ff.IDCATEGORIE,
       ff.CATEGORIELIB,
       ff.IDPROVISION,
       ff.IDPROVISIONLIB,
       ff.ESTDDPMICTSL,
       ff.DEVISEMERE,
       ff.CODEPRESTATION,
       ff.CODEPRESTATIONLIB,
       ff.CODE,
       ff.ESTMICTSL,
       ff.CODEPROVISION,
       ff.ETATLIB,
       ff.MONTANTTTCVRAI,
       ff.IDBL,
       ff.PROJET,
       ff.NUMEROOP,
       ff.CODE_ETABLISSEMENT,
       ff.PROJETLIB,
       ff.CODE_ETABLISSEMENTLIB,
       ff.NATURE,
       ff.NATURELIB,
       ff.IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
       idengagement,
       idengagementlib,
       CODE_ETABLISSEMENT as CODEETABLISSEMENT,
       ord.id AS idop
            ,p.id AS idrefpmt
,p.valcaisse AS valcaisserefpmt
,p.numpiece AS numpiecerefpmt
,p.dateeffet AS dateeffetrefpmt
,p.libelle AS libellerefpmt
,p.debit AS debitrefpmt
,p.numcheque as numchequerefpmt
from FACTUREFOURNVALIDE ff
         left join LIAISONINTRATABLE op on op.ID1 = ff.id
         left join ORDONNERPAYEMENT ord on op.ID2 = ord.id
LEFT JOIN PaiementOPJCUnion_op p ON p.idordre=ord.id
where ff.etat >= 11
  and ff.id not in (select id1 from LIAISONINTRATABLE);
 
 
CREATE OR REPLACE  VIEW FACTUREFOURNVALIDE_EP (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT,idop,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt) AS 
  select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       TVA,
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
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       MONTANTTTCVRAI,
       'ATTENTE DE PAIEMENT' as ETATLIB,
       ff.IDBL,
       ff.NUMEROOP,
       projet,
       code_etablissement,
       projetlib,
       code_etablissementlib,
       NATURE,
       NATURELIB,
       IDBC,
       ord.NUMEROOP          as numop,
       ff.exercice,
       IDENGAGEMENT,
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
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
         left join ORDONNERPAYEMENT ord on li.ID2 = ord.id
LEFT JOIN PaiementOPJCUnion_op p ON p.idordre=ord.id
where (li.IDJOURNAL is not null
    and li.ETATJC = 1)
   or (li.IDJOURNAL is null);

  
  
CREATE OR REPLACE  VIEW FACTUREFOURNVALIDE_P (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT,idop,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt) AS 
  select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       TVA,
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
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       MONTANTTTCVRAI,
       'PAYE'       as ETATLIB,
       ff.IDBL,
       ff.NUMEROOP,
       projet,
       code_etablissement,
       projetlib,
       code_etablissementlib,
       NATURE,
       NATURELIB,
       IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
       IDENGAGEMENT,
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
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
         left join ORDONNERPAYEMENT ord on li.ID2 = ord.id
         left join PAIEMENTFACTUREF_GRP gr on gr.IDFACT = ff.id
LEFT JOIN PaiementOPJCUnion_op p ON p.idordre=ord.id
where li.IDJOURNAL is not null
  and li.ETATJC = 11
and gr.MONTANT = ff.MONTANTTTC;






CREATE OR REPLACE  VIEW FACTUREFOURNVALIDE_TOUS (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET, CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, CODEETABLISSEMENT,idop,idrefpmt
 ,valcaisserefpmt
,numpiecerefpmt
 ,dateeffetrefpmt
 ,libellerefpmt
 ,debitrefpmt) AS 
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
       cast(MONTANT as number(30, 2)),
       cast(MONTANTTVA as number(30, 2)),
       cast(MONTANTAVOIR as NUMBER(30, 2)),
       cast(MONTANTTTC as number(30, 2)),
       cast(MONTANTPAYE as number(30, 2)),
       cast(MONTANTRESTE as number(30, 2)),
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
       cast(MONTANTTTCVRAI as number(30, 3)),
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
         from FACTUREFOURNVALIDE_p)
         ;
		 
		 
		 
		 
		 
		 
		 
		 create
or replace view AS_BONDECOMMANDE_LIBELLE as
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
  bc.CODE_ETAB as codeetablissement
from
  union_bc_spat_cemedi bc
  join modepaiement mp on bc.modepaiement = mp.id
  left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
  left join PROJET pe on pe.id = bc.projet
  left join ENGAGEMENT en on bc.IDENGAGEMENT = en.ID;

create
or replace view AS_BONDECOMMANDE_LIBELLE_LIB (
  ID,
  DATY,
  ETAT,
  REMARQUE,
  DESIGNATION,
  MODEPAIEMENT,
  FOURNISSEUR,
  TVA,
  NUMBC,
  MONTANT,
  MONTANTTVA,
  MONTANTTTC,
  IDFACTURE,
  MONTANT_PAYE_REEL,
  RESTEPAYERGENERAL,
  RESTEAPAYERREEL,
  MONTANT_A_PAYER,
  PROJET,
  CODE_ETAB,
  MONTANTFACTURE,
  ETATLIB,
  MONTANTREMISE,
  IDENGAGEMENTLIB,
  IDENGAGEMENT,
  CODEETABLISSEMENT,
  COMPTEBDG,
  MONTANTHTSANSREMISE
) as
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
  CAST((c.montantht + montantremise) AS number (30, 3)) AS montantHTSansRemise
from
  AS_BONDECOMMANDE_LIBELLE bc
  left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
  left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
  left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
  LEFT JOIN AS_BONDELIVRAISON_BC bl on bl.id_bc = bc.id
  left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur;
  
  
  
  
  
  
  
  
CREATE OR REPLACE VIEW PMENTFACTHORSPROVAVPROVCPLT3 AS 
  SELECT prov.ID AS idfact,prov.MONTANT,prov.IDPROVISION, 
fcu.daty,
 fcu.TIERS,
 fcu.TIERSLIB,
 fcu.DESIGNATION , 
 fcu.TYPE, 
 fcu.REMARQUE,
 fcu.DATE_ECHEANCE,
fcu.ETATLIB,
 fcu.ETAT, 
 fcu.CONTACT,
 fcu.ADRESSE, 
 fcu.DEVISEMERE,
 cast(fcu.MONTANTTVA as number(25,2)) as MONTANTTVA, 
 cast(fcu.MONTANTAVOIR as number(25,2)) as MONTANTAVOIR, 
 cast(fcu.MONTANTPAYE as number(25,2)) AS MONTANTPAYE ,
cast(fcu.MONTANTRESTE as number(25,2)) AS MONTANTRESTE, 
fcu.CATEGORIELIB,
fcu.numfact,fcu.ID,fcu.code,fcu.montantttc
FROM PAIEMENTFACTHORSPROVAVECPROV2 prov LEFT join FACTURE_CLIENT_UNION2 fcu on prov.id = fcu.ID;
