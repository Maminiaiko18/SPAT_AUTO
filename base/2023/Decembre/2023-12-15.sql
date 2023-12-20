

CREATE OR REPLACE  VIEW ENGAGEMENTLIB (ID, DESIGNATION, CODEETABLISSEMENT, PROJET, MONTANT, DISPOAVANT, DISPOAPRES, ETAT, CODEETABLISSEMENTLIB, PROJETLIB, IDLC, IDLCLIB, DATY, AVECFACTURE, AVECFACTURELIB, MONTANTOP, DISPONIBLE, TIERS, TIERSLIB, NUM, OBSERVATION, ANNEE, DATEIMPRESSION, MONTANTRESTE, MONTANTLIBERER, COMPTE, CHANTIER, OBJET, DUREE, IDAVENANT,iduser) AS 
  SELECT
    E.ID,
    E.DESIGNATION,
    NVL(E.CODEETABLISSEMENT, LP.CODEETABLISSEMENT)                                       AS CODEETABLISSEMENT,
    NVL(E.PROJET, LP.PROJET)                                                             AS PROJET,
    CAST(LEB.MONTANT AS NUMBER(30, 2)),
 --e.DISPONIBLE,
    CAST(E.DISPOAVANT AS NUMBER(30, 2)),
    CAST(E.DISPOAPRES AS NUMBER(30, 2)),
    E.ETAT,
    NVL(CE.VAL, CE1.VAL)                                                                 AS CODEETABLISSEMENTLIB,
    NVL(P.DESIGNATION, P1.DESIGNATION)                                                   AS PROJETLIB,
    E.IDLC,
    LP.DESIGNATION                                                                       AS IDLCLIB,
    E.DATY,
    E.AVECFACTURE,
    CASE
      WHEN E.AVECFACTURE = 0 THEN
        'NON'
      WHEN E.AVECFACTURE = 1 THEN
        'OUI'
    END AS         AVECFACTURELIB,
    CAST(NVL(GR.MONTANT, 0) AS NUMBER(30, 2))                                            AS MONTANTOP,
    CAST(E.MONTANT- NVL(ENG.MONTANTTAUX, 0)-NVL(LEB.MONTANTLIBERER, 0) AS NUMBER(30, 2)) AS DISPONIBLE,
    E.TIERS,
    T.NOM                                                                                AS TIERSLIB,
    E.NUM,
    E.OBSERVATION,
    E.ANNEE,
    E.DATEIMPRESSION,
    CAST(LEB.MONTANTRESTE AS NUMBER(30, 2)),
    CAST (NVL(LEB.MONTANTLIBERER, 0) AS NUMBER(30, 2))                                   AS MONTANTLIBERER,
    LC.COMPTE,
    E.CHANTIER,
    E.OBJET,
    E.DUREE,
    e.idavenant,
    	CASE 
	WHEN u.LOGINUSER IS NOT NULL THEN (u.LOGINUSER ||' - '||u.NOMUSER) 
	ELSE null
	END AS IDUSER 
  FROM
    ENGAGEMENT                  E
    JOIN LIAISONENGAGEMENT_RESTE LEB
    ON LEB.IDENGAGEMENT =E.ID LEFT JOIN CODEETABLISSEMENT CE
    ON CE.ID = E.CODEETABLISSEMENT
    LEFT JOIN PROJET P
    ON P.ID = E.PROJET
    LEFT JOIN LIGNECREDITDEPENSE LP
    ON E.IDLC = LP.ID
    LEFT JOIN CODEETABLISSEMENT CE1
    ON CE1.ID = LP.CODEETABLISSEMENT
    LEFT JOIN PROJET P1
    ON P1.ID = LP.PROJET
    LEFT JOIN ENGAGEMENTOPMONTANT GR
    ON GR.IDENGAGEMENT = E.ID
    LEFT JOIN FACTFOURN_ENGAGEMENT ENG
    ON ENG.IDENGAGEMENT = E.ID
 --LEFT JOIN LIBERER_MONTANT lib ON
 --	lib.IDENGAGEMENT = e.ID
    LEFT JOIN FOURNISSEUR_UNION_PERSONNEL T
    ON T.ID = E.TIERS
    LEFT JOIN LIGNECREDITDEPENSE LC
    ON E.IDLC = LC.ID
LEFT JOIN UTILISATEUR u ON u.REFUSER = e.IDUSER 
;


