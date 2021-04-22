/* Formatted on 04/02/2021 22:29:57 (QP5 v5.256.13226.35538) */
CREATE OR REPLACE FORCE VIEW JOURNALCAISSELIBMIV
(
   ID,
   DATESAISIE,
   DATEEFFET,
   FOLIO,
   CAISSE,
   NUMPIECE,
   NUMCHEQUE,
   LIBELLE,
   CREDIT,
   DEBIT,
   REMARQUE,
   ETAT,
   TIERS,
   IDTYPECHEQUE,
   IDPLACEMENT,
   SORTIE,
   ENTREE,
   tierslib
)
AS
   SELECT id,
          datesaisie,
          dateeffet,
          folio,
          valcaisse AS caisse,
          numpiece,
          numcheque,
          libelle,
          debit AS credit,
          credit AS debit,
          remarque,
          etat,
          tiers,
          valtypecheque AS idtypecheque,
          idplacement,
          debit AS sortie,
          credit AS entree,
          tierslib
     FROM journalcaisselibcomplet;

     CREATE OR REPLACE FORCE VIEW JOURNALCAISSELIBCOMPLET
(
   ID,
   DATESAISIE,
   DATEEFFET,
   FOLIO,
   CAISSE,
   NUMPIECE,
   LIBELLE,
   DEBIT,
   CREDIT,
   REMARQUE,
   ETAT,
   TIERS,
   IDTYPECHEQUE,
   DESIGNATION,
   IDDEVISE,
   IDMODE,
   NUMCHEQUE,
   TYPEMVT,
   IDORDRE,
   IDPLACEMENT,
   IDCAISSE,
   VALCAISSE,
   DESCECAISSE,
   VALTYPECHEQUE,
   DESCETYPECHEQUE,
   TIERSLIB
)
AS
   SELECT j."ID",
          j."DATESAISIE",
          j."DATEEFFET",
          j."FOLIO",
          j."CAISSE",
          j."NUMPIECE",
          j."LIBELLE",
          j."DEBIT",
          j."CREDIT",
          j."REMARQUE",
          j."ETAT",
          j."TIERS",
          j."IDTYPECHEQUE",
          j."DESIGNATION",
          j."IDDEVISE",
          j."IDMODE",
          j."NUMCHEQUE",
          j."TYPEMVT",
          j."IDORDRE",
          j."IDPLACEMENT",
          c.ID AS idcaisse,
          c.val AS valcaisse,
          c.desce AS descecaisse,
          tc.val AS valtypecheque,
          m.val AS descetypecheque,
          ti.NOM AS tierslib
     FROM Journalcaisse j
          JOIN CAISSE C ON j.CAISSE = C.ID
          LEFT JOIN TYPECHEQUE tc ON tc.id = j.idtypecheque
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL ti ON ti.id = j.TIERS
          LEFT JOIN MODEPAIEMENT m on j.idmode=m.id;