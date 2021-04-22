CREATE VIEW MVTCAISSEGROUPEFOPOR (ID, IDORDRE, DATY, DEBIT, CREDIT, REMARQUE, ETAT) AS 
  SELECT   '-' AS ID, mvt.idordre,  MAX (mvt.daty) AS daty,
            SUM (mvt.debit) AS debit,SUM (mvt.credit) AS credit, '-' AS remarque, mvt.etat
       FROM mvtCaisse mvt
      WHERE mvt.etat >=11
   GROUP BY mvt.idordre, mvt.etat;

    CREATE  VIEW FACTUREFOURNISSEURLETTRE (ID, DATY, IDFOURNISSEUR, IDTVA, MONTANTTTC, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT, DATYECHEANCE, ETAT) AS 
  SELECT ff.id, ff.daty, c.DESCRIPTION as idFournisseur, ff.idtva, ff.montantttc,ff.remarque,
  ff.dateemission, ff.designation, ff.iddevise, ff.numfact, ff.datyecheance, CASE
   WHEN ff.etat=1 THEN 'CREER'
   WHEN ff.etat=11 THEN 'VALIDER'
   ELSE 'AUTRE'
  END
FROM facturefournisseurmontant ff, TIERS c where c.id (+)= ff.idFOURNISSEUR;

CREATE  VIEW ORDONNERPAYEMENTLETTRE (ID, DED_ID, IDLIGNE, DATY, MONTANT, REMARQUE, ETAT, ETATLETTRE, TIERS) AS 
  select o.ID,o.DED_ID,o.IDLIGNE,o.DATY,o.MONTANT,o.REMARQUE,o.ETAT, CASE
   WHEN o.etat=1 THEN 'CREER'
   WHEN o.etat=11 THEN 'VALIDER'
   ELSE 'AUTRE'
  END as etatLettre, f.IDFOURNISSEUR as tiers from ordonnerPayement o,factureFournisseurLettre f where o.DED_ID=f.ID;

  
CREATE  VIEW ETATORDONNERPAYEMENT (ID, DED_ID, IDLIGNE, DATY, MONTANT, REMARQUE, ETAT, ETATLETTRE, TIERS, MONTANTPAYE, RESTE) AS 
  SELECT o.ID,o.DED_ID,o.IDLIGNE,o.DATY,o.MONTANT,o.REMARQUE,o.ETAT,o.ETATLETTRE,o.TIERS, CAST (NVL (mvt.debit, 0) AS NUMBER (10, 2)) AS montantpaye,
          CAST ((o.MONTANT - NVL (mvt.debit, 0)) AS NUMBER (10, 2)
               ) AS reste
     FROM ordonnerpayementlettre o, mvtcaissegroupefopor mvt
    WHERE o.ID = mvt.idordre(+);