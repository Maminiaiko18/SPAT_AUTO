create table typeadditif(
	id varchar(50) primary key,
	val varchar(100),
	desce varchar(100)
);

CREATE OR REPLACE view AS_BONDELIVRAISON_FILLEQTE_RES AS
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
          tiers.nom as nomTiers
     FROM AS_BONDELIVRAISON_FILLE blf
          LEFT JOIN AS_BONDECOMMANDE_FILLE bcf
             ON bcf.id = blf.IDBONDECOMMANDE
          left join as_bondecommande bc on bc.id=bcf.idbc
          left join tiers on tiers.id=bc.fournisseur
          LEFT JOIN DETAILSFACTUREFOURNISSEUR qff
             ON qff.IDINGREDIENT = blf.id;
			 
			 
