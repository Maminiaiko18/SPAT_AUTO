create or replace view SITUATIONLCDEPENSE as
SELECT l.id                                                                                     AS id,
       l.DESIGNATION                                                                            AS designation,
       l.COMPTE                                                                                 AS compte,
       l.ANNEE                                                                                  AS annee,
       cast((l.MONTANT) as NUMBER(30, 3))                                                       AS montant,
       l.etat,
       CAST(nvl(sum(MONTANTTTC), 0) AS NUMBER(30, 3))
                                                                                                AS facture,
       CAST(NVL(SUM(montantpaye), 0) AS NUMBER(30, 2))                                             paye,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3))              as arecouvrir,
       cast((sum(l.montant)) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                        as restebudget,
       cast(((nvl(sum(MONTANTTTC), 0)) / nvl(nullif(l.montant, 0), 1)) * 100 as NUMBER(30, 3))  as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) / nvl(nullif(l.montant, 0), 1)) * 100 as number(30, 3)) as pourcPaye,
       substr(substr(l.COMPTE, 1, 6), 1, 3)                                                     as direction,
       substr(substr(l.COMPTE, 1, 6), 4, 7)                                                     as projet,
       substr(l.COMPTE, 7, length(l.COMPTE))                                                    as comptestr,
       substr(substr(l.COMPTE, 7, length(l.COMPTE)),1,1)  as  niveau1,
       substr(substr(l.COMPTE, 7, length(l.COMPTE)),1,2)  as  niveau2,
       substr(substr(l.COMPTE, 7, length(l.COMPTE)),1,3)  as  niveau3,
       substr(substr(l.COMPTE, 7, length(l.COMPTE)),1,4)  as  niveau4
FROM LIGNECREDITDEPENSEVRAI l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
                   ON mf.COMPTE = l.COMPTE and length(mf.COMPTE) = 11

--where l.ETAT >= 11
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.etat,
         l.montant;

create or replace view SITUATIONLCDEPENSEC as
select *
from SITUATIONLCDEPENSE
where etat = 1;


create or replace view SITUATIONLCDEPENSEVSD as
select l.id,
       l.DESIGNATION,
       l.compte,
       l.ANNEE,
       l.montant                                                                   as montant,
       l.etat,
       substr(l.compte, 7, length(l.compte))                                       as comptestr,
       cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))                              as facture,
       cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3))                             as PAYE,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3)) as arecouvrir,
       cast((l.montant) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                as restebudget,
       cast(((nvl(sum(MONTANTTTC), 0)) / l.MONTANT) * 100 as NUMBER(30, 3))        as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100 as number(30, 3))       as pourcPaye,
       comptecpl,
       substr(l.COMPTE, 7) || substr(l.COMPTE, 1, 6)                               as compteinv,
       substr(l.COMPTE, 7)                                                         as comptesimple,
       substr(l.COMPTE, 1, 6)                                                      as directionProjet,
       substr(substr(l.COMPTE, 1, 6), 1, 3)                                        as direction,
       substr(substr(l.COMPTE, 1, 6), 4, 7)                                        as projet,
       ----  mf.DATY,
       l.PROJET                                                                    as idprojet,
       l.CODEETABLISSEMENT                                                         as idCODEETABLISSEMENT,
       substr(substr(l.COMPTE, 7, length(l.COMPTE)), 1, 1)                         as niveau1,
       substr(substr(l.COMPTE, 7, length(l.COMPTE)), 1, 2)                         as niveau2,
       substr(substr(l.COMPTE, 7, length(l.COMPTE)), 1, 3)                         as niveau3,
       substr(substr(l.COMPTE, 7, length(l.COMPTE)), 1, 4)                         as niveau4

from LIGNECREDITDEPENSEVRAI l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
    -- on substr(l.compte, 7, length(l.compte)) = mf.compte AND mf.annee = l.annee
                   on l.compte = mf.COMPTE
                       --AND mf.annee = l.annee
                       and length(mf.COMPTE) = 11
