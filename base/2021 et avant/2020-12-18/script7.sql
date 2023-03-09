create or replace view additiflib as
select ad.ID,
       ad.DATY,
       ff.DESIGNATION as IDFACTURE,
       ad.MONTANT,
       tf.VAL         as TYPE,
       ad.ETAT
from additif ad
         left join FACTUREFOURNISSEUR ff on ff.id = ad.IDFACTURE
         left join TYPEADDITIF tf on tf.id = ad.TYPE;
create or replace view additif_libcomplet as
select ad.*,
        ff.DESIGNATION as IDFACTURElib,
       tf.VAL         as TYPElib
from ADDITIF ad
         left join FACTUREFOURNISSEUR ff on ff.id = ad.IDFACTURE
         left join TYPEADDITIF tf on tf.id = ad.TYPE;
create view avoir_visesm as
select IDFACTURE as idfacture, sum(MONTANT) as montant, etat
from AVOIR
where ETAT>=11
group by IDFACTURE,ETAT;

create view additif_visesm as
select IDFACTURE as idfacture, sum(MONTANT) as montant, etat
from ADDITIF
where ETAT>=11
group by IDFACTURE,ETAT;

create or replace view ETATFACTUREMONTANTDATYRETENU as
SELECT DISTINCT efm.id,
                efm.daty,
                efm.idfournisseur,
                t.nom                                                              AS nomfournisseur,
                efm.idtva,
                --efm.montantttc,
                efm.remarque                                                       AS remarque,
                efm.dateemission,
                efm.designation,
                efm.iddevise,
                efm.numfact,
                efm.datyecheance,
                efm.etat,
                dff.NUMID,
                COALESCE(efm.montantpaye, 0)                                       AS montantpaye,
                COALESCE(efm.reste, 0)                                             AS reste,
                ''                                                                 AS entite,
                dff.montantttc                                                     AS montantttdevise,
                ''                                                                 AS budget,
                0                                                                  AS retenue,
                ff.MONTANT                                                         AS montant,
                cast(ff.MONTANT * (efm.IDTVA / 100) as number(25, 2))              as montanttva,
                cast(ff.montant + ff.MONTANT * (efm.IDTVA / 100) as number(25, 2)) as montantttc,
                NVl(av.montant, 0)                                                 as montantavoir,
                NVl(ad.montant, 0)                                                 as montantadditif
FROM etatfacturemontant efm
         JOIN facturefournisseur dff ON dff.id = efm.id
         LEFT JOIN tiers t ON dff.idfournisseur = t.id
         LEFT JOIN ordonnerpayement op
                   ON op.ded_id = dff.id AND OP.ETAT >= 11
         LEFT JOIN JOURNALCAISSE mv ON mv.idordre = op.id
         join facturefournisseur_SumMtt ff on ff.id = efm.id
         left join avoir_visesm av on av.idfacture = ff.id
         left join additif_visesm ad on ad.idfacture = ff.id;



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
       cast((et.montant) - (NVl(et.MONTANTADDITIF, 0) + NVl(et.MONTANTAVOIR, 0)) as number(25, 2)) as montantTotalApayer
FROM etatfacturemontantdatyretenu et
         join facturefournisseur_SumMtt ff on ff.id = et.id
         left join TIERS t on t.id = et.idfournisseur;