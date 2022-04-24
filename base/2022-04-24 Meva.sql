CREATE OR REPLACE VIEW "JOURNALCAISSEVISE_GRP_OP"  AS 
  select
    idordre,
    sum(debit) as debit,
    sum(credit) as credit
from journalcaisselib_vise jc group by idordre;


CREATE OR REPLACE VIEW "ORDONNERPAYEMENT_LIBETAT" ("ID", "DED_ID", "IDLIGNE", "DATY", "MONTANT", "REMARQUE", "ETAT", "NUMEROOP", "DESTINATION", "MODEPAIEMENT", "IDUSER", "FOLIO", "NUMCHEQUE", "ETATLIB", "MODEPAIEMENTLIB", "TIERS") AS 
  SELECT op.ID,
       op.DED_ID,
       op.IDLIGNE,
       op.DATY,
       op.MONTANT,
       op.REMARQUE,
       op.ETAT,
       op.NUMEROOP,
       op.DESTINATION,
       op.MODEPAIEMENT,
       op.IDUSER,
       '' AS FOLIO,
       '' AS NUMCHEQUE,
       CASE
           WHEN op.etat = 0 THEN 'annule'
           WHEN op.etat = 1 THEN 'cree'
           WHEN op.etat = 11 THEN 'vise'
           END
              AS etatlib,
       md.VAL AS MODEPAIEMENTLIB,
       fup.NOM as TIERS
FROM OrdonnerPayement op
         left join JOURNALCAISSEVISE_GRP_OP jc on jc.IDORDRE = op.ID
         LEFT JOIN modepaiement md ON md.ID = op.MODEPAIEMENT
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = op.TIERS
 ORDER BY op.DATY DESC;

CREATE OR REPLACE VIEW "ORDONNERPAYEMENT_PAYE_LIB" ("ID", "DED_ID", "IDLIGNE", "DATY", "MONTANT", "REMARQUE", "ETAT", "NUMEROOP", "DESTINATION", "MODEPAIEMENT", "IDUSER", "FOLIO", "NUMCHEQUE", "ETATLIB", "MODEPAIEMENTLIB", "TIERS") AS 
  SELECT op."ID",op."DED_ID",op."IDLIGNE",op."DATY",op."MONTANT",op."REMARQUE",op."ETAT",op."NUMEROOP",op."DESTINATION",op."MODEPAIEMENT",op."IDUSER",op."FOLIO",op."NUMCHEQUE",op."ETATLIB",op."MODEPAIEMENTLIB",op."TIERS"
     FROM ORDONNERPAYEMENT_LIBETAT op
          JOIN JOURNALCAISSEVISE_GRP_OP jc ON jc.IDORDRE = op.id
    WHERE op.ETAT >= 11;


--refresh colonnes
CREATE OR REPLACE VIEW "ENGAGEMENTLIBC" AS 
  select *
from engagementlib where etat=1;

CREATE OR REPLACE VIEW "ENGAGEMENTLIBV"  AS 
  select *
from engagementlib
where etat >= 11;