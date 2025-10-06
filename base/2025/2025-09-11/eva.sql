ALTER TABLE MOUVEMENT_PROF  DISABLE CONSTRAINT SYS_C0072575;



CREATE OR REPLACE  VIEW "PREVISIONLIBCOMPLET_ORDREPROF" ("ID", "DATE_RADE", "PROVENANCE", "NAVIRE", "CONSIGNATAIRE", "CARGAISON", "TONNAGE", "PILOTE", "DATE_ARRIVEE", "HEURE_ARRIVEE", "DATE_DEPART", "HEURE_DEPART", "DESTINATION", "ETAT", "QUAIPROVENANCE", "VALQUAISPROVENANCE", "PAYSPROVENANCE", "VALPAYSPROVENANCE", "QUAIDESTINATION", "VALQUAISDESTINATION", "PAYSDESTINATION", "VALPAYSDESTINATION", "INTERNEPOVENANCE", "LONGUEURPROVENANCE", "TIRANTPROVENANCE", "PROFONDEURPROVENANCE", "REFERENCENAVIRE", "NOMNAVIRE", "PAVILLONNAVIRE", "JNTNAVIRE", "JBTNAVIRE", "PLTNAVIRE", "LHTNAVIRE", "LMNAVIRE", "TENAVIRE", "VOLUMENAVIRE", "REMARQUENAVIRE", "ETATNAVIRE", "VALCONSIGNATAIRE", "DESCECONSIGNATAIRE", "VALCARGAISON", "DESCECARGAISON", "VALPILOTE", "DESCEPILOTE", "INTERNEDESTINATION", "LONGUEURDESTINATION", "TIRANTDESTINATION", "PROFONDEURDESTINATION", "DESCEPROVENANCE", "DESCEDESTINATION", "VALTYPEQUAISPROVENANCE", "DESCETYPEQUAISPROVENANCE", "VALTYPEQUAISDESTINATION", "DESCETYPEQUAISDESTINATION", "DESCEQUAISPROVENANCE", "DESCEQUAISDESTINATION", "TYPEQUAISPROVENANCE", "TYPEQUAISDESTINATION", "TYPENAVIRE", "TYPENAVIRELIB", "ESCALE", "NOVOYAGE", "ARMATEUR", "ARMATEURLIB", "MAJORATION", "REDUCTION", "PAVILLONLIB", "DESIGNATION", "CODE", "ESTFICTIVE") AS 
  SELECT pre.ID,
       pre.date_rade,
       pre.provenance,
       pre.navire,
       pre.consignataire,
       pre.cargaison,

       pre.TONNAGE,
       pre.pilote,
       pre.date_arrivee,
       pre.heure_arrivee,
       pre.date_depart,
       pre.heure_depart,
       pre.destination,
       pre.etat,
       pro.QUAI      AS QUAIPROVENANCE,
       q.VAL         AS valquaisprovenance,
       q.PAYS        AS paysprovenance,
       pa.VAL        AS valpaysprovenance,
       pr.QUAI       AS QUAIDESTINATION,
       q1.val        AS valquaisdestination,
       q1.PAYS       AS paysdestination,
       pa1.VAL       AS valpaysdestination,
       pro.INTERNE   AS INTERNEPOVENANCE,
       q.LONGUEUR    AS longueurprovenance,
       q.TIRANT      AS tirantprovenance,
       q.PROFONDEUR  AS profondeurprovenance,
       na.REFERENCE  AS referencenavire,
       na.NOM        AS nomnavire,
       na.PAVILLON   AS pavillonnavire,
       na.JNT        AS jntnavire,
       na.JBT        AS jbtnavire,
       na.PLT        AS pltnavire,
       na.LHT        AS lhtnavire,
       na.LM         AS lmnavire,
       na.TE         AS tenavire,
       na.VOLUME     AS volumenavire,
       na.REMARQUE   AS remarquenavire,
       na.ETAT       AS etatnavire,
       con.NOMCLT    AS valconsignataire,
       con.ADRCLT    AS desceconsignataire,
       car.VAL       AS valcargaison,
       car.DESCE     AS descecargaison,
       pi.VAL        AS valpilote,
       pi.DESCE      AS descepilote,
       pr.INTERNE    AS INTERNEDESTINATION,
       q1.LONGUEUR   AS longueurdestination,
       q1.TIRANT     AS tirantdestination,
       q1.PROFONDEUR AS profondeurdestination,
       pa.DESCE      AS desceprovenance,
       pa1.DESCE     AS descedestination,
       t.VAL         AS valtypequaisprovenance,
       t.DESCE       AS descetypequaisprovenance,
       t2.val        AS valtypequaisdestination,
       t2.DESCE      AS descetypequaisdestination,
       q.DESCE       AS descequaisprovenance,
       q1.DESCE      AS descequaisdestination,
       q.TYPEQUAIS   AS typequaisprovenance,
       q1.TYPEQUAIS  AS typequaisdestination,
       na.TYPE       AS typenavire,
       tn.VAL        AS typenavirelib,
       pre.escale,
       pre.NOVOYAGE,
       pre.ARMATEUR,
       cons.val   AS ARMATEURLIB,
       0             AS majoration,
       0             AS reduction,
       pay.val       AS pavillonlib,
       fc.DESIGNATION,
       fc.CODE ,
       pre.ESTFICTIVE
