CREATE OR REPLACE FORCE VIEW AS_BONDELIVRAISON_FILLEQTE_RES AS
   SELECT blf."ID",
          blf."PRODUIT",
          blf."NUMBL",
          blf."QUANTITE",
          blf."QUANTITEPARPACK",
          blf."IDDETAILSFACTUREFOURNISSEUR",
          blf."IDBONDECOMMANDE",
          NVL (qff.QTE, 0) AS facture,
          blf.QUANTITE - NVL (qff.QTE, 0) AS quantitereste,
          bcf.PU,
          tiers.nom AS nomTiers,
		  tiers.id as idtiers
     FROM AS_BONDELIVRAISON_FILLE blf
          LEFT JOIN AS_BONDECOMMANDE_FILLE bcf
             ON bcf.id = blf.IDBONDECOMMANDE
          LEFT JOIN as_bondecommande bc ON bc.id = bcf.idbc
          LEFT JOIN tiers ON tiers.id = bc.fournisseur
          LEFT JOIN DETAILSFACTUREFOURNISSEUR qff
             ON qff.IDINGREDIENT = blf.id;