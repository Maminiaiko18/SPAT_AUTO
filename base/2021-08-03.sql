alter table coursdevise add estMICTSL varchar2(200);
CREATE OR REPLACE VIEW coursdeviselib AS
SELECT  CDV.*,
        CASE
            WHEN CDV.ESTMICTSL = 0 THEN 'NON'
            WHEN CDV.ESTMICTSL = 1 THEN 'OUI'
            END AS estMICTSLlib
FROM COURSDEVISE CDV;

create or replace view coursdeviseNonMICTSL  as select * from coursdevise where estMICTSL is null or estMICTSL<>1;

alter table facture_client_fille add reduction number(20,2);
alter table facture_client_fille add majoration number(20,2);
alter table factureclient add estDDPMICTSL varchar2(200);

create
or
replace view HEURENORMALE_LIB as
select hn.ID,
       pf.VAL as FONCTION,
       PERIODE,
       J1,
       J2,
       J3,
       J4,
       J5,
       J6,
       J7
from HEURENORMALE hn
         left join paie_fonction pf on hn.FONCTION = pf.ID;
		 
create OR REPLACE view FACTURECLIENTMSUM as
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
          CAST (NVL (grp.montanttaux, 0) AS NUMBER (30, 3)) AS montant,
          CAST (NVL (grp.MONTANTTVA, 0) AS NUMBER (30, 3)) AS montanttva,
          NVL (grp.montantavoiravectaux, 0) AS montantavoir,
          CAST (
               NVL (NVL (grp.MONTANTTVA, 0) + grp.montanttaux, 0)
             - NVL (grp.montantavoiravectaux, 0) AS NUMBER (30, 3))
             AS MONTANTTTC,
          pr.ESCALE,
          tfc.VAL AS typelib,
          fc.IDCATEGORIE,
          catfc.VAL AS CATEGORIELIB,
          fc.IDPROVISION,
          fcf.DESIGNATION AS IDPROVISIONlib,
       fc.ESTDDPMICTSL
     FROM FACTURECLIENT fc
          LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id
          LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
          LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
          LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
          LEFT JOIN factureclient fcf ON fcf.IDPROVISION = fc.IDPROVISION;
		  
create or replace view FACTURECLIENTMSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL)
as
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
          CAST (NVL (jc.montant, 0) AS NUMBER (32, 3)) AS montantpaye,
          CAST (M.MONTANTTTC - NVL (jc.montant, 0) AS NUMBER (32, 3))
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
       m.ESTDDPMICTSL
     FROM factureclientMSum m
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
          LEFT JOIN JOURNALCAISSELIB_VISE_SUM jc ON jc.IDPLACEMENT = m.id;
		  
create or replace view FACTURE_CLIENT_FILLE_PLUS as
SELECT facture_client_fille.ID,
          facture_client_fille.IDMERE,
          facture_client_fille.DESIGNATION,
          facture_client_fille.QUANTITE,
          facture_client_fille.PU,
          facture_client_fille.COMPTE,
          facture_client_fille.IDPRODUIT,
          facture_client_fille.DEVISE,
          facture_client_fille.TAUX,
          CAST (0.0 AS NUMBER (30, 3)) AS montant,
          facture_client_fille.tva,
          facture_client_fille.IDACTIVITE,
          FACTURE_CLIENT_FILLE.DATEFACT,
          facture_client_fille.RUBRIQUE,
          facture_client_fille.MOIS,
          facture_client_fille.ANNEE,
          facture_client_fille.HEUREDEBUT,
          facture_client_fille.HEUREFIN ,
       FACTURE_CLIENT_FILLE.MAJORATION,
       FACTURE_CLIENT_FILLE.REDUCTION
     FROM facture_client_fille
    WHERE 1 > 2;
	
