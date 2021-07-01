CREATE or replace VIEW ACTIVITECOMPLETFORMULE_I
AS
SELECT ac.ID                                    as id,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       sysdate                                            AS datedebut,
       '00:00:00'                                    as heuredebut,
       sysdate                                       AS datefin,
       '00:00:00'                                    as HEUREFIN ,
       '-'                                           AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       'NUIT'
                                                     AS estJour,
       'FERIE'                                          estFerie,
       '-'                                           AS manoeuvre,
       'weekend'
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       cast('-' as VARCHAR2(500))                    AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
    --  LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
     -- LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
where ac.RUBRIQUE in ('RB0000000021170444', 'RB0000000021170448');


CREATE or replace VIEW ACTIVITECOMPLETFORMULE_II
AS
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       NV.PAVILLON,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       pre.cargaison,
       occ.daty                                      AS datedebut,
       occ.heuredebut,
       OCC.DATEFIN                                   AS datefin,
       OCC.HEUREFIN                                  AS heurefin,
       occ.id                                        AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       CASE
           WHEN occ.heuredebut BETWEEN '05:00:00' AND '19:00:00'
               THEN
               'JOUR'
           ELSE
               'NUIT'
           END
                                                     AS estJour,
       CASE
           WHEN occ.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                     AS estFerie,
       occ.idmanoeuvrebord                           AS manoeuvre,
       CASE
           WHEN TO_CHAR(occ.daty, 'DAY') = 'DIMANCHE'
               OR TO_CHAR(occ.daty, 'DAY') = 'SAMEDI'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       nat.id                                        AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         LEFT JOIN occupationmaterielnaval occ ON occ.idprevision = pre.id
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
         LEFT JOIN natureoperation nat ON occ.idnatureoperation = nat.id
where Ra.ID not in ('RB0000000021170444', 'RB0000000021170448');

create or replace view ACTIVITECOMPLETFORMULE
            (
             ID,
             DESIGNATION,
             CLIENT,
             RUBRIQUE,
             QTE,
             MOIS,
             MOISLIB,
             ANNEE,
             DATY,
             BATEAU,
             ETAT,
             RUBRIQUELIB,
             NAVIRE,
             BATEAULIB,
             POIDS,
             LONGUEUR,
             LARGEUR,
             AUTRES,
             PU,
             DEVISE,
             COMPTE,
             UNITE,
             DIRECTION,
             CONDITION,
             TVA,
             OBJET,
             REDEVANCE,
             CLIENTLIB,
             REDEVANCELIB,
             DIRECTIONLIB,
             ETATLIB,
             CATEGORIE,
             CATEGORIELIB,
             REFOBJET,
             TYPESOURCE,
             DATEFACT,
             PAVILLON,
             VOLUME,
             VOLUMEARRONDI,
             CARGAISON,
             DATEDEBUT,
             HEUREDEBUT,
             datefin,
             heurefin,
             IDPRESTATION,
             ESTNATIONAL,
             ESTJOUR,
             ESTFERIE,
             MANOEUVRE,
             ESTWEEKEND,
             POSTE,
             POSTELIB,
             NATUREOPERATION,
             nbreheure,
             nbquartheure
                )
as
select *
from ACTIVITECOMPLETFORMULE_I
union
select *
from ACTIVITECOMPLETFORMULE_II;