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
         left join LIAISONINTRATABLE_OP_PARFACT_f f on f.DED_ID = op.DED_ID
         left join etatfacturemontantdaty ff on ff.id = op.DED_ID
         left join DESTINATION de on de.id = op.DESTINATION
where op.ETAT >= 1
group by op.ID, op.DED_ID, op.IDLIGNE, op.DATY, op.MONTANT, op.REMARQUE, op.ETAT, op.NUMEROOP,
         op.DESTINATION, op.MODEPAIEMENT, op.TIERS, op.adresse, nvl(ff.IDDEVISE, 'Ar'), f.NUMFACT,de.VAL;
