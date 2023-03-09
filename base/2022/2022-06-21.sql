

CREATE OR REPLACE  VIEW AS_BONDECOMMANDE_FILLE_PRD (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, MONTANT, REMARQUE, UNITE, TVA, DESIGNATION, PRODUITLIB, REMISE, OBSERVATION,taux,devise) AS 
  SELECT BCF.ID,
       BCF.PRODUIT,
       BCF.IDBC,
       BCF.QUANTITE,
       BCF.PU,
       BCF.QUANTITEPARPACK,
       BCF.MONTANT,
       BCF.REMARQUE,
       BCF.UNITE,
       BCF.TVA,
       BCF.DESIGNATION,
       pr.NOM as produitlib,
       BCF.REMISE,
       observation,
       bcf.taux,
       bcf.devise
FROM AS_BONDECOMMANDE_FILLE BCF
         left join union_produit_tbd_cemedi pr on pr.id = bcf.PRODUIT;
		 
		    update AS_BONDECOMMANDE_FILLE set devise='Ar';