FROM prevision_prof pre
         LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
         LEFT JOIN NAVIRE na ON na.id = pre.NAVIRE
         LEFT JOIN PAYS pay ON pay.id = na.pavillon
         LEFT JOIN client_union con ON con.CDCLT = pre.CONSIGNATAIRE
         LEFT JOIN CARGAISON car ON car.id = pre.CARGAISON
         LEFT JOIN commandant pi ON pi.ID = pre.PILOTE
         LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = pre.DESTINATION
         LEFT JOIN QUAIS q ON q.id = pro.QUAI
         LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
         LEFT JOIN PAYS pa ON pa.id = q.PAYS
         LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
         LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
         LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
         LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
         LEFT JOIN armateur_tbd cons ON cons.id = pre.ARMATEUR
         LEFT JOIN FACTURECLIENT fc ON fc.IDPREVISION = pre.id; 
		 
		 
		 



-- SPAT_TEST.ACTIVITELIBCOMPLETPROF source

CREATE OR REPLACE  VIEW "ACTIVITELIBCOMPLETPROF" ("ID", "DESIGNATION", "CLIENT", "RUBRIQUE", "QTE", "MOIS", "MOISLIB", "ANNEE", "DATY", "BATEAU", "ETAT", "RUBRIQUELIB", "NAVIRE", "BATEAULIB", "POIDS", "LONGUEUR", "LARGEUR", "AUTRES", "PU", "DEVISE", "COMPTE", "UNITE", "DIRECTION", "CONDITION", "TVA", "OBJET", "REDEVANCE", "CLIENTLIB", "REDEVANCELIB", "DIRECTIONLIB", "ETATLIB", "CATEGORIE", "CATEGORIELIB", "REFOBJET", "TYPESOURCE", "DATEFACT", "POSTE", "POSTELIB", "DATEDEBUT", "HEUREDEBUT", "DATEFIN", "HEUREFIN", "VOLUME", "VOLUMEARRONDI", "CARGAISON", "IDPRESTATION", "ESTNATIONAL", "ESTJOUR", "ESTFERIE", "MANOEUVRE", "ESTWEEKEND", "NATUREOPERATION", "NBQUARTHEURE", "NBHEURE", "NBJOUR", "TYPEQUAIS", "SURFACE", "NB5JOURS", "QUAI", "FLOTTE", "CATEGORIE_FLOTTE", "UNITELIB", "ESTPETROLIER", "VOLUMERUBRIQUE", "TAUX", "TIRANT", "VOLUMEVIR", "NBHEUREPREV", "DEPART", "ARRIVE", "PROVENANCEPAYS", "DESTINATIONPAYS", "PROVENANCEMADAGASCAR", "DESTINATIONMADAGASCAR", "ESTDERNIERSTAT") AS 
  SELECT
    ac.ID,
    ac.DESIGNATION,
    ac.CLIENT,
    ac.RUBRIQUE,
    ac.QTE,
    ac.MOIS,
    MOIS.VAL AS MOISLIB,
    ac.ANNEE,
    ac.DATY,
    ac.BATEAU,
    ac.ETAT,
    ra.DESIGNATION AS rubriquelib,
    nv.id AS navire,
    nv.NOM AS bateaulib,
    nv.PLT AS poids,
    nv.LHT AS longueur,
    nv.LM AS largeur,
    CAST('-' AS VARCHAR2(100)) AS autres,
    ra.pu,
    ra.devise,
    ra.compte,
    ra.unite,
    ra.direction,
    ra.condition,
    case
        when (
            nv.PAVILLON not in ('PAYS000054', 'PAYS000010', 'PAYS000057')
            OR (
                nv.PAVILLON in ('PAYS000054', 'PAYS000010', 'PAYS000057')
                AND (
                    occ.provenancePays not in ('PAYS000054', 'PAYS000010', 'PAYS000057')
                    OR occ.destinationPays not in ('PAYS000054', 'PAYS000010', 'PAYS000057')
                )
            )
        )
        and rubrique in (
            'RB0000000021170445',
            'RB0000000021170446',
            'RB0000000021170447'
        ) then 0
        else ra.tva
    end as tva,
    ra.objet,
    ra.redevance,
    fup.NOM AS clientlib,
    re.VAL AS redevancelib,
    di.LIBELLEDIR AS directionlib,
    CASE
        WHEN ac.etat = 1 THEN 'CREE(E)'
        WHEN AC.ETAT = 11 THEN 'VISE(E)'
        WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
    END AS ETATLIB,
    ra.CATEGORIE,
    cf.val AS categorieLib,
    ac.REFOBJET,
    ac.TYPESOURCE,
    pre.DATE_DEPART AS DATEFACT,
    ac.POSTE,
    pd.VALQUAIS AS postelib,
    ac.DATEDEBUT,
    ac.HEUREDEBUT,
    ac.DATEFIN,
    ac.HEUREFIN,
    CAST(
        TRUNC(nv.lm, 2) * TRUNC(nv.lht, 2) * TRUNC(nv.te, 2) AS NUMBER(10, 3)
    ) AS volume,
    cast(
        round(
            (
                TRUNC(nv.lm, 2) * TRUNC(nv.lht, 2) * TRUNC(nv.te, 2)
            ) / 100,
            1
        ) AS number(10, 0)
    ) AS volumeArrondi,
    NVL(pre.cargaison, '-') AS cargaison,
    pre.id AS idprestation,
    CASE
        WHEN nv.pavillon = 'PAYS000054'
        OR nv.pavillon = 'PAYS000010'
        OR nv.pavillon = 'PAYS000057' THEN 'National'
        WHEN nv.pavillon != 'PAYS000054'
        OR nv.pavillon != 'PAYS000010'
        OR nv.pavillon != 'PAYS000057' THEN 'International'
    END AS estNational,
    CASE
        WHEN ac.heuredebut BETWEEN '05:00:00'
        AND '18:59:59' THEN 'JOUR'
        ELSE 'NUIT'
    END AS estJour,
    CASE
        WHEN ac.daty IN (
            SELECT
                daty
            FROM
                jour_ferie
        ) THEN 'FERIE'
        ELSE 'NONFERIE'
    END AS estFerie,
    occ.idmanoeuvrebord AS manoeuvre,
    CASE
        WHEN TO_CHAR(ac.daty, 'DAY') LIKE '%DIMANCHE%'
        OR TO_CHAR(ac.daty, 'DAY') LIKE '%SAMEDI%' THEN 'weekend'
        ELSE 'normal'
    END AS estWeekend,
    occ.IDNATUREOPERATION AS natureoperation,
    CASE
        WHEN (
            (
                60 * 24 * (
                    TO_DATE(
                        ac.DATEFIN || ' ' || ac.HEUREFIN,
                        'dd-mm-yy hh24:mi:ss'
                    ) - TO_DATE(
                        ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                        'dd-mm-yy hh24:mi:ss'
                    )
                )
            ) - 60
        ) < 0 THEN 0
        WHEN (
            (
                60 * 24 * (
                    TO_DATE(
                        ac.DATEFIN || ' ' || ac.HEUREFIN,
                        'dd-mm-yy hh24:mi:ss'
                    ) - TO_DATE(
                        ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                        'dd-mm-yy hh24:mi:ss'
                    )
                )
            ) - 60
        ) <= 1 THEN 0
        ELSE CEIL(
            (
                (
                    60 * 24 * (
                        TO_DATE(
                            ac.DATEFIN || ' ' || ac.HEUREFIN,
                            'dd-mm-yy hh24:mi:ss'
                        ) - TO_DATE(
                            ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                            'dd-mm-yy hh24:mi:ss'
                        )
                    )
                ) - 60
            ) / 15
        )
    END AS nbQuartHeure,
    CASE
        WHEN 24 * (
            TO_DATE(
                ac.DATEFIN || ' ' || ac.HEUREFIN,
                'dd-mm-yy hh24:mi:ss'
            ) - TO_DATE(
                ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                'dd-mm-yy hh24:mi:ss'
            )
        ) < 0 THEN 0
        ELSE (
            CEIL(
                24 * (
                    TO_DATE(
                        ac.DATEFIN || ' ' || ac.HEUREFIN,
                        'dd-mm-yy hh24:mi:ss'
                    ) - TO_DATE(
                        ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                        'dd-mm-yy hh24:mi:ss'
                    )
                )
            )
        )
    END AS nbHeure,
    CASE
        WHEN (
            TO_DATE(
                ac.DATEFIN || ' ' || ac.HEUREFIN,
                'dd-mm-yy hh24:mi:ss'
            ) - TO_DATE(
                ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                'dd-mm-yy hh24:mi:ss'
            )
        ) < 0 THEN 0
        WHEN ROUND(
            (
                TO_DATE(
                    ac.DATEFIN || ' ' || ac.HEUREFIN,
                    'dd-mm-yy hh24:mi:ss'
                ) - TO_DATE(
                    ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                    'dd-mm-yy hh24:mi:ss'
                )
            )
        ) = 0
        or ROUND(
            (
                TO_DATE(
                    ac.DATEFIN || ' ' || ac.HEUREFIN,
                    'dd-mm-yy hh24:mi:ss'
                ) - TO_DATE(
                    ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                    'dd-mm-yy hh24:mi:ss'
                )
            )
        ) = 1 THEN 1
        ELSE (
            (
                TO_DATE(ac.DATEFIN, 'dd-mm-yy') - TO_DATE(ac.DATEDEBUT, 'dd-mm-yy')
            )
        ) + 1
    END AS nbJour,
    CASE
        WHEN TYPESOURCE IS NULL THEN q.typequais
        ELSE ty.TYPEQUAIS
    END AS typequais,
    --type not postedestinaire
    CAST(nv.LHT * nv.lm AS NUMBER(20, 2)) AS surface,
    CASE
        WHEN (
            TO_DATE(
                ac.DATEFIN || ' ' || ac.HEUREFIN,
                'dd-mm-yy hh24:mi:ss'
            ) - TO_DATE(
                ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                'dd-mm-yy hh24:mi:ss'
            )
        ) < 0 THEN 0
        ELSE CASE
            WHEN ROUND(
                (
                    TO_DATE(
                        ac.DATEFIN || ' ' || ac.HEUREFIN,
                        'dd-mm-yy hh24:mi:ss'
                    ) - TO_DATE(
                        ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                        'dd-mm-yy hh24:mi:ss'
                    )
                )
            ) BETWEEN 0
            AND 5 THEN 1
            ELSE (
                TRUNC(
                    (
                        TO_DATE(
                            ac.DATEFIN || ' ' || ac.HEUREFIN,
                            'dd-mm-yy hh24:mi:ss'
                        ) - TO_DATE(
                            ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                            'dd-mm-yy hh24:mi:ss'
                        )
                    ) / 5
                ) + 1
            )
        END
    END AS nb5jours,
    pd2.QUAI,
    occ.IDMATERIEL_NAVAL AS flotte,
    cm.IDCATEGORIE AS categorie_flotte,
    ua.VAL AS unitelib,
    CASE
        WHEN nv.TYPE = 'TP0001' THEN 'TRUE'
        ELSE 'FALSE'
    END AS estPetrolier,
    RA.VOLUME AS volumeRubrique,
    ac.TAUX,
    nv.te AS tirant,
    cast(
        (
            TRUNC(nv.lm, 2) * TRUNC(nv.lht, 2) * TRUNC(nv.te, 2)
        ) / 100 as number(10, 2)
    ) AS volumeVir,
    CASE
        WHEN pre.DATE_DEPART IS NULL
        OR pre.DATE_ARRIVEE IS NULL
        OR HEURE_DEPART IS NULL
        OR HEURE_ARRIVEE IS NULL
        OR (
            24 * (
                TO_DATE(
                    pre.DATE_DEPART || ' ' || pre.HEURE_DEPART,
                    'dd-mm-yy hh24:mi:ss'
                ) - TO_DATE(
                    pre.DATE_ARRIVEE || ' ' || pre.HEURE_ARRIVEE,
                    'dd-mm-yy hh24:mi:ss'
                )
            ) < 0
        ) THEN 0
        ELSE (
            CEIL(
                TRUNC(
                    24 * (
                        TO_DATE(
                            pre.DATE_DEPART || ' ' || pre.HEURE_DEPART,
                            'dd-mm-yy hh24:mi:ss'
                        ) - TO_DATE(
                            pre.DATE_ARRIVEE || ' ' || pre.HEURE_ARRIVEE,
                            'dd-mm-yy hh24:mi:ss'
                        )
                    ),
                    3
                )
            )
        )
    END AS nbHeurePrev,
    CASE
        WHEN pre.DATE_DEPART IS NULL
        OR pre.DATE_ARRIVEE IS NULL
        OR HEURE_DEPART IS NULL
        OR HEURE_ARRIVEE IS NULL THEN NULL
        ELSE TO_DATE(
            pre.DATE_DEPART || ' ' || pre.HEURE_DEPART,
            'dd-mm-yy hh24:mi:ss'
        )
    END AS depart,
    CASE
        WHEN pre.DATE_DEPART IS NULL
        OR pre.DATE_ARRIVEE IS NULL
        OR HEURE_DEPART IS NULL
        OR HEURE_ARRIVEE IS NULL THEN NULL
        ELSE TO_DATE(
            pre.DATE_ARRIVEE || ' ' || pre.HEURE_ARRIVEE,
            'dd-mm-yy hh24:mi:ss'
        )
    END AS arrive,
    occ.provenancePays,
    occ.destinationPays,
    CASE
        WHEN occ.provenancePays = 'PAYS000054'
        OR occ.provenancePays = 'PAYS000010'
        OR occ.provenancePays = 'PAYS000057' THEN 1
        ELSE 0
    END AS provenanceMadagascar,
    CASE
        WHEN occ.destinationPays = 'PAYS000054'
        OR occ.destinationPays = 'PAYS000010'
        OR occ.destinationPays = 'PAYS000057' THEN 1
        ELSE 0
    END AS destinationMadagascar,
    case
        when ds.idactivite is not null then cast('TRUE' as VARCHAR2(100))
        else cast('FALSE' as VARCHAR2(100))
    end as estDernierStat
