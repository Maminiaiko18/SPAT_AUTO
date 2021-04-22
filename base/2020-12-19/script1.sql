CREATE OR REPLACE FORCE VIEW ETATFACTUREMONTANTDATY  AS 
  SELECT et.id,
       et.daty,
       et.idfournisseur,
       et.nomfournisseur,
       et.idtva,
       et.remarque,
       et.dateemission,
       et.designation,
       et.iddevise,
       et.numfact,
       et.datyecheance,
       CASE
           WHEN et.etat = 'VALIDER' THEN '11'
           WHEN et.etat = 'CREER' THEN '1'
           ELSE '0'
           END                                                                      AS etat,
       et.montantpaye,
       et.montantnet+et.montanttva - nvl(op.montant,0)                                                        AS reste,
       et.entite,
       et.montantttdevise,
       et.budget,
       et.retenue,
       et.NUMID,
       t.NOM                                                                        as tierslib,
       et.IDTVA                                                                     as tva,
       et.montant,
       et.montantavoir,
       et.montantadditif,
       et.montantnet,
       et.montanttva,
        cast((et.montantnet) +Et.montanttva as number(25, 2)) as montantttc,
       cast((et.montantnet) +Et.montanttva as number(25, 2)) as montantTotalApayer
FROM etatfacturemontantdatyretenu et
         join facturefournisseur_SumMtt ff on ff.id = et.id
         left join TIERS t on t.id = et.idfournisseur
         left join ordonnerpayementgroupefact op on op.ded_id=et.id;