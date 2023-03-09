create or replace view ordonnerpayement_pdf as
select op.*,
       fup.NOM||' '||fup.DESCRIPTION as tiers,
       fup.adresse,
       ff.IDDEVISE as devise

from ordonnerpayement op
         left join etatfacturemontantdaty ff on ff.id = op.DED_ID
         left join fournisseur_union_personnel fup on fup.id = ff.IDFOURNISSEUR;