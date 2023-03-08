CREATE OR REPLACE FORCE VIEW ETATORDONNERPAYEMENT AS 
  SELECT o.ID,o.DED_ID,o.IDLIGNE,o.DATY,o.MONTANT,o.REMARQUE,o.ETAT,o.ETATLETTRE,o.TIERS, CAST (NVL (mvt.debit, 0) AS NUMBER (10, 2)) AS montantpaye,
          CAST ((o.MONTANT - NVL (mvt.debit, 0)) AS NUMBER (25, 2)
               ) AS reste
     FROM ordonnerpayementlettre o, mvtcaissegroupefopor mvt
    WHERE o.ID = mvt.idordre(+);
	
alter table ORDONNERPAYEMENT modify (montant    NUMBER (25, 2) );