create view AS_BONDECOMMANDE_LIBELLE_lib as
select bc.id,
       daty,
       bc.etat,
       remarque,
       designation,
       modepaiement,
       ti.NOM as fournisseur,
       tva
from AS_BONDECOMMANDE_LIBELLE bc
         left join TIERS ti on ti.id = bc.fournisseur;