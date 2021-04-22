CREATE OR REPLACE VIEW JOURNALCAISSE_INFO AS 
  SELECT e.id,
       e.nomfournisseur,
       e.montantttc,
       e.RESTE ,
  		o.ID AS idordre,
       e.idfournisseur
FROM  ordonnerpayement o 
         JOIN etatfacturemontantdaty e ON o.ded_id = e.id;