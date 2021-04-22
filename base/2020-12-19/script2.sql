CREATE OR REPLACE FORCE VIEW BC_BL_LIVRE AS 
  SELECT
	BCF.ID,
CASE
		WHEN ap.Nom IS NULL THEN BCF.PRODUIT
		ELSE ap.Nom
	END AS PRODUIT,
	BCF.IDBC,
	BCF.QUANTITE,
	BCF.PU,
	BCF.QUANTITEPARPACK,
	BCF.MONTANT,
	BCF.REMARQUE,
	CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitelivre,
	CAST(BCF.QUANTITE - NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) AS quantitereste,
	CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU AS MontantBL,
	(bcf.quantite*bcf.pu)-CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25, 2)) * BCF.PU AS MontantBLreste,
	u.DESCE AS UNITE
FROM
	AS_BONDECOMMANDE_FILLE BCF
LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG ON
	BFG.IDBONDECOMMANDE = BCF.ID
LEFT JOIN AS_PRODUITS ap ON
	BCF.produit = ap.id
LEFT JOIN UNITECHANTIER u ON
	bcf.UNITE = u.id;
	
	
	CREATE OR REPLACE FORCE VIEW AS_BONDECOMMANDE_LIBELLE_TIERS AS 
  select bcl.ID,
       bcl.DATY,
       bcl.ETAT,
       bcl.REMARQUE,
       bcl.DESIGNATION,
       bcl.MODEPAIEMENT,
       bcl.FOURNISSEUR,
       bcl.TVA,
       nvl(ti.NOM, '-')                      as nomfournisseur,
       bcl.NUMBC,
       bc.montant,
       bc.montanttva,
       bc.montantttc,
       ff.idfacture,
       nvl(bl.montantttc,0) as montant_A_payer,
       nvl(op.montant, 0)                    as montant_paye_reel,
       bc.montantttc - nvl(bl.montantttc, 0) as restepayergeneral,
       bc.montantttc - nvl(op.montant, 0)    as resteapayerreel
from ORDONNERPAYEMENTGROUPEFACT op
         join facturefournisseur_final ff on ff.idfacture = op.DED_ID
         join bonlivraison_final bl on bl.numbl = ff.IDBL
         right join boncommande_final bc on bc.IDBC = bl.IDBC
         join AS_BONDECOMMANDE_LIBELLE bcl on bcl.ID = bc.idbc
         left join TIERS ti on ti.id = bcl.fournisseur;