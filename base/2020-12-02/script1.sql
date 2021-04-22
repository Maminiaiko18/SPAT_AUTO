CREATE OR REPLACE FORCE VIEW AS_BONDECOMMANDE_LIB AS 
  select 
  	bc.id, bc.daty, bc.etat, bc.remarque, bc.designation, mp.val as modepaiement, tr.nom AS FOURNISSEUR,
	bc.tva 
from as_bondecommande bc join modepaiement mp on bc.modepaiement = mp.id
JOIN tiers tr ON bc.fournisseur = tr.id;