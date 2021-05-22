drop table detFormuFact;
CREATE TABLE DETFORMUFACT
(
  ID                VARCHAR2(100 BYTE),
  MIN               NUMBER(10,2),
  MAX               NUMBER(10,2),
  FORMULE           VARCHAR2(4000 BYTE),
  UNITE             VARCHAR2(400 BYTE),
  REM          VARCHAR2(400 BYTE),
  MERE              VARCHAR2(100 BYTE),
  CONDITION  VARCHAR2(100 BYTE),
FORMULEQTE VARCHAR2(4000 BYTE)
);





ALTER TABLE DETFORMUFACT ADD (
  CONSTRAINT DETFORMUFACT_PK
  PRIMARY KEY
  (ID));
  
update menudynamique set href='/spat/pages/globalnegoce.jsp?but=exploitants/activites-saisie.jsp' where id='MEN00741001';
update menudynamique set href='/spat/pages/globalnegoce.jsp?but=exploitants/activites-liste.jsp' where id='MEN00741002'; 

Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CODE, CATEGORIE, REDEVANCE, 
    PU, DEVISE, UNITE, TVA)
 Values
   ('rub4', 'Transbordement 20 pied vide', 'T20V', 'CATFC002', 'REDV002', 
    1, 'Eur', 'UA001', 20);
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CODE, CATEGORIE, REDEVANCE, 
    PU, DEVISE, UNITE, TVA)
 Values
   ('rub3', 'Embarquement 20 pied vide', 'E20V', 'CATFC002', 'REDV002', 
    2, 'Eur', 'UA001', 20);
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CODE, CATEGORIE, REDEVANCE, 
    PU, DEVISE, UNITE, TVA)
 Values
   ('rub2', 'Debarquement 20 pied vide', 'D20V', 'CATFC002', 'REDV002', 
    5, 'Eur', 'UA001', 20);
Insert into RUBRIQUE_ACTIVITE
   (ID, DESIGNATION, CODE, CATEGORIE, REDEVANCE, 
    PU, DEVISE, UNITE, OBJET, TVA)
 Values
   ('rub1', 'Occupation Q2', 'OQ2', 'CATFC001', 'REDV002', 
    10, 'Eur', 'UA002', 'Q2', 20);
COMMIT;



CREATE OR REPLACE FORCE VIEW ACTIVITELIBCOMPLET
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
   categorieLib
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
          cf.val as categorieLib
     FROM ACTIVITE ac
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
          LEFT JOIN NAVIRE nv ON nv.ID = ac.BATEAU
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
          LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
          LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
          LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
          LEFT JOIN CategorieFacturation cf on ra.categorie=cf.id;

ALTER TABLE FACTURE_CLIENT_FILLE
ADD (tva NUMBER(20,2));

CREATE OR REPLACE FORCE VIEW FACTURE_CLIENT_MERE_FILLE
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
   DATY,
   TIERS,
   DESIGNATIONMERE,
   TYPE,
   TVA,
   REMARQUE,
   IDUSER,
   DATE_ECHEANCE,
   ETAT
)
AS
   SELECT fi."ID",
          fi."IDMERE",
          fi."DESIGNATION",
          fi."QUANTITE",
          fi."PU",
          fi."COMPTE",
          fi."IDPRODUIT",
          fi."DEVISE",
          fi."TAUX",
          fc.daty,
          fc.tiers,
          fc.designation AS designationmere,
          fc.TYPE,
          nvl(fi.tva,20),
          fc.remarque,
          fc.iduser,
          fc.date_echeance,
          fc.etat
     FROM facture_client_fille fi
          LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;

CREATE OR REPLACE FORCE VIEW FACTURE_CLIENT_GRP
(
   MONTANT,
   MONTANTTAUX,
   MONTANTAVOIRSANSTAUX,
   MONTANTAVOIRAVECTAUX,
   montantTva,
   IDMERE
)
AS
     SELECT SUM (fm.MONTANT) AS montant,
            SUM (fm.montanttaux) AS montanttaux,
            SUM (fm.MONTANTAVOIRSANSTAUX) AS MONTANTAVOIRSANSTAUX,
            SUM (fm.montantavoiravectaux) AS montantavoiravectaux,
            cast (sum(fm.montanttaux*fm.tva/100) as NUMBER(20,2)) as montantTva,
            fm.idmere
       FROM facture_client_montant fm
   GROUP BY fm.idmere;
		  
CREATE OR REPLACE FORCE VIEW FACTURECLIENTMSUM
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
   MONTANT,
   MONTANTTVA,
   MONTANTAVOIR,
   MONTANTTTC
)
AS
   SELECT fc.ID,
          fc.DATY,
          fc.TIERS,
          fc.DESIGNATION,
          fc.TYPE,
          fc.TVA,
          fc.REMARQUE,
          fc.IDUSER,
          fc.DATE_ECHEANCE,
          fc.ETAT,
          CAST (NVL (grp.montanttaux, 0) AS NUMBER (30, 2)) AS montant,
          CAST (NVL (grp.MONTANTTVA, 0) AS NUMBER (30, 2))
             AS montanttva,
          NVL (grp.montantavoiravectaux, 0) AS montantavoir,
          CAST (
               NVL ( NVL (grp.MONTANTTVA, 0) + grp.montanttaux,
                    0)
             - NVL (grp.montantavoiravectaux, 0) AS NUMBER (30, 2))
             AS MONTANTTTC
     FROM FACTURECLIENT fc
          LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id;

