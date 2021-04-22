create or replace view ORDONNERPAYEMENT_PDF as
select op.*,
       fup.NOM || ' ' || fup.DESCRIPTION as beneficiaire,
       fup.adresse,
       ff.IDDEVISE                       as devise

from ordonnerpayement op
         left join etatfacturemontantdaty ff on ff.id = op.DED_ID
         left join fournisseur_union_personnel fup on fup.id = ff.IDFOURNISSEUR
/
