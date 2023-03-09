CREATE OR REPLACE  VIEW ETATFACTUREMONTANTDATYRETENU (ID, DATY, IDFOURNISSEUR, NOMFOURNISSEUR, IDTVA, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE,
    NUMFACT, DATYECHEANCE, ETAT, NUMID, MONTANTPAYE, RESTE, ENTITE, MONTANTTTDEVISE, BUDGET, RETENUE, MONTANT, MONTANTAVOIR,
    MONTANTADDITIF, MONTANTNET, MONTANTHT, MONTANTTVA, MONTANTTTC, MONTANTAVOIRHT, MONTANTAVOIRTVA, MONTANTAVOIRTTC, MONTANTADDITIFHT, MONTANTADDITIFTVA, MONTANTADDITIFTTC, CODE_ETABLISSEMENT,PROJET) AS
  SELECT DISTINCT efm.id,
                efm.daty,
                efm.idfournisseur,
                t.nom                                                  AS nomfournisseur,
                efm.idtva,
                --efm.montantttc,
                efm.remarque                                           AS remarque,
                efm.dateemission,
                efm.designation,
                efm.iddevise,
                efm.numfact,
                efm.datyecheance,
                efm.etat,
                dff.NUMID,
                COALESCE(efm.montantpaye, 0)                           AS montantpaye,
                COALESCE(efm.reste, 0)                                 AS reste,
                ''                                                     AS entite,
                dff.montantttc                                         AS montantttdevise,
                ''                                                     AS budget,
                0                                                      AS retenue,
                ff.MONTANt                                             AS montant,


                av.montantavoirttc                                     as montantavoir,
                ad.montantadditifttc                                   as montantadditif,
                (ff.MONTANT - nvl(av.MONTANT, 0) + nvl(ad.montant, 0)) as montantnet,
                nvl(efm.montantht, 0)                                  as montantht,
                nvl(efm.montanttva, 0)                                 as montanttva,
                nvl(efm.montantttc, 0)                                 as montantttc,
                nvl(av.montantavoirht, 0)                              as montantavoirht,
                nvl(av.montantavoirtva, 0)                             as montantavoirtva,
                nvl(av.montantavoirttc, 0)                             as montantavoirttc,
                nvl(ad.montantadditifht, 0)                            as montantadditifht,
                nvl(ad.montantadditiftva, 0)                           as montantadditiftva,
                nvl(ad.montantadditifttc, 0)                           as montantadditifttc,
                dff.CODE_ETABLISSEMENT,
                dff.PROJET
                -- cast((ff.MONTANT - nvl(av.MONTANT, 0) + nvl(ad.montant, 0)) *(efm.IDTVA / 100) as number(25, 2))                                                          as montanttva
FROM etatfacturemontant efm
         JOIN facturefournisseur dff ON dff.id = efm.id
         LEFT JOIN tiers t ON dff.idfournisseur = t.id
         join facturefournisseur_SumMtt ff on ff.id = efm.id
         left join AVOIR_VISESM_grouper av on av.idfacture = ff.id
         left join additif_VISESM_grouper ad on ad.idfacture = ff.id;


create or replace view ETATFACTUREMONTANTDATY
            (ID, DATY, IDFOURNISSEUR, NOMFOURNISSEUR, IDTVA, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT,
             DATYECHEANCE, ETAT, MONTANTPAYE, RESTE, ENTITE, MONTANTTTDEVISE, BUDGET, RETENUE, NUMID, TIERSLIB, TVA,
             MONTANT, MONTANTAVOIR, MONTANTADDITIF, MONTANTNET, MONTANTTVA, MONTANTTTC, MONTANTTOTALAPAYER, TYPE,code_etablissement,projet)
as
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
             WHEN et.etat = 'VALIDE(E)' THEN '11'
             WHEN et.etat = 'CREE(E)' THEN '1'
             ELSE '0'
          END
             AS etat,
          NVL (et.montantpaye, 0) AS montantpaye,
          RESTE AS reste,
          et.entite,
          et.montantttdevise,
          et.budget,
          et.retenue,
          et.NUMID,
          t.NOM AS tierslib,
          et.IDTVA AS tva,
          et.montantht + et.montantadditifht - et.montantavoirht AS montant,
          (et.montantavoir),
          (et.montantadditif),
          (et.montantnet),
          et.montanttva + et.montantadditiftva - et.montantavoirtva
             AS montanttva,
          et.montantttc ,
          reste AS montantTotalApayer,
          ff.TYPE,
          co.VAL as CODE_ETABLISSEMENT,
          pr.DESIGNATION as PROJET
     FROM etatfacturemontantdatyretenu et
          JOIN facturefournisseur_SumMtt ff ON ff.id = et.id
          LEFT JOIN TIERS t ON t.id = et.idfournisseur
          left join  projet pr on pr.id=et.PROJET
          left join CODEETABLISSEMENT co on co.id=et.CODE_ETABLISSEMENT;