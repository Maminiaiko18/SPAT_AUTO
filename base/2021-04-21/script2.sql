CREATE OR REPLACE FORCE VIEW "ORDONNERPAYEMENT_LIBETAT" ("ID", "DED_ID", "IDLIGNE", "DATY", "MONTANT", "REMARQUE", "ETAT", "NUMEROOP", "DESTINATION", "MODEPAIEMENT", "IDUSER", "FOLIO", "NUMCHEQUE", "ETATLIB","MODEPAIEMENTLIB") AS 
  SELECT op."ID",
       op."DED_ID",
       op."IDLIGNE",
       op."DATY",
       op."MONTANT",
       op."REMARQUE",
       op."ETAT",
       op."NUMEROOP",
       op."DESTINATION",
       op."MODEPAIEMENT",
       op."IDUSER",
       jc.FOLIO,
       jc.NUMCHEQUE ,
       CASE
           WHEN op.etat = 0 THEN 'annule'
           WHEN op.etat = 1 THEN 'cree'
           WHEN op.etat = 11 THEN 'vise'
           END
           AS etatlib,
       md.VAL AS MODEPAIEMENTLIB
FROM OrdonnerPayement op
left join journalcaisse jc on jc.IDORDRE=op.ID
LEFT JOIN modepaiement md ON md.ID = op.MODEPAIEMENT 

