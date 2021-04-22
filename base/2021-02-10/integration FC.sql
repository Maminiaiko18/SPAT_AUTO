create view rubriqueFactureFournisseurLib as
select rf.id,
       no.VAL as designation,
       rf.Montant,
       rf.duree,
       rf.compte
from rubriqueFactureFournisseur rf
         left join NATUREOPERATION no on no.id = rf.DESIGNATION;