ALTER TABLE facture_client_fille ADD duree NUMBER(10,2);

CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_PLUS
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, MONTANT, TVA,
             IDACTIVITE, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION,
             EXERCICE,duree)
AS
SELECT facture_client_fille.ID,
       facture_client_fille.IDMERE,
       facture_client_fille.DESIGNATION,
       facture_client_fille.QUANTITE,
       facture_client_fille.PU,
       facture_client_fille.COMPTE,
       facture_client_fille.IDPRODUIT,
       facture_client_fille.DEVISE,
       facture_client_fille.TAUX,
       CAST(0.0 AS NUMBER(30, 3)) AS montant,
       facture_client_fille.tva,
       facture_client_fille.IDACTIVITE,
       FACTURE_CLIENT_FILLE.DATEFACT,
       facture_client_fille.RUBRIQUE,
       facture_client_fille.MOIS,
       facture_client_fille.ANNEE,
       facture_client_fille.HEUREDEBUT,
       facture_client_fille.HEUREFIN,
       FACTURE_CLIENT_FILLE.MAJORATION,
       FACTURE_CLIENT_FILLE.REDUCTION,
       CAST(0 AS NUMBER(10))      AS exercice,
       CAST(0 AS NUMBER(10, 2))   AS duree
FROM facture_client_fille
WHERE 1 > 2;


create or replace view FACTURE_CLIENT_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION,
             IDACTIVITE, DATEFACT, RUBRIQUE, IDAVOIR,
             DUREE)
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
       fc.designation        AS designationmere,
       fc.TYPE,
       decode(fi.tva, null, fc.tva, fi.tva),
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.IDPREVISION,
       nvl(fi.REDUCTION, 0)  as REDUCTION,
       nvl(fi.MAJORATION, 0) as MAJORATION,
       fi.IDACTIVITE,
       fi.DATEFACT,
       fi.RUBRIQUE,
       IDAVOIR,
       DUREE
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;


  CREATE OR REPLACE VIEW FACTURECLIENTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA,
      REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR,
      MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB,
      ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION,
      MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE,IDAVOIR) AS
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 3))          AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3))           AS montanttva,
       cast(NVL(grp.montantavoiravectaux, 0) as NUMBER(32, 3)) AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 3))
                                                               AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                                 AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                               AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                         AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                                  as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                                as codeprovision,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0) AS NUMBER(30, 3))
                                                               AS MONTANTTTCVRAI,
       pr.NAVIRE,
       nv.armateurlib,
       fc.exercice,
        fc.IDAVOIR
FROM FACTURECLIENT fc
         LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id
         left join NAVIRELIBCOMPLET nv on pr.NAVIRE = nv.id;
		 
	 CREATE OR REPLACE VIEW FACTURECLIENTMSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA,
      REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR,
      MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB,
      IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE,
      CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI,
      NAVIRE, ARMATEURLIB, EXERCICE,IDAVOIR) AS
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
       CAST(m.MONTANT AS NUMBER(32, 3)),
       CAST(M.MONTANTTVA AS NUMBER(32, 3)),
       CAST(M.MONTANTAVOIR AS NUMBER(32, 3)),
       CAST(M.MONTANTTTC AS NUMBER(32, 3)),
       CAST(NVL(pf.montant, 0) AS NUMBER(32, 3)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(pf.montant, 0) AS NUMBER(32, 3))
                                                 AS montantreste,
       fup.NOM                                   AS tierslib,
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
       codeprovision,
       cast(m.MONTANTTTCVRAI as NUMBER(32, 3)),
       m.NAVIRE,
       m.ARMATEURLIB,
       m.EXERCICE,
         IDAVOIR
FROM factureclientMSum m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id;
 
 
 
CREATE OR REPLACE VIEW AVOIRFCFILLE_FACTURE
            (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, REMISE, DATY, IDFACTURE, ETAT, DESIGNATION, CODE, CATEGORIE,
             MOTIF, TYPE, RUBRIQUE)
