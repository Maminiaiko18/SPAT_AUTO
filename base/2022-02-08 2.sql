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
   ETAT,
   IDCATEGORIE,
   IDPROVISION,
   IDPREVISION,
   REDUCTION,
   MAJORATION,
   IDACTIVITE,
   DATEFACT,
   RUBRIQUE,
   IDAVOIR,
   DUREE,
   MOIS,
   ANNEE,
   moisM,
   anneeM
)
AS
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
          fc.designation AS designationmere,
          fc.TYPE,
          DECODE (fi.tva, NULL, fc.tva, fi.tva),
          fc.remarque,
          fc.iduser,
          fc.date_echeance,
          fc.etat,
          fc.IDCATEGORIE,
          fc.IDPROVISION,
          fc.IDPREVISION,
          NVL (fi.REDUCTION, 0) AS REDUCTION,
          NVL (fi.MAJORATION, 0) AS MAJORATION,
          fi.IDACTIVITE,
          fi.DATEFACT,
          fi.RUBRIQUE,
          IDAVOIR,
          DUREE,
          fi.MOIS,
          fi.ANNEE,
          EXTRACT (MONTH FROM fc.daty) AS moisM,
          EXTRACT (YEAR FROM fc.daty) AS anneeM
     FROM facture_client_fille fi
          LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;
          
          
CREATE OR REPLACE FORCE VIEW FCFILLECOMPLET
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
   MONTANTHTSIMPLE
)
AS
   SELECT fcf.ID,
          fcf.IDMERE,
          fcf.DESIGNATION,
          fcf.QUANTITE,
          fcf.PU,
          fcf.COMPTE,
          fcf.IDPRODUIT,
          fcf.DEVISE,
          fcf.TAUX,
          fcf.IDACTIVITE,
          fcf.TVA,
          fcf.DATEFACT,
          fcf.RUBRIQUE,
          EXTRACT (MONTH FROM fc.DATY) AS mois,
          EXTRACT (YEAR FROM fc.DATY) AS annee,
          fcf.HEUREDEBUT,
          fcf.HEUREFIN,
          fcf.REDUCTION,
          fcf.MAJORATION,
          fcf.TEST,
          fcf.RANG,
          fcf.DUREE,
          fcf.pu * fcf.quantite * fcf.taux * NVL (fcf.duree, 1) AS montantAV,
          DECODE (fcf.rubrique, NULL, a.rubrique, fcf.rubrique)
             AS rubriquecpl,
          fc.daty,
          fc.tiers,
          fc.idcategorie,
          fc.TYPE,
          fc.devisemere,
          fc.exercice,
          FC.IDAVOIr,
          fc.etat,
          NVL (AV.MONTANT, 0) AS mtavoir,
            fcf.pu
          * fcf.quantite
          * fcf.taux
          * NVL (fcf.duree, 1)
          * NVL (FCF.REDUCTION, 0)
          / 100
             AS montantReduction,
            fcf.pu
          * fcf.quantite
          * fcf.taux
          * NVL (fcf.duree, 1)
          * NVL (FCF.MAJORATION, 0)
          / 100
             AS montantMajoration,
            fcf.pu * fcf.quantite * fcf.taux * NVL (fcf.duree, 1)
          +   (  fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL (fcf.duree, 1)
               * NVL (FCF.MAJORATION, 0))
            / 100
          -   (  fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL (fcf.duree, 1)
               * NVL (FCF.REDUCTION, 0))
            / 100
             AS montant,
            (  fcf.pu * fcf.quantite * fcf.taux * NVL (fcf.duree, 1)
             +   (  fcf.pu
                  * fcf.quantite
                  * fcf.taux
                  * NVL (fcf.duree, 1)
                  * NVL (FCF.MAJORATION, 0))
               / 100
             -   (  fcf.pu
                  * fcf.quantite
                  * fcf.taux
                  * NVL (fcf.duree, 1)
                  * NVL (FCF.REDUCTION, 0))
               / 100)
          * NVL (fcf.tva / 100, 0)
             AS montanttva,
            (  fcf.pu * fcf.quantite * fcf.taux * NVL (fcf.duree, 1)
             +   (  fcf.pu
                  * fcf.quantite
                  * fcf.taux
                  * NVL (fcf.duree, 1)
                  * NVL (FCF.MAJORATION, 0))
               / 100
             -   (  fcf.pu
                  * fcf.quantite
                  * fcf.taux
                  * NVL (fcf.duree, 1)
                  * NVL (FCF.REDUCTION, 0))
               / 100)
          * (1 + NVL (fcf.tva / 100, 0))
             AS montantttc,
          m.VAL AS moislib,
          f.MONTANTHTSIMPLE
     FROM facture_client_fille fcf
          JOIN factureclient fc ON fcf.idmere = fc.id
          LEFT JOIN activite a ON a.id = fcf.idactivite
          LEFT JOIN avoirfcFilleValideGroupe av
             ON AV.IDDETAILFACTURE = fcf.id
          LEFT JOIN mois m ON m.ID = EXTRACT (MONTH FROM fc.DATY)
          LEFT JOIN facture_client_filleTTC f ON f.ID = fcf.ID
          where fc.etat>=11;