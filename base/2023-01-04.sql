CREATE OR REPLACE VIEW FACTURE_CLIENT_MERE_FILLE as
SELECT fi.ID,
       fi.IDMERE,
       fi.DESIGNATION,
       fi.QUANTITE,
       fi.PU,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fc.daty,
       fc.tiers,
       fc.designation              AS designationmere,
       fc.TYPE,
       DECODE(fi.tva, NULL, fc.tva, fi.tva) AS tva,
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.IDPREVISION,
       NVL(fi.REDUCTION, 0)        AS REDUCTION,
       NVL(fi.MAJORATION, 0)       AS MAJORATION,
       fi.IDACTIVITE,
       fi.DATEFACT,
       fi.RUBRIQUE,
       IDAVOIR,
       DUREE,
       fi.MOIS,
       fi.ANNEE,
       EXTRACT(MONTH FROM fc.daty) AS moisM,
       EXTRACT(YEAR FROM fc.daty)  AS anneeM,
       fi.RANG,
       fi.HEUREDEBUT,
       fi.HEUREFIN,
       fi.DATY as datyactivite,  
       ua.val AS unite
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id
        LEFT JOIN RUBRIQUE_ACTIVITE ra ON fi.RUBRIQUE = ra.ID 
       LEFT JOIN UNITE_ACTIVITE ua ON ua.ID = ra.UNITE;


CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANT AS SELECT fm.ID,
       fm.IDMERE,
       fm.DESIGNATION,
       fm.QUANTITE,
       fm.PU,
       fm.COMPTE,
       fm.IDPRODUIT,
       fm.DEVISE,
       fm.TAUX,
       fm.DATY,
       fm.TIERS,
       fm.DESIGNATIONMERE,
       fm.TYPE,
       fm.TVA,
       fm.REMARQUE,
       fm.IDUSER,
       fm.DATE_ECHEANCE,
       fm.ETAT,
       IDPREVISION,
       IDPROVISION,
       IDCATEGORIE,
       CAST(fm.pu * fm.quantite * NVL(duree, 1) AS NUMBER(30, 3))
                               AS Montant,
       CAST(
                       ((fm.pu * fm.quantite) * fm.taux)
                       - NVL(
                                       ((fm.pu * fm.quantite * NVL(duree, 1)) * fm.taux)
                                       * fm.REDUCTION
                                   / 100,
                                       0)
                   + NVL(
                                       ((fm.pu * fm.quantite * NVL(duree, 1)) * fm.taux)
                                       * fm.MAJORATION
                                   / 100,
                                       0) AS NUMBER(30, 3))
                               AS montanttaux,
       NVL(montantsanstaux, 0) AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 3))
                               AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)   AS MAJORATION,
       NVL(fm.REDUCTION, 0)    AS REDUCTION,
       CAST(
               NVL(
                               ((fm.pu * fm.quantite * NVL(duree, 1)) * fm.taux)
                               * fm.MAJORATION
                           / 100,
                               0) AS NUMBER(30, 3))
                               AS montantMajoration,
       CAST(
               NVL(
                               ((fm.pu * fm.quantite * NVL(duree, 1)) * fm.taux)
                               * fm.REDUCTION
                           / 100,
                               0) AS NUMBER(30, 3))
                               AS montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE,
       IDAVOIR,
       CAST(
                       ((fm.pu * fm.quantite) * fm.taux)
                       - NVL(
                                       ((fm.pu * fm.quantite * NVL(duree, 1)) * fm.taux)
                                       * fm.REDUCTION
                                   / 100,
                                       0)
                   + NVL(
                                       ((fm.pu * fm.quantite * NVL(duree, 1)) * fm.taux)
                                       * fm.MAJORATION
                                   / 100,
                                       0) AS NUMBER(30, 3))
           * fm.tva
           / 100
                               AS montanttauxtva,
       fm.RANG,
       fm.mois,
       fm.annee,
       fm.duree,
       fm.HEUREDEBUT,
       fm.HEUREFIN,
       fm.datyactivite,
       fm.unite
FROM facture_client_Mere_fille fm
         LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;

CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANT AS SELECT fm.ID,
       fm.IDMERE,
       fm.DESIGNATION,
       fm.QUANTITE,
       fm.PU,
       fm.COMPTE,
       fm.IDPRODUIT,
       fm.DEVISE,
       fm.TAUX,
       fm.DATY,
       fm.TIERS,
       fm.DESIGNATIONMERE,
       fm.TYPE,
       fm.TVA,
       fm.REMARQUE,
       fm.IDUSER,
       fm.DATE_ECHEANCE,
       fm.ETAT,
       IDPREVISION,
       IDPROVISION,
       IDCATEGORIE,
       CAST(fm.pu * fm.quantite * NVL(duree, 1) AS NUMBER(30, 3))
                               AS Montant,
       CAST(
                       ((fm.pu * fm.quantite) * fm.taux)
                       - NVL(
                                       ((fm.pu * fm.quantite * NVL(duree, 1)) * fm.taux)
                                       * fm.REDUCTION
                                   / 100,
                                       0)
                   + NVL(
                                       ((fm.pu * fm.quantite * NVL(duree, 1)) * fm.taux)
                                       * fm.MAJORATION
                                   / 100,
                                       0) AS NUMBER(30, 3))
                               AS montanttaux,
       NVL(montantsanstaux, 0) AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 3))
                               AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)   AS MAJORATION,
       NVL(fm.REDUCTION, 0)    AS REDUCTION,
       CAST(
               NVL(
                               ((fm.pu * fm.quantite * NVL(duree, 1)) * fm.taux)
                               * fm.MAJORATION
                           / 100,
                               0) AS NUMBER(30, 3))
                               AS montantMajoration,
       CAST(
               NVL(
                               ((fm.pu * fm.quantite * NVL(duree, 1)) * fm.taux)
                               * fm.REDUCTION
                           / 100,
                               0) AS NUMBER(30, 3))
                               AS montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE,
       IDAVOIR,
       CAST(
                       ((fm.pu * fm.quantite) * fm.taux)
                       - NVL(
                                       ((fm.pu * fm.quantite * NVL(duree, 1)) * fm.taux)
                                       * fm.REDUCTION
                                   / 100,
                                       0)
                   + NVL(
                                       ((fm.pu * fm.quantite * NVL(duree, 1)) * fm.taux)
                                       * fm.MAJORATION
                                   / 100,
                                       0) AS NUMBER(30, 3))
           * fm.tva
           / 100
                               AS montanttauxtva,
       fm.RANG,
       fm.mois,
       fm.annee,
       fm.duree,
       fm.HEUREDEBUT,
       fm.HEUREFIN,
       fm.datyactivite,
       fm.unite
FROM facture_client_Mere_fille fm
         LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;

         CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANTTC (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MONTANTTVA, MONTANTTAXE, MONTANTTC, IDACTIVITE, DATEFACT, RUBRIQUE, DATYACTIVITE, HEUREDEBUT, HEUREFIN, MOIS, ANNEE, RANG, DUREE, MAJORATION, REDUCTION, UNITE) AS 
  SELECT fc.ID,
          fc.IDMERE,
          fc.DESIGNATION,
          fc.QUANTITE,
          fc.PU,
          fc.COMPTE,
          fc.IDPRODUIT,
          fc.DEVISE,
          fc.TAUX,
          fc.DATY,
          fc.TIERS,
          fc.DESIGNATIONMERE,
          fc.TYPE,
          fc.TVA,
          fc.REMARQUE,
          fc.IDUSER,
          fc.DATE_ECHEANCE,
          fc.ETAT,
          CAST (fc.MONTANT AS NUMBER (32, 3)) AS MONTANT,
          CAST (fc.MONTANTTAUX AS NUMBER (32, 3)) AS MONTANTTAUX,
          CAST (fc.MONTANTAVOIRSANSTAUX AS NUMBER (32, 3))
             AS MONTANTAVOIRSANSTAUX,
          CAST (fc.MONTANTAVOIRAVECTAUX AS NUMBER (32, 3))
             AS MONTANTAVOIRAVECTAUX,
          CAST ( (fc.pu * QUANTITE * fc.TVA*nvl(FC.DUREE,1)) / 100 AS NUMBER (20, 3))
             AS montanttva,
          CAST ( (fc.pu * QUANTITE * fc.TVA*nvl(FC.DUREE,1)) / 100 AS NUMBER (20, 3))
             AS montanttaxe,
          CAST (
             (fc.pu * QUANTITE) + (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER (20, 3))
             AS montanttc,
          fc.IDACTIVITE,
          fc.DATEFACT,
          fc.RUBRIQUE,
          fc.DATYACTIVITE AS datyactivite,
          fc.HEUREDEBUT,
          fc.HEUREFIN,
          fc.mois,
          fc.annee,
          fc.rang,
          fc.duree,
          CAST (fc.MAJORATION AS NUMBER (30, 3)) AS MAJORATION,
          CAST (fc.REDUCTION AS NUMBER (30, 3)) AS REDUCTION,
          fc.unite
     FROM facture_client_montant fc
          LEFT JOIN ACTIVITE ac ON ac.ID = fc.IDACTIVITE;


INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENA00040100', NULL, 'MEN00N101', 'ROL0000001342174504', NULL, NULL, 0);

INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENA00040101', NULL, 'MEN000682', 'ROL0000001342174504', NULL, NULL, 0);
