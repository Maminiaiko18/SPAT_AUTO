create or replace view CONTRAT_CHANTIER_SUM as
select ch.ID,
       ch.IDCHANTIER,
       ch.DESIGNATION,
       ch.MONTANT,
       ch.PRESTATAIRE,
       ch.ETAT,
       nvl(fact.montant, 0)                           as montantfact,
       ch.montant - nvl(fact.montant, 0)              as resteAfacturer,
       nvl(pay.montantpaye, 0)                        as montant_paye,
       nvl(fact.montant - nvl(pay.montantpaye, 0), 0) as reste_a_payer,
       ti.NOM as nom_prestataire
from contrat_chantier ch
         left join facturefournisseur_SumMtt fact on fact.remarque = ch.id
         left join contrat_chantier_mttpaye pay on pay.id = ch.id
          left join TIERS ti on ti.id=ch.PRESTATAIRE;

create or replace view ETATFACTUREMONTANTDATYRETENU as
SELECT DISTINCT efm.id,
                efm.daty,
                efm.idfournisseur,
                t.nom                                                                                             AS nomfournisseur,
                efm.idtva,
                --efm.montantttc,
                efm.remarque                                                                                      AS remarque,
                efm.dateemission,
                efm.designation,
                efm.iddevise,
                efm.numfact,
                efm.datyecheance,
                efm.etat,
                dff.NUMID,
                COALESCE(efm.montantpaye, 0)                                                                      AS montantpaye,
                COALESCE(efm.reste, 0)                                                                            AS reste,
                ''                                                                                                AS entite,
                dff.montantttc                                                                                    AS montantttdevise,
                ''                                                                                                AS budget,
                0                                                                                                 AS retenue,
                ff.MONTANT                                                                                        AS montant,
                NVl(av.montant, 0)                                                                                as montantavoir,
                NVl(ad.montant, 0)                                                                                as montantadditif,
                (ff.MONTANT - nvl(av.MONTANT, 0) + nvl(ad.montant, 0))                 as montantnet,
                cast((ff.MONTANT - nvl(av.MONTANT, 0) + nvl(ad.montant, 0)) *(efm.IDTVA / 100) as number(25, 2))  as montanttva
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
           END                                                                      AS etat,
       et.montantpaye,
       et.reste - et.retenue                                                        AS reste,
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
         left join TIERS t on t.id = et.idfournisseur;

CREATE OR REPLACE  VIEW MOUVEMENTLIBCOMPLET  as
SELECT distinct
            mvt.ID,
            mvt.daty,
            mvt.ESCALE,
            mvt.NAVIRE,
            mvt.CONSIGNATAIRE,
            mvt.PROVENANCE,
            mvt.DESTINATION,
            mvt.REMARQUE,
            mvt.DUREE  ,
            mvt.TYPEMVT,
            mvt.CARGAISON,
            na.REFERENCE as referencenavire,
            na.NOM as nomnavire,
            tm.VAL as valmvt,
            tm.desce as descemvt,
            car.VAL as valcargaison,
            car.desce as descecargaison,
            cons.VAL as valconsignataire,
            cons.DESCE as desceconsignataire,
            pro.QUAI as quaiprovenance,
            q.val as valquaisprovenance,
            q.PAYS as paysprovenance,
            p.VAL as valpaysprovenance,
            des.QUAI as quaisdestination,
            q1.VAL as valquaisdestination,
            q1.PAYS as paysdestination,
            p1.VAL as valpaysdestination,
            mvt.DATEARRIVEE,
            mvt.heure,
            mvt.DATE_DEPART,
            mvt.HEURE_DEPART,
            pro.INTERNE as interneprovenance,
            q.DESCE as descequaisprovenance,
            q.TYPEQUAIS as typequaisprovenance,
            q.TIRANT as tirantprovenance,
            q.LONGUEUR as longueurprovenance,
            q.PROFONDEUR as profondeurprovenance,
            p.DESCE as descepaysprovenance,
            des.INTERNE as internedestination,
            q1.DESCE as descequaisdestination,
            q1.TYPEQUAIS as typequaisdestianantion,
            q1.TIRANT as tirantdestination,
            q1.LONGUEUR as longueurdestination,
            q1.PROFONDEUR as profondeurdestination,
            p1.DESCE as descepaysdestination,
            na.PAVILLON as pavillonnavire,
            na.JNT as jntnavire,
            na.JBT as jbtnavire,
            na.PLT as pltnavire,
            na.LHT as lhtnavire,
            na.LM as lmnavire,
            na.TE as tenavire,
            na.VOLUME as volumenavire,
            na.REMARQUE as remarquenavire,
            na.ETAT as etatnavire,
            t.VAL as valtypequaisprovenance,
            t.DESCE as descetypequaisprovenance,
            t2.val as valtypequaisdestination,
            t2.DESCE as descetypequaisdestination,
            mvt.etat
        from MOUVEMENT mvt
        left join  NAVIRE na on na.ID=MVT.NAVIRE
        left join CONSIGNATAIRETAB cons on cons.val =mvt.CONSIGNATAIRE
        left join POSTEDESTINATAIRE pro on pro.id=mvt.PROVENANCE
        left join POSTEDESTINATAIRE des on des.id=mvt.DESTINATION
        left join TYPEMVT tm on  tm.id=mvt.TYPEMVT
        left join CARGAISON car on car.id=mvt.CARGAISON
        left join quais q on q.id=pro.QUAI
        left join pays p on p.id=q.PAYS
        left join  quais q1 on q1.id=des.QUAI
        left join pays p1 on p1.id=q1.PAYS
        left JOIN TYPEQUAIS T on q.TYPEQUAIS = T.ID
        left JOIN TYPEQUAIS T2 ON T2.ID=Q1.TYPEQUAIS;