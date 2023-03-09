alter table facture_client_fille
    modify pu number(30, 3);
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
       CAST(0.0 AS NUMBER(30, 3)) AS montant,
       facture_client_fille.tva,
       facture_client_fille.IDACTIVITE,
       FACTURE_CLIENT_FILLE.DATEFACT
FROM facture_client_fille
where 1 > 2;



create or replace view AVOIRFCAVECTAUX as
select ac.*,
       cast(nvl(fc.TAUX, 1) as number(30, 3))              as taux,
       nvl(fc.DEVISE, 'Ar')                                as devise,
       cast(ac.MONTANT * nvl(fc.TAUX, 1) as number(30, 3)) as montantavectsaux,
       a.ETAT
from AVOIRFCFILLE ac
         left join FACTURE_CLIENT_FILLE fc on fc.ID = ac.IDDETAILFACTURE
         left join avoirfc a on ac.IDMERE = a.ID;


create or replace view ANALYSEGLOBALEFACTURE_VAOVAO
            (NMFACT, DATY, CATEGORIE_FACTURE, SOUS_CATEGORIE_FACTURE, CLIENT, CATEGORIE_CLIENT, DESIGNATION, MTTC, MTHT,
             TAXE, DEVFACT, MTDEVISE, MTAVOIR, PAYE, RESTE, NUMCOMPTE, VALCAT)
as
SELECT fc.id,
       fc.daty,
       cat.ID,
       '-',
       fc.tiers,
       cl.categorie,
       fc.designation,
       cast(fc.montantttc as number(32, 3)),
       cast(fc.montant as NUMBER(32, 3)),
       cast(fc.montanttva as NUMBER(32, 3)),
       '-',
       cast(fc.montantttc as NUMBER(32, 3)),
       cast(fc.montantavoir as NUMBER(32, 3)),
       cast(fc.MONTANTPAYE as NUMBER(32, 3)),
       cast(fc.MONTANTTTC - fc.MONTANTPAYE as NUMBER(32, 3)),
       '-',
       cat.val
FROM factureclientmsum_lib fc
         LEFT JOIN FACTURE_CLIENT_FILLE ff ON fc.id = FF.IDMERE
         LEFT JOIN ACTIVITE act ON ff.IDACTIVITE = act.ID
         LEFT JOIN RUBRIQUE_ACTIVITE rub ON act.RUBRIQUE = rub.ID
         LEFT JOIN CATEGORIEFACTURATION cat ON rub.CATEGORIE = cat.ID
         LEFT JOIN V_client_categorie cl ON fc.tiers = CL.CDCLT;


create view FACTURE_CLIENT_FILLE_LIBELLE as
select fi.ID,
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
       pr.nom                           as produit_lib,
       ac.DESIGNATION                   as activitelib,
       to_date(fi.DATEFACT, 'dd/MM/YY') AS DATEFACT
from FACTURE_CLIENT_FILLE fi
         left join AS_PRODUITS pr on pr.id = fi.IDPRODUIT
         left join activite ac on ac.id = fi.IDACTIVITE;


create or replace view FACTURE_CLIENT_FILLE_VM as
select fcf.*
from facture_client_fille fcf
         join factureclient fc on fcf.IDMERE = fc.ID
where fc.etat >= 11;


create or replace view FACTURE_CLIENT_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT)
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
       fc.etat
FROM facture_client_fille fi
         LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;


create or replace view AS_BONDELIVRAISON_CL_PDT as
select fi.ID,
       nvl(fil.idPRODUIT, fil.DESIGNATION) as produit,
       fi.NUMBL,
       fi.QUANTITE,
       fi.IDDETAILSFACTUREFOURNISSEUR,
       cast('' as varchar2(400))           as pdt
from as_bondelivraison_cl_fille fi
         left join FACTURE_CLIENT_FILLE fil on fi.IDDETAILSFACTUREFOURNISSEUR = fil.ID;

create  or replace view FACTURE_CLIENT_FILLE_LIB_RESTE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB)
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
       ra.DESIGNATION                             as activitelib
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         left join ACTIVITE ra on ra.id = fc.IDACTIVITE;



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
       CATEGORIECLIENTLIB
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
                fcm.CATEGORIE                                            as categorieclientlib
         from facture_client_fille fc
                  left join AS_PRODUITS pr on pr.ID = fc.IDPRODUIT
                  left join as_bondelivraison_cl_grp gr on gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
                  left join FACTURE_CLIENT_MONTANT_LIB fcm on fcm.id = fc.id
                  left join ACTIVITELIBCOMPLET al on al.id = fc.IDACTIVITE
         union all
         select *
         from ANALYSEGLOBALFACTURE_FAC);

