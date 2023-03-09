delete from bon_provisoire where credit!=0;
CREATE OR REPLACE FORCE VIEW BON_PROVISOIRE_LIBCOMPLET
AS
   SELECT bnp."ID",
          bnp."DATESAISIE",
          bnp."DATEEFFET",
          bnp."FOLIO",
          bnp."CAISSE",
          bnp."NUMPIECE",
          bnp."LIBELLE",
          bnp."DEBIT",
          bnp."CREDIT",
          bnp."REMARQUE",
          bnp."ETAT",
          bnp."BENEFICIAIRE",
          bnp."RESTE",
          c.VAL AS valcaisse,
          DESCE AS descecaisse,
          bnp.BENEFICIAIRE AS beneficiairelib
     FROM bon_provisoire_rst bnp
          JOIN caisse c ON bnp.CAISSE = c.ID;

		  
		  