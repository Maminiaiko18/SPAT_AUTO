
  CREATE OR REPLACE  VIEW ORDONNERPAYEMENT_LIB (ID, DED_ID, IDLIGNE, DESTINATION, DATY, MONTANT, REMARQUE, ETAT, NUMEROOP, MODEPAIEMENT, TIERS, ADRESSE, NUMFACT) AS
  select op.ID,
       op.DED_ID,
       IDLIGNE,
       DESTINATION,
       DATY,
       MONTANT,
       REMARQUE,
       op.ETAT,
       NUMEROOP,
       mp.VAL  as MODEPAIEMENT,
       fup.NOM as TIERS,
       fup.ADRESSE,
       op1.numfact
from ORDONNERPAYEMENT op
         left join MODEPAIEMENT mp on mp.id = op.MODEPAIEMENT
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id = op.TIERS
         left join concat_numfact_ff op1 on op.id=op1.id2;


