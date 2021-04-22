create or replace view ORDONNERPAYEMENT_LIB as
select op.ID,
       DED_ID,
       IDLIGNE,
       DESTINATION,
       DATY,
       MONTANT,
       REMARQUE,
       op.ETAT,
       NUMEROOP,
       mp.VAL  as MODEPAIEMENT,
       fup.NOM as TIERS,
       fup.ADRESSE
from ORDONNERPAYEMENT op
         left join MODEPAIEMENT mp on mp.id = op.MODEPAIEMENT
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id = op.TIERS
/


create or replace view LIAISONINTRATABLE_OP_PARFACT_f as
select op.ID2,
       DED_ID,
       sum(OP.MONTANT)                                       as montant,
       sum(MONTANTOP)                                        as MONTANTOP,
       LISTAGG(NUMFACT, ';') WITHIN GROUP ( ORDER BY OP.ID1) as numfact
from LIAISONINTRATABLE_OP_VISE OP
         JOIN etatfacturemontantdaty FF ON FF.ID = OP.ID1
group by ID2, DED_ID
/

create or replace view ORDONNERPAYEMENT_PDF as
select op."ID",
       op."DED_ID",
       op."IDLIGNE",
       op."DATY",
       op."MONTANT",
       op."REMARQUE",
       op."ETAT",
       op."NUMEROOP",
       op."DESTINATION",
       op."MODEPAIEMENT",
       op.TIERS               as beneficiaire,
       op.adresse,
       nvl(ff.IDDEVISE, 'Ar') as devise,
       f.NUMFACT

from ordonnerpayement_lib op
         left join LIAISONINTRATABLE_OP_PARFACT_f f on f.DED_ID = op.DED_ID
         left join etatfacturemontantdaty ff on ff.id = op.DED_ID
where op.ETAT >= 11
group by op."ID", op."DED_ID", op."IDLIGNE", op."DATY", op."MONTANT", op."REMARQUE", op."ETAT", op."NUMEROOP",
         op."DESTINATION", op."MODEPAIEMENT", op.TIERS, op.adresse, nvl(ff.IDDEVISE, 'Ar'), f.NUMFACT
/