CREATE OR REPLACE FORCE VIEW AVOIRFCAVECTAUX (
    ID,
    IDMERE,
    IDDETAILFACTURE,
    MONTANT,
    COMPTE,
    TAUX,
    DEVISE,
    MONTANTAVECTSAUX,
    ETAT,
    TVA,
    MONTANTTVA,
    MONTANTTTC
) AS
    SELECT
        AC.ID,
        AC.IDMERE,
        AC.IDDETAILFACTURE,
        AC.MONTANT,
        AC.COMPTE,
        CAST(NVL(FC.TAUX, 1) AS NUMBER(30, 2))                                   AS TAUX,
        NVL(FC.DEVISE, 'Ar')                                                     AS DEVISE,
        CAST(AC.MONTANT * NVL(FC.TAUX, 1) AS NUMBER(30, 2))                      AS MONTANTAVECTSAUX,
        A.ETAT,
        AC.TVA,
        CAST((AC.MONTANT*NVL(FC.TAUX, 1)* NVL(AC.TVA, 0) )/100 AS NUMBER(30, 2)) AS MONTANTTVA,
        CAST(AC.MONTANT*NVL(TAUX, 1)*(1+ NVL(AC.TVA, 0) /100)AS NUMBER(30, 2))   AS MONTANTTTC
    FROM
        AVOIRFCFILLE         AC
        LEFT JOIN FACTURE_CLIENT_FILLE FC
        ON FC.ID = AC.IDDETAILFACTURE
        LEFT JOIN AVOIRFC A
        ON AC.IDMERE = A.ID;

CREATE OR REPLACE FORCE VIEW AVOIRFCAVECTAUX_GRP_MERE (
    IDMERE,
    MONTANT,
    MONTANTTVA,
    MONTANTTTC
) AS
    SELECT
        AT.IDMERE,
        CAST(SUM(AT.MONTANTAVECTSAUX) AS NUMBER(30, 2)) AS MONTANT,
        CAST(SUM(MONTANTTVA) AS NUMBER(30, 2))          AS MONTANTTVA,
        CAST(SUM(MONTANTTTC) AS NUMBER(30, 2))          AS MONTANTTTC
    FROM
        AVOIRFCAVECTAUX AT
    GROUP BY
        AT.IDMERE;

CREATE OR REPLACE FORCE VIEW AVOIRFCFILLEVALIDEGROUPE (
    ID,
    IDMERE,
    IDDETAILFACTURE,
    MONTANT,
    COMPTE,
    REMISE,
    MONTANTAVOIRAVECTSAUX,
    MONTANTAVTTCAVECTAUX
) AS
    SELECT
        MAX(AF.ID)                                                             AS ID,
        AF.IDMERE,
        AF.IDDETAILFACTURE,
        SUM(MONTANT)                                                           AS MONTANT,
        MAX(AF.COMPTE)                                                         AS COMPTE,
        AVG(REMISE)                                                            AS REMISE,
        CAST(SUM(MONTANT * NVL(FC.TAUX, 1)) AS NUMBER(30, 2))                  AS MONTANTAVOIRAVECTSAUX,
        CAST(SUM(MONTANT*NVL(FC.TAUX, 1)*(1+(FC.TVA/100)) ) AS NUMBER (30, 2)) AS MONTANTAVTTCAVECTAUX
    FROM
        AVOIRFCFILLE         AF
        JOIN AVOIRFC A
        ON A.ID = AF.IDMERE LEFT JOIN FACTURE_CLIENT_FILLE FC
        ON FC.ID = AF.IDDETAILFACTURE
    WHERE
        A.ETAT >= 11
    GROUP BY
        AF.IDMERE, AF.IDDETAILFACTURE;

CREATE OR REPLACE FORCE VIEW AVOIRFCFILLE_FM (
    ID,
    IDMERE,
    IDDETAILFACTURE,
    MONTANT,
    COMPTE,
    REMISE,
    DATY,
    IDFACTURE,
    ETAT,
    DESIGNATION,
    CODE,
    CATEGORIE,
    MOTIF,
    TYPE
) AS
    SELECT
        FIL.ID,
        FIL.IDMERE,
        FIL.IDDETAILFACTURE,
        FIL.MONTANT,
        FIL.COMPTE,
        FIL.REMISE,
        DATY,
        IDFACTURE,
        ETAT,
        DESIGNATION,
        CODE,
        CATEGORIE,
        MOTIF,
        TYPE
    FROM
        AVOIRFCFILLE FIL
        LEFT JOIN AVOIRFC AV
        ON AV.ID = FIL.IDMERE;

CREATE OR REPLACE FORCE VIEW AVOIRFCFILLE_PDF (
    ID,
    IDMERE,
    IDDETAILFACTURE,
    MONTANT,
    COMPTE,
    REMISE,
    DESIGNATION,
    TAUX,
    DEVISE,
    TVA,
    QTE,
    PU,
    DUREE,
    MONTANTHTDEVISE,
    MAJ,
    REDUCTION,
    RANG,
    DATEFACTUREFILLE,
    RED,
    MAJORATION
) AS
    SELECT
        AV.ID,
        AV.IDMERE,
        AV.IDDETAILFACTURE,
        AV.MONTANT,
        AV.COMPTE,
        AV.REMISE,
        CA.DESIGNATION                                  AS DESIGNATION,
        CA.TAUX,
        CA.DEVISE,
        AV.TVA,
        CAST(NVL(AV.QTE, CA.QUANTITE) AS NUMBER(30, 2)) QTE,
        CAST(NVL(AV.PU, CA.PU) AS NUMBER(30, 2))        PU,
        CAST(NVL(AV.DUREE, CA.DUREE) AS NUMBER(30, 2))  DUREE,
        CAST(
            CASE
                WHEN DEVISE = 'Ar' THEN
                    AV.MONTANT / CA.TAUX
                ELSE
                    AV.MONTANT
            END AS NUMBER(30, 2))                       AS MONTANTHTDEVISE,
        CA.MAJORATION                                   AS MAJ,
        CA.REDUCTION                                    AS REDUCTION,
        CA.RANG,
        CA.DATEFACTUREFILLE,
        AV.REDUCTION                                    AS RED,
        AV.MAJORATION
    FROM
        AVOIRFCFILLE   AV
        LEFT JOIN FCFILLECOMPLET CA
        ON CA.ID = AV.IDDETAILFACTURE;

CREATE OR REPLACE FORCE VIEW AVOIRFC_MONTANT (
    ID,
    DATY,
    IDFACTURE,
    ETAT,
    TIERS,
    TIERSLIB,
    CATEGORIE,
    CATEGORIELIB,
    MOTIF,
    MOTIFLIB,
    CODE,
    TYPE,
    TYPELIB,
    DESIGNATION,
    MONTANT,
    MONTANTTVA,
    MONTANTTTC,
    MONTANTPAYE,
    MONTANTRESTE,
    CODEFACTURE,
    DATEFACTURE,
    CDCLT
) AS
    SELECT
        FC.ID,
        FC.DATY,
        FC.IDFACTURE,
        FC.ETAT,
        F.TIERS,
        F.TIERSLIB,
        FC.CATEGORIE,
        C.VAL                                                                        AS CATEGORIELIB,
        FC.MOTIF,
        MO.VAL                                                                       AS MOTIFLIB,
        FC.CODE,
        FC.TYPE,
        CASE
            WHEN FC.TYPE = '1' THEN
                'interne'
            WHEN FC.TYPE = '2' THEN
                'externe'
        END AS TYPELIB,
        FC.DESIGNATION,
        CAST (NVL (MR.MONTANT, 0.0) AS NUMBER (30, 2))                               AS MONTANT,
        CAST (MR.MONTANTTVA AS NUMBER (30, 2))                                       AS MONTANTTVA,
        CAST (MR.MONTANTTTC AS NUMBER (30, 2))                                       AS MONTANTTC,
        CAST (NVL (OP.DEBIT, 0) AS NUMBER (30, 2))                                   AS MONTANTPAYE,
        CAST (NVL (MR.MONTANTTTC, 0.0) - NVL (OP.DEBIT, 0) AS NUMBER (30, 2))        AS MONTANTRESTE,
        F.CODE                                                                       AS CODEFACTURE,
        F.DATY                                                                       AS DATEFACTURE,
        F.CDCLT
    FROM
        AVOIRFC                  FC
        LEFT JOIN CATEGORIEAVOIRFC C
        ON FC.CATEGORIE = C.ID
        LEFT JOIN MOTIFAVOIRFC MO
        ON FC.MOTIF = MO.ID
        LEFT JOIN AVOIRFCAVECTAUX_GRP_MERE MR
        ON MR.IDMERE = FC.ID
        LEFT JOIN FACTURECLIENT_LIBCOMPLET F
        ON FC.IDFACTURE = F.ID
        LEFT JOIN ORDONNERPAYEMENT_JC_VISE OP
        ON OP.DED_ID = FC.ID;

