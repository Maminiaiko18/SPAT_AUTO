CREATE OR REPLACE FORCE VIEW RECAP_TRESO
AS
   SELECT "DATY",
          "LIBELLE",
          "NUMERO_COMPTE",
          cast(MONTANT as number(25,2)) as montant
     FROM recap_caisse
   UNION
   SELECT date_placement AS daty,
          'Placement' AS libelle,
          NULL AS numero_compte,
          cast(MONTANT as number(25,2)) as montant
     FROM placement;