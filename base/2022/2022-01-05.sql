
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MEN0006811', 'Redevance communale', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=facture/redevance-communale-liste.jsp', 10, 3,
        'MEN00068');

create or replace view FACT_CLT_FILL_LIB_REST_TAXE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION,
             REDUCTION, DATEFACT, RUBRIQUE, RANG, DATY, DUREE, TYPE)
as
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
       CAST(((fc.pu * fc.QUANTITE * nvl(duree,1))* fc.TVA) / 100 AS NUMBER(20, 3))
                                                                          AS montanttaxe,
       NVL(fc.majoration, 0)                                              AS majoration,
       NVL(fc.reduction, 0)                                               AS reduction,
       fc.DATEFACT,
       nvl(fc.RUBRIQUE,r.ID),
      fc.rang,
       CASE WHEN fc.IDACTIVITE IS NOT NULL THEN ra.DATY else fcm.DATY END AS daty,
       fc.DUREE,
        fcm.TYPE
FROM facture_client_fille_rangfinal fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE
         LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fc.RUBRIQUE
/

create view FACTURE_CLIENT_MONTANT as
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
       CAST(((fm.pu * fm.quantite*nvl(duree,1)) * fm.taux) -
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
         LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID
/

create view redevanceCommunaleFacture as
select e.id,
       e.code,
       e.typelib,
       e.daty,
       e.tierslib,
       cast(a.MONTANTTAUX as NUMBER(30,3)) as montantHT,--(avy amin’ny détails where rubrique=redevance communale)
       e.tva,-- (valeur tva ho an’ilay ligne)
       cast(a.MONTANTTAUX + MONTANTTAXE as NUMBER(30,3)) as montantTTC-- (an’ilay détails foana)
from FACTURE_CLIENT_UNIONV e
        left join FACT_CLT_FILL_LIB_REST_TAXE  a on a.IDMERE=e.id
where lower(e.DESIGNATION)=lower('%REDEVANCE COMMUNALE%');


CREATE OR REPLACE VIEW FABRICATIONCATLIB (ID, DATY, PRODUIT, INGREDIENT, REMARQUE, CATEGORIE, QTE, DEPOT, ETAT,montant,pu) AS
select f.id,
       f.daty,
       rl.libelleproduit                                  as produit,
       rl.libelleingredient                               as ingredient,
       f.remarque,
       c.val                                              as categorie,
       cast(nvl(f.qte * rl.quantite, 0) as number(10, 2)) as qte,
       f.depot,
       f.etat,
       rl.pu,
       rl.pu*cast(nvl(f.qte * rl.quantite, 0) as number(10, 2)) as montant
from fabrication f
         join AS_RECETTE_LIBCOMPLET rl on rl.idproduits = f.ingredient
         left join AS_INGREDIENTS ing on ing.ID = rl.IDINGREDIENTS
         join categorieingredient c on ing.categorieingredient = c.id;
