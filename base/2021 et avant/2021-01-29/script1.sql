CREATE OR REPLACE FORCE VIEW JOURNALCAISSELIBmiv
AS
   SELECT id,
          datesaisie,
          dateeffet,
          folio,
          valcaisse AS caisse,
          numpiece,
          numcheque,
          libelle,
          debit as credit,
          credit as debit,
          remarque,
          etat,
          tiers,
          valtypecheque AS idtypecheque,
          idplacement
     FROM journalcaisselibcomplet;
     
CREATE OR REPLACE FORCE VIEW JOURNALCAISSELIB_CREE_miv
AS
   SELECT *
     FROM JOURNALCAISSELIBmiv
    WHERE etat = 1;
    
CREATE OR REPLACE FORCE VIEW JOURNALCAISSELIB_vise_miv
AS
   SELECT *
     FROM JOURNALCAISSELIBmiv
    WHERE etat >= 11;