		
DELETE from configuration WHERE 1<2;
COMMIT;


CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE_I
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface, nb5jours)
AS
SELECT ac.ID                                         AS id,
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
       SYSDATE                                       AS datedebut,
       '00:00:00'                                    AS heuredebut,
       SYSDATE                                       AS datefin,
       '00:00:00'                                    AS HEUREFIN,
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
       'NUIT'                                        AS estJour,
       'FERIE'                                          estFerie,
       '-'                                           AS manoeuvre,
       'weekend'                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       CAST('-' AS VARCHAR2(500))                    AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure,
       CAST(1 AS NUMBER(10))                         AS nbjour,
       q.typequais,
       cast(5.00 as NUMBER(20,2)) as surface,
       cast(2 as NUMBER(10))as nb5jours
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
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
WHERE ac.RUBRIQUE IN ('RB0000000021170444',
                      'RB0000000021170448',
                      'RB0000000021170449', 'RBR0101', 'RBR0102', 'RBR0103', 'RBR0104', 'RBR0105', 'RBR0106', 'RBR0107',
                      'RBR0108', 'RBR0109', 'RBR0110', 'RBR0111', 'RBR0112', 'RBR0113', 'RBR0114', 'RBR0115', 'RBR0116',
                      'RBR0117', 'RBR0118', 'RBR0119', 'RBR0120', 'RBR0121', 'RBR0122', 'RBR0123', 'RBR0124', 'RBR0125');



CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE_II
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface, nb5jours)
as
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
       CASE
           WHEN ((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15 < 0
               THEN
               0
           ELSE
               ROUND(((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15)
           END
                                                     AS nbQuartHeure,
       CASE
           WHEN 24 * (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           ELSE ROUND((24 * (na.DATYFIN - na.DATYDEBUT)))
           END
                                                     AS nbHeure,
       CASE
           WHEN (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           ELSE ROUND(na.DATYFIN - na.DATYDEBUT)
           END
                                                     AS nbJour,
       q.typequais,
       cast(nv.LHT * nv.lm as NUMBER(20, 2))         as surface,
       CASE
           WHEN (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           ELSE case
                    when ((na.DATYFIN - na.DATYDEBUT) / 5) < 1 then 0
                    else trunc((na.DATYFIN - na.DATYDEBUT) / 5)+1
               end
           END                                       as nb5jours
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
         LEFT JOIN OCCUPATIONMATERIELNAVAL_daty na ON na.id = occ.id
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
WHERE Ra.ID NOT IN ('RB0000000021170444',
                    'RB0000000021170448',
                    'RB0000000021170449', 'RBR0101', 'RBR0102', 'RBR0103', 'RBR0104', 'RBR0105', 'RBR0106', 'RBR0107',
                    'RBR0108', 'RBR0109', 'RBR0110', 'RBR0111', 'RBR0112', 'RBR0113', 'RBR0114', 'RBR0115', 'RBR0116',
                    'RBR0117', 'RBR0118', 'RBR0119', 'RBR0120', 'RBR0121', 'RBR0122', 'RBR0123', 'RBR0124', 'RBR0125');
					
CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE_II
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface, nb5jours)
as
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
       CASE
           WHEN ((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15 < 0
               THEN
               0
           ELSE
               ROUND(((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15)
           END
                                                     AS nbQuartHeure,
       CASE
           WHEN 24 * (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           ELSE ROUND((24 * (na.DATYFIN - na.DATYDEBUT)))
           END
                                                     AS nbHeure,
       CASE
           WHEN (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           WHEN round(na.DATYFIN - na.DATYDEBUT) = 0 THEN 1
           ELSE ROUND(na.DATYFIN - na.DATYDEBUT)
           END
                                                     AS nbJour,
       q.typequais,
       cast(nv.LHT * nv.lm as NUMBER(20, 2))         as surface,
       CASE
           WHEN (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           ELSE case
                    when round(((na.DATYFIN - na.DATYDEBUT) )) between 0 and 5 then 1
                    else trunc((na.DATYFIN - na.DATYDEBUT) / 5)+1
               end
           END                                       as nb5jours
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
         LEFT JOIN OCCUPATIONMATERIELNAVAL_daty na ON na.id = occ.id
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
WHERE Ra.ID NOT IN ('RB0000000021170444',
                    'RB0000000021170448',
                    'RB0000000021170449', 'RBR0101', 'RBR0102', 'RBR0103', 'RBR0104', 'RBR0105', 'RBR0106', 'RBR0107',
                    'RBR0108', 'RBR0109', 'RBR0110', 'RBR0111', 'RBR0112', 'RBR0113', 'RBR0114', 'RBR0115', 'RBR0116',
                    'RBR0117', 'RBR0118', 'RBR0119', 'RBR0120', 'RBR0121', 'RBR0122', 'RBR0123', 'RBR0124', 'RBR0125');

CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE_II
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface, nb5jours, quais)
as
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
       CASE
           WHEN ((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15 < 0
               THEN
               0
           ELSE
               ROUND(((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15)
           END
                                                     AS nbQuartHeure,
       CASE
           WHEN 24 * (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           ELSE ROUND((24 * (na.DATYFIN - na.DATYDEBUT)))
           END
                                                     AS nbHeure,
       CASE
           WHEN (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           WHEN round(na.DATYFIN - na.DATYDEBUT) = 0 THEN 1
           ELSE ROUND(na.DATYFIN - na.DATYDEBUT)
           END
                                                     AS nbJour,
       q.typequais,
       cast(nv.LHT * nv.lm as NUMBER(20, 2))         as surface,
       CASE
           WHEN (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           ELSE case
                    when round(((na.DATYFIN - na.DATYDEBUT))) between 0 and 5 then 1
                    else trunc((na.DATYFIN - na.DATYDEBUT) / 5) + 1
               end
           END                                       as nb5jours,
       pd2.QUAI
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
         LEFT JOIN OCCUPATIONMATERIELNAVAL_daty na ON na.id = occ.id
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
WHERE Ra.ID NOT IN ('RB0000000021170444',
                    'RB0000000021170448',
                    'RB0000000021170449', 'RBR0101', 'RBR0102', 'RBR0103', 'RBR0104', 'RBR0105', 'RBR0106', 'RBR0107',
                    'RBR0108', 'RBR0109', 'RBR0110', 'RBR0111', 'RBR0112', 'RBR0113', 'RBR0114', 'RBR0115', 'RBR0116',
                    'RBR0117', 'RBR0118', 'RBR0119', 'RBR0120', 'RBR0121', 'RBR0122', 'RBR0123', 'RBR0124', 'RBR0125');

					

CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE_I
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface, nb5jours,QUAI)
AS
SELECT ac.ID                                         AS id,
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
       SYSDATE                                       AS datedebut,
       '00:00:00'                                    AS heuredebut,
       SYSDATE                                       AS datefin,
       '00:00:00'                                    AS HEUREFIN,
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
       'NUIT'                                        AS estJour,
       'FERIE'                                          estFerie,
       '-'                                           AS manoeuvre,
       'weekend'                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       CAST('-' AS VARCHAR2(500))                    AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure,
       CAST(1 AS NUMBER(10))                         AS nbjour,
       q.typequais,
       cast(5.00 as NUMBER(20,2)) as surface,
       cast(2 as NUMBER(10))as nb5jours,
       pd2.QUAI
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
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
WHERE ac.RUBRIQUE IN ('RB0000000021170444',
                      'RB0000000021170448',
                      'RB0000000021170449', 'RBR0101', 'RBR0102', 'RBR0103', 'RBR0104', 'RBR0105', 'RBR0106', 'RBR0107',
                      'RBR0108', 'RBR0109', 'RBR0110', 'RBR0111', 'RBR0112', 'RBR0113', 'RBR0114', 'RBR0115', 'RBR0116',
                      'RBR0117', 'RBR0118', 'RBR0119', 'RBR0120', 'RBR0121', 'RBR0122', 'RBR0123', 'RBR0124', 'RBR0125');
					  
					

CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE_I
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface, nb5jours,QUAI,flotte)
AS
SELECT ac.ID                                         AS id,
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
       SYSDATE                                       AS datedebut,
       '00:00:00'                                    AS heuredebut,
       SYSDATE                                       AS datefin,
       '00:00:00'                                    AS HEUREFIN,
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
       'NUIT'                                        AS estJour,
       'FERIE'                                          estFerie,
       '-'                                           AS manoeuvre,
       'weekend'                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       CAST('-' AS VARCHAR2(500))                    AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure,
       CAST(1 AS NUMBER(10))                         AS nbjour,
       q.typequais,
       cast(5.00 as NUMBER(20,2)) as surface,
       cast(2 as NUMBER(10))as nb5jours,
       pd2.QUAI,
       cast('-' as varchar2(100)) as flotte
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
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
WHERE ac.RUBRIQUE IN ('RB0000000021170444',
                      'RB0000000021170448',
                      'RB0000000021170449', 'RBR0101', 'RBR0102', 'RBR0103', 'RBR0104', 'RBR0105', 'RBR0106', 'RBR0107',
                      'RBR0108', 'RBR0109', 'RBR0110', 'RBR0111', 'RBR0112', 'RBR0113', 'RBR0114', 'RBR0115', 'RBR0116',
                      'RBR0117', 'RBR0118', 'RBR0119', 'RBR0120', 'RBR0121', 'RBR0122', 'RBR0123', 'RBR0124', 'RBR0125');


CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE_II
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface, nb5jours, quais,flotte)
as
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
       CASE
           WHEN ((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15 < 0
               THEN
               0
           ELSE
               ROUND(((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15)
           END
                                                     AS nbQuartHeure,
       CASE
           WHEN 24 * (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           ELSE ROUND((24 * (na.DATYFIN - na.DATYDEBUT)))
           END
                                                     AS nbHeure,
       CASE
           WHEN (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           WHEN round(na.DATYFIN - na.DATYDEBUT) = 0 THEN 1
           ELSE ROUND(na.DATYFIN - na.DATYDEBUT)
           END
                                                     AS nbJour,
       q.typequais,
       cast(nv.LHT * nv.lm as NUMBER(20, 2))         as surface,
       CASE
           WHEN (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           ELSE case
                    when round(((na.DATYFIN - na.DATYDEBUT))) between 0 and 5 then 1
                    else trunc((na.DATYFIN - na.DATYDEBUT) / 5) + 1
               end
           END                                       as nb5jours,
       pd2.QUAI,
       occ.IDMATERIEL_NAVAL as flotte
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
         LEFT JOIN OCCUPATIONMATERIELNAVAL_daty na ON na.id = occ.id
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
WHERE Ra.ID NOT IN ('RB0000000021170444',
                    'RB0000000021170448',
                    'RB0000000021170449', 'RBR0101', 'RBR0102', 'RBR0103', 'RBR0104', 'RBR0105', 'RBR0106', 'RBR0107',
                    'RBR0108', 'RBR0109', 'RBR0110', 'RBR0111', 'RBR0112', 'RBR0113', 'RBR0114', 'RBR0115', 'RBR0116',
                    'RBR0117', 'RBR0118', 'RBR0119', 'RBR0120', 'RBR0121', 'RBR0122', 'RBR0123', 'RBR0124', 'RBR0125');

CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface, nb5jours, QUAI,
             flotte)
AS
select ID,
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
       cast(VOLUME as number(20, 2)) as VOLUME,
       cast(VOLUMEARRONDI as number(20,2)) as VOLUMEARRONDI,
       cast(CARGAISON as NUMBER(20,2)),
       DATEDEBUT,
       HEUREDEBUT,
       DATEFIN,
       HEUREFIN,
       IDPRESTATION,
       ESTNATIONAL,
       ESTJOUR,
       ESTFERIE,
       MANOEUVRE,
       ESTWEEKEND,
       POSTE,
       POSTELIB,
       NATUREOPERATION,
       cast(NBQUARTHEURE as NUMBER(20))as NBQUARTHEURE,
       cast(NBHEURE as NUMBER(20)) as NBHEURE,
       cast(NBJOUR as NUMBER(20)) as NBJOUR,
       TYPEQUAIS,
       cast(surface as NUMBER(20,2)) as surface,
       cast(nb5jours as NUMBER(2)) as nb5jours,
       QUAI,
       flotte
from (
         SELECT *
         FROM ACTIVITECOMPLETFORMULE_I
         UNION ALL
         SELECT *
         FROM ACTIVITECOMPLETFORMULE_II a);
		 
DELETE FROM SPAT_PREPROD_II.TYPE_MATERIEL WHERE ID LIKE 'TYPE000108';
commit;

create table categorie_materiel
(
    id    varchar2(100)
        constraint categorie_materiel_pk primary key,
    val   varchar2(500),
    desce varchar2(500)
);


 INSERT INTO CATEGORIE_MATERIEL (ID, VAL, DESCE) VALUES ('CM001', 'matériel armé', 'matériel armé');
 INSERT INTO CATEGORIE_MATERIEL (ID, VAL, DESCE) VALUES ('CM002', 'matériel de servitude', 'matériel de servitude');

commit;

alter table materiel_naval
    add idcategorie varchar2(100)
        constraint idcategorie_materielnaval_fk references categorie_materiel;
		

  CREATE OR REPLACE VIEW MATERIELNAVALLIBCOMPLET (ID, DENOMINATION, DATE_AQUISITION,
      IDMARQUE, PUISSANCE, DETENTEUR, MAINTENANCE, IDTYPE_MATERIEL, IMMATRICULATION,
      ETAT, VALMARQUE, DESCEMARQUE, VALTYPEMATERIEL, DESCETYPEMATERIEL,IDCATEGORIE,idCategorielib) AS
  SELECT
	mat.ID,
	mat.DENOMINATION,
	mat.DATE_AQUISITION,
	mat.IDMARQUE,
	mat.PUISSANCE,
	mat.DETENTEUR,
	mat.MAINTENANCE,
	mat.IDTYPE_MATERIEL,
	mat.IMMATRICULATION,
	mat.ETAT,
	marque.VAL AS valmarque,
	marque.DESCE AS descemarque,
	typemat.val AS valtypemateriel,
	typemat.DESCE AS descetypemateriel,
    mat.IDCATEGORIE,
    cm.val as idCategorielib
FROM
	MATERIEL_NAVAL mat
LEFT JOIN MARQUE_MATERIEL marque ON marque.id = mat.IDMARQUE
LEFT JOIN TYPE_MATERIEL typemat ON 	typemat.id = mat.IDTYPE_MATERIEL
left join categorie_materiel cm on cm.ID=mat.IDCATEGORIE;

CREATE OR REPLACE VIEW MATERIELNAVALLIB
            (ID, DENOMINATION, DATE_AQUISITION, IDMARQUE, PUISSANCE,
                DETENTEUR, MAINTENANCE, IDTYPE_MATERIEL,IMMATRICULATION, ETAT,IDCATEGORIE,IDCATEGORIELIB)
AS
select id,
       denomination,
       date_aquisition,
       valmarque       as idmarque,
       puissance,
       detenteur,
       maintenance,
       valtypemateriel as idtype_materiel,
       immatriculation,
       etat,
       IDCATEGORIE,
       IDCATEGORIELIB
from MATERIELNAVALLIBCOMPLET;

CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE_I
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface,
             nb5jours,QUAI,flotte,categorie_flotte)
AS
SELECT ac.ID                                         AS id,
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
       SYSDATE                                       AS datedebut,
       '00:00:00'                                    AS heuredebut,
       SYSDATE                                       AS datefin,
       '00:00:00'                                    AS HEUREFIN,
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
       'NUIT'                                        AS estJour,
       'FERIE'                                          estFerie,
       '-'                                           AS manoeuvre,
       'weekend'                                     AS estWeekend,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       CAST('-' AS VARCHAR2(500))                    AS natureoperation,
       CAST(3 AS INTEGER)                            AS nbHeure,
       CAST(5 AS INTEGER)                            AS nbQuartHeure,
       CAST(1 AS NUMBER(10))                         AS nbjour,
       q.typequais,
       cast(5.00 as NUMBER(20,2)) as surface,
       cast(2 as NUMBER(10))as nb5jours,
       pd2.QUAI,
       cast('-' as varchar2(100)) as flotte,
       cast('-' as varchar2(100))categorie_flotte
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
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
WHERE ac.RUBRIQUE IN ('RB0000000021170444',
                      'RB0000000021170448',
                      'RB0000000021170449', 'RBR0101', 'RBR0102', 'RBR0103', 'RBR0104', 'RBR0105', 'RBR0106', 'RBR0107',
                      'RBR0108', 'RBR0109', 'RBR0110', 'RBR0111', 'RBR0112', 'RBR0113', 'RBR0114', 'RBR0115', 'RBR0116',
                      'RBR0117', 'RBR0118', 'RBR0119', 'RBR0120', 'RBR0121', 'RBR0122', 'RBR0123', 'RBR0124', 'RBR0125');
					  

CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE_II
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface,
             nb5jours, quais,flotte,categorie_flotte)
as
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
       CASE
           WHEN ((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15 < 0
               THEN
               0
           ELSE
               ROUND(((60 * 24 * (na.DATYFIN - na.DATYDEBUT)) - 60) / 15)
           END
                                                     AS nbQuartHeure,
       CASE
           WHEN 24 * (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           ELSE ROUND((24 * (na.DATYFIN - na.DATYDEBUT)))
           END
                                                     AS nbHeure,
       CASE
           WHEN (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           WHEN round(na.DATYFIN - na.DATYDEBUT) = 0 THEN 1
           ELSE ROUND(na.DATYFIN - na.DATYDEBUT)
           END
                                                     AS nbJour,
       q.typequais,
       cast(nv.LHT * nv.lm as NUMBER(20, 2))         as surface,
       CASE
           WHEN (na.DATYFIN - na.DATYDEBUT) < 0 THEN 0
           ELSE case
                    when round(((na.DATYFIN - na.DATYDEBUT))) between 0 and 5 then 1
                    else trunc((na.DATYFIN - na.DATYDEBUT) / 5) + 1
               end
           END                                       as nb5jours,
       pd2.QUAI,
       occ.IDMATERIEL_NAVAL as flotte,
       cm.IDCATEGORIE as categorie_flotte
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
         LEFT JOIN OCCUPATIONMATERIELNAVAL_daty na ON na.id = occ.id
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
         left join MATERIEL_NAVAL cm on cm.id=occ.IDMATERIEL_NAVAL
WHERE Ra.ID NOT IN ('RB0000000021170444',
                    'RB0000000021170448',
                    'RB0000000021170449', 'RBR0101', 'RBR0102', 'RBR0103', 'RBR0104', 'RBR0105', 'RBR0106', 'RBR0107',
                    'RBR0108', 'RBR0109', 'RBR0110', 'RBR0111', 'RBR0112', 'RBR0113', 'RBR0114', 'RBR0115', 'RBR0116',
                    'RBR0117', 'RBR0118', 'RBR0119', 'RBR0120', 'RBR0121', 'RBR0122', 'RBR0123', 'RBR0124', 'RBR0125');

	


CREATE OR REPLACE VIEW ACTIVITECOMPLETFORMULE
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE,
             MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR,
             LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE,
             CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET,
             TYPESOURCE, DATEFACT, PAVILLON, VOLUME, VOLUMEARRONDI, CARGAISON, DATEDEBUT, HEUREDEBUT,
             DATEFIN, HEUREFIN, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND,
             POSTE, POSTELIB, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, surface, nb5jours, QUAI,
             flotte,categorie_flotte)
AS
select ID,
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
       cast(VOLUME as number(20, 2)) as VOLUME,
       cast(VOLUMEARRONDI as number(20,2)) as VOLUMEARRONDI,
       cast(CARGAISON as NUMBER(20,2)),
       DATEDEBUT,
       HEUREDEBUT,
       DATEFIN,
       HEUREFIN,
       IDPRESTATION,
       ESTNATIONAL,
       ESTJOUR,
       ESTFERIE,
       MANOEUVRE,
       ESTWEEKEND,
       POSTE,
       POSTELIB,
       NATUREOPERATION,
       cast(NBQUARTHEURE as NUMBER(20))as NBQUARTHEURE,
       cast(NBHEURE as NUMBER(20)) as NBHEURE,
       cast(NBJOUR as NUMBER(20)) as NBJOUR,
       TYPEQUAIS,
       cast(surface as NUMBER(20,2)) as surface,
       cast(nb5jours as NUMBER(2)) as nb5jours,
       QUAI,
       flotte,
       categorie_flotte
from (
         SELECT *
         FROM ACTIVITECOMPLETFORMULE_I
         UNION ALL
         SELECT *
         FROM ACTIVITECOMPLETFORMULE_II a);
		 
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MEDI825000', 'Configurations num&eacute;riques', 'fa fa-cog', '#', 10, 3, 'MENM01');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MEDI826000', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=configuration/configuration-saisie.jsp', 1, 4, 'MEDI825000');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MEDI827000', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=configuration/configuration-liste.jsp', 2, 4, 'MEDI825000');