CREATE OR REPLACE  VIEW FCFILLECOMPLETNPENTRE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MONTANTAVOIRAVECTSAUX, MONTANTAVTTCAVECTAUX, MONTANTAVTVAAVECTAUX, CODE, NUMPIECE, CDCLT,escale,designationmere) AS 
  SELECT
        FCF.ID,
        FCF.IDMERE,
        FCF.DESIGNATION,
        FCF.QUANTITE,
        FCF.PU,
        FCF.COMPTE,
        FCF.IDPRODUIT,
        FCF.DEVISE,
        FCF.TAUX,
        FCF.IDACTIVITE,
        FCF.TVA,
        FCF.DATEFACT,
        FCF.RUBRIQUE,
        EXTRACT(MONTH FROM FC.DATY)                                                                                                                                                                                                                                         AS MOIS,
        EXTRACT(YEAR FROM FC.DATY)                                                                                                                                                                                                                                          AS ANNEE,
        FCF.HEUREDEBUT,
        FCF.HEUREFIN,
        FCF.REDUCTION,
        FCF.MAJORATION,
        FCF.TEST,
        FCF.RANG,
        FCF.DUREE,
        FCF.PU * FCF.QUANTITE * FCF.TAUX * NVL(FCF.DUREE, 1)                                                                                                                                                                                                                AS MONTANTAV,
        DECODE(FCF.RUBRIQUE, NULL, A.RUBRIQUE, FCF.RUBRIQUE)                                                                                                                                                                                                                AS RUBRIQUECPL,
        FC.DATY,
        FC.TIERS,
        FC.IDCATEGORIE,
        FC.TYPE,
        FC.DEVISEMERE,
        FC.EXERCICE,
        FC.IDAVOIR,
        FC.ETAT,
        NVL(AV.MONTANTSANSTAUX, 0)                                                                                                                                                                                                                                          AS MTAVOIR,
        FCF.PU * FCF.QUANTITE * FCF.TAUX * NVL(FCF.DUREE, 1) * NVL(FCF.REDUCTION, 0) / 100 AS MONTANTREDUCTION,
        FCF.PU * FCF.QUANTITE * FCF.TAUX * NVL(FCF.DUREE, 1) * NVL(FCF.MAJORATION, 0) / 100 AS MONTANTMAJORATION,
        FCF.PU * FCF.QUANTITE * FCF.TAUX * NVL(FCF.DUREE, 1) + (FCF.PU * FCF.QUANTITE * FCF.TAUX * NVL(FCF.DUREE, 1) * NVL(FCF.MAJORATION, 0)) / 100 - (FCF.PU * FCF.QUANTITE * FCF.TAUX * NVL(FCF.DUREE, 1) * NVL(FCF.REDUCTION, 0)) / 100 AS MONTANT,
        (FCF.PU * FCF.QUANTITE * FCF.TAUX * NVL(FCF.DUREE, 1) + (FCF.PU * FCF.QUANTITE * FCF.TAUX * NVL(FCF.DUREE, 1) * NVL(FCF.MAJORATION, 0)) / 100 - (FCF.PU * FCF.QUANTITE * FCF.TAUX * NVL(FCF.DUREE, 1) * NVL(FCF.REDUCTION, 0)) / 100) * NVL(FCF.TVA / 100, 0)       AS MONTANTTVA,
        (FCF.PU * FCF.QUANTITE * FCF.TAUX * NVL(FCF.DUREE, 1) + (FCF.PU * FCF.QUANTITE * FCF.TAUX * NVL(FCF.DUREE, 1) * NVL(FCF.MAJORATION, 0)) / 100 - (FCF.PU * FCF.QUANTITE * FCF.TAUX * NVL(FCF.DUREE, 1) * NVL(FCF.REDUCTION, 0)) / 100) * (1 + NVL(FCF.TVA / 100, 0)) AS MONTANTTTC,
        M.VAL                                                                                                                                                                                                                                                               AS MOISLIB,
        F.MONTANTHTSIMPLE,
        T.NOMCLT,
        CAST(NVL(AV.MONTANTAVECTSAUX, 0) AS NUMBER (30, 3))                                                                                                                                                                                                                 AS MONTANTAVOIRAVECTSAUX,
        CAST(NVL(AV.MONTANTTTC, 0) AS NUMBER (30, 3))                                                                                                                                                                                                                       AS MONTANTAVTTCAVECTAUX,
        CAST(NVL(AV.MONTANTTVA, 0) AS NUMBER (30, 3))                                                                                                                                                                                                                       AS MONTANTAVTVAAVECTAUX,
        FC.CODE,
        J.NUMPIECE,
        FUP.CDCLT,
        fc.escale,
        fc.designation as designationmere
    FROM
        FACTURE_CLIENT_FILLE        FCF
        JOIN FACTURECLIENT FC
        ON FCF.IDMERE = FC.ID LEFT JOIN ACTIVITE A
        ON A.ID = FCF.IDACTIVITE
        LEFT JOIN AVOIRFCAVECTAUX_GRP AV
        ON AV.IDDETAILFACTURE = FCF.ID
        LEFT JOIN MOIS M
        ON M.ID = EXTRACT(MONTH FROM FC.DATY)
        LEFT JOIN FACTURE_CLIENT_FILLETTC F
        ON F.ID = FCF.ID
        LEFT JOIN CLIENT_UNION T
        ON FC.TIERS = T.CDCLT
        LEFT JOIN PAIEMENTFACTURE P
        ON P.IDFACT= FC.ID
        LEFT JOIN JOURNALCAISSE J
        ON J.ID = P.IDMVT
        LEFT JOIN FOURNISSEUR_UNION_PERSONNEL FUP
        ON FUP.ID = FC.TIERS;


