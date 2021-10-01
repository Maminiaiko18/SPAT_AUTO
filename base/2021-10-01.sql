CREATE OR REPLACE VIEW FACT_CLT_FILL_LIB_REST_TAXE
(
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
   DATY
)
AS
   SELECT fc.ID,
          fc.IDMERE,
          fc.DESIGNATION,
          fc.QUANTITE,
          fc.PU,
          fc.COMPTE,
          pr.NOM AS IDPRODUIT,
          fc.DEVISE,
          fc.TAUX,
          CAST (NVL (gr.QUANTITE, 0) AS NUMBER (10, 2)) AS qteLivree,
          CAST (fc.QUANTITE - NVL (gr.QUANTITE, 0) AS NUMBER (10, 2))
             AS resteAlivrer,
          CAST (fcm.MONTANTTAUX AS NUMBER (32, 3)) AS MONTANTTAUX,
          CAST (fcm.MONTANT AS NUMBER (32, 5)) AS MONTANT,
          CAST (fcm.MONTANTAVOIRSANSTAUX AS NUMBER (32, 3))
             AS MONTANTAVOIRSANSTAUX,
          CAST (fcm.MONTANTAVOIRAVECTAUX AS NUMBER (32, 3))
             AS MONTANTAVOIRAVECTAUX,
          CAST (fcm.tva AS NUMBER (20, 3)) AS tva,
          fc.idactivite,
          ra.DESIGNATION AS activitelib,
          fc.mois,
          fc.annee,
          fc.heureDebut,
          fc.heureFin,
          mois.VAL AS moislib,
          CAST (0 AS NUMBER (32, 2)) AS tauxEuro,
          CAST (0 AS NUMBER (32, 2)) AS montantHTEuro,
          CAST (0 AS NUMBER (32, 2)) AS montantTVAEuro,
          CAST ( (fc.pu * fc.QUANTITE * fc.TVA) / 100 AS NUMBER (20, 3))
             AS montanttaxe,
          NVL (fc.majoration, 0) AS majoration,
          NVL (fc.reduction, 0) AS reduction,
          fc.DATEFACT,
          fc.RUBRIQUE,
          CASE WHEN fc.IDACTIVITE IS NOT NULL THEN r.RANG END AS rang,
          CASE WHEN fc.IDACTIVITE IS NOT NULL THEN ra.DATY END AS daty
     FROM facture_client_fille fc
          LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
          LEFT JOIN as_bondelivraison_cl_grp gr
             ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
          LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
          LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
          LEFT JOIN mois ON mois.id = fc.mois
          LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE;
		  
CREATE TABLE PAIEMENTFACTURE
(
  ID       VARCHAR2(100 BYTE),
  IDMVT    VARCHAR2(50 BYTE),
  IDFACT   VARCHAR2(500 BYTE),
  MONTANT  NUMBER(30,3)
)   ;
ALTER TABLE PAIEMENTFACTURE ADD (
  CONSTRAINT PK_PAIEMENTFACTURE
  PRIMARY KEY
  (ID));

ALTER TABLE PAIEMENTFACTURE ADD (
  CONSTRAINT FK_PAIEMENTFACT_FACTURECLIENT 
  FOREIGN KEY (IDFACT) 
  REFERENCES FACTURECLIENT (ID)
  ENABLE VALIDATE,
  CONSTRAINT FK_PAIEMENTFACT_JOURNALCAISSE 
  FOREIGN KEY (IDMVT) 
  REFERENCES JOURNALCAISSE (ID)
  ENABLE VALIDATE);
  
CREATE OR REPLACE  VIEW PAIEMENTFACTURESUM
(
   MONTANT,
   IDFACT
)
AS
     SELECT SUM (montant) AS montant, idfact
       FROM paiementfacture
   GROUP BY idfact;		  