create or replace view FACTURE_CLIENT_MFVAOVAO as
SELECT fi."ID",fi."IDMERE",fi."DESIGNATION",fi."QUANTITE",fi."PU",fi."COMPTE",fi."IDPRODUIT",fi."DEVISE",fi."TAUX",fi."IDACTIVITE",fi."TVA",fi."DATEFACT",fi."RUBRIQUE",
       fc.daty,
       fc.tiers,
       fc.designation AS designationmere,
       fc.TYPE,
       decode(fi.tva, null, fc.tva, fi.tva) AS TVAFILLE,
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat,
       nvl(fi.MAJORATION,0) as MAJORATION,
       NVL(fi.REDUCTION ,0) as REDUCTION
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;
		 
create or replace view FACTURE_CLIENT_FILLE_VM as
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
       mois,
       ANNEE,
       TIERS,
       nvl(fcf.MAJORATION, 0) as MAJORATION,
       nvl(fcf.REDUCTION, 0)  as REDUCTION
from facture_client_fille fcf
         join factureclient fc on fcf.IDMERE = fc.ID
where fc.etat >= 11;

create view FACTURE_CLIENT_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION)
as
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
       decode(fi.tva, null, fc.tva, fi.tva),
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.IDPREVISION,
       nvl(fi.REDUCTION,0) as REDUCTION,
       nvl(fi.MAJORATION,0) as MAJORATION
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;
		 
create or replace view FACTURE_CLIENT_FILLE_LIB_RESTE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MAJORATION, REDUCTION)
as
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
          CAST (fcm.MONTANTTAUX AS NUMBER (32, 3)),
          CAST (fcm.MONTANT AS NUMBER (32, 5)),
          CAST (fcm.MONTANTAVOIRSANSTAUX AS NUMBER (32, 3)),
          CAST (fcm.MONTANTAVOIRAVECTAUX AS NUMBER (32, 3)),
          CAST (fcm.tva AS NUMBER (20, 3)),
          idactivite,
          ra.DESIGNATION AS activitelib,
          fc.mois,
          fc.annee,
          fc.heureDebut,
          fc.heureFin,
          mois.VAL AS moislib,
          CAST (0 AS NUMBER (32, 2)) AS tauxEuro,
          CAST (0 AS NUMBER (32, 2)) AS montantHTEuro,
          CAST (0 AS NUMBER (32, 2)) AS montantTVAEuro,
          nvl(fc.majoration,0) as majoration,
          nvl(fc.reduction,0) as reduction
     FROM facture_client_fille fc
          LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
          LEFT JOIN as_bondelivraison_cl_grp gr
             ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
          LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
          LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
          LEFT JOIN mois ON mois.id = fc.mois;
		  
		create view FACTURE_CLIENT_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION)
as
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
       decode(fi.tva, null, fc.tva, fi.tva),
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.IDPREVISION,
       nvl(fi.REDUCTION,0) as REDUCTION,
       nvl(fi.MAJORATION,0) as MAJORATION
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;
		 

create or replace
    view FACTURE_CLIENT_FILLE_LIB_PDF
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEELIB, HEUREDEBUT, HEUREFIN, MOISLIB,MAJORATION,REDUCTION)
as
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANT AS NUMBER(32, 5)),
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3)),
       CAST(fcm.tva AS NUMBER(20, 3)),
       idactivite,
       ra.DESIGNATION                             as activitelib,
       fc.mois,
       cast(fc.annee as VARCHAR2(100)) as annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL as moislib,
       fc.MAJORATION,
       fc.REDUCTION
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         left join ACTIVITE ra on ra.id = fc.IDACTIVITE
        left join mois on mois.id=fc.mois;
		
create or replace view FACTURE_CLIENT_FILLE_LIBELLE as
SELECT fi.ID,
          fi.IDMERE,
          fi.DESIGNATION,
          fi.QUANTITE,
          fi.PU,
          fi.COMPTE,
          fi.IDPRODUIT,
          fi.DEVISE,
          fi.TAUX,
          fi.IDACTIVITE,
          fi.TVA,
          pr.nom AS produit_lib,
          ac.DESIGNATION AS activitelib,
          TO_DATE (fi.DATEFACT, 'dd/MM/YY') AS DATEFACT,
          fi.RUBRIQUE,
          ra.DESIGNATION AS rubriquelib,
          fi.MOIS,
          fi.ANNEE,
          fi.HEUREDEBUT,
          fi.HEUREFIN,
       nvl(fi.MAJORATION,0) as MAJORATION,
       nvl(fi.REDUCTION,0) as REDUCTION
     FROM FACTURE_CLIENT_FILLE fi
          LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
          LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = fi.RUBRIQUE;

