CREATE OR REPLACE VIEW JOURNALCAISSELIB (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, TIERS, IDTYPECHEQUE, IDPLACEMENT, IDORDRE,descecaisse) AS 
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
          idplacement,
		  idordre,
		  descecaisse
     FROM journalcaisselibcomplet;



CREATE OR REPLACE  VIEW JOURNALCAISSELIB_VISE AS
SELECT jc.ID,
          jc.DATESAISIE,
          jc.DATEEFFET,
          jc.FOLIO,
          jc.CAISSE,
          jc.NUMPIECE,
          jc.LIBELLE,
          jc.DEBIT,
          jc.CREDIT,
          jc.REMARQUE,
          jc.ETAT,
          jc.TIERS,
          jc.IDTYPECHEQUE,
          jc.IDPLACEMENT,
          fup.NOM AS tierslib,
          jc.idordre,
          jc.descecaisse
     FROM journalcaisselib jc
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = jc.TIERS
          left join ordonnerpayement op on op.id=jc.idordre
    WHERE jc.etat >= 11;
   
   
   CREATE OR REPLACE  VIEW JOURNALCAISSEVISE_GRP_OPCS  AS 
  select
    idordre,
    sum(debit) as debit,
    sum(credit) as credit,
    jc.descecaisse
from journalcaisselib_vise jc group by idordre,descecaisse;





CREATE OR REPLACE  VIEW ORDONNERPAYEMENT_LIBETATCS  AS 
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
       fup.NOM as TIERS,
       jc.descecaisse
FROM OrdonnerPayement op
         left join JOURNALCAISSEVISE_GRP_OPCS jc on jc.IDORDRE = op.ID
         LEFT JOIN modepaiement md ON md.ID = op.MODEPAIEMENT
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = op.TIERS
 ORDER BY op.DATY DESC;
    
   CREATE OR REPLACE  VIEW ORDONNERPAYEMENT_CREECS  AS 
  SELECT ID,DED_ID,IDLIGNE,DATY,MONTANT,REMARQUE,ETAT,NUMEROOP,DESTINATION,MODEPAIEMENT,IDUSER,FOLIO,NUMCHEQUE,ETATLIB,MODEPAIEMENTLIB,TIERS,descecaisse
     FROM ORDONNERPAYEMENT_LIBETATCS
    WHERE etat = 1;
    
   
   CREATE OR REPLACE  VIEW ORDONNERPAYEMENT_N_PAYECS AS 
  SELECT ID,DED_ID,IDLIGNE,DATY,MONTANT,REMARQUE,ETAT,NUMEROOP,DESTINATION,MODEPAIEMENT,IDUSER,FOLIO,NUMCHEQUE,ETATLIB,MODEPAIEMENTLIB,TIERS,descecaisse
     FROM ORDONNERPAYEMENT_LIBETATCS op
    WHERE     op.id NOT IN (SELECT jc.IDORDRE
                              FROM journalcaisse jc
                             WHERE jc.IDORDRE = op.id)
          AND op.ETAT >= 11;
  
CREATE OR REPLACE  VIEW ORDONNERPAYEMENT_PAYE_LIBCS  AS 
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
       op.descecaisse
FROM ORDONNERPAYEMENT_LIBETATCS op
         JOIN journalcaisse jc ON jc.IDORDRE = op.id
WHERE jc.ETAT >= 11
  AND op.ETAT >= 11;
  
 
 CREATE OR REPLACE  VIEW ORDONNERPAYEMENT_ANNULECS  AS 
  SELECT ID,DED_ID,IDLIGNE,DATY,MONTANT,REMARQUE,ETAT,NUMEROOP,DESTINATION,MODEPAIEMENT,IDUSER,FOLIO,NUMCHEQUE,ETATLIB,MODEPAIEMENTLIB,TIERS,descecaisse
     FROM ORDONNERPAYEMENT_LIBETATCS
    WHERE etat = 0;
	
	
	INSERT INTO MENUDYNAMIQUE(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MEN000001213', 'Etat caisse global', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=treso/etat-caisse-global.jsp', 8, 5, 'MEN0031');