/* Formatted on 01/10/2021 02:40:19 (QP5 v5.256.13226.35538) */
CREATE OR REPLACE  VIEW FACTURECLIENTMSUM_LIB
(
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
   CODEPROVISION
)
AS
   SELECT m.ID,
          m.DATY,
          m.TIERS,
          m.DESIGNATION,
          m.TYPE,
          m.TVA,
          '--' || m.remarque AS remarque,
          m.IDUSER,
          m.DATE_ECHEANCE,
          m.ETAT,
          m.idprevision,
          CAST (m.MONTANT AS NUMBER (32, 3)),
          CAST (M.MONTANTTVA AS NUMBER (32, 3)),
          CAST (M.MONTANTAVOIR AS NUMBER (32, 3)),
          CAST (M.MONTANTTTC AS NUMBER (32, 3)),
          CAST (NVL (pf.montant, 0) AS NUMBER (32, 3)) AS montantpaye,
          CAST (M.MONTANTTTC - NVL (pf.montant, 0) AS NUMBER (32, 3))
             AS montantreste,
          fup.NOM AS tierslib,
          fup.CONTACT,
          fup.ADRESSE,
          M.ESCALE,
          TYPELIB,
          m.IDCATEGORIE,
          m.CATEGORIELIB,
          IDPROVISION,
          IDPROVISIONLIB,
          m.ESTDDPMICTSL,
          m.devisemere,
          m.codePrestation,
          m.codePrestationlib,
          m.CODE,
          m.ESTMICTSL,
          codeprovision
     FROM factureclientMSum m
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
          LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id;
		  
