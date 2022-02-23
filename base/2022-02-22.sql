
alter table facture_fournisseur_fille add pu_tmp number(20,2);
alter table facture_fournisseur_fille add QUANTITE_tmp number(20,2);
update facture_fournisseur_fille set pu_tmp=pu where id=id;
update facture_fournisseur_fille set QUANTITE_tmp=QUANTITE  where id=id;
update facture_fournisseur_fille set pu=null ;
update facture_fournisseur_fille set QUANTITE=null;

alter table facture_fournisseur_fille modify pu number(20,2);
alter table facture_fournisseur_fille modify QUANTITE number(20,2);


update facture_fournisseur_fille set pu=pu_tmp  where id=id;
update facture_fournisseur_fille set QUANTITE=QUANTITE_tmp   where id=id;

alter table facture_fournisseur_fille drop column pu_tmp;
alter table facture_fournisseur_fille drop column QUANTITE_tmp;


  CREATE OR REPLACE VIEW FACTFOURN_MONTANT (ID, IDMERE, DESIGNATION,
      QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS,
      DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE,
      ETAT, IDPREVISION, IDPROVISION, IDCATEGORIE, MONTANT, MONTANTTAUX,
      MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MAJORATION, REDUCTION,
      MONTANTMAJORATION, MONTANTREDUCTION, IDACTIVITE, DATEFACT, RUBRIQUE, MONTANTTAUXTVA) AS
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
       CAST(fm.pu * fm.quantite AS NUMBER(30, 2))                                             AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2))
                                                                                              AS montanttaux,
       NVL(montantsanstaux, 0)                                                                AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 2))
                                                                                              AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)                                                                  as MAJORATION,
       NVL(fm.REDUCTION, 0)                                                                   as REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2)) as montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) AS NUMBER(30, 2))  as montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite ) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2)) * fm.tva /
       100                                                                                    as montanttauxtva
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirffavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;


CREATE OR REPLACE view FACTFOURN_FILLEMONTANT  (IDFACTURE, MONTANT, MONTANTTVA, MONTANTREMISE) AS
select fcd.idmere                                                                        as idfacture,
       cast(nvl(sum(fcd.pu * fcd.quantite), 0) as NUMBER(30, 2))                         as montant,
       cast(nvl((sum(fcd.pu * fcd.quantite * fc.TVA) / 100), 0) as number(30, 2))        as montanttva,
       cast(nvl((sum(fcd.pu * fcd.quantite * fcd.REDUCTION) / 100), 0) as NUMBER(30, 2)) as montantremise
from FACTURE_FOURNISSEUR_FILLE fcd
         left join FACTURE_FOURNISSEUR_MERE fc on fc.id = fcd.IDMERE
group by fcd.idmere;


  CREATE OR REPLACE VIEW FACTFOURN_FILL_LIB_REST_TAXE
      (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT,
          DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT,
          MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB,
          MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO,
          MONTANTTAXE, MAJORATION, REDUCTION, DATEFACT, RUBRIQUE, RANG, DATY) AS
  SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                               AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))           AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                            AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 2))               as MONTANTTAUX,
       CAST(fcm.MONTANT AS NUMBER(32, 2))                   as MONTANT,
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 2))      as MONTANTAVOIRSANSTAUX,
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 2))      as MONTANTAVOIRAVECTAUX,
       CAST(fcm.tva AS NUMBER(30, 2))                       as tva,
       fc.idactivite,
       ra.DESIGNATION                                       AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                             AS moislib,
       CAST(0 AS NUMBER(32, 2))                             AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                             AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                             AS montantTVAEuro,
       CAST((fc.pu * fc.QUANTITE * fc.TVA) / 100 AS NUMBER(30, 2))
                                                            AS montanttaxe,
       nvl(fc.majoration, 0)                                as majoration,
       nvl(fc.reduction, 0)                                 as reduction,
       fc.DATEFACT,
       fc.RUBRIQUE,
       case when fc.IDACTIVITE is not null then r.RANG end  as rang,
       case when fc.IDACTIVITE is not null then ra.DATY end as daty
FROM FACTURE_FOURNISSEUR_FILLE fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTFOURN_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE;





create or replace view FACTFOURN_FILLE_LIB_RESTE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MAJORATION, REDUCTION) as
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       fc.IDPRODUIT                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 2)),
       CAST(fcm.MONTANT AS NUMBER(32, 2)),
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 2)),
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 2)),
       CAST(fcm.tva AS NUMBER(20, 2)),
       fc.idactivite,
       ra.DESIGNATION                             AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                   AS moislib,
       CAST(0 AS NUMBER(32, 2))                   AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                   AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                   AS montantTVAEuro,
       nvl(fc.majoration, 0)                      as majoration,
       nvl(fc.reduction, 0)                       as reduction
