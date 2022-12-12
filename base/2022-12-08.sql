CREATE OR REPLACE VIEW SITUATIONLCDEPENSE (ID, DESIGNATION, COMPTE, ANNEE, MONTANT, ETAT, FACTURE, PAYE, ARECOUVRIR, RESTEBUDGET, POURCENGAGE, POURCPAYE, DIRECTION, PROJET, COMPTESTR, NIVEAU1, NIVEAU2, NIVEAU3, NIVEAU4) AS 
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
       cast((l.montant) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                        as restebudget,
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
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.etat,
         l.montant;