AS
select fc.ID,
       fc.IDMERE,
       fc.IDDETAILFACTURE,
       fc.MONTANT,
       fc.COMPTE,
       fc.REMISE,
       fcf.DATY,
       fc.IDFACTURE,
       fc.ETAT,
       fc.DESIGNATION,
       fc.CODE,
       fc.CATEGORIE,
       fc.MOTIF,
       fc.TYPE,
       fcf.RUBRIQUE

from AVOIRFCFILLE_FM fc
         left join FACTURE_CLIENT_MONTANT fcf on fc.IDDETAILFACTURE = fcf.ID;
		 

CREATE OR REPLACE VIEW FACT_CLT_FILL_LIB_REST_TAXE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION,
             REDUCTION, DATEFACT, RUBRIQUE, RANG, DATY, DUREE)
AS
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                                             AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))                         AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                                          AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3))                             AS MONTANTTAUX,
       CAST(fcm.MONTANT AS NUMBER(32, 5))                                 AS MONTANT,
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3))
                                                                          AS MONTANTAVOIRSANSTAUX,
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3))
                                                                          AS MONTANTAVOIRAVECTAUX,
       CAST(fcm.tva AS NUMBER(20, 3))                                     AS tva,
       fc.idactivite,
       ra.DESIGNATION                                                     AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                                           AS moislib,
       CAST(0 AS NUMBER(32, 2))                                           AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                                           AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                                           AS montantTVAEuro,
       CAST((fc.pu * fc.QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                                          AS montanttaxe,
       NVL(fc.majoration, 0)                                              AS majoration,
       NVL(fc.reduction, 0)                                               AS reduction,
       fc.DATEFACT,
       fc.RUBRIQUE,
       CASE
           WHEN fc.IDACTIVITE IS NOT NULL THEN r.RANG
           else r1.RANG END                                               AS rang,
       CASE WHEN fc.IDACTIVITE IS NOT NULL THEN ra.DATY else fcm.DATY END AS daty,
       fc.DUREE
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fc.RUBRIQUE;
		 
delete from TIERS where TYPE='TC003';
delete from TYPECLIENT where id='TC003';

INSERT INTO TYPECLIENT (ID, VAL, DESCE) VALUES ('TC004', 'Administratifs et société d’état', 'Administratifs et société d’état');
INSERT INTO TYPECLIENT (ID, VAL, DESCE) VALUES ('TC005', 'Armateurs consignataires', 'Armateurs consignataires');
INSERT INTO TYPECLIENT (ID, VAL, DESCE) VALUES ('TC006', 'Organisme internationaux', 'Organisme internationaux');
INSERT INTO TYPECLIENT (ID, VAL, DESCE) VALUES ('TC007', 'Société privées', 'Société privées');
INSERT INTO TYPECLIENT (ID, VAL, DESCE) VALUES ('TC008', 'Transitaires', 'Transitaires');


alter table manoeuvrebord  add rang number(10);

update manoeuvrebord set rang=1 where id='MDB_0003';
update manoeuvrebord set rang=2 where id='MDB_0004';
update manoeuvrebord set rang=3 where id='MDB_0005';



  CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANT (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDPROVISION, IDCATEGORIE, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MAJORATION, REDUCTION, MONTANTMAJORATION, MONTANTREDUCTION, IDACTIVITE, DATEFACT, RUBRIQUE, IDAVOIR) AS
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
       CAST(fm.pu * fm.quantite * nvl(duree,1) AS NUMBER(30, 3))                                 AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite* nvl(duree,1)) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite* nvl(duree,1)) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3))
                                                                                              AS montanttaux,
       NVL(montantsanstaux, 0)                                                                AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 3))
                                                                                              AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)                                                                  as MAJORATION,
       NVL(fm.REDUCTION, 0)                                                                   as REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite* nvl(duree,1)) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3)) as montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite* nvl(duree,1)) * fm.taux) * fm.REDUCTION / 100, 0) AS NUMBER(30, 3))  as montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE,
       IDAVOIR
FROM facture_client_Mere_fille fm
         LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;