FROM
    ACTIVITE_prof ac
    LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
    LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
    LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
    LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
    LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
    LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
    LEFT JOIN PREVISION_prof pre ON pre.id = ac.BATEAU
    LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
    LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
    LEFT JOIN UNITE_ACTIVITE ua ON ua.ID = ra.UNITE
    LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
    LEFT JOIN quais q ON q.id = pd2.quai
    LEFT JOIN OCCUPATIONMATLNAVAL_LIBCPLpr occ ON occ.id = ac.REFOBJET
    LEFT JOIN MATERIEL_NAVAL cm ON cm.id = occ.IDMATERIEL_NAVAL
    LEFT JOIN POSTEDESTINATAIRELIBCOMPLET ty ON ty.id = ac.TYPESOURCE
    LEFT JOIN dernier_stationnement ds on ac.id = ds.idactivite;
  --  LEFT JOIN dernier_stationnement_prof ds on ac.id = ds.idactivite;		 
  
  
  
CREATE OR REPLACE  VIEW "ACTIVITELIBCOMPLETPROF_V" ("ID", "DESIGNATION", "CLIENT", "RUBRIQUE", "QTE", "MOIS", "MOISLIB", "ANNEE", "DATY", "BATEAU", "ETAT", "RUBRIQUELIB", "NAVIRE", "BATEAULIB", "POIDS", "LONGUEUR", "LARGEUR", "AUTRES", "PU", "DEVISE", "COMPTE", "UNITE", "DIRECTION", "CONDITION", "TVA", "OBJET", "REDEVANCE", "CLIENTLIB", "REDEVANCELIB", "DIRECTIONLIB", "ETATLIB", "CATEGORIE", "CATEGORIELIB", "REFOBJET", "TYPESOURCE", "DATEFACT", "POSTE", "POSTELIB", "DATEDEBUT", "HEUREDEBUT", "DATEFIN", "HEUREFIN", "VOLUME", "VOLUMEARRONDI", "CARGAISON", "IDPRESTATION", "ESTNATIONAL", "ESTJOUR", "ESTFERIE", "MANOEUVRE", "ESTWEEKEND", "NATUREOPERATION", "NBQUARTHEURE", "NBHEURE", "NBJOUR", "TYPEQUAIS", "SURFACE", "NB5JOURS", "QUAI", "FLOTTE", "CATEGORIE_FLOTTE", "UNITELIB", "ESTPETROLIER", "VOLUMERUBRIQUE", "TAUX") AS 
  SELECT "ID","DESIGNATION","CLIENT","RUBRIQUE","QTE","MOIS","MOISLIB","ANNEE","DATY","BATEAU","ETAT","RUBRIQUELIB","NAVIRE","BATEAULIB","POIDS","LONGUEUR","LARGEUR","AUTRES","PU","DEVISE","COMPTE","UNITE","DIRECTION","CONDITION","TVA","OBJET","REDEVANCE","CLIENTLIB","REDEVANCELIB","DIRECTIONLIB","ETATLIB","CATEGORIE","CATEGORIELIB","REFOBJET","TYPESOURCE","DATEFACT","POSTE","POSTELIB","DATEDEBUT","HEUREDEBUT","DATEFIN","HEUREFIN","VOLUME","VOLUMEARRONDI","CARGAISON","IDPRESTATION","ESTNATIONAL","ESTJOUR","ESTFERIE","MANOEUVRE","ESTWEEKEND","NATUREOPERATION","NBQUARTHEURE","NBHEURE","NBJOUR","TYPEQUAIS","SURFACE","NB5JOURS","QUAI","FLOTTE","CATEGORIE_FLOTTE","UNITELIB","ESTPETROLIER","VOLUMERUBRIQUE","TAUX"
FROM ACTIVITELIBCOMPLETPROF
WHERE ETAT >= 11;  