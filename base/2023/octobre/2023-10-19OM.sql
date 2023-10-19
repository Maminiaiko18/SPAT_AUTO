ALTER TABLE ORDRE_MISSION ADD DATEARRIVEE DATE;

CREATE OR REPLACE VIEW ORDRE_MISSION_LIB (
    ID,
    IDINDEMNITEMISSION,
    IDINDEMNITEMISSIONLIB,
    IDTIERS,
    MOTIFVOYAGE,
    LIEUDEPLACEMENT,
    DUREE,
    DATEDEPART,
    NUMOM,
    ESTFORFAITAIRE,
    IDUSER,
    ESTFORFAITAIRELIB,
    ETAT,
    ETATLIB,
    NOM,
    PRENOM,
    FONCTION,
    MATRICULE,
    IDMOYENDEPLACEMENT,
    IDMOYENDEPLACEMENTLIB,
    DIRECTION,
    INDEMNITEMISSION,
    DATEARRIVEE
) AS
    SELECT
        OM.ID,
        CP.DESCE                                                                              AS IDINDEMNITEMISSION,
        CP.VAL                                                                                AS IDINDEMNITEMISSIONLIB,
        OM.IDTIERS,
        OM.MOTIFVOYAGE,
        OM.LIEUDEPLACEMENT,
        OM.DUREE,
        OM.DATEDEPART,
        OM.NUMOM,
        OM.ESTFORFAITAIRE,
        OM.IDUSER,
        CASE
            WHEN OM.ESTFORFAITAIRE = 1 THEN
                'oui'
            WHEN OM.ESTFORFAITAIRE = -1 THEN
                'non'
        END AS ESTFORFAITAIRELIB,
        OM.ETAT,
        CASE
            WHEN OM.ETAT = 1 THEN
                'crée'
            WHEN OM.ETAT = 11 THEN
                'validée'
        END AS                ETATLIB,
        I.NOM,
        I.PRENOM,
        I.POSTE                                                                               AS FONCTION,
        I.NUMERO_MATRICULE                                                                    AS MATRICULE,
        OM.IDMOYENDEPLACEMENT,
        MO.VAL                                                                                AS IDMOYENDEPLACEMENTLIB,
        DIR.LIBELLEDIR                                                                        AS DIRECTION,
        IM.ID                                                                                 AS INDEMNITEMISSION,
        OM.DATEARRIVEE
    FROM
        ORDRE_MISSION           OM
        LEFT JOIN INFOPERSONNELGLOBAL I
        ON I.IDTIERS = OM.IDTIERS
        LEFT JOIN INDEMNITE_MISSION IM
        ON IM.ID = OM.IDINDEMNITEMISSION
        LEFT JOIN CATEGORIE_PROFESSIONNEL CP
        ON CP.ID = IM.IDCATEGORIEPROFESSIONNEL
        LEFT JOIN MOYEN_DEPLACEMENT MO
        ON MO.ID = OM.IDMOYENDEPLACEMENT
        LEFT JOIN DIRECTION DIR
        ON DIR.IDDIR=I.DIRECTION;