create or replace view FACTURE_CLIENT_FILLE_LIB as
select ID,
       IDMERE,
       DESIGNATION,
       cast(QUANTITE as NUMBER(32, 3))             as QUANTITE,
       cast(PU as NUMBER(32, 3))                   as PU,
       COMPTE,
       IDPRODUIT,
       DEVISE,
       TAUX,
       cast(QTELIVREE as number(32, 3))            as QTELIVREE,
       cast(RESTEALIVRER as NUMBER(32, 3))         as RESTEALIVRER,
       cast(MONTANTTAUX as NUMBER(32, 3))          as MONTANTTAUX,
       cast(MONTANT as NUMBER(32, 3))              as MONTANT,
       cast(MONTANTAVOIRSANSTAUX as NUMBER(32, 3)) as MONTANTAVOIRSANSTAUX,
       cast(MONTANTAVOIRAVECTAUX as NUMBER(32, 3)) as MONTANTAVOIRAVECTAUX,
       IDPRODUITLIB,
       IDACTIVITE,
       CATEGORIEFACTURELIB,
       CATEGORIECLIENTLIB,
       RUBRIQUELIB,
       clientlib,
       MAJORATION,
       REDUCTION
from (
         select fc.ID,
                fc.IDMERE,
                fc.DESIGNATION,
                fc.QUANTITE,
                fc.PU,
                fc.COMPTE,
                fc.IDPRODUIT,
                fc.DEVISE,
                fc.TAUX,
                cast(nvl(gr.QUANTITE, 0) as number(10, 3))               as qteLivree,
                cast(fc.QUANTITE - nvl(gr.QUANTITE, 0) as number(10, 3)) as resteAlivrer,
                cast(fcm.MONTANTTAUX as number(32, 3))                   as MONTANTTAUX,
                cast(fcm.MONTANT as NUMBER(32, 3))                       as MONTANT,
                cast(fcm.MONTANTAVOIRSANSTAUX as number(32, 3))          as MONTANTAVOIRSANSTAUX,
                cast(fcm.MONTANTAVOIRAVECTAUX as NUMBER(32, 3))          as MONTANTAVOIRAVECTAUX,
                pr.nom                                                   AS IDPRODUITlib,
                fc.IDACTIVITE,
                al.CATEGORIELIB                                          as categorieFacturelib,
                fcm.CATEGORIE                                            as categorieclientlib,
                nvl(RUBRIQUELIB, ra.DESIGNATION)                         as RUBRIQUELIB,
                v.NOMCLT as clientlib,
                nvl(fc.MAJORATION,0) as MAJORATION,
                nvl(fc.REDUCTION,0) as REDUCTION
         from facture_client_fille fc
                  left join AS_PRODUITS pr on pr.ID = fc.IDPRODUIT
                  left join as_bondelivraison_cl_grp gr on gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
                  left join FACTURE_CLIENT_MONTANT_LIB fcm on fcm.id = fc.id
                  left join ACTIVITELIBCOMPLET al on al.id = fc.IDACTIVITE
                  left join RUBRIQUE_ACTIVITE ra on ra.id = fc.RUBRIQUE
                  left join FACTURECLIENT f on fc.IDMERE = f.ID
                   left join  V_CLIENT_CATEGORIE v on v.CDCLT=f.TIERS
         union all
         select a.*,
                cast('-' as VARCHAR2(500)) as RUBRIQUELIB,
                cast('-' as VARCHAR2(500)) as clientlib,
                0 as MAJORATION,
                0 as REDUCTION
         from ANALYSEGLOBALFACTURE_FAC a);