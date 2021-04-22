create or replace view facturefournisseurmontant_p
            (id, daty, idfournisseur, idtva, montantttc, remarque, dateemission, designation, iddevise, numfact, resp,
             datyecheance, etat, idfacturefournisseur, budget,exercice,montantdevise)
as
SELECT ff.id,
       ff.daty,
       ff.idfournisseur,
       ff.idtva,
       COALESCE((SELECT sum(detailsfacturefournisseur.pu * detailsfacturefournisseur.qte) +
                        ff.idtva * sum(detailsfacturefournisseur.pu * detailsfacturefournisseur.qte) /
                        100
                 FROM detailsfacturefournisseur
                 WHERE ff.id = detailsfacturefournisseur.idmere), 0) AS montantttc,
       ff.remarque,
       ff.dateemission,
       ff.designation,
       ff.iddevise,
       ff.numfact,
       ff.resp,
       ff.datyecheance,
       ff.etat,
       ff.idfacturefournisseur,
       ff.budget,
       ff.exercice,
       ff.montantdevise
FROM facturefournisseur ff;

create or replace view facturefournisseurlibelle as
select ff.id,
       daty,
       idfournisseur,
       t.NOM    as fournisseur,
       idtva,
       montantttc,
       remarque as idchantier,
       ch.nom   as remarque,
       dateemission,
       designation,
       iddevise,
       numfact,
       resp,
       datyecheance,
       ff.etat,
       ff.idfacturefournisseur,
       budget,
       montantdevise,
       exercice

from facturefournisseurmontant_p ff
         left join chantier ch on ch.id = ff.remarque
         left join tiers t on t.id = ff.idfournisseur;