CREATE OR REPLACE FORCE VIEW AVOIRFC_MONTANTLIBETAT (
    ID,
    CODE,
    DATY,
    IDFACTURE,
    ETAT,
    MONTANT,
    TIERS,
    TIERSLIB,
    MONTANTPAYE,
    MONTANTRESTE,
    ETATLIB
) AS
    SELECT
        OP.ID,
        OP.CODE,
        OP.DATY,
        OP.IDFACTURE,
        OP.ETAT,
        CAST(OP.MONTANT AS NUMBER(30, 2))                                                                  AS MONTANT,
        OP.TIERS,
        OP.TIERSLIB,
        CAST(OP.MONTANTPAYE AS NUMBER(30, 2))                                                              AS MONTANTPAYE,
        CAST(OP.MONTANTRESTE AS NUMBER(30, 2))                                                             AS MONTANTRESTE,
        CASE
            WHEN OP.ETAT = 0 THEN
                'annule'
            WHEN OP.ETAT = 1 THEN
                'cree'
            WHEN OP.ETAT = 11 THEN
                'vise'
        END AS ETATLIB
    FROM
        AVOIRFC_MONTANT OP;

CREATE OR REPLACE FORCE VIEW AVOIRFC_MONTANTREGROUPLIBETAT (
    ID,
    CODE,
    DATY,
    IDFACTURE,
    ETAT,
    MONTANT,
    TIERS,
    TIERSLIB,
    MONTANTPAYE,
    MONTANTRESTE,
    ETATLIB
) AS
    SELECT
        OP.ID,
        OP.CODE,
        OP.DATY,
        OP.IDFACTURE,
        OP.ETAT,
        CAST(OP.MONTANT AS NUMBER(30, 2))                                                                  AS MONTANT,
        OP.TIERS,
        OP.TIERSLIB,
        CAST(OP.MONTANTPAYE AS NUMBER(30, 2))                                                              AS MONTANTPAYE,
        CAST(OP.MONTANTRESTE AS NUMBER(30, 2))                                                             AS MONTANTRESTE,
        CASE
            WHEN OP.ETAT = 0 THEN
                'annule'
            WHEN OP.ETAT = 1 THEN
                'cree'
            WHEN OP.ETAT = 11 THEN
                'vise'
        END AS ETATLIB
    FROM
        AVOIRFC_MONTANT_REGROUP OP;

CREATE OR REPLACE FORCE VIEW AVOIRFC_MONTANT_REGROUP (
    ID,
    DATY,
    IDFACTURE,
    ETAT,
    TIERS,
    TIERSLIB,
    CATEGORIE,
    CATEGORIELIB,
    MOTIF,
    MOTIFLIB,
    CODE,
    TYPE,
    TYPELIB,
    DESIGNATION,
    MONTANT,
    MONTANTTVA,
    MONTANTTTC,
    MONTANTPAYE,
    MONTANTRESTE,
    CODEFACTURE,
    DATEFACTURE,
    CDCLT
) AS
    SELECT
        ID,
        DATY,
        IDFACTURE,
        ETAT,
        TIERS,
        TIERSLIB,
        CATEGORIE,
        CATEGORIELIB,
        MOTIF,
        MOTIFLIB,
        CODE,
        TYPE,
        TYPELIB,
        DESIGNATION,
        CAST(MONTANT AS NUMBER (30, 2))                       AS MONTANT,
        CAST(MONTANTTVA AS NUMBER (30, 2))                    AS MONTANTTVA,
        CAST(MONTANTTTC AS NUMBER (30, 2))                    AS MONTANTTTC,
        CAST(SUM(MONTANTPAYE) AS NUMBER (30, 2))              AS MONTANTPAYE,
        CAST((MONTANTTTC-SUM(MONTANTPAYE)) AS NUMBER (30, 2)) AS MONTANTRESTE,
        CODEFACTURE,
        DATEFACTURE,
        CDCLT
    FROM
        AVOIRFC_MONTANT
    GROUP BY
        ID,
        DATY,
        IDFACTURE,
        ETAT,
        TIERS,
        TIERSLIB,
        CATEGORIE,
        CATEGORIELIB,
        MOTIF,
        MOTIFLIB,
        CODE,
        TYPE,
        TYPELIB,
        DESIGNATION,
        MONTANT,
        MONTANTTVA,
        MONTANTTTC,
        CODEFACTURE,
        DATEFACTURE,
        CDCLT;

CREATE OR REPLACE FORCE VIEW AVOIRFC_MONTANT_REGROUP_V (
    ID,
    DATY,
    IDFACTURE,
    ETAT,
    TIERS,
    TIERSLIB,
    CATEGORIE,
    CATEGORIELIB,
    MOTIF,
    MOTIFLIB,
    CODE,
    TYPE,
    TYPELIB,
    DESIGNATION,
    MONTANT,
    MONTANTTVA,
    MONTANTTTC,
    MONTANTPAYE,
    MONTANTRESTE,
    CODEFACTURE,
    DATEFACTURE,
    CDCLT,
    MONTANTRESTEFC
) AS
    SELECT
        AV.ID,
        AV.DATY,
        AV.IDFACTURE,
        AV.ETAT,
        AV.TIERS,
        AV.TIERSLIB,
        AV.CATEGORIE,
        AV.CATEGORIELIB,
        AV.MOTIF,
        AV.MOTIFLIB,
        AV.CODE,
        AV.TYPE,
        AV.TYPELIB,
        AV.DESIGNATION,
        CAST(AV.MONTANT AS NUMBER (30, 2))                          AS MONTANT,
        CAST(AV.MONTANTTVA AS NUMBER (30, 2))                       AS MONTANTTVA,
        CAST(AV.MONTANTTTC AS NUMBER (30, 2))                       AS MONTANTTTC,
        CAST(SUM(AV.MONTANTPAYE) AS NUMBER (30, 2))                 AS MONTANTPAYE,
        CAST((AV.MONTANTTTC-SUM(AV.MONTANTPAYE)) AS NUMBER (30, 2)) AS MONTANTRESTE,
        AV.CODEFACTURE,
        AV.DATEFACTURE,
        AV.CDCLT,
        FCU.MONTANTRESTE                                            AS MONTANTRESTEFC
    FROM
        AVOIRFC_MONTANT            AV
        LEFT JOIN FACTURE_CLIENT_UNION_ORDRE FCU
        ON AV.IDFACTURE=FCU.ID
    WHERE
        AV.ETAT >=11
    GROUP BY
        AV.ID, AV.DATY, AV.IDFACTURE, AV.ETAT, AV.TIERS, AV.TIERSLIB, AV.CATEGORIE, AV.CATEGORIELIB, AV.MOTIF, AV.MOTIFLIB, AV.CODE, AV.TYPE, AV.TYPELIB, AV.DESIGNATION, AV.MONTANT, AV.MONTANTTVA, AV.MONTANTTTC, AV.CODEFACTURE, AV.DATEFACTURE, AV.CDCLT, FCU.MONTANTRESTE;

CREATE OR REPLACE FORCE VIEW AVOIRFC_MONTANT_V (
    ID,
    DATY,
    IDFACTURE,
    ETAT,
    MONTANT,
    TIERS,
    TIERSLIB,
    MONTANTPAYE,
    MONTANTRESTE,
    CATEGORIE,
    CATEGORIELIB,
    MOTIF,
    MOTIFLIB,
    CODE,
    TYPE,
    TYPELIB,
    DESIGNATION,
    MONTANTTVA,
    MONTANTTTC,
    CODEFACTURE,
    DATEFACTURE,
    CDCLT
) AS
    SELECT
        ID,
        DATY,
        IDFACTURE,
        ETAT,
        MONTANT,
        TIERS,
        TIERSLIB,
        MONTANTPAYE,
        MONTANTRESTE,
        CATEGORIE,
        CATEGORIELIB,
        MOTIF,
        MOTIFLIB,
        CODE,
        TYPE,
        TYPELIB,
        DESIGNATION,
        MONTANTTVA,
        MONTANTTTC,
        CODEFACTURE,
        DATEFACTURE,
        CDCLT
    FROM
        AVOIRFC_MONTANT
    WHERE
        ETAT >= 11;

