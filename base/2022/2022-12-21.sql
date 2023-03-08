CREATE OR REPLACE  VIEW FCFILLECOMPLETNPentre (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE, CLIENT, MONTANTAVOIRAVECTSAUX, MONTANTAVTTCAVECTAUX, MONTANTAVTVAAVECTAUX, CODE,numpiece) AS 
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
       EXTRACT(MONTH FROM fc.DATY)                          AS mois,
       EXTRACT(YEAR FROM fc.DATY)                           AS annee,
       fcf.HEUREDEBUT,
       fcf.HEUREFIN,
       fcf.REDUCTION,
       fcf.MAJORATION,
       fcf.TEST,
       fcf.RANG,
       fcf.DUREE,
       fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) AS montantAV,
       DECODE(fcf.rubrique, NULL, a.rubrique, fcf.rubrique)
                                                            AS rubriquecpl,
       fc.daty,
       fc.tiers,
       fc.idcategorie,
       fc.TYPE,
       fc.devisemere,
       fc.exercice,
       FC.IDAVOIr,
       fc.etat,
       NVL(AV.montantsanstaux, 0)                                   AS mtavoir,
       fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.REDUCTION, 0)
           / 100
                                                            AS montantReduction,
       fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.MAJORATION, 0)
           / 100
                                                            AS montantMajoration,
       fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1)
           + (fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.MAJORATION, 0))
           / 100
           - (fcf.pu
           * fcf.quantite
           * fcf.taux
           * NVL(fcf.duree, 1)
           * NVL(FCF.REDUCTION, 0))
           / 100
                                                            AS montant,
       (fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1)
            + (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.MAJORATION, 0))
            / 100
           - (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.REDUCTION, 0))
            / 100)
           * NVL(fcf.tva / 100, 0)
                                                            AS montanttva,
       (fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1)
            + (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.MAJORATION, 0))
            / 100
           - (fcf.pu
               * fcf.quantite
               * fcf.taux
               * NVL(fcf.duree, 1)
               * NVL(FCF.REDUCTION, 0))
            / 100)
           * (1 + NVL(fcf.tva / 100, 0))
                                                            AS montantttc,
       m.VAL                                                AS moislib,
       f.MONTANTHTSIMPLE,
       t.nomclt,
       CAST(nvl(av.montantavectsaux, 0) AS  NUMBER (30, 3)) AS  montantavoiravectsaux ,
       CAST(nvl(av.MONTANTTTC, 0) AS NUMBER (30, 3)) as montantavTTCavecTaux,
       CAST(nvl(av.MONTANTTVA, 0) AS NUMBER (30, 3)) as montantavTVAavecTaux,
       fc.code,
       j.numpiece
FROM facture_client_fille fcf
         JOIN factureclient fc ON fcf.idmere = fc.id
         LEFT JOIN activite a ON a.id = fcf.idactivite
         LEFT JOIN AVOIRFCAVECTAUX_GRP av
                   ON AV.IDDETAILFACTURE = fcf.id
         LEFT JOIN mois m ON m.ID = EXTRACT(MONTH FROM fc.DATY)
         LEFT JOIN facture_client_filleTTC f ON f.ID = fcf.ID
         left join client_union t on fc.TIERS = t.cdclt
         LEFT JOIN PAIEMENTFACTURE p ON p.IDFACT= fc.id
         LEFT JOIN JOURNALCAISSE j ON j.ID = p.IDMVT;

        
CREATE OR REPLACE VIEW FCFILLECOMPLETNP as     
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
LISTAGG(NUMPIECE,';') WITHIN GROUP (ORDER BY id) AS NUMPIECE
FROM FCFILLECOMPLETNPentre
GROUP BY ID,
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
CODE;