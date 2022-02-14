create or replace view AVOIRFCFILLEVALIDEGROUPE as
select max(AF.ID)     as id,
       af.idmere,
       AF.IDDETAILFACTURE,
       sum(montant)   as montant,
       max(af.compte) as compte,
       avg(remise)    as remise,
       cast(sum(montant * nvl(fc.TAUX, 1)) as number(30, 3))
                      as montantavoiravectsaux
from avoirfcfille af
         join avoirfc a on a.id = AF.IDMERE
         left join FACTURE_CLIENT_FILLE fc on fc.ID = af.IDDETAILFACTURE
where A.ETAT >= 11
group by af.idmere, AF.IDDETAILFACTURE;

CREATE OR REPLACE  VIEW FCFILLECOMPLET
            (ID, IDMERE, DESIGNATION, QUANTITE, PU,
             COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN,
             REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE,
             DEVISEMERE,
             EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC,
             MOISLIB,
             MONTANTHTSIMPLE, CLIENT, montantavoiravectsaux)
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
       NVL(AV.MONTANT, 0)                                   AS mtavoir,
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
       nvl(av.montantavoiravectsaux, 0) as montantavoiravectsaux
FROM facture_client_fille fcf
         JOIN factureclient fc ON fcf.idmere = fc.id
         LEFT JOIN activite a ON a.id = fcf.idactivite
         LEFT JOIN avoirfcFilleValideGroupe av
                   ON AV.IDDETAILFACTURE = fcf.id
         LEFT JOIN mois m ON m.ID = EXTRACT(MONTH FROM fc.DATY)
         LEFT JOIN facture_client_filleTTC f ON f.ID = fcf.ID
         left join client_union t on fc.TIERS = t.cdclt;

create or replace view CAFCFILLECOMPLET_GRP as
select idmere,
       sum(montantav)             as montantav,
       sum(mtavoir)               as mtavoir,
       sum(montantreduction)      as montantreduction,
       sum(montantmajoration)     as montantmajoration,
       sum(montant)               as montant,
       sum(montanttva)            as montanttva,
       sum(montantttc)            as montantttc,
       sum(montanthtsimple)       as montanthtsimple,
       sum(MONTANTAVOIRAVECTSAUX) as MONTANTAVOIRAVECTSAUX
from FCFILLECOMPLET
group by idmere;

CREATE OR REPLACE VIEW FACTURECLIENTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR) AS
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
          fc.idprevision,
          CAST (NVL (grp.montant, 0) AS NUMBER (30, 3)) AS montant, --montanttaux
          CAST (NVL (grp.MONTANTTVA, 0) AS NUMBER (30, 3)) AS montanttva,
          CAST (NVL (grp.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER (32, 3)) AS montantavoir,
          CAST (NVL (MONTANTTTC, 0) AS NUMBER (30, 3)) AS MONTANTTTC,
          pr.ESCALE,
          tfc.VAL AS typelib,
          fc.IDCATEGORIE,
          catfc.VAL AS CATEGORIELIB,
          fc.IDPROVISION,
          fcf.DESIGNATION AS IDPROVISIONlib,
          fc.ESTDDPMICTSL,
          fc.DEVISEMERE,
          fc.codePrestation,
          cp.VAL AS codePrestationlib,
          fc.code,
          fc.ESTMICTSL,
          fcf.CODE AS codeprovision,
          CAST (
             NVL (NVL (grp.MONTANTTVA, 0) + grp.MONTANT, 0) AS NUMBER (30, 3))
             AS MONTANTTTCVRAI,
          pr.NAVIRE,
          nv.armateurlib,
          fc.exercice,
          fc.IDAVOIR
     FROM FACTURECLIENT fc
          LEFT JOIN CAFCFILLECOMPLET_GRP grp ON grp.idmere = fc.id
          LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
          LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
          LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
          LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
          LEFT JOIN CODE_PRESTATION cp ON fc.codePrestation = cp.id
          LEFT JOIN NAVIRELIBCOMPLET nv ON pr.NAVIRE = nv.id;


create or replace view FACTURE_CLIENT_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION,
             IDACTIVITE, DATEFACT, RUBRIQUE, IDAVOIR, DUREE, MOIS, ANNEE, MOISM, ANNEEM,RANG)
as
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
       DECODE(fi.tva, NULL, fc.tva, fi.tva),
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
       fi.RANG
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id
/


CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANT
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDPROVISION, IDCATEGORIE, MONTANT, MONTANTTAUX,
             MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MAJORATION, REDUCTION, MONTANTMAJORATION, MONTANTREDUCTION,
             IDACTIVITE, DATEFACT, RUBRIQUE, IDAVOIR, MONTANTTAUXTVA,RANG)
AS
SELECT fm.ID,
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
       CAST(fm.pu * fm.quantite * nvl(duree, 1) AS NUMBER(30, 3)) AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3))
                                                                  AS montanttaux,
       NVL(montantsanstaux, 0)                                    AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 3))
                                                                  AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)                                      as MAJORATION,
       NVL(fm.REDUCTION, 0)                                       as REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.MAJORATION / 100,
                0) AS NUMBER(30, 3))                              as montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.REDUCTION / 100,
                0) AS NUMBER(30, 3))                              as montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE,
       IDAVOIR,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite * nvl(duree, 1)) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3)) * fm.tva /
       100                                                        as montanttauxtva,
       fm.RANG
FROM facture_client_Mere_fille fm
         LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;
CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANTTC (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE,
      TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX,
      MONTANTAVOIRAVECTAUX, MONTANTTVA, MONTANTTAXE, MONTANTTC, IDACTIVITE, DATEFACT, RUBRIQUE, DATYACTIVITE, HEUREDEBUT, HEUREFIN,rang) AS
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
       cast(fc.MONTANT as number(32, 3))              as MONTANT,
       cast(fc.MONTANTTAUX as number(32, 3))          as MONTANTTAUX,
       cast(fc.MONTANTAVOIRSANSTAUX as number(32, 3)) as MONTANTAVOIRSANSTAUX,
       cast(fc.MONTANTAVOIRAVECTAUX as number(32, 3)) as MONTANTAVOIRAVECTAUX,
       CAST((fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                      AS montanttva,
       CAST((fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                      AS montanttaxe,
       CAST(
               (fc.pu * QUANTITE) + (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                      AS montanttc,
       fc.IDACTIVITE,
       fc.DATEFACT,
       fc.RUBRIQUE,
       ac.DATY as datyactivite,
       ac.HEUREDEBUT,
       ac.HEUREFIN,
       fc.RANG
FROM facture_client_montant fc
        left join ACTIVITE ac on ac.ID=fc.IDACTIVITE;



  CREATE OR REPLACE  VIEW ACTIVITELIBCOMPLETEVPTOUS (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE, BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE, CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE, DATEFACT, POSTE, POSTELIB, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, VOLUME, VOLUMEARRONDI, CARGAISON, IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, NATUREOPERATION, NBQUARTHEURE, NBHEURE, NBJOUR, TYPEQUAIS, SURFACE, NB5JOURS, QUAI, FLOTTE, CATEGORIE_FLOTTE, UNITELIB, ESTPETROLIER, VOLUMERUBRIQUE) AS
  SELECT ID,
          DESIGNATION,
          CLIENT,
          RUBRIQUE,
          CAST (
             CASE
                WHEN CATEGORIE = 'CATFC002' THEN qte * (volumerubrique / 20)
                ELSE qte
             END AS NUMBER (10, 2))
             AS QTE,
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
     FROM ACTIVITELIBCOMPLET ;



create view SITUATIONLCDEPENSE_CPL as
select l.id,
       l.DESIGNATION,
       l.compte,
       l.ANNEE,
       l.montant                                                                   as montant,
       l.etat,
       substr(l.compte, 7, length(l.compte))                                       as comptestr,
       substr(l.COMPTE, 7) || substr(l.COMPTE, 1, 6)                               as compteinv,
       substr(l.COMPTE, 7)                                                         as comptesimple,
       substr(l.COMPTE, 1, 6)  as directionProjet ,
       substr(substr(l.COMPTE, 1, 6), 1, 3)                                        as direction,
       substr(substr(l.COMPTE, 1, 6), 4, 7)                                        as projet

from LIGNECREDITDEPENSE l;

  CREATE OR REPLACE VIEW FACTURECLIENTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR) AS
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
          fc.idprevision,
          CAST (NVL (grp.montant, 0) AS NUMBER (30, 3)) AS montant, --montanttaux
          CAST (NVL (grp.MONTANTTVA, 0) AS NUMBER (30, 3)) AS montanttva,
          CAST (NVL (grp.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER (32, 3)) AS montantavoir,
          CAST (NVL (MONTANTTTC, 0)-NVL (grp.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER (30, 3)) AS MONTANTTTC,
          pr.ESCALE,
          tfc.VAL AS typelib,
          fc.IDCATEGORIE,
          catfc.VAL AS CATEGORIELIB,
          fc.IDPROVISION,
          fcf.DESIGNATION AS IDPROVISIONlib,
          fc.ESTDDPMICTSL,
          fc.DEVISEMERE,
          fc.codePrestation,
          cp.VAL AS codePrestationlib,
          fc.code,
          fc.ESTMICTSL,
          fcf.CODE AS codeprovision,
          CAST (
             NVL (NVL (grp.MONTANTTVA, 0) + grp.MONTANT, 0) AS NUMBER (30, 3))
             AS MONTANTTTCVRAI,
          pr.NAVIRE,
          nv.armateurlib,
          fc.exercice,
          fc.IDAVOIR
     FROM FACTURECLIENT fc
          LEFT JOIN CAFCFILLECOMPLET_GRP grp ON grp.idmere = fc.id
          LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
          LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
          LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
          LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
          LEFT JOIN CODE_PRESTATION cp ON fc.codePrestation = cp.id
          LEFT JOIN NAVIRELIBCOMPLET nv ON pr.NAVIRE = nv.id;


CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANT
AS
   SELECT fm.ID,
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
          CAST (fm.pu * fm.quantite * NVL (duree, 1) AS NUMBER (30, 3))
             AS Montant,
          CAST (
               ( (fm.pu * fm.quantite) * fm.taux)
             - NVL (
                    ( (fm.pu * fm.quantite * NVL (duree, 1)) * fm.taux)
                  * fm.REDUCTION
                  / 100,
                  0)
             + NVL (
                    ( (fm.pu * fm.quantite * NVL (duree, 1)) * fm.taux)
                  * fm.MAJORATION
                  / 100,
                  0) AS NUMBER (30, 3))
             AS montanttaux,
          NVL (montantsanstaux, 0) AS montantavoirsanstaux,
          CAST (NVL ( (montantsanstaux * fm.TAUX), 0) AS NUMBER (30, 3))
             AS montantavoiravectaux,
          NVL (fm.MAJORATION, 0) AS MAJORATION,
          NVL (fm.REDUCTION, 0) AS REDUCTION,
          CAST (
             NVL (
                  ( (fm.pu * fm.quantite * NVL (duree, 1)) * fm.taux)
                * fm.MAJORATION
                / 100,
                0) AS NUMBER (30, 3))
             AS montantMajoration,
          CAST (
             NVL (
                  ( (fm.pu * fm.quantite * NVL (duree, 1)) * fm.taux)
                * fm.REDUCTION
                / 100,
                0) AS NUMBER (30, 3))
             AS montantReduction,
          fm.IDACTIVITE,
          fm.DATEFACT,
          fm.RUBRIQUE,
          IDAVOIR,
            CAST (
                 ( (fm.pu * fm.quantite) * fm.taux)
               - NVL (
                      ( (fm.pu * fm.quantite * NVL (duree, 1)) * fm.taux)
                    * fm.REDUCTION
                    / 100,
                    0)
               + NVL (
                      ( (fm.pu * fm.quantite * NVL (duree, 1)) * fm.taux)
                    * fm.MAJORATION
                    / 100,
                    0) AS NUMBER (30, 3))
          * fm.tva
          / 100
             AS montanttauxtva,
          fm.RANG,
		  fm.mois,
		  fm.annee
     FROM facture_client_Mere_fille fm
          LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;
		  
		  
CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANTTC
AS
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
          CAST ( (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER (20, 3))
             AS montanttva,
          CAST ( (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER (20, 3))
             AS montanttaxe,
          CAST (
             (fc.pu * QUANTITE) + (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER (20, 3))
             AS montanttc,
          fc.IDACTIVITE,
          fc.DATEFACT,
          fc.RUBRIQUE,
          ac.DATY AS datyactivite,
          ac.HEUREDEBUT,
          ac.HEUREFIN,
          fc.mois,
          fc.annee,
          fc.rang
     FROM facture_client_montant fc
          LEFT JOIN ACTIVITE ac ON ac.ID = fc.IDACTIVITE;
		  
