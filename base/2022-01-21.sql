
CREATE OR REPLACE VIEW FCFILLECOMPLET
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV,
             RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR,
             MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE)
AS
select fcf.ID,
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
       extract(month from fc.DATY)                          as mois,
       extract(year from fc.DATY)                           as annee,
       fcf.HEUREDEBUT,
       fcf.HEUREFIN,
       fcf.REDUCTION,
       fcf.MAJORATION,
       fcf.TEST,
       fcf.RANG,
       fcf.DUREE,
       fcf.pu * fcf.quantite * fcf.taux * nvl(fcf.duree, 1) as montantAV,
       decode(fcf.rubrique, null, a.rubrique, fcf.rubrique) as rubriquecpl,
       fc.daty,
       fc.tiers,
       fc.idcategorie,
       fc.type,
       fc.devisemere,
       fc.exercice,
       FC.IDAVOIr,
       fc.etat,
       nvl(AV.MONTANT, 0)                                   as mtavoir,
       fcf.pu * fcf.quantite * fcf.taux * nvl(fcf.duree, 1) * nvl(FCF.REDUCTION, 0) /
       100                                                  as montantReduction,
       fcf.
           pu * fcf.quantite * fcf.taux * nvl(fcf.duree, 1) * nvl(FCF.MAJORATION, 0) /
       100                                                  as montantMajoration,
       fcf.pu * fcf.quantite * fcf.taux * nvl(fcf.duree, 1) +
       (fcf.pu * fcf.quantite * fcf.taux * nvl(fcf.duree, 1) * nvl(FCF.MAJORATION, 0)) / 100 -
       (fcf.pu * fcf.quantite * fcf.taux * nvl(fcf.duree, 1) * nvl(FCF.REDUCTION, 0)) /
       100                                                  as montant,
       (fcf.pu * fcf.quantite * fcf.taux * nvl(fcf.duree, 1) +
        (fcf.pu * fcf.quantite * fcf.taux * nvl(fcf.duree, 1) * nvl(FCF.MAJORATION, 0)) / 100 -
        (fcf.pu * fcf.quantite * fcf.taux * nvl(fcf.duree, 1) * nvl(FCF.REDUCTION, 0)) / 100) *
       nvl(fcf.tva / 100, 0)                                as montanttva,
       (fcf.pu * fcf.quantite * fcf.taux * nvl(fcf.duree, 1) +
        (fcf.pu * fcf.quantite * fcf.taux * nvl(fcf.duree, 1) * nvl(FCF.MAJORATION, 0)) / 100 -
        (fcf.pu * fcf.quantite * fcf.taux * nvl(fcf.duree, 1) * nvl(FCF.REDUCTION, 0)) / 100) *
       (1 + nvl(fcf.tva / 100, 0))                          as montantttc,
       m.VAL                                                as moislib,
       f.MONTANTHTSIMPLE
from facture_client_fille fcf
         join factureclient fc on fcf.idmere = fc.id
         left join activite a on a.id = fcf.idactivite
         left join avoirfcFilleValideGroupe av on AV.IDDETAILFACTURE = fcf.id
         left join mois m on m.ID = extract(month from fc.DATY)
         left join facture_client_filleTTC f on f.ID = fcf.ID;
