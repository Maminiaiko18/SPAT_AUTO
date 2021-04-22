insert into modepaiement values('pay5','versement','versement espece');


CREATE OR REPLACE FORCE VIEW JOURNALCAISSELIB
AS
   SELECT id,
          datesaisie,
          dateeffet,
          folio,
          valcaisse AS caisse,
          numpiece,
          libelle,
          debit,
          credit,
          remarque,
          etat,
          tiers,
          valtypecheque AS idtypecheque,
          idplacement
     FROM journalcaisselibcomplet;