CREATE OR REPLACE  VIEW FCFILLECOMPLETNP (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MONTANTAVOIRAVECTSAUX, MONTANTAVTTCAVECTAUX, MONTANTAVTVAAVECTAUX, CODE, NUMPIECE, CDCLT,escale,designationmere) AS 
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
        MONTANTAVOIRAVECTSAUX,
        MONTANTAVTTCAVECTAUX,
        MONTANTAVTVAAVECTAUX,
        CODE,
        LISTAGG(NUMPIECE, ';') WITHIN GROUP (ORDER BY ID) AS NUMPIECE,
        CDCLT,
        escale,
        designationmere
    FROM
        FCFILLECOMPLETNPENTRE
    GROUP BY
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
        MONTANTAVOIRAVECTSAUX,
        MONTANTAVTTCAVECTAUX,
        MONTANTAVTVAAVECTAUX,
        CODE,
        CDCLT,
        escale,
        designationmere;


CREATE OR REPLACE  VIEW CAFCFILLECOMPLET_AVOIRNP3 (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MERECA, CODE, ETATLIB, NUMPIECE, CDCLT,escale,designationmere) AS 
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
        END                                       AS ETATLIB,
        FF.NUMPIECE,
        FF.CDCLT,
        ff.escale,
        designationmere
    FROM
        FCFILLECOMPLETNP FF
        LEFT JOIN COMPTECA CPTCA
        ON CPTCA.VAL=FF.COMPTE
        LEFT JOIN MERECA CPTM
        ON CPTM.ID=CPTCA.DESCE
    WHERE
        FF.IDCATEGORIE <> 'CATFCO2'
        AND FF.IDCATEGORIE <> 'CATFCO1';

CREATE OR REPLACE  VIEW CAFCFILLECOMPLET_AVOIRC3 (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MERECA, CODE, ETATLIB, NUMPIECE, CDCLT,escale,designationmere) AS 
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
        CAST(MONTANTAV AS NUMBER(30, 2)),
        RUBRIQUECPL,
        DATY,
        TIERS,
        IDCATEGORIE,
        TYPE,
        DEVISEMERE,
        EXERCICE,
        IDAVOIR,
        ETAT,
        CAST(MTAVOIR AS NUMBER(30, 2)),
        CAST(MONTANTREDUCTION AS NUMBER(30, 2)),
        CAST(MONTANTMAJORATION AS NUMBER(30, 2)),
        CAST(MONTANT AS NUMBER(30, 2)),
        CAST(MONTANTTVA AS NUMBER(30, 2)),
        CAST(MONTANTTTC AS NUMBER(30, 2)),
        MOISLIB,
        CAST(MONTANTHTSIMPLE AS NUMBER(30, 2)),
        CLIENT,
        MERECA,
        CODE,
        ETATLIB,
        NUMPIECE,
        CDCLT,
        escale,
        designationmere
    FROM
        CAFCFILLECOMPLET_AVOIRNP3
    WHERE
        ETAT = 1;

CREATE OR REPLACE  VIEW CAFCFILLECOMPLET_AVOIRV3 (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MERECA, CODE, ETATLIB, NUMPIECE, CDCLT,escale,designationmere) AS 
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
        CAST(MONTANTAV AS NUMBER(30, 2)),
        RUBRIQUECPL,
        DATY,
        TIERS,
        IDCATEGORIE,
        TYPE,
        DEVISEMERE,
        EXERCICE,
        IDAVOIR,
        ETAT,
        CAST(MTAVOIR AS NUMBER(30, 2)),
        CAST(MONTANTREDUCTION AS NUMBER(30, 2)),
        CAST(MONTANTMAJORATION AS NUMBER(30, 2)),
        CAST(MONTANT AS NUMBER(30, 2)),
        CAST(MONTANTTVA AS NUMBER(30, 2)),
        CAST(MONTANTTTC AS NUMBER(30, 2)),
        MOISLIB,
        CAST(MONTANTHTSIMPLE AS NUMBER(30, 2)),
        CLIENT,
        MERECA,
        CODE,
        ETATLIB,
        NUMPIECE,
        CDCLT,
        escale,
        designationmere
    FROM
        CAFCFILLECOMPLET_AVOIRNP3
    WHERE
        ETAT = 11;

CREATE OR REPLACE  VIEW CAFCFILLECOMPLET_AVOIRANNULE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MERECA, CODE, ETATLIB, NUMPIECE, CDCLT,escale,designationmere) AS 
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
        NUMPIECE,
        CDCLT,
        escale,
        designationmere
    FROM
        CAFCFILLECOMPLET_AVOIRNP3 C
    WHERE
        ETAT=0;
