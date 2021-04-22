create or replace view ETATFACTUREMONTANTDATY as
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
           END                                                                       AS etat,
       et.montantpaye,
       et.reste - et.retenue                                                         AS reste,
       et.entite,
       et.montantttdevise,
       et.budget,
       et.retenue,
       et.montant,
       et.NUMID,
       t.NOM                                                                         as tierslib,
       et.IDTVA                                                                      as tva,
       et.montanttva,
       et.montantttc,
       et.montantavoir,
       et.montantadditif,
       cast((et.MONTANTTTC) + (NVl(et.MONTANTADDITIF, 0) - NVl(et.MONTANTAVOIR, 0)) as number(25, 2)) as montantTotalApayer
FROM etatfacturemontantdatyretenu et
         join facturefournisseur_SumMtt ff on ff.id = et.id
         left join TIERS t on t.id = et.idfournisseur
/