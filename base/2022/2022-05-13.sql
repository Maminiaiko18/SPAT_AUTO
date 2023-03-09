Create view factureclient_emise as
    select
    fc.*,
    rfe.val,
    rfe.desce
    from FACTURE_CLIENT_UNIONV fc
    left  join RUBRIQUE_FACT_EMISES rfe on code like '%'||rfe.val||'%';


create or replace view AS_BONDECOMMANDE_LIBELLE_TIERS
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NOMFOURNISSEUR, NUMBC, MONTANT,
             MONTANTTVA, MONTANTTTC, IDFACTURE, MONTANT_A_PAYER, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL,
             CODE_ETAB, PROJET, ETATLIB, DELAIPAIEMENT, ADRESSE, REMISE, TYPEPAIEMENT, DELAILIVRAISON, MONTANTREMISE,code_etablib)
as
select op.ID,
       op.DATY,
       op.ETAT,
       op.REMARQUE,
       op.DESIGNATION,
       op.MODEPAIEMENT,
       ti.id                                    as FOURNISSEUR,
       op.TVA,
       op.FOURNISSEUR,
       op.NUMBC,
       cast(op.montant as number(25, 2))        as MONTANT,
       cast(op.MONTANTTVA as number(25, 2))     as MONTANTTVA,
       cast(op.MONTANTTTC as number(25, 2))     as MONTANTTTC,
       cast(IDFACTURE as varchar2(100)),
       cast(MONTANT_A_PAYER as number(25, 2))   as MONTANTTTC,
       cast(MONTANT_PAYE_REEL as number(25, 2)) as MONTANT_PAYE_REEL,
       cast(RESTEPAYERGENERAL as number(25, 2)) as RESTEPAYERGENERAL,
       cast(RESTEAPAYERREEL as number(25, 2))   as RESTEAPAYERREEL,
       op.CODE_ETAB,
       op.PROJET,
       ETATLIB,
       bc.DELAIPAIEMENT,
       ti.ADRESSE,
       cast(0 as number(25, 2))                    remise,
       tc.VAL                                   as TYPEPAIEMENT,
       DELAILIVRAISON,
       MONTANTREMISE,
       cd.desce as code_etablib
from AS_BONDECOMMANDE_LIBELLE_LIB op
         left join union_bc_spat_cemedi bc on op.id = bc.ID
         left join union_tiers_tbd_cemedi ti on ti.NOM = op.FOURNISSEUR
         left join TYPECHEQUE tc on tc.id = bc.TYPEPAIEMENT
         left join codeetablissement cd on cd.id=bc.code_etab;

CREATE OR REPLACE VIEW AS_BONDECOMMANDE_LIBELLE_AN AS
select ID,
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
       CODEETABLISSEMENT
from AS_BONDECOMMANDE_LIBELLE_lib
where ETAT = 0;

     CREATE OR REPLACE  VIEW AVOIRFCFILLE_PDF (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, REMISE, DESIGNATION, TAUX, DEVISE, TVA, QTE, PU, DUREE, MONTANTHTDEVISE, MAJ, RED) AS 
  SELECT 
av.ID,
av.IDMERE,
av.IDDETAILFACTURE,
av.MONTANT,
av.COMPTE,
av.remise,
ca.designation as designation,
ca.taux,
ca.devise,
av.tva,
CAST (nvl(av.qte,ca.quantite) AS NUMBER (30,3)) qte,
CAST(nvl(av.pu,ca.pu) AS NUMBER (30,3))  pu,
CAST (nvl(av.duree,ca.duree) as NUMBER (30,3)) duree,
CAST (CASE WHEN devise='Ar' THEN av.montant/ca.taux
else av.montant END AS NUMBER (30,3))
AS  montantHTDevise , 
ca.majoration AS maj, 
ca.reduction AS red




from AvoirFCFille av
left join CAFCFILLECOMPLET ca on ca.id=av.IDDETAILFACTURE  
;

CREATE VIEW AS_BONDECOMMANDE_LIB_fiche as 
SELECT
	ID,
	DATY,
	REMARQUE,
	DESIGNATION,
	MODEPAIEMENT,
	FOURNISSEUR,
	NUMBC,
	PROJET,
	CODE_ETAB,
	CODEETABLISSEMENT,
	IDENGAGEMENTLIB,
	IDENGAGEMENT,
	ETAT,
	ETATLIB,
	MONTANTHTSANSREMISE,
	MONTANTREMISE,
	MONTANT,
	TVA,
	MONTANTTVA,
	MONTANTTTC,
	MONTANT_PAYE_REEL,
	RESTEPAYERGENERAL,
	RESTEAPAYERREEL,
	MONTANT_A_PAYER,
	MONTANTFACTURE,
	COMPTEBDG,
	IDFACTURE
FROM
	AS_BONDECOMMANDE_LIBELLE_lib;
CREATE OR REPLACE VIEW AS_BONDECOMMANDE_LIBELLE_AN AS
select ID,
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
       CODEETABLISSEMENT
from AS_BONDECOMMANDE_LIBELLE_lib
where ETAT = 0;