CREATE OR REPLACE  VIEW ACTIVITELIBCOMPLET
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
   POSTE,
   POSTELIB,
   DATEDEBUT,
   HEUREDEBUT,
   DATEFIN,
   HEUREFIN,
   VOLUME,
   VOLUMEARRONDI,
   CARGAISON,
   IDPRESTATION,
   ESTNATIONAL,
   ESTJOUR,
   ESTFERIE,
   MANOEUVRE,
   ESTWEEKEND,
   NATUREOPERATION,
   NBQUARTHEURE,
   NBHEURE,
   NBJOUR,
   TYPEQUAIS,
   SURFACE,
   NB5JOURS,
   QUAI,
   FLOTTE,
   CATEGORIE_FLOTTE,
   UNITELIB,
   ESTPETROLIER,
   VOLUMERUBRIQUE
)
AS
   SELECT ac.ID,
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
          CAST ('-' AS VARCHAR2 (100)) AS autres,
          ra.pu,
          ra.devise,
          ra.compte,
          ra.unite,
          ra.direction,
          ra.condition,
          ra.tva,
          ra.objet,
          ra.redevance,
          fup.NOM AS clientlib,
          re.VAL AS redevancelib,
          di.LIBELLEDIR AS directionlib,
          CASE
             WHEN ac.etat = 1 THEN 'CREE(E)'
             WHEN AC.ETAT = 11 THEN 'VISE(E)'
             WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
          END
             AS ETATLIB,
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
          CAST (nv.lm * nv.lht * nv.te AS NUMBER (10, 3)) AS volume,
          CAST (ROUND ( (nv.lm * nv.lht * nv.te) / 100) AS NUMBER (10, 3))
             AS volumeArrondi,
          NVL (pre.cargaison, '-') AS cargaison,
          pre.id AS idprestation,
          CASE
             WHEN    nv.pavillon = 'PAYS000054'
                  OR nv.pavillon = 'PAYS000010'
                  OR nv.pavillon = 'PAYS000057'
             THEN
                'National'
             WHEN    nv.pavillon != 'PAYS000054'
                  OR nv.pavillon != 'PAYS000010'
                  OR nv.pavillon != 'PAYS000057'
             THEN
                'International'
          END
             AS estNational,
          CASE
             WHEN ac.heuredebut BETWEEN '05:00:00' AND '19:00:00' THEN 'JOUR'
             ELSE 'NUIT'
          END
             AS estJour,
          CASE
             WHEN ac.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
             ELSE 'NONFERIE'
          END
             AS estFerie,
          occ.idmanoeuvrebord AS manoeuvre,
          CASE
             WHEN    TO_CHAR (ac.daty, 'DAY') = 'DIMANCHE'
                  OR TO_CHAR (ac.daty, 'DAY') = 'SAMEDI'
             THEN
                'weekend'
             ELSE
                'normal'
          END
             AS estWeekend,
          occ.IDNATUREOPERATION AS natureoperation,
          CASE
             WHEN   (  (  60
                        * 24
                        * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss')))
                     - 60)
                  / 15 < 0
             THEN
                0
             ELSE
                ROUND (
                     (  (  60
                         * 24
                         * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                       'dd-mm-yy hh24:mi:ss')
                            - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                       'dd-mm-yy hh24:mi:ss')))
                      - 60)
                   / 15)
          END
             AS nbQuartHeure,
          CASE
             WHEN   24
                  * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                'dd-mm-yy hh24:mi:ss')
                     - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                'dd-mm-yy hh24:mi:ss')) < 0
             THEN
                0
             ELSE
                ROUND (
                       24
                     * (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                   'dd-mm-yy hh24:mi:ss')
                        - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                   'dd-mm-yy hh24:mi:ss'))
                   + 1)
          END
             AS nbHeure,
          CASE
             WHEN (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                              'dd-mm-yy hh24:mi:ss')
                   - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                              'dd-mm-yy hh24:mi:ss')) < 0
             THEN
                0
             WHEN ROUND (
                     (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                 'dd-mm-yy hh24:mi:ss')
                      - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                 'dd-mm-yy hh24:mi:ss'))) = 0
             THEN
                1
             ELSE
                CASE
                   WHEN ROUND (
                             TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss')) <
                           ROUND (
                              (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                          'dd-mm-yy hh24:mi:ss')
                               - TO_DATE (
                                    ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                    'dd-mm-yy hh24:mi:ss')),
                              1)
                   THEN
                        ROUND (
                             TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss'))
                      + 1
                   ELSE
                        ROUND (
                             TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss'))
                      + 1
                END
          END
             AS nbJour,
          q.typequais,
          CAST (nv.LHT * nv.lm AS NUMBER (20, 2)) AS surface,
          CASE
             WHEN (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                              'dd-mm-yy hh24:mi:ss')
                   - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                              'dd-mm-yy hh24:mi:ss')) < 0
             THEN
                0
             ELSE
                CASE
                   WHEN ROUND (
                           (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                       'dd-mm-yy hh24:mi:ss')
                            - TO_DATE (ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                       'dd-mm-yy hh24:mi:ss'))) BETWEEN 0
                                                                    AND 5
                   THEN
                      1
                   ELSE
                      ROUND (
                           TRUNC (
                                (  TO_DATE (ac.DATEFIN || ' ' || ac.HEUREFIN,
                                            'dd-mm-yy hh24:mi:ss')
                                 - TO_DATE (
                                      ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss'))
                              / 5)
                         + 1)
                END
          END
             AS nb5jours,
          pd2.QUAI,
          occ.IDMATERIEL_NAVAL AS flotte,
          cm.IDCATEGORIE AS categorie_flotte,
          ua.VAL AS unitelib,
          CASE WHEN nv.TYPE = 'TP0001' THEN 'TRUE' ELSE 'FALSE' END
             AS estPetrolier,
          RA.VOLUME AS volumeRubrique
     FROM ACTIVITE ac
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
          LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
          LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
          LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
          LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
          LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
          LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
          LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
          LEFT JOIN UNITE_ACTIVITE ua ON ua.ID = ra.UNITE
          LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
          LEFT JOIN quais q ON q.id = pd2.quai
          LEFT JOIN occupationmaterielnaval occ ON occ.id = ac.REFOBJET
          LEFT JOIN MATERIEL_NAVAL cm ON cm.id = occ.IDMATERIEL_NAVAL;	  
CREATE OR REPLACE  VIEW FACTUREFILLEACTIVITEPRESTATION
(
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
   IDPRESTATION
)
AS
   SELECT fcf."ID",
          fcf."IDMERE",
          fcf."DESIGNATION",
          fcf."QUANTITE",
          fcf."PU",
          fcf."COMPTE",
          fcf."IDPRODUIT",
          fcf."DEVISE",
          fcf."TAUX",
          fcf."IDACTIVITE",
          fcf."TVA",
          fcf."DATEFACT",
          fcf."RUBRIQUE",
          occ.id AS idprestation
     FROM FACTURE_CLIENT_FILLE_VM fcf
          LEFT JOIN ACTIVITE ac ON fcf.IDACTIVITE = ac.ID
          LEFT JOIN OCCUPATIONMATERIELNAVAL occ ON occ.ID = ac.REFOBJET;	
CREATE OR REPLACE VIEW OCCUPATIONMATERIELNAVALFACTURE
(
   ID,
   DATY,
   IDMATERIEL_NAVAL,
   IDPILOTE,
   IDCOMMANDANT,
   IDNATUREOPERATION,
   IDMANOEUVREBORD,
   HEUREDEBUT,
   HEUREFIN,
   IDNAVIRE,
   IDCLIENT,
   DUREE,
   POSITION,
   OBSERVATION,
   ETAT,
   DATEFIN,
   IDARRIVEE,
   IDPREVISION,
   IDFACTUREFILLE,
   IDFACTUREMERE
)
AS
   SELECT o."ID",
          o."DATY",
          o."IDMATERIEL_NAVAL",
          o."IDPILOTE",
          o."IDCOMMANDANT",
          o."IDNATUREOPERATION",
          o."IDMANOEUVREBORD",
          o."HEUREDEBUT",
          o."HEUREFIN",
          o."IDNAVIRE",
          o."IDCLIENT",
          o."DUREE",
          o."POSITION",
          o."OBSERVATION",
          o."ETAT",
          o."DATEFIN",
          o."IDARRIVEE",
          o."IDPREVISION",
          c.id AS idfacturefille,
          c.IDMERE AS idfacturemere
     FROM occupationmaterielnaval o
          JOIN factureFilleActivitePrestation c ON c.idprestation = o.id;		


/* Formatted on 01/10/2021 03:14:30 (QP5 v5.256.13226.35538) */
CREATE OR REPLACE  VIEW OCCUPMATERIELNONAVALNFACTURE
(
   ID,
   IDMATERIEL_NAVAL,
   IDPILOTE,
   IDCOMMANDANT,
   IDNATUREOPERATION,
   IDMANOEUVREBORD,
   IDNAVIRE,
   POSITION,
   OBSERVATION,
   ETAT,
   IDARRIVEE,
   IDARRIVEELIB,
   POSITIONLIB,
   DUREE,
   DATY,
   HEUREDEBUT,
   DATEFIN,
   HEUREFIN,
   ETATLIB,
   IDPREVISION,
   COMMANDANTID
)
AS
   SELECT "ID",
          "IDMATERIEL_NAVAL",
          "IDPILOTE",
          "IDCOMMANDANT",
          "IDNATUREOPERATION",
          "IDMANOEUVREBORD",
          "IDNAVIRE",
          "POSITION",
          "OBSERVATION",
          "ETAT",
          "IDARRIVEE",
          "IDARRIVEELIB",
          "POSITIONLIB",
          "DUREE",
          "DATY",
          "HEUREDEBUT",
          "DATEFIN",
          "HEUREFIN",
          "ETATLIB",
          "IDPREVISION",
          "COMMANDANTID"
     FROM OCCUPMATERIELNAVALLIBV
    WHERE ID NOT IN (SELECT id FROM OCCUPATIONMATERIELNAVALFACTURE);
	
--
CREATE OR REPLACE VIEW ACTIVITESNONFACTUREES
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
   POSTE,
   POSTELIB,
   DATEDEBUT,
   HEUREDEBUT,
   DATEFIN,
   HEUREFIN,
   VOLUME,
   VOLUMEARRONDI,
   CARGAISON,
   IDPRESTATION,
   ESTNATIONAL,
   ESTJOUR,
   ESTFERIE,
   MANOEUVRE,
   ESTWEEKEND,
   NATUREOPERATION,
   NBQUARTHEURE,
   NBHEURE,
   NBJOUR,
   TYPEQUAIS,
   SURFACE,
   NB5JOURS,
   QUAI,
   FLOTTE,
   CATEGORIE_FLOTTE,
   UNITELIB
)
AS
   SELECT "ID",
          "DESIGNATION",
          "CLIENT",
          "RUBRIQUE",
          "QTE",
          "MOIS",
          "MOISLIB",
          "ANNEE",
          "DATY",
          "BATEAU",
          "ETAT",
          "RUBRIQUELIB",
          "NAVIRE",
          "BATEAULIB",
          "POIDS",
          "LONGUEUR",
          "LARGEUR",
          "AUTRES",
          "PU",
          "DEVISE",
          "COMPTE",
          "UNITE",
          "DIRECTION",
          "CONDITION",
          "TVA",
          "OBJET",
          "REDEVANCE",
          "CLIENTLIB",
          "REDEVANCELIB",
          "DIRECTIONLIB",
          "ETATLIB",
          "CATEGORIE",
          "CATEGORIELIB",
          "REFOBJET",
          "TYPESOURCE",
          "DATEFACT",
          "POSTE",
          "POSTELIB",
          "DATEDEBUT",
          "HEUREDEBUT",
          "DATEFIN",
          "HEUREFIN",
          "VOLUME",
          "VOLUMEARRONDI",
          "CARGAISON",
          "IDPRESTATION",
          "ESTNATIONAL",
          "ESTJOUR",
          "ESTFERIE",
          "MANOEUVRE",
          "ESTWEEKEND",
          "NATUREOPERATION",
          "NBQUARTHEURE",
          "NBHEURE",
          "NBJOUR",
          "TYPEQUAIS",
          "SURFACE",
          "NB5JOURS",
          "QUAI",
          "FLOTTE",
          "CATEGORIE_FLOTTE",
          "UNITELIB"
     FROM ACTIVITELIBCOMPLET ac
    WHERE id NOT IN (SELECT idactivite
                       FROM facture_client_fille_vm
                      WHERE ac.id = IDACTIVITE); 

--
CREATE TABLE EDITIONMICTSLVIDE
(
  ID               VARCHAR2(100 BYTE),
  DATY             DATE,
  TYPE             VARCHAR2(500 BYTE),
  NOTEEXPLICATIVE  VARCHAR2(500 BYTE),
  MOIS             NUMBER(10),
  ANNEE            NUMBER(10)
);
ALTER TABLE EDITIONMICTSLVIDE ADD (
  CONSTRAINT PK_EDITIONMICTSLVIDE
  PRIMARY KEY
  (ID));
  
CREATE TABLE CODE_RUBRIQUE_MICTSL
(
  ID     VARCHAR2(100 BYTE),
  VAL    VARCHAR2(500 BYTE),
  DESCE  VARCHAR2(500 BYTE)
) ;
ALTER TABLE CODE_RUBRIQUE_MICTSL ADD (
  CONSTRAINT CODE_RUBRIQUE_MICTSL_PK
  PRIMARY KEY
  (ID));
  

Insert into CODE_RUBRIQUE_MICTSL
   (ID, VAL, DESCE)
 Values
   ('CRM2', 'RB0000000027173349', 'RV');
Insert into CODE_RUBRIQUE_MICTSL
   (ID, VAL, DESCE)
 Values
   ('CRM3', 'RB0000000026172740', 'RF');

create or replace view paiementFC as
   select
    jc.id,
    JC.DATEEFFET,
    jc.caisse,
    jc.tierslib,
    jc.libelle,
    pf.montant,
    pf.idfact
    from 
   journalcaisselib_vise jc
   left join paiementfacture pf
   on pf.idmvt=jc.id;
  
		  
		  