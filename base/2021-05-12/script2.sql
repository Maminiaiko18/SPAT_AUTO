create view factureclientMSum_lib as
select
       m.* ,
       fup.NOM as tierslib
from factureclientMSum m
        left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID=m.tiers;