where l.etat >= 11
      --and mf.comptecpl is not null
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat, substr(l.compte, 7, length(l.compte)), comptecpl,
         l.PROJET, l.CODEETABLISSEMENT;



create or replace view PREVISIONLIBCOMPLETPDF as
SELECT pre.ID,
          pre.date_rade,
          pre.provenance,
          pre.navire,
          pre.consignataire,
          pre.cargaison,
          pre.pilote,
          pre.date_arrivee,
          pre.heure_arrivee,
          pre.date_depart,
          pre.heure_depart,
          esca.DESTINATION as destination,
          pre.etat,
          pro.QUAI AS QUAIPROVENANCE,
          q.VAL AS valquaisprovenance,
          q.PAYS AS paysprovenance,
          pa.VAL AS valpaysprovenance,
          pr.QUAI AS QUAIDESTINATION,
          q1.val AS valquaisdestination,
          q1.PAYS AS paysdestination,
          pa1.VAL AS valpaysdestination,
          pro.INTERNE AS INTERNEPOVENANCE,
          q.LONGUEUR AS longueurprovenance,
          q.TIRANT AS tirantprovenance,
          q.PROFONDEUR AS profondeurprovenance,
          na.REFERENCE AS referencenavire,
          na.NOM AS nomnavire,
          na.PAVILLON AS pavillonnavire,
          na.JNT AS jntnavire,
          na.JBT AS jbtnavire,
          na.PLT AS pltnavire,
          na.LHT AS lhtnavire,
          na.LM AS lmnavire,
          na.TE AS tenavire,
          na.VOLUME AS volumenavire,
          na.REMARQUE AS remarquenavire,
          na.ETAT AS etatnavire,
          con.NOMCLT AS valconsignataire,
          con.ADRCLT AS desceconsignataire,
          car.VAL AS valcargaison,
          car.DESCE AS descecargaison,
          pi.VAL AS valpilote,
          pi.DESCE AS descepilote,
          pr.INTERNE AS INTERNEDESTINATION,
          q1.LONGUEUR AS longueurdestination,
          q1.TIRANT AS tirantdestination,
          q1.PROFONDEUR AS profondeurdestination,
          pa.DESCE AS desceprovenance,
          pa1.DESCE AS descedestination,
          t.VAL AS valtypequaisprovenance,
          t.DESCE AS descetypequaisprovenance,
          t2.val AS valtypequaisdestination,
          t2.DESCE AS descetypequaisdestination,
          q.DESCE AS descequaisprovenance,
          q1.DESCE AS descequaisdestination,
          q.TYPEQUAIS AS typequaisprovenance,
          q1.TYPEQUAIS AS typequaisdestination,
          na.TYPE AS typenavire,
          tn.VAL AS typenavirelib,
          pre.escale,
          pre.NOVOYAGE,
          pre.ARMATEUR,
          cons.NOMCLT AS ARMATEURLIB,
          0 AS majoration,
          0 AS reduction,
          pay.val AS pavillonlib,
          CAST ('' AS VARCHAR2 (500)) AS DESIGNATION,
          CAST ('' AS VARCHAR2 (500)) AS CODE,
          pre.TONNAGE
     FROM prevision pre
          LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
          LEFT JOIN NAVIRE na ON na.id = pre.NAVIRE
          LEFT JOIN PAYS pay ON pay.id = na.pavillon
          LEFT JOIN clientmat con ON con.CDCLT = pre.CONSIGNATAIRE
          LEFT JOIN CARGAISON car ON car.id = pre.CARGAISON
          LEFT JOIN commandant pi ON pi.ID = pre.PILOTE
          left join MOUVEMENTDEPART_ESC esca on esca.ESCALE=pre.id
          LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = esca.DESTINATION
          LEFT JOIN QUAIS q ON q.id = pro.QUAI
          LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
          LEFT JOIN PAYS pa ON pa.id = q.PAYS
          LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
          LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
          LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
          LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
          LEFT JOIN clientmat cons ON cons.CDCLT = pre.ARMATEUR;