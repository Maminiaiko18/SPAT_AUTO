CREATE OR REPLACE VIEW CAFCFILLECOMPLET_AVOIRNP3 (
    ID,
    IDMERE,
    DESIGNATION,
    QUANTITE,
    PU,
    COMPTE,
    IDPRODUIT,
    DEVISE,
    TAUX,
    IDACTIVITE,
    TVA,
    DATEFACT,
    RUBRIQUE,
    MOIS,
    ANNEE,
    HEUREDEBUT,
    HEUREFIN,
    REDUCTION,
    MAJORATION,
    TEST,
    RANG,
    DUREE,
    MONTANTAV,
    RUBRIQUECPL,
    DATY,
    TIERS,
    IDCATEGORIE,
    TYPE,
    DEVISEMERE,
    EXERCICE,
    IDAVOIR,
    ETAT,
    MTAVOIR,
    MONTANTREDUCTION,
    MONTANTMAJORATION,
    MONTANT,
    MONTANTTVA,
    MONTANTTTC,
    MOISLIB,
    MONTANTHTSIMPLE,
    CLIENT,
    MERECA,
    CODE,
    ETATLIB,
    NUMPIECE
) AS
    SELECT
        FF.ID,
        IDMERE,
        DESIGNATION,
        QUANTITE,
        PU,
        COMPTE,
        IDPRODUIT,
        DEVISE,
        TAUX,
        IDACTIVITE,
        TVA,
        DATEFACT,
        RUBRIQUE,
        CAST(MOIS AS NUMBER(10)),
        CAST(ANNEE AS NUMBER(10)),
        HEUREDEBUT,
        HEUREFIN,
        REDUCTION,
        MAJORATION,
        TEST,
        FF.RANG,
        DUREE,
        CAST(MONTANTAV AS NUMBER(30, 2)),
        RUBRIQUECPL,
        DATY,
        TIERS,
        IDCATEGORIE,
        FF.TYPE,
        DEVISEMERE,
        EXERCICE,
        IDAVOIR,
        FF.ETAT,
        CAST(MTAVOIR AS NUMBER(30, 2)),
        CAST(MONTANTREDUCTION AS NUMBER(30, 2)),
        CAST(MONTANTMAJORATION AS NUMBER(30, 2)),
        CAST(MONTANT AS NUMBER(30, 2)),
        CAST(FF.MONTANTTVA AS NUMBER(30, 2)),
        CAST(FF.MONTANTTTC AS NUMBER(30, 2)),
        MOISLIB,
        CAST(FF.MONTANTHTSIMPLE AS NUMBER(30, 2)),
        FF.CLIENT,
        CPTM.ID,
        FF.CODE,
        CASE
            WHEN FF.ETAT = 1 THEN
                'CREE'
            WHEN FF.ETAT >= 11 THEN
                'VISE'
            WHEN FF.ETAT = 0 THEN
                'ANNULE'
            ELSE
                ''
        END AS ETATLIB,
        FF.NUMPIECE
    FROM
        FCFILLECOMPLETNP FF
        LEFT JOIN COMPTECA CPTCA
        ON CPTCA.VAL=FF.COMPTE
        LEFT JOIN MERECA CPTM
        ON CPTM.ID=CPTCA.DESCE
    WHERE
        FF.IDCATEGORIE <> 'CATFCO2'
        AND FF.IDCATEGORIE <> 'CATFCO1';

CREATE VIEW CAFCFILLECOMPLET_AVOIRANNULE AS
    SELECT
        *
    FROM
        CAFCFILLECOMPLET_AVOIRNP3 C
    WHERE
        ETAT=0;

INSERT INTO MENUDYNAMIQUE (
    ID,
    LIBELLE,
    ICONE,
    HREF,
    RANG,
    NIVEAU,
    ID_PERE
) VALUES(
    'MEN00D999',
    'Analyse détails',
    'fa fa-line-chart',
    '/spat/pages/globalnegoce.jsp?but=facture/facture-fournisseur-details-analyse.jsp',
    10,
    3,
    'MEN00211'
);