FROM FACTURE_FOURNISSEUR_FILLE fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTFOURN_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois;


  CREATE OR REPLACE VIEW FACTFOURN_FILLE_PLUS (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, MONTANT, TVA, IDACTIVITE, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION, IDBLF) AS
  SELECT f.ID,
       f.IDMERE,
       f.DESIGNATION,
       f.QUANTITE,
       f.PU,
       f.COMPTE,
       f.IDPRODUIT,
       f.DEVISE,
       f.TAUX,
       CAST(0.0 AS NUMBER(30, 2)) AS montant,
       f.tva,
       f.IDACTIVITE,
       f.DATEFACT,
       f.RUBRIQUE,
       f.MOIS,
       f.ANNEE,
       f.HEUREDEBUT,
       f.HEUREFIN,
       f.MAJORATION,
       f.REDUCTION,
       f.IDBLF
FROM FACTURE_FOURNISSEUR_FILLE f
WHERE 1 > 2;
alter view FACTFOURN_FILLE_VM compile;
alter view FACTFOURN_FILLE_VM_LIB compile;


alter view FACTFOURN_FILLEHT compile;
alter view FACTFOURN_FILLE_LIBELLE compile;

alter view FACTFOURN_FILLEMR compile;
alter view FACTFOURN_FILLENET compile;
alter view FACTFOURN_FILLEWITHTVA compile;
alter view FACTFOURN_FILLETTC compile;


alter view FACTFOURN_MERE_FILLE compile;

alter view FACTFOURN_MEREMONTANT compile;
alter view FACTFOURN_MERELETTRE compile;
alter view FACTFOURN_MERE_LIBCOMPLET compile;



CREATE OR REPLACE VIEW FACTFOURN_MEREMONTANT
            (ID, DATY, IDFOURNISSEUR, TVA, REMARQUE, DATEEMISSION, DESIGNATION, DEVISE, NUMFACT, RESP, DATE_ECHEANCE,
             ETAT, IDFACTUREFOURNISSEUR, ENTITE, MONTANTTTC, REMISE)
AS
select ff.id,
       ff.daty,
       ff.TIERS                                            as idfournisseur,
       ff.tva,
       ff.remarque,
       (select current_date from dual)                     as dateemission,
       ff.designation,
       ff.devisemere                                       as devise,
       cast('' as varchar2(100))                           as numfact,
       cast('' as varchar2(100))                           as resp,
       (select current_date from dual)                     as date_echeance,
       ff.etat,
       cast('' as varchar2(100))                           as idfacturefournisseur,
       ''                                                  as entite,
       cast(fcm.montant + fcm.montanttva as NUMBER(30, 2)) as montantttc,
       cast(fcm.montantremise as NUMBER(30, 2))            as remise
from FACTURE_FOURNISSEUR_MERE ff
         join FACTFOURN_FILLEMONTANT fcm on fcm.IDFACTURE = ff.id;

alter view FACTFOURN_MERELETTRE compile;


  CREATE OR REPLACE VIEW FACTFOURN_MONTANTTC (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MONTANTTVA, MONTANTTAXE, MONTANTTC, IDACTIVITE, DATEFACT, RUBRIQUE) AS
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
       cast(fc.MONTANT as number(32, 2))              as MONTANT,
       cast(fc.MONTANTTAUX as number(32, 2))          as MONTANTTAUX,
       cast(fc.MONTANTAVOIRSANSTAUX as number(32, 2)) as MONTANTAVOIRSANSTAUX,
       cast(fc.MONTANTAVOIRAVECTAUX as number(32, 2)) as MONTANTAVOIRAVECTAUX,
       CAST((fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(30, 2))
                                                      AS montanttva,
       CAST((fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(30, 2))
                                                      AS montanttaxe,
       CAST(
               (fc.pu * QUANTITE) + (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(30, 2))
                                                      AS montanttc,
       fc.IDACTIVITE,
       fc.DATEFACT,
       fc.RUBRIQUE
FROM FACTFOURN_MONTANT fc;



  CREATE OR REPLACE VIEW FACTFOURN_MSUM (ID, DATY, TIERS, DESIGNATION, TYPE,
      TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA,
      MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION,
      IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE,
      ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB,
      NUMEROOP, PROJET, PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC, EXERCICE) AS
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 2))                          AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 2))                           AS montanttva,
       NVL(grp.montantavoiravectaux, 0)                                        AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 2))
                                                                               AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                                                 AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                                               AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                                         AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                                                  as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                                                as codeprovision,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0) AS NUMBER(30, 2)) as MONTANTTTCVRAI,
       fc.IDBL,
       fc.CODE_ETABLISSEMENT,
       cod.VAL                                                                 as CODE_ETABLISSEMENTlib,
       fc.NUMEROOP,
       fc.PROJET,
       p.DESIGNATION                                                           as projetlib,
       fc.NUMFACT,
       fc.NATURE,
       n.VAL                                                                   as naturelib,
       bl.ID_BC,
       fc.EXERCICE
FROM FACTURE_FOURNISSEUR_MERE fc
         LEFT JOIN FACTFOURN_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFf tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFF catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id
         left join CODEETABLISSEMENT cod on fc.CODE_ETABLISSEMENT = cod.ID
         left join projet p on fc.PROJET = p.ID
         LEFT JOIN nature n on fc.NATURE = n.ID
         left join AS_BONDELIVRAISON bl on bl.ID = nvl(fc.IDBL, fc.REMARQUE);


alter view FACTFOURN_MSUM_LIB compile;

alter view FACTFOURN_MSUM_V compile;

alter view FACTFOURN_MSUM_LIBV compile;

alter view FACTFOURN_MSUM_LIBC compile;

alter view FACTFOURN_UNION compile;

alter view FACTFOURN_MSUM_LIB_ODRE compile;

alter view FACTFOURN_VALIDE compile;

  CREATE OR REPLACE  VIEW "FACTFOURN_VALIDE" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA",
      "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC",
      "MONTANTPAYE", "MONTANTRESTE", "TIERSLIB", "CONTACT", "ADRESSE", "IDPREVISION", "ESCALE", "ETATLIB",
      "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "DEVISEMERE", "CODEPRESTATION",
      "CODEPRESTATIONLIB", "CODE", "ESTMICTSL") AS
  SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       cast(fc.TVA as number(30, 2))          as TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(fc.MONTANT as NUMBER(30, 2))      as MONTANT,
       cast(fc.MONTANTTVA as NUMBER(30, 2))   as MONTANTTVA,
       cast(fc.MONTANTAVOIR as NUMBER(30,2)) as MONTANTAVOIR,
       cast(fc.MONTANTTTC as NUMBER(30, 2))   as MONTANTTTC,
       cast(fc.MONTANTPAYE as NUMBER(30, 2))  as MONTANTPAYE,
       cast(fc.MONTANTRESTE as NUMBER(30, 2)) as MONTANTRESTE,
       fc.TIERSLIB,
       fc.CONTACT,
       fc.ADRESSE,
       fc.IDPREVISION,
       fc.ESCALE,
       fc.ETATLIB,
       fc.TYPELIB,
       fc.IDCATEGORIE,
       fc.CATEGORIELIB,
       fc.IDPROVISION,
       fc.IDPROVISIONLIB,
       fc.DEVISEMERE,
       fc.CODEPRESTATION,
       fc.CODEPRESTATIONLIB,
       fc.CODE,
       ESTMICTSL
FROM FACTFOURN_UNION fc
WHERE id NOT IN (SELECT id FROM ProvisionFactureDefinitive);



  CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA,
      REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR,
      MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE,
      CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB,
      CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB,
      NUMEROOP, PROJET, PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC, EXERCICE) AS
  SELECT m.ID,
       m.DATY,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       '--' || m.remarque                        AS remarque,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.idprevision,
       CAST(m.MONTANT AS NUMBER(32, 2)),
       CAST(M.MONTANTTVA AS NUMBER(32, 2)),
       CAST(M.MONTANTAVOIR AS NUMBER(32, 2)),
       CAST(M.MONTANTTTC AS NUMBER(32, 2)),
       CAST(NVL(pf.montant, 0) AS NUMBER(32, 2)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(pf.montant, 0) AS NUMBER(32, 2))
                                                 AS montantreste,
       fup.NOM                                   AS tierslib,
       fup.CONTACT,
       fup.ADRESSE,
       M.ESCALE,
       TYPELIB,
       m.IDCATEGORIE,
       m.CATEGORIELIB,
       m.IDPROVISION,
       m.IDPROVISIONLIB,
       m.ESTDDPMICTSL,
       m.devisemere,
       m.codePrestation,
       m.codePrestationlib,
       m.CODE,
       m.ESTMICTSL,
       codeprovision,
       case
           when m.etat = 1 then 'CREE'
           when m.etat >= 11 then 'VISE'
           else '' end                           as etatlib,
       MONTANTTTCVRAI,
       m.IDBL,
       m.CODE_ETABLISSEMENT,
       m.CODE_ETABLISSEMENTLIB,
       m.NUMEROOP,
       m.PROJET,
       m.PROJETLIB,
       m.NUMFACT,
       m.NATURE,
       m.naturelib,
       m.IDBC,
       m.exercice
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id;



  CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIB_ODRE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTTTCVRAI, MONTANTTTC, MONTANTAVOIR, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB, NUMEROOP, PROJET, PROJETLIB) AS
  select ID,
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
         cast(MONTANT as NUMBER(30,2)),
         cast(MONTANTTVA as NUMBER(30,2)),
         cast(montantTTCvrai as NUMBER(30,2)),
         cast(MONTANTTTC as NUMBER(30,2)),
         cast(MONTANTAVOIR as NUMBER(30,2)),
         cast(MONTANTPAYE as NUMBER(30,2)),
         cast(MONTANTRESTE as NUMBER(30,2)),
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
       ETATLIB,
       CODE_ETABLISSEMENT,
       CODE_ETABLISSEMENTLIB,
       NUMEROOP,
       PROJET,
       PROJETLIB
from FACTFOURN_MSUM_LIB;
