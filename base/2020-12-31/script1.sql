create or replace view ETATFACTUREMONTANT as
SELECT f.id,
       f.daty,
       f.idfournisseur,
       f.idtva,
       f.montantHt,
       f.montanttva,
       f.montantttc,
       f.remarque,
       f.dateemission,
       f.designation,
       f.iddevise,
       f.numfact,
       f.datyecheance,
       f.etat,
       COALESCE(op.montant, 0)                AS montantpaye,
       f.montantttc - COALESCE(op.montant, 0) AS reste,
       f.entite,
       f.designation                          AS nomfournisseur,
       case
           when av.type = 'TYPEAV0001' then nvl(av.montant, 0)
           else 0 END                         AS MONTANTAVOIRHT
        ,
       case
           when av.type = 'TYPEAV0002' then nvl(av.montant, 0)
           else 0 end                         as montantavoirttc,

       case
           when ad.type = 'TYPEAV0001' then ad.montant
           when ad.type = 'TYPEAV0002' then ad.montant
           else 0 end                         as tet
FROM facturefournisseurlettremtt f
         LEFT JOIN LIAISONINTRATABLE_OP_PARFACT op ON f.id = op.ID1
         left join avoir_visesm av on av.idfacture = f.id
         left join additif_visesm ad on ad.idfacture = f.id
    group by f.id, f.daty, f.idfournisseur, f.idtva, f.montantHt, f.montanttva, f.montantttc, f.remarque, f.dateemission, f.designation, f.iddevise, f.numfact, f.datyecheance, f.etat, COALESCE(op.montant, 0), f.montantttc - COALESCE(op.montant, 0), f.entite, f.designation, case
           when av.type = 'TYPEAV0001' then nvl(av.montant, 0)
           else 0 END, case
           when av.type = 'TYPEAV0002' then nvl(av.montant, 0)
           else 0 end, case
           when ad.type = 'TYPEAV0001' then ad.montant
           when ad.type = 'TYPEAV0002' then ad.montant
           else 0 end
/

create or replace view ETATFACTUREMONTANTDATYRETENU as
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
                nvl(ad.montantadditifttc, 0)                           as montantadditifttc
                -- cast((ff.MONTANT - nvl(av.MONTANT, 0) + nvl(ad.montant, 0)) *(efm.IDTVA / 100) as number(25, 2))                                                          as montanttva
FROM etatfacturemontant efm
         JOIN facturefournisseur dff ON dff.id = efm.id
         LEFT JOIN tiers t ON dff.idfournisseur = t.id
         join facturefournisseur_SumMtt ff on ff.id = efm.id
         left join AVOIR_VISESM_grouper av on av.idfacture = ff.id
         left join additif_VISESM_grouper ad on ad.idfacture = ff.id
/

alter table regulBP
    add etat number(10);

create or replace view ETATFACTUREMONTANTDATY
            (ID, DATY, IDFOURNISSEUR, NOMFOURNISSEUR, IDTVA, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT,
             DATYECHEANCE, ETAT, MONTANTPAYE, RESTE, ENTITE, MONTANTTTDEVISE, BUDGET, RETENUE, NUMID, TIERSLIB, TVA,
             MONTANT, MONTANTAVOIR, MONTANTADDITIF, MONTANTNET, MONTANTTVA, MONTANTTTC, MONTANTTOTALAPAYER, TYPE)
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
           WHEN et.etat = 'VALIDER' THEN '11'
           WHEN et.etat = 'CREER' THEN '1'
           ELSE '0'
           END                                                   AS etat,
       nvl(op.MONTANT, 0)                                      as montantpaye,
       RESTE                                                     AS reste,
       et.entite,
       et.montantttdevise,
       et.budget,
       et.retenue,
       et.NUMID,
       t.NOM                                                     as tierslib,
       et.IDTVA                                                  as tva,
       et.montantht + et.montantadditifht - et.montantavoirht    as montant,
       (et.montantavoir),
       (et.montantadditif),
       (et.montantnet),
       et.montanttva + et.montantadditiftva - et.montantavoirtva as montanttva,
       et.montantttc + et.montantadditifttc - et.montantavoirttc as montantttc,
       et.montantttc + et.montantadditifttc - et.montantavoirttc as montantTotalApayer,
       ff.TYPE
FROM etatfacturemontantdatyretenu et
         join facturefournisseur_SumMtt ff on ff.id = et.id
         left join TIERS t on t.id = et.idfournisseur
         left join LIAISONINTRATABLE_OP_PARFACT op on op.ID1 = et.id
/

create view ordonnerpayement_bp
as
select rf.idbon,
       sum(op.montant) as montant
from regulfacture rf
         join liaisonintratable l on rf.IDFACTURE = l.id1
         join ordonnerpayement op on op.id = l.id2
where op.etat >= 11
group by rf.idbon;



CREATE OR REPLACE FORCE VIEW REGULBP_LIBCOMPLET ("ID", "IDBON", "MONTANT", "DATY", "IDUSER", "IDBONLIB", "IDUSERLIB", "ETAT") AS 
  select re."ID",re."IDBON",re."MONTANT",re."DATY",re."IDUSER",
       pro.LIBELLE as idbonlib,
       ut.NOMUSER as iduserlib,
       re.etat
from regulbp re
        join BON_PROVISOIRE pro on pro.id=re.IDBON
        join UTILISATEUR ut on re.idUser = ut.REFUSER;