CREATE OR REPLACE VIEW FACTFOURN_FILL_LIB_REST_TAXE (
    ID,
    IDMERE,
    DESIGNATION,
    QUANTITE,
    PU,
    COMPTE,
    IDPRODUIT,
    DEVISE,
    TAUX,
    QTELIVREE,
    RESTEALIVRER,
    MONTANTTAUX,
    MONTANT,
    MONTANTAVOIRSANSTAUX,
    MONTANTAVOIRAVECTAUX,
    TVA,
    IDACTIVITE,
    ACTIVITELIB,
    MOIS,
    ANNEE,
    HEUREDEBUT,
    HEUREFIN,
    MOISLIB,
    TAUXEURO,
    MONTANTHTEURO,
    MONTANTTVAEURO,
    MONTANTTAXE,
    MAJORATION,
    REDUCTION,
    DATEFACT,
    RUBRIQUE,
    RANG,
    DATY,
    MONTANTTTC,
    COMPTESTR,
    CATEGORIE,
    MONTANTTVA,
    MONTANTREDUCTION
) AS
    SELECT
        FC.ID,
        FC.IDMERE,
        FC.DESIGNATION,
        FC.QUANTITE,
        FC.PU,
        FC.COMPTE,
        PR.NOM                                                          AS IDPRODUIT,
        FC.DEVISE,
        FC.TAUX,
        CAST(NVL(GR.QUANTITE, 0) AS NUMBER(10, 2))                      AS QTELIVREE,
        CAST(FC.QUANTITE - NVL(GR.QUANTITE, 0) AS NUMBER(10, 2))        AS RESTEALIVRER,
        CAST(FCM.MONTANTTAUX AS NUMBER(32, 2))                          AS MONTANTTAUX,
        CAST(FCM.MONTANT AS NUMBER(32, 2))                              AS MONTANT,
        CAST(FCM.MONTANTAVOIRSANSTAUX AS NUMBER(32, 2))                 AS MONTANTAVOIRSANSTAUX,
        CAST(FCM.MONTANTAVOIRAVECTAUX AS NUMBER(32, 2))                 AS MONTANTAVOIRAVECTAUX,
        CAST(FCM.TVA AS NUMBER(30, 2))                                  AS TVA,
        FC.IDACTIVITE,
        RA.DESIGNATION                                                  AS ACTIVITELIB,
        FC.MOIS,
        FC.ANNEE,
        FC.HEUREDEBUT,
        FC.HEUREFIN,
        MOIS.VAL                                                        AS MOISLIB,
        CAST(0 AS NUMBER(32, 2))                                        AS TAUXEURO,
        CAST(0 AS NUMBER(32, 2))                                        AS MONTANTHTEURO,
        CAST(0 AS NUMBER(32, 2))                                        AS MONTANTTVAEURO,
        CAST((FC.PU * FC.QUANTITE * FC.TVA) / 100 AS NUMBER(30, 2))     AS MONTANTTAXE,
        CAST(NVL(FC.MAJORATION, 0) AS NUMBER(30, 2))                    AS MAJORATION,
        CAST (NVL(FC.REDUCTION, 0) AS NUMBER(30, 2))                    AS REDUCTION,
        FC.DATEFACT,
        FC.RUBRIQUE,
        CASE
            WHEN FC.IDACTIVITE IS NOT NULL THEN
                R.RANG
        END AS             RANG,
        CASE
            WHEN FC.IDACTIVITE IS NOT NULL THEN
                RA.DATY
        END AS            DATY,
        CAST(MONTANTTAUX + MONTANTTAUXTVA AS NUMBER(30, 2))             AS MONTANTTTC,
        CASE
            WHEN FC.COMPTE IS NULL THEN
                NULL
            ELSE
                CET.VAL
                    || ''
                    || PRO.DESIGNATION
                    || ''
                    || FC.COMPTE
        END AS COMPTESTR,
        IDCATEGORIE                                                     AS CATEGORIE,
        CAST (FCM.MONTANTTAUXTVA AS NUMBER(30, 2))                      AS MONTANTTVA,
        CAST (FCM.MONTANTREDUCTION AS NUMBER (30, 2))                   AS MONTANTREDUCTION
    FROM
        FACTURE_FOURNISSEUR_FILLE FC
        LEFT JOIN AS_PRODUITS PR
        ON PR.ID = FC.IDPRODUIT
        LEFT JOIN AS_BONDELIVRAISON_CL_GRP GR
        ON GR.IDDETAILSFACTUREFOURNISSEUR = FC.ID
        LEFT JOIN FACTFOURN_MONTANT FCM
        ON FCM.ID = FC.ID
        LEFT JOIN ACTIVITE RA
        ON RA.ID = FC.IDACTIVITE
        LEFT JOIN MOIS
        ON MOIS.ID = FC.MOIS
        LEFT JOIN RUBRIQUE_ACTIVITE R
        ON R.ID = RA.RUBRIQUE
        LEFT JOIN CODEETABLISSEMENT CET
        ON CET.ID=FCM.CODE_ETABLISSEMENT
        LEFT JOIN PROJET PRO
        ON PRO.ID=FCM.PROJET;