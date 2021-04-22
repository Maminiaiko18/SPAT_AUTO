create view ordonnerpayement_lib as
select op.ID,
       DED_ID,
       IDLIGNE,
       DATY,
       MONTANT,
       REMARQUE,
       ETAT,
       NUMEROOP,
       DESTINATION,
       mp.VAL as MODEPAIEMENT
from ORDONNERPAYEMENT op
        left join MODEPAIEMENT mp on mp.id=op.MODEPAIEMENT;

create or replace view ORDONNERPAYEMENT_PDF as
select op.*,
       fup.NOM || ' ' || fup.DESCRIPTION as beneficiaire,
       fup.adresse,
       nvl(ff.IDDEVISE,'Ar')                       as devise,
       ff.NUMFACT

from ordonnerpayement_lib op
         left join etatfacturemontantdaty ff on ff.id = op.DED_ID
         left join fournisseur_union_personnel fup on fup.id = ff.IDFOURNISSEUR
where op.ETAT>=11
/



