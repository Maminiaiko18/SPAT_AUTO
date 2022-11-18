CREATE OR REPLACE VIEW LIAISONTABLE_OP_PARFACT_F2 (ID2, DED_ID, MONTANT, MONTANTOP, NUMFACT) AS 
  select op.ID2,
       op.DED_ID,
       sum(OP.MONTANT)                                       as montant,
       sum(op.MONTANTOP)                                        as MONTANTOP,
       LISTAGG(ff.NUMFACT, ';') WITHIN GROUP ( ORDER BY OP.ID1) as numfact
from LIAISONINTRATABLE_OP_TOUS OP
         JOIN etatfacturemontantdaty FF ON FF.ID = OP.ID1
group by op.ID2, op.DED_ID;


CREATE OR REPLACE VIEW ORDONNERPAYEMENT_PDF (ID, DED_ID, IDLIGNE, DATY, MONTANT, REMARQUE, ETAT, NUMEROOP, DESTINATION, MODEPAIEMENT, BENEFICIAIRE, ADRESSE, DEVISE, NUMFACT, DESTINATIONLIB) AS 
  select op.ID,
       op.DED_ID,
       op.IDLIGNE,
       op.DATY,
       op.MONTANT,
       op.REMARQUE,
       op.ETAT,
       op.NUMEROOP,
       op.DESTINATION,
       op.MODEPAIEMENT,
       op.TIERS               as beneficiaire,
       op.adresse,
       nvl(ff.IDDEVISE, 'Ar') as devise,
       f.NUMFACT,
        de.VAL as DESTINATIONlib
from ordonnerpayement_lib op
         left join LIAISONTABLE_OP_PARFACT_F2 f on f.DED_ID = op.DED_ID
         left join etatfacturemontantdaty ff on ff.id = op.DED_ID
         left join DESTINATION de on de.id = op.DESTINATION
where op.ETAT >= 1
group by op.ID, op.DED_ID, op.IDLIGNE, op.DATY, op.MONTANT, op.REMARQUE, op.ETAT, op.NUMEROOP,
         op.DESTINATION, op.MODEPAIEMENT, op.TIERS, op.adresse, nvl(ff.IDDEVISE, 'Ar'), f.NUMFACT,de.VAL;
