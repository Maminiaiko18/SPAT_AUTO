create or replace view LIAISONINTRATABLE_OP_CODE as
select
       op.id as idOP,
       op.DED_ID,
       LISTAGG(FF.code,';')within group ( order by id2) as numerocompta
from LIAISONINTRATABLE lt
         right join ordonnerpayement op on op.id = lt.ID2
         left join FACTURE_FOURNISSEUR_MERE ff on ff.id = lt.id1
group by op.id,  op.DED_ID;

CREATE OR REPLACE VIEW ORDONNERPAYEMENT_PAYE_LIB
            (ID, DED_ID, IDLIGNE, DATY, MONTANT, REMARQUE, ETAT, NUMEROOP, DESTINATION, MODEPAIEMENT, IDUSER, FOLIO,
             NUMCHEQUE, ETATLIB, MODEPAIEMENTLIB, TIERS)
AS
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
       op.FOLIO,
       op.NUMCHEQUE,
       'PAYE' as ETATLIB,
       op.MODEPAIEMENTLIB,
       op.TIERS
FROM ORDONNERPAYEMENT_LIBETAT op
         JOIN journalcaisse jc ON jc.IDORDRE = op.id
WHERE jc.ETAT >= 11
  AND op.ETAT >= 11;

create view LIAISONINTRATABLE_OP_CODE as
select
       lt."ID2",
       op.DED_ID,
       LISTAGG(FF.code,';')within group ( order by id2) as numerocompta
from LIAISONINTRATABLE lt
         join ordonnerpayement op on op.id = lt.ID2
         left join FACTURE_FOURNISSEUR_MERE ff on ff.id = lt.id1
group by id2,  op.DED_ID;

CREATE OR REPLACE VIEW ORDONNERPAYEMENT_LIBETAT
            (ID, DED_ID, IDLIGNE, DATY, MONTANT, REMARQUE, ETAT, NUMEROOP, DESTINATION, MODEPAIEMENT, IDUSER, FOLIO,
             NUMCHEQUE, ETATLIB, MODEPAIEMENTLIB, TIERS,numerocompta)
AS
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
       jc.FOLIO,
       jc.NUMCHEQUE,
       CASE
           WHEN op.etat = 0 THEN 'annule'
           WHEN op.etat = 1 THEN 'cree'
           WHEN op.etat = 11 THEN 'vise'
           END
               AS etatlib,
       md.VAL  AS MODEPAIEMENTLIB,
       fup.NOM as TIERS,
       co.numerocompta

FROM OrdonnerPayement op
         left join journalcaisse jc on jc.IDORDRE = op.ID
         LEFT JOIN modepaiement md ON md.ID = op.MODEPAIEMENT
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = op.TIERS
         left join LIAISONINTRATABLE_OP_CODE co on co.idOP = op.id
ORDER BY op.DATY DESC;

create or replace view ORDONNERPAYEMENT_CREE as
SELECT "ID",
       "DED_ID",
       "IDLIGNE",
       "DATY",
       "MONTANT",
       "REMARQUE",
       "ETAT",
       "NUMEROOP",
       "DESTINATION",
       "MODEPAIEMENT",
       "IDUSER",
       "FOLIO",
       "NUMCHEQUE",
       'CREE(E)' AS ETATLIB,
       "MODEPAIEMENTLIB",
       "TIERS",
       NUMEROCOMPTA
FROM ORDONNERPAYEMENT_LIBETAT
WHERE etat = 1;

create or replace view ORDONNERPAYEMENT_ANNULE as
SELECT ID,
       DED_ID,
       IDLIGNE,
       DATY,
       MONTANT,
       REMARQUE,
       ETAT,
       NUMEROOP,
       DESTINATION,
       MODEPAIEMENT,
       IDUSER,
       FOLIO,
       NUMCHEQUE,
       'ANNULE(E)'ETATLIB,
       MODEPAIEMENTLIB,
       TIERS,
       NUMEROCOMPTA
FROM ORDONNERPAYEMENT_LIBETAT
WHERE etat = 0;

create or replace view ORDONNERPAYEMENT_N_PAYE as
SELECT "ID",
       "DED_ID",
       "IDLIGNE",
       "DATY",
       "MONTANT",
       "REMARQUE",
       "ETAT",
       "NUMEROOP",
       "DESTINATION",
       "MODEPAIEMENT",
       "IDUSER",
       "FOLIO",
       "NUMCHEQUE",
       'NON PAYE(E)' AS "ETATLIB",
       "MODEPAIEMENTLIB",
       "TIERS",
	  NUMEROCOMPTA
FROM ORDONNERPAYEMENT_LIBETAT op
WHERE op.id NOT IN (SELECT jc.IDORDRE
                    FROM journalcaisse jc
                    WHERE jc.IDORDRE = op.id)
  AND op.ETAT >= 11;


create or replace view ORDONNERPAYEMENT_PAYE_LIB as
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
       op.FOLIO,
       op.NUMCHEQUE,
       'PAYE' as ETATLIB,
       op.MODEPAIEMENTLIB,
       op.TIERS,
       op.NUMEROCOMPTA
FROM ORDONNERPAYEMENT_LIBETAT op
         JOIN journalcaisse jc ON jc.IDORDRE = op.id
WHERE jc.ETAT >= 11
  AND op.ETAT >= 11;

CREATE VIEW ORDONNERPAYEMENT_LIBETAT_FINAL AS
SELECT *
FROM OrdonnerPayement_Cree OC
union
SELECT *
FROM ordonnerpayement_n_paye OC
union
SELECT *
FROM ordonnerpayement_paye_lib OC
union
SELECT *
FROM OrdonnerPayement_Annule OC;