CREATE OR REPLACE FORCE VIEW CAFCFILLECOMPLET (
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
    CODE
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
        RANG,
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
        CAST(MONTANTTVA AS NUMBER(30, 2)),
        CAST(MONTANTTTC AS NUMBER(30, 2)),
        MOISLIB,
        CAST(MONTANTHTSIMPLE AS NUMBER(30, 2)),
        FF.CLIENT,
        FF.CODE
    FROM
        FCFILLECOMPLET FF
    WHERE
        FF.IDCATEGORIE <> 'CATFCO2'
        AND FF.IDCATEGORIE <> 'CATFCO1'
        AND ETAT>=11;

CREATE OR REPLACE FORCE VIEW CAFCFILLECOMPLET_AVOIR (
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
    ETATLIB
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
        CAST(MONTANT-NVL(FF.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER(30, 2)),
        CAST(FF.MONTANTTVA-NVL(FF.MONTANTAVTVAAVECTAUX, 0) AS NUMBER(30, 2)),
        CAST(FF.MONTANTTTC-NVL(FF.MONTANTAVTTCAVECTAUX, 0) AS NUMBER(30, 2)),
        MOISLIB,
        CAST(FF.MONTANTHTSIMPLE-NVL(FF.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER(30, 2)),
        FF.CLIENT,
        CPTM.ID,
        FF.CODE,
        CASE
            WHEN FF.ETAT = 1 THEN
                'CREE'
            WHEN FF.ETAT >= 11 THEN
                'VISE'
            ELSE
                ''
        END AS ETATLIB
    FROM
        FCFILLECOMPLET FF
        LEFT JOIN COMPTECA CPTCA
        ON CPTCA.VAL=FF.COMPTE
        LEFT JOIN MERECA CPTM
        ON CPTM.ID=CPTCA.DESCE
    WHERE
        FF.IDCATEGORIE <> 'CATFCO2'
        AND FF.IDCATEGORIE <> 'CATFCO1'
        AND ETAT>=11;

CREATE OR REPLACE FORCE VIEW CAFCFILLECOMPLET_AVOIRC2 (
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
    FROM
        CAFCFILLECOMPLET_AVOIRNP2
    WHERE
        ETAT = 1;

CREATE OR REPLACE FORCE VIEW CAFCFILLECOMPLET_AVOIRNP (
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
        RANG,
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
        CAST(MONTANT-NVL(FF.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER(30, 2)),
        CAST(FF.MONTANTTVA-NVL(FF.MONTANTAVTVAAVECTAUX, 0) AS NUMBER(30, 2)),
        CAST(FF.MONTANTTTC-NVL(FF.MONTANTAVTTCAVECTAUX, 0) AS NUMBER(30, 2)),
        MOISLIB,
        CAST(FF.MONTANTHTSIMPLE-NVL(FF.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER(30, 2)),
        FF.CLIENT,
        CPTM.ID,
        FF.CODE,
        CASE
            WHEN FF.ETAT = 1 THEN
                'CREE'
            WHEN FF.ETAT >= 11 THEN
                'VISE'
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
        AND FF.IDCATEGORIE <> 'CATFCO1'
        AND ETAT>=11;

CREATE OR REPLACE FORCE VIEW CAFCFILLECOMPLET_AVOIRNP2 (
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
        RANG,
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
        CAST(MONTANT-NVL(FF.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER(30, 2)),
        CAST(FF.MONTANTTVA-NVL(FF.MONTANTAVTVAAVECTAUX, 0) AS NUMBER(30, 2)),
        CAST(FF.MONTANTTTC-NVL(FF.MONTANTAVTTCAVECTAUX, 0) AS NUMBER(30, 2)),
        MOISLIB,
        CAST(FF.MONTANTHTSIMPLE-NVL(FF.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER(30, 2)),
        FF.CLIENT,
        CPTM.ID,
        FF.CODE,
        CASE
            WHEN FF.ETAT = 1 THEN
                'CREE'
            WHEN FF.ETAT >= 11 THEN
                'VISE'
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

CREATE OR REPLACE FORCE VIEW CAFCFILLECOMPLET_AVOIRNP3 (
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

CREATE OR REPLACE FORCE VIEW AVOIRFCFILLE_FACTURE (
    ID,
    IDMERE,
    IDDETAILFACTURE,
    MONTANT,
    COMPTE,
    REMISE,
    DATY,
    IDFACTURE,
    ETAT,
    DESIGNATION,
    CODE,
    CATEGORIE,
    MOTIF,
    TYPE,
    RUBRIQUE,
    MONTANTAR,
    DATYFACT
) AS
    SELECT
        FC.ID,
        FC.IDMERE,
        FC.IDDETAILFACTURE,
        FC.MONTANT,
        FCF.COMPTE,
        FC.REMISE,
        FC.DATY,
        FC.IDFACTURE,
        FC.ETAT,
        FC.DESIGNATION,
        FC.CODE,
        FC.CATEGORIE,
        FC.MOTIF,
        FC.TYPE,
        FCF.RUBRIQUE,
        MONTANTAVOIRAVECTAUX AS MONTANTAR,
        FCF.DATY             AS DATYFACT
    FROM
        AVOIRFCFILLE_FM        FC
        LEFT JOIN FACTURE_CLIENT_MONTANT FCF
        ON FC.IDDETAILFACTURE = FCF.ID;

CREATE OR REPLACE FORCE VIEW AVOIRFCAVECTAUX_GRP (
    IDDETAILFACTURE,
    MONTANTSANSTAUX,
    MONTANTAVECTSAUX,
    MONTANTTVA,
    MONTANTTTC
) AS
    SELECT
        AC.IDDETAILFACTURE,
        CAST (SUM (MONTANT) AS NUMBER(30, 2))         AS MONTANTSANSTAUX,
        CAST (SUM (MONTANTAVECTSAUX)AS NUMBER(30, 2)) AS MONTANTAVECTSAUX,
        CAST (SUM (MONTANTTVA)AS NUMBER(30, 2))       AS MONTANTTVA,
        CAST (SUM (MONTANTTTC)AS NUMBER(30, 2))       AS MONTANTTTC
    FROM
        AVOIRFCAVECTAUX AC
    WHERE
        ETAT >= 11
    GROUP BY
        AC.IDDETAILFACTURE;

CREATE OR REPLACE FORCE VIEW AVOIRDETAILFCFILLE (
    IDAVOIRFILLE,
    ID,
    CODEAVOIR,
    DATYAVOIRFC,
    TYPE,
    IDFC,
    CODEFC,
    DATYFC,
    CLIENT,
    DESIGNATION,
    PU,
    QTE,
    DUREE,
    COMPTE,
    REMISE,
    TVA,
    REDUCTION,
    MAJORATION,
    DEVISE,
    TAUX,
    MONTANTHTDEVISE,
    MTTHTVA,
    MONTANTTVA,
    MONTANTTTC,
    MOIS,
    ANNEE
) AS
    SELECT
        A2.ID                                                                  AS IDAVOIRFILLE,
        A2.IDMERE                                                              AS ID,
        A.CODE                                                                 AS CODEAVOIR,
        A.DATY                                                                 AS DATYAVOIRFC,
        CASE
            WHEN A.TYPE = 1 THEN
                'interne'
            WHEN A.TYPE = 2 THEN
                'externe'
        END AS TYPE,
        A.IDFACTURE                                                            AS IDFC,
        FC.CODE                                                                AS CODEFC,
        FC.DATY                                                                AS DATYFC,
        FC.NOMCLT                                                              AS CLIENT,
        FCF.DESIGNATION,
        A2.PU,
        QTE,
        A2.DUREE,
        FCF.COMPTE,
        A2.REMISE,
        A2.TVA,
        A2.REDUCTION,
        A2.MAJORATION,
        A3.DEVISE,
        A3.TAUX,
        A3.MONTANT                                                             AS MONTANTHTDEVISE,
        A3.MONTANTAVECTSAUX                                                    AS MTTHTVA,
        A3.MONTANTTVA,
        A3.MONTANTTTC,
        EXTRACT (MONTH FROM A.DATY)                                            AS MOIS,
        EXTRACT (YEAR FROM A.DATY)                                             AS ANNEE
    FROM
        AVOIRFCFILLE         A2
        JOIN AVOIRFC A
        ON A.ID = A2.IDMERE JOIN FACTURE_CLIENT_FILLE FCF
        ON A2.IDDETAILFACTURE = FCF.ID
        JOIN FACTURECLIENT FC
        ON FCF.IDMERE = FC.ID JOIN AVOIRFCAVECTAUX A3
        ON A3.ID = A2.ID;

CREATE OR REPLACE FORCE VIEW PAIEMENTFF (
    ID,
    DATEEFFET,
    CAISSE,
    TIERSLIB,
    LIBELLE,
    MONTANT,
    IDFACT
) AS
    SELECT
        JC.ID,
        JC.DATEEFFET,
        JC.CAISSE,
        JC.TIERSLIB,
        JC.LIBELLE,
        PF.MONTANT,
        PF.IDFACT
    FROM
        JOURNALCAISSELIB_VISE JC
        LEFT JOIN PAIEMENTFACTUREF PF
        ON PF.IDMVT=JC.ID;

CREATE OR REPLACE FORCE VIEW LIAISONOPFF_MSUM (
    ID,
    DATY,
    TIERS,
    DESIGNATION,
    TYPE,
    TVA,
    REMARQUE,
    IDUSER,
    DATE_ECHEANCE,
    ETAT,
    IDPREVISION,
    MONTANT,
    MONTANTTVA,
    MONTANTAVOIR,
    MONTANTTTC,
    MONTANTPAYE,
    MONTANTRESTE,
    TIERSLIB,
    CONTACT,
    ADRESSE,
    ESCALE,
    TYPELIB,
    IDCATEGORIE,
    CATEGORIELIB,
    IDPROVISION,
    IDPROVISIONLIB,
    ESTDDPMICTSL,
    DEVISEMERE,
    CODEPRESTATION,
    CODEPRESTATIONLIB,
    CODE,
    ESTMICTSL,
    CODEPROVISION,
    MONTANTTTCVRAI,
    ETATLIB,
    IDBL,
    NUMEROOP,
    PROJET,
    CODE_ETABLISSEMENT,
    PROJETLIB,
    CODE_ETABLISSEMENTLIB,
    NATURE,
    NATURELIB,
    IDBC,
    NUMOP,
    EXERCICE,
    ID2
) AS
    SELECT
        ID,
        DATY,
        TIERS,
        DESIGNATION,
        TYPE,
        TVA,
        REMARQUE,
        IDUSER,
        DATE_ECHEANCE,
        ETAT,
        IDPREVISION,
        CAST(MONTANT AS NUMBER(30, 2)),
        CAST( MONTANTTVA AS NUMBER(30, 2)),
        CAST( MONTANTAVOIR AS NUMBER(30, 2)),
        CAST(MONTANTTTC AS NUMBER(30, 2)),
        CAST( MONTANTPAYE AS NUMBER(30, 2)),
        CAST( MONTANTRESTE AS NUMBER(30, 2)),
        TIERSLIB,
        CONTACT,
        ADRESSE,
        ESCALE,
        TYPELIB,
        IDCATEGORIE,
        CATEGORIELIB,
        IDPROVISION,
        IDPROVISIONLIB,
        ESTDDPMICTSL,
        DEVISEMERE,
        CODEPRESTATION,
        CODEPRESTATIONLIB,
        CODE,
        ESTMICTSL,
        CODEPROVISION,
        CAST( MONTANTTTCVRAI AS NUMBER(30, 2)),
        ETATLIB,
        IDBL,
        NUMEROOP,
        PROJET,
        CODE_ETABLISSEMENT,
        PROJETLIB,
        CODE_ETABLISSEMENTLIB,
        NATURE,
        NATURELIB,
        IDBC,
        NUMOP,
        EXERCICE,
        IDORDRE                                AS ID2
    FROM
        (
            SELECT
                FF.ID,
                FF.DATY,
                FF.TIERS,
                FF.DESIGNATION,
                FF.TYPE,
                FF.TVA,
                FF.REMARQUE,
                FF.IDUSER,
                FF.DATE_ECHEANCE,
                FF.ETAT,
                FF.IDPREVISION,
                CAST(FF.MONTANT AS NUMBER(30, 2))        AS MONTANT,
                CAST(FF.MONTANTTVA AS NUMBER(30, 2))     AS MONTANTTVA,
                CAST(FF.MONTANTAVOIR AS NUMBER(30, 2))   AS MONTANTAVOIR,
                CAST(FF.MONTANTTTC AS NUMBER(30, 2))     AS MONTANTTTC,
                CAST(FF.MONTANTPAYE AS NUMBER(30, 2))    AS MONTANTPAYE,
                CAST(FF.MONTANTRESTE AS NUMBER(30, 2))   AS MONTANTRESTE,
                FF.TIERSLIB,
                FF.CONTACT,
                FF.ADRESSE,
                FF.ESCALE,
                FF.TYPELIB,
                FF.IDCATEGORIE,
                FF.CATEGORIELIB,
                FF.IDPROVISION,
                FF.IDPROVISIONLIB,
                FF.ESTDDPMICTSL,
                FF.DEVISEMERE,
                FF.CODEPRESTATION,
                FF.CODEPRESTATIONLIB,
                FF.CODE,
                FF.ESTMICTSL,
                FF.CODEPROVISION,
                CAST(FF.MONTANTTTCVRAI AS NUMBER(30, 2)) AS MONTANTTTCVRAI,
                FF.ETATLIB,
                FF.IDBL,
                FF.NUMEROOP,
                FF.PROJET,
                FF.CODE_ETABLISSEMENT,
                FF.PROJETLIB,
                FF.CODE_ETABLISSEMENTLIB,
                FF.NATURE,
                FF.NATURELIB,
                FF.IDBC,
                O.NUMEROOP                               AS NUMOP,
                FF.EXERCICE,
                L.ID2                                    AS IDORDRE
            FROM
                FACTFOURN_MSUM_LIBV FF
                JOIN LIAISONINTRATABLE L
                ON L.ID1=FF.ID LEFT JOIN ORDONNERPAYEMENT O
                ON L.ID2 = O.ID UNION
                SELECT
                    FF.ID,
                    FF.DATY,
                    FF.TIERS,
                    FF.DESIGNATION,
                    FF.TYPE,
                    FF.TVA,
                    FF.REMARQUE,
                    FF.IDUSER,
                    FF.DATE_ECHEANCE,
                    FF.ETAT,
                    FF.IDPREVISION,
                    CAST(FF.MONTANT AS NUMBER(30, 2))        AS MONTANT,
                    CAST(FF.MONTANTTVA AS NUMBER(30, 2))     AS MONTANTTVA,
                    CAST(FF.MONTANTAVOIR AS NUMBER(30, 2))   AS MONTANTAVOIR,
                    CAST(FF.MONTANTTTC AS NUMBER(30, 2))     AS MONTANTTTC,
                    CAST(FF.MONTANTPAYE AS NUMBER(30, 2))    AS MONTANTPAYE,
                    CAST(FF.MONTANTRESTE AS NUMBER(30, 2))   AS MONTANTRESTE,
                    FF.TIERSLIB,
                    FF.CONTACT,
                    FF.ADRESSE,
                    FF.ESCALE,
                    FF.TYPELIB,
                    FF.IDCATEGORIE,
                    FF.CATEGORIELIB,
                    FF.IDPROVISION,
                    FF.IDPROVISIONLIB,
                    FF.ESTDDPMICTSL,
                    FF.DEVISEMERE,
                    FF.CODEPRESTATION,
                    FF.CODEPRESTATIONLIB,
                    FF.CODE,
                    FF.ESTMICTSL,
                    FF.CODEPROVISION,
                    CAST(FF.MONTANTTTCVRAI AS NUMBER(30, 2)) AS MONTANTTTCVRAI,
                    FF.ETATLIB,
                    FF.IDBL,
                    FF.NUMEROOP,
                    FF.PROJET,
                    FF.CODE_ETABLISSEMENT,
                    FF.PROJETLIB,
                    FF.CODE_ETABLISSEMENTLIB,
                    FF.NATURE,
                    FF.NATURELIB,
                    FF.IDBC,
                    O.NUMEROOP                               AS NUMOP,
                    FF.EXERCICE,
                    L.ID2                                    AS IDORDRE
                FROM
                    FACTFOURN_MSUM_LIBV FF
                    JOIN LIAISONINTRATABLE L
                    ON L.ID1=FF.IDPROVISION LEFT JOIN ORDONNERPAYEMENT O
                    ON L.ID2 = O.ID
        )                   ;

CREATE OR REPLACE FORCE VIEW LIAISONENGAGEMENTFF_GRPFFENGAG (
    ID,
    DESIGNATION,
    CODEETABLISSEMENT,
    PROJET,
    MONTANT,
    DISPOAVANT,
    DISPOAPRES,
    COMPTE,
    ETAT,
    CODEETABLISSEMENTLIB,
    PROJETLIB,
    IDLC,
    IDLCLIB,
    DATY,
    AVECFACTURE,
    AVECFACTURELIB,
    MONTANTOP,
    DISPONIBLE,
    TIERS,
    TIERSLIB,
    NUM,
    OBSERVATION,
    ANNEE,
    MONTANTRESTE,
    IDFACTUREFOURNISSEUR,
    MONTANTENGAGER
) AS
    SELECT
        ID,
        DESIGNATION,
        CODEETABLISSEMENT,
        PROJET,
        MONTANT,
        DISPOAVANT,
        DISPOAPRES,
        COMPTE,
        ETAT,
        CODEETABLISSEMENTLIB,
        PROJETLIB,
        IDLC,
        IDLCLIB,
        DATY,
        AVECFACTURE,
        AVECFACTURELIB,
        MONTANTOP,
        DISPONIBLE,
        TIERS,
        TIERSLIB,
        NUM,
        OBSERVATION,
        ANNEE,
        MONTANTRESTE,
        IDFACTUREFOURNISSEUR,
        SUM(NVL(MONTANTENGAGER, 0)) AS MONTANTENGAGER
    FROM
        LIAISONENGAGEMENTFF_TMP
    GROUP BY
        ID,
        DESIGNATION,
        CODEETABLISSEMENT,
        PROJET,
        MONTANT,
        DISPOAVANT,
        DISPOAPRES,
        COMPTE,
        ETAT,
        CODEETABLISSEMENTLIB,
        PROJETLIB,
        IDLC,
        IDLCLIB,
        DATY,
        AVECFACTURE,
        AVECFACTURELIB,
        MONTANTOP,
        DISPONIBLE,
        TIERS,
        TIERSLIB,
        NUM,
        OBSERVATION,
        ANNEE,
        MONTANTRESTE,
        IDFACTUREFOURNISSEUR;

CREATE OR REPLACE FORCE VIEW LIAISONENGAGEMENTFF (
    ID,
    DESIGNATION,
    CODEETABLISSEMENT,
    PROJET,
    MONTANT,
    DISPOAVANT,
    DISPOAPRES,
    COMPTE,
    ETAT,
    CODEETABLISSEMENTLIB,
    PROJETLIB,
    IDLC,
    IDLCLIB,
    DATY,
    AVECFACTURE,
    AVECFACTURELIB,
    MONTANTOP,
    DISPONIBLE,
    TIERS,
    TIERSLIB,
    NUM,
    OBSERVATION,
    ANNEE,
    MONTANTRESTE,
    IDFACTUREFOURNISSEUR,
    MONTANTENGAGER
) AS
    SELECT
        ID,
        DESIGNATION,
        CODEETABLISSEMENT,
        PROJET,
        MONTANT,
        DISPOAVANT,
        DISPOAPRES,
        COMPTE,
        ETAT,
        CODEETABLISSEMENTLIB,
        PROJETLIB,
        IDLC,
        IDLCLIB,
        DATY,
        AVECFACTURE,
        AVECFACTURELIB,
        MONTANTOP,
        DISPONIBLE,
        TIERS,
        TIERSLIB,
        NUM,
        OBSERVATION,
        ANNEE,
        MONTANTRESTE,
        IDFACTUREFOURNISSEUR,
        MONTANTENGAGER
    FROM
        LIAISONENGAGEMENTFF_GRPFFENGAG
    WHERE
        MONTANTENGAGER>0;

CREATE OR REPLACE FORCE VIEW AVOIRFF_MONTANT (
    ID,
    DATY,
    IDFACTURE,
    ETAT,
    MONTANT,
    TIERS,
    TIERSLIB,
    MONTANTPAYE,
    MONTANTRESTE,
    CATEGORIE,
    CATEGORIELIB,
    MOTIF,
    MOTIFLIB,
    CODE,
    TYPE,
    TYPELIB,
    DESIGNATION
) AS
    SELECT
        FC.ID,
        FC.DATY,
        FC.IDFACTURE,
        FC.ETAT,
        CAST(NVL(MR.MONTANT, 0.0) AS NUMBER(30, 2))                                  AS MONTANT,
        F.TIERS                                                                      AS TIERS,
        F.TIERSLIB                                                                   AS TIERSLIB,
        CAST(NVL(OP.DEBIT, 0) AS NUMBER(30, 2))                                      AS MONTANTPAYE,
        CAST(NVL(MR.MONTANT, 0.0) - NVL(OP.DEBIT, 0) AS NUMBER(30, 2))               AS MONTANTRESTE,
        FC.CATEGORIE,
        C.VAL                                                                        AS CATEGORIELIB,
        FC.MOTIF,
        MO.VAL                                                                       AS MOTIFLIB,
        FC.CODE,
        FC.TYPE,
        CASE
            WHEN FC.TYPE = '1' THEN
                'interne'
            WHEN FC.TYPE = '2' THEN
                'externe'
        END AS TYPELIB,
        FC.DESIGNATION
    FROM
        AVOIRFF                   FC
        LEFT JOIN CATEGORIEAVOIRFF C
        ON FC.CATEGORIE = C.ID
        LEFT JOIN MOTIFAVOIRFC MO
        ON FC.MOTIF = MO.ID
        LEFT JOIN AVOIRFFAVECTAUX_GRP_MERE MR
        ON MR.IDMERE = FC.ID
        LEFT JOIN FACTFOURN_MERE_LIBCOMPLET F
        ON FC.IDFACTURE = F.ID
        LEFT JOIN ORDONNERPAYEMENT_JC_VISE OP
        ON OP.DED_ID = FC.ID;

CREATE OR REPLACE FORCE VIEW AVOIRFF_MONTANTLIBETAT (
    ID,
    CODE,
    DATY,
    IDFACTURE,
    ETAT,
    MONTANT,
    TIERS,
    TIERSLIB,
    MONTANTPAYE,
    MONTANTRESTE,
    ETATLIB
) AS
    SELECT
        OP.ID,
        OP.CODE,
        OP.DATY,
        OP.IDFACTURE,
        OP.ETAT,
        CAST(OP.MONTANT AS NUMBER(30, 2))                                                                  AS MONTANT,
        OP.TIERS,
        OP.TIERSLIB,
        CAST(OP.MONTANTPAYE AS NUMBER(30, 2))                                                              AS MONTANTPAYE,
        CAST(OP.MONTANTRESTE AS NUMBER(30, 2))                                                             AS MONTANTRESTE,
        CASE
            WHEN OP.ETAT = 0 THEN
                'annule'
            WHEN OP.ETAT = 1 THEN
                'cree'
            WHEN OP.ETAT = 11 THEN
                'vise'
        END AS ETATLIB
    FROM
        AVOIRFF_MONTANT OP;

CREATE OR REPLACE FORCE VIEW AVOIRFFAVECTAUX (
    ID,
    IDMERE,
    IDDETAILFACTURE,
    MONTANT,
    COMPTE,
    TAUX,
    DEVISE,
    MONTANTAVECTSAUX,
    ETAT
) AS
    SELECT
        AC.ID,
        AC.IDMERE,
        AC.IDDETAILFACTURE,
        AC.MONTANT,
        AC.COMPTE,
        CAST(NVL(FC.TAUX, 1) AS NUMBER(30, 2))              AS TAUX,
        NVL(FC.DEVISE, 'Ar')                                AS DEVISE,
        CAST(AC.MONTANT * NVL(FC.TAUX, 1) AS NUMBER(30, 2)) AS MONTANTAVECTSAUX,
        A.ETAT
    FROM
        AVOIRFFFILLE              AC
        LEFT JOIN AVOIRFF A
        ON AC.IDMERE = A.ID
        LEFT JOIN FACTURE_FOURNISSEUR_FILLE FC
        ON FC.ID = AC.IDDETAILFACTURE;

CREATE OR REPLACE FORCE VIEW AVOIRFFAVECTAUX_GRP (
    IDDETAILFACTURE,
    MONTANTSANSTAUX,
    MONTANTAVECTSAUX
) AS
    SELECT
        AC.IDDETAILFACTURE,
        CAST(SUM(MONTANT) AS NUMBER(30, 2))          AS MONTANTSANSTAUX,
        CAST(SUM(MONTANTAVECTSAUX) AS NUMBER(30, 2)) AS MONTANTAVECTSAUX
    FROM
        AVOIRFFAVECTAUX AC
    WHERE
        ETAT >= 11
    GROUP BY
        AC.IDDETAILFACTURE;

CREATE OR REPLACE FORCE VIEW UNION_AVOIRFF_MONTANT_REGROUP (
    ID,
    DATY,
    IDFACTURE,
    ETAT,
    MONTANT,
    TIERS,
    TIERSLIB,
    MONTANTPAYE,
    MONTANTRESTE,
    CATEGORIE,
    CATEGORIELIB,
    MOTIF,
    MOTIFLIB,
    CODE,
    TYPE,
    TYPELIB,
    DESIGNATION
) AS
    SELECT
        ID,
        DATY,
        IDFACTURE,
        ETAT,
        CAST(MONTANT AS NUMBER(30, 2))      AS MONTANT,
        TIERS,
        TIERSLIB,
        CAST(MONTANTPAYE AS NUMBER(30, 2)) AS MONTANTPAYE,
        CAST(MONTANTRESTE AS NUMBER(30, 2)) AS MONTANTRESTE,
        CATEGORIE,
        CATEGORIELIB,
        MOTIF,
        MOTIFLIB,
        CODE,
        TYPE,
        TYPELIB,
        DESIGNATION
    FROM
        (
            SELECT
                ID,
                DATY,
                IDFACTURE,
                ETAT,
                CAST(MONTANT AS NUMBER(30, 2))      AS MONTANT,
                TIERS,
                TIERSLIB,
                CAST(MONTANTPAYE AS NUMBER(30, 2)) AS MONTANTPAYE,
                CAST(MONTANTRESTE AS NUMBER(30, 2)) AS MONTANTRESTE,
                CATEGORIE,
                CATEGORIELIB,
                MOTIF,
                MOTIFLIB,
                CODE,
                TYPE,
                TYPELIB,
                DESIGNATION
            FROM
                AVOIRFF_MONTANT UNION
                SELECT
                    ID,
                    DATY,
                    IDFACTURE,
                    ETAT,
                    CAST(MONTANTTTC AS NUMBER(30, 2))   AS MONTANT,
                    TIERS,
                    TIERSLIB,
                    CAST(MONTANTPAYE AS NUMBER(30, 2)) AS MONTANTPAYE,
                    CAST(MONTANTRESTE AS NUMBER(30, 2)) AS MONTANTRESTE,
                    CATEGORIE,
                    CATEGORIELIB,
                    MOTIF,
                    MOTIFLIB,
                    CODE,
                    TYPE,
                    TYPELIB,
                    DESIGNATION
                FROM
                    AVOIRFC_MONTANT_REGROUP
        )                       ;

CREATE OR REPLACE FORCE VIEW UNION_AVOIRFF_MONTANT (
    ID,
    DATY,
    IDFACTURE,
    ETAT,
    MONTANT,
    TIERS,
    TIERSLIB,
    MONTANTPAYE,
    MONTANTRESTE,
    CATEGORIE,
    CATEGORIELIB,
    MOTIF,
    MOTIFLIB,
    CODE,
    TYPE,
    TYPELIB,
    DESIGNATION
) AS
    SELECT
        ID,
        DATY,
        IDFACTURE,
        ETAT,
        CAST(MONTANT AS NUMBER(30, 2)),
        TIERS,
        TIERSLIB,
        CAST(MONTANTPAYE AS NUMBER(30, 2)),
        CAST(MONTANTRESTE AS NUMBER(30, 2)),
        CATEGORIE,
        CATEGORIELIB,
        MOTIF,
        MOTIFLIB,
        CODE,
        TYPE,
        TYPELIB,
        DESIGNATION
    FROM
        AVOIRFF_MONTANT UNION
        SELECT
            ID,
            DATY,
            IDFACTURE,
            ETAT,
            MONTANTTTC                          AS MONTANT,
            TIERS,
            TIERSLIB,
            MONTANTPAYE,
            MONTANTRESTE,
            CATEGORIE,
            CATEGORIELIB,
            MOTIF,
            MOTIFLIB,
            CODE,
            TYPE,
            TYPELIB,
            DESIGNATION
        FROM
            AVOIRFC_MONTANT;

CREATE OR REPLACE FORCE VIEW FACTURECLIENTMSUM (
    ID,
    DATY,
    TIERS,
    DESIGNATION,
    TYPE,
    TVA,
    REMARQUE,
    IDUSER,
    DATE_ECHEANCE,
    ETAT,
    IDPREVISION,
    MONTANT,
    MONTANTTVA,
    MONTANTAVOIR,
    MONTANTTTC,
    ESCALE,
    TYPELIB,
    IDCATEGORIE,
    CATEGORIELIB,
    IDPROVISION,
    IDPROVISIONLIB,
    ESTDDPMICTSL,
    DEVISEMERE,
    CODEPRESTATION,
    CODEPRESTATIONLIB,
    CODE,
    ESTMICTSL,
    CODEPROVISION,
    MONTANTTTCVRAI,
    NAVIRE,
    ARMATEURLIB,
    EXERCICE,
    IDAVOIR,
    POURCOMPTE,
    POURCOMPTELIB,
    ESTANCIENNE,
    ARMATEUR,
    PAIEMENT,
    LHT,
    LM,
    TE,
    JNT,
    DATEDEPART,
    HEUREDEPART,
    DATEARRIVEE,
    HEUREARRIVEE,
    BATEAU,
    PROVENANCE,
    DESTINATION,
    PAVILLON,
    PAVILLONLIB,
    BATEAULIB,
    VOLUME,
    VOLUME100,
    NOMCLT,
    ADRCLT,
    NMSTTCLT,
    TELCLT,
    NIF,
    RC,
    DTTP,
    TP,
    DTQUIT,
    QUIT
) AS
    SELECT
        FC.ID,
        FC.DATY,
        FC.TIERS,
        FC.DESIGNATION,
        FC.TYPE,
        FC.TVA,
        FC.REMARQUE,
        FC.IDUSER,
        FC.DATE_ECHEANCE,
        FC.ETAT,
        FC.IDPREVISION,
        CAST(NVL(GRP.MONTANT, 0) AS NUMBER(30, 2))                                    AS MONTANT, --montanttaux
        CAST(NVL(GRP.MONTANTTVA, 0) AS NUMBER(30, 2))                                 AS MONTANTTVA,
        CAST(NVL(GRP.MONTANTAVTTCAVECTAUX, 0) AS NUMBER(30, 2))                       AS MONTANTAVOIR,
        CAST(NVL(MONTANTTTC, 0) - NVL( GRP.MONTANTAVTTCAVECTAUX, 0) AS NUMBER(30, 2)) AS MONTANTTTC,
        NVL(PR.ESCALE, FC.ESCALE)                                                     AS ESCALE,
        TFC.VAL                                                                       AS TYPELIB,
        FC.IDCATEGORIE,
        CATFC.VAL                                                                     AS CATEGORIELIB,
        FC.IDPROVISION,
        FCF.DESIGNATION                                                               AS IDPROVISIONLIB,
        FC.ESTDDPMICTSL,
        FC.DEVISEMERE,
        FC.CODEPRESTATION,
        CP.VAL                                                                        AS CODEPRESTATIONLIB,
        FC.CODE,
        FC.ESTMICTSL,
        FCF.CODE                                                                      AS CODEPROVISION,
        CAST( NVL(NVL(GRP.MONTANTTVA, 0) + GRP.MONTANT, 0) AS NUMBER(30, 2))          AS MONTANTTTCVRAI,
        PR.NAVIRE,
        A.VAL                                                                         AS ARMATEURLIB,
        FC.EXERCICE,
        FC.IDAVOIR,
        FC.POURCOMPTE,
        FUP.NOM                                                                       AS POURCOMPTELIB,
        FC.ESTANCIENNE,
        FC.ARMATEUR,
        FC.PAIEMENT,
        CAST(
            CASE
                WHEN FC.LHT IS NULL OR FC.LHT=0 THEN
                    CAST(NVL(NV.LHT, NVC.LHT) AS NUMBER(10, 2))
                ELSE
                    CAST(FC.LHT AS NUMBER(10, 2))
            END AS NUMBER(10, 2))                                                     AS LHT,
        CAST(
            CASE
                WHEN FC.LM IS NULL OR FC.LM=0 THEN
                    CAST(NVL(NV.LM, NVC.LM) AS NUMBER(10, 2))
                ELSE
                    CAST(FC.LM AS NUMBER(10, 2))
            END AS NUMBER(10, 2))                                                     AS LM,
        CAST(
            CASE
                WHEN FC.TE IS NULL OR FC.TE=0 THEN
                    CAST(NVL(NV.TE, NVC.TE) AS NUMBER(10, 2))
                ELSE
                    CAST(FC.TE AS NUMBER(10, 2))
            END AS NUMBER(10, 2))                                                     AS TE,
        CAST(
            CASE
                WHEN FC.JNT IS NULL OR FC.JNT=0 THEN
                    CAST(NVL(NV.JNT, NVC.JNT) AS NUMBER(10, 2))
                ELSE
                    CAST(FC.JNT AS NUMBER(10, 2))
            END AS NUMBER(10, 2))                                                     AS JNT,
        NVL(PR.DATE_DEPART, FC.DATEDEPART)                                            AS DATEDEPART,
        NVL(PR.HEURE_DEPART, FC.HEUREDEPART)                                          AS HEUREDEPART,
        NVL(PR.DATE_ARRIVEE, FC.DATEARRIVEE)                                          AS DATEARRIVEE,
        NVL(PR.HEURE_ARRIVEE, FC.HEUREARRIVEE)                                        AS HEUREARRIVEE,
        NVL(PR.NAVIRE, FC.BATEAU)                                                     AS BATEAU,
        NVL(PR.PROVENANCE, FC.PROVENANCE)                                             AS PROVENANCE,
        NVL(ESCA.DESTINATION, FC. DESTINATION)                                        AS DESTINATION,
        NVL(NV.PAVILLON, NVC.PAVILLON)                                                AS PAVILLON,
        NVL(NV.VALPAVILLON, NVC.VALPAVILLON)                                          AS PAVILLONLIB,
        NVL(NV.NOM, NVC.NOM)                                                          AS BATEAULIB,
        FC.VOLUME,
        FC.VOLUME100,
        NVL(FC.NOMCLT, CU. NOMCLT),
        NVL(FC. ADRCLT, CU. ADRCLT),
        NVL(FC. NMSTTCLT, CU. NMSTTCLT),
        NVL(FC. TELCLT, CU. TELCLT),
        NVL(FC.NIF, CU.NIF),
        NVL(FC. RC, CU. RC),
        NVL(FC.DTTP, CU.DTTP),
        NVL(FC.TP, CU.TP),
        NVL(FC.DTQUIT, CU.DTQUIT),
        NVL(FC.QUIT, CU.QUIT)
    FROM
        FACTURECLIENT               FC
        LEFT JOIN CAFCFILLECOMPLET_GRP GRP
        ON GRP.IDMERE = FC.ID
        LEFT JOIN PREVISION PR
        ON PR.ID = FC.IDPREVISION
        LEFT JOIN MOUVEMENTDEPART_ESC ESCA
        ON ESCA.ESCALE=PR.ID
        LEFT JOIN TYPEFC TFC
        ON TFC.ID = FC.TYPE
        LEFT JOIN CATEGORIEFC CATFC
        ON CATFC.ID = FC.IDCATEGORIE
        LEFT JOIN FACTURECLIENT FCF
        ON FCF.ID = FC.IDPROVISION
        LEFT JOIN CODE_PRESTATION CP
        ON FC.CODEPRESTATION = CP.ID
        LEFT JOIN NAVIRELIBCOMPLET NV
        ON PR.NAVIRE = NV.ID
        LEFT JOIN FOURNISSEUR_UNION_PERSONNEL FUP
        ON FUP.ID = FC.POURCOMPTE
        LEFT JOIN ARMATEUR_TBD A
        ON A.ID = FC.ARMATEUR
        LEFT JOIN NAVIRELIBCOMPLET NVC
        ON NVC.ID=FC.BATEAU
        LEFT JOIN POSTEDESTINATAIRE PD
        ON PD.ID=FC.PROVENANCE
        LEFT JOIN POSTEDESTINATAIRE PD2
        ON PD2.ID=FC.DESTINATION
        LEFT JOIN CLIENT_UNION CU
        ON CU.CDCLT=FC.TIERS;

CREATE OR REPLACE FORCE VIEW FACTURECLIENTMSUM_LIB (
    ID,
    DATY,
    TIERS,
    DESIGNATION,
    TYPE,
    TVA,
    REMARQUE,
    IDUSER,
    DATE_ECHEANCE,
    ETAT,
    IDPREVISION,
    MONTANT,
    MONTANTTVA,
    MONTANTAVOIR,
    MONTANTTTC,
    MONTANTPAYE,
    MONTANTRESTE,
    TIERSLIB,
    CONTACT,
    ADRESSE,
    ESCALE,
    TYPELIB,
    IDCATEGORIE,
    CATEGORIELIB,
    IDPROVISION,
    IDPROVISIONLIB,
    ESTDDPMICTSL,
    DEVISEMERE,
    CODEPRESTATION,
    CODEPRESTATIONLIB,
    CODE,
    ESTMICTSL,
    CODEPROVISION,
    MONTANTTTCVRAI,
    NAVIRE,
    ARMATEURLIB,
    EXERCICE,
    IDAVOIR,
    POURCOMPTE,
    POURCOMPTELIB,
    ESTANCIENNE,
    ARMATEUR,
    PAIEMENT,
    PAIEMENTLIB,
    LHT,
    LM,
    TE,
    JNT,
    PAVILLON,
    PAVILLONLIB,
    PROVENANCE,
    PROVENANCELIB,
    DESTINATION,
    DESTINATIONLIB,
    BATEAU,
    BATEAULIB,
    DATEDEPART,
    HEUREDEPART,
    DATEARRIVEE,
    HEUREARRIVEE,
    VOLUME,
    VOLUME100,
    NOMCLT,
    ADRCLT,
    NMSTTCLT,
    TELCLT,
    NIF,
    RC,
    DTTP,
    TP,
    DTQUIT,
    QUIT,
    CDCLT
) AS
    SELECT
        M.ID,
        M.DATY,
        M.TIERS,
        M.DESIGNATION,
        M.TYPE,
        M.TVA,
        '--'
        || M.REMARQUE                                            AS REMARQUE,
        M.IDUSER,
        M.DATE_ECHEANCE,
        M.ETAT,
        M.IDPREVISION,
        CAST(M.MONTANT AS NUMBER(30, 2))                         AS MONTANT,
        CAST(M.MONTANTTVA AS NUMBER(30, 2))                      AS MONTANTTVA,
        CAST(M.MONTANTAVOIR AS NUMBER(30, 2))                    AS MONTANTAVOIR,
        CAST(M.MONTANTTTC AS NUMBER(30, 2))                      AS MONTANTTTC,
 -- CAST (LEAST (NVL (pf.montant, 0),(m.montant-m.montantavoir)) AS NUMBER (32, 2)) AS montantpaye,
        CAST((NVL(PF.MONTANT, 0)) AS NUMBER(30, 2))              AS MONTANTPAYE,
        CAST(M.MONTANTTTC - NVL(PF.MONTANT, 0) AS NUMBER(30, 2)) AS MONTANTRESTE,
        FUP.NOM                                                  AS TIERSLIB,
        FUP.CONTACT,
        FUP.ADRESSE,
        M.ESCALE,
        TYPELIB,
        M.IDCATEGORIE,
        M.CATEGORIELIB,
        IDPROVISION,
        IDPROVISIONLIB,
        M.ESTDDPMICTSL,
        M.DEVISEMERE,
        M.CODEPRESTATION,
        M.CODEPRESTATIONLIB,
        M.CODE,
        M.ESTMICTSL,
        CODEPROVISION,
        CAST(M.MONTANTTTCVRAI AS NUMBER(30, 2))                  AS MONTANTTTCVRAI,
        M.NAVIRE,
        M.ARMATEURLIB,
        M.EXERCICE,
        IDAVOIR,
        POURCOMPTE,
        POURCOMPTELIB,
        ESTANCIENNE,
        M.ARMATEUR,
        D.ID                                                     AS PAIEMENT,
        D.VAL                                                    AS PAIEMENTLIB,
        CAST(M.LHT AS NUMBER(10, 2))                             AS LHT,
        CAST(M.LM AS NUMBER(10, 2))                              AS LM,
        CAST(M.TE AS NUMBER(10, 2))                              AS TE,
        CAST(M.JNT AS NUMBER(10, 2))                             AS JNT,
        M.PAVILLON,
        M.PAVILLONLIB,
        M.PROVENANCE,
        P1.VALQUAIS                                              AS PROVENANCELIB,
        M.DESTINATION,
        P2.VALQUAIS                                              AS DESTINATIONLIB,
        M.BATEAU,
        M.BATEAULIB,
        M.DATEDEPART,
        M.HEUREDEPART,
        M.DATEARRIVEE,
        M.HEUREARRIVEE,
        M.VOLUME,
        M.VOLUME100,
        M. NOMCLT,
        M. ADRCLT,
        M. NMSTTCLT,
        M. TELCLT,
        M.NIF,
        M. RC,
        M.DTTP,
        M.TP,
        M.DTQUIT,
        M.QUIT,
        FUP.CDCLT
    FROM
        FACTURECLIENTMSUM           M
        LEFT JOIN FOURNISSEUR_UNION_PERSONNEL FUP
        ON FUP.ID = M.TIERS
        LEFT JOIN PAIEMENTFACTURESUM PF
        ON PF.IDFACT = M.ID
        LEFT JOIN DEVISE D
        ON D.ID = M.PAIEMENT
        LEFT JOIN POSTEDESTINATAIRELIBCOMPLET P1
        ON P1.ID=M.PROVENANCE
        LEFT JOIN POSTEDESTINATAIRELIBCOMPLET P2
        ON P2.ID=M.DESTINATION;

CREATE OR REPLACE FORCE VIEW FACTURE_CLIENT_UNION (
    ID,
    DATY,
    TIERS,
    DESIGNATION,
    TYPE,
    TVA,
    REMARQUE,
    IDUSER,
    DATE_ECHEANCE,
    ETAT,
    MONTANT,
    MONTANTTVA,
    MONTANTAVOIR,
    MONTANTTTC,
    MONTANTPAYE,
    MONTANTRESTE,
    TIERSLIB,
    CONTACT,
    ADRESSE,
    IDPREVISION,
    ESCALE,
    ETATLIB,
    TYPELIB,
    IDCATEGORIE,
    CATEGORIELIB,
    IDPROVISION,
    IDPROVISIONLIB,
    DEVISEMERE,
    CODEPRESTATION,
    CODEPRESTATIONLIB,
    CODE,
    ESTMICTSL,
    CODEPROVISION,
    MONTANTTTCVRAI,
    ARMATEURLIB,
    EXERCICE,
    IDAVOIR,
    POURCOMPTE,
    POURCOMPTELIB,
    ARMATEUR,
    PAIEMENT,
    PAIEMENTLIB,
    LHT,
    LM,
    TE,
    JNT,
    DATEDEPART,
    HEUREDEPART,
    DATEARRIVEE,
    HEUREARRIVEE,
    BATEAU,
    BATEAULIB,
    PROVENANCE,
    PROVENANCELIB,
    DESTINATION,
    DESTINATIONLIB,
    PAVILLON,
    PAVILLONLIB,
    NOMCLT,
    ADRCLT,
    NMSTTCLT,
    TELCLT,
    NIF,
    RC,
    DTTP,
    TP,
    DTQUIT,
    QUIT,
    CDCLT
) AS
    SELECT
        ID,
        DATY,
        TIERS,
        DESIGNATION,
        TYPE,
        CAST(TVA AS NUMBER(20, 2))                                          AS TVA,
        REMARQUE,
        IDUSER,
        DATE_ECHEANCE,
        CAST(ETAT AS NUMBER(10))                                            AS ETAT,
        CAST(MONTANT AS NUMBER(32, 2)),
        CAST(MONTANTTVA AS NUMBER(32, 2)),
        CAST(MONTANTAVOIR AS NUMBER(32, 2)),
        CAST(MONTANTTTC AS NUMBER(32, 2)),
        CAST(MONTANTPAYE AS NUMBER(32, 2)),
        CAST(MONTANTRESTE AS NUMBER(32, 2)),
        TIERSLIB,
        CONTACT,
        ADRESSE,
        IDPREVISION,
        ESCALE,
        CASE
            WHEN ETAT = 1 THEN
                'CREE(E)'
            WHEN ETAT = 11 THEN
                'VISE(E)'
        END AS ETATLIB,
        TYPELIB,
        IDCATEGORIE,
        CATEGORIELIB,
        IDPROVISION,
        IDPROVISIONLIB,
        DEVISEMERE,
        CODEPRESTATION,
        CODEPRESTATIONLIB,
        CODE,
        ESTMICTSL,
        CODEPROVISION,
        CAST(MONTANTTTCVRAI AS NUMBER(32, 2)),
        ARMATEURLIB,
        EXERCICE,
        IDAVOIR,
        POURCOMPTE,
        POURCOMPTELIB,
        ARMATEUR,
        PAIEMENT,
        PAIEMENTLIB,
        CAST(LHT AS NUMBER(10, 2)),
        CAST(LM AS NUMBER(10, 2)),
        CAST(TE AS NUMBER(10, 2)),
        CAST(JNT AS NUMBER(10, 2)),
        DATEDEPART,
        HEUREDEPART,
        DATEARRIVEE,
        HEUREARRIVEE,
        BATEAU,
        BATEAULIB,
        PROVENANCE,
        PROVENANCELIB,
        DESTINATION,
        DESTINATIONLIB,
        PAVILLON,
        PAVILLONLIB,
        NOMCLT,
        ADRCLT,
        NMSTTCLT,
        TELCLT,
        NIF,
        RC,
        DTTP,
        TP,
        DTQUIT,
        QUIT,
        CDCLT
    FROM
        (
            SELECT
                ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                CAST(TVA AS NUMBER(20, 2))                                                                                                            AS TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                CAST(ETAT AS NUMBER(10))                                                                                                              AS ETAT,
                CAST(MONTANT AS NUMBER(32, 2))                                                                                                        AS MONTANT,
                CAST(MONTANTTVA AS NUMBER(32, 2))                                                                                                     AS MONTANTTVA,
                CAST(MONTANTAVOIR AS NUMBER(32, 2))                                                                                                   AS MONTANTAVOIR,
                CASE
                    WHEN ABS(MONTANTRESTE)<50 AND MONTANTRESTE!=0 THEN
                        CAST(MONTANTPAYE AS NUMBER(32, 2))
                    ELSE
                        CAST(MONTANTTTC AS NUMBER(32, 2))
                END AS MONTANTTTC,
                CAST(MONTANTPAYE AS NUMBER(32, 2))                                                                                                    AS MONTANTPAYE,
                CASE
                    WHEN ABS(MONTANTRESTE)<50 AND MONTANTRESTE!=0 THEN
                        CAST(MONTANTPAYE-MONTANTPAYE AS NUMBER(32, 2)) --here
                    ELSE
                        CAST(MONTANTRESTE AS NUMBER(32, 2))
                END AS                                                                                          MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                IDPREVISION,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                ARMATEURLIB,
                EXERCICE,
                IDAVOIR,
                POURCOMPTE,
                POURCOMPTELIB,
                ARMATEUR,
                PAIEMENT,
                PAIEMENTLIB,
                CAST (LHT AS NUMBER(10, 2))                                                                                                           AS LHT,
                CAST (LM AS NUMBER(10, 2))                                                                                                            AS LM,
                CAST (TE AS NUMBER(10, 2))                                                                                                            AS TE,
                CAST (JNT AS NUMBER(10, 2))                                                                                                           AS JNT,
                DATEDEPART,
                HEUREDEPART,
                DATEARRIVEE,
                HEUREARRIVEE,
                BATEAU,
                BATEAULIB,
                PROVENANCE,
                PROVENANCELIB,
                DESTINATION,
                DESTINATIONLIB,
                PAVILLON,
                PAVILLONLIB,
                NOMCLT,
                ADRCLT,
                NMSTTCLT,
                TELCLT,
                NIF,
                RC,
                DTTP,
                TP,
                DTQUIT,
                QUIT,
                CDCLT
            FROM
                FACTURECLIENTMSUM_LIB
            WHERE
                DATY >= TO_DATE('2021-10-01', 'YYYY-MM-DD')
                OR ESTANCIENNE = 1
        );