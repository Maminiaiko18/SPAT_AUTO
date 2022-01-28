
  CREATE OR REPLACE VIEW FCFILLECOMPLET (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, RANG, DUREE, MONTANTAV, RUBRIQUECPL, DATY, TIERS, IDCATEGORIE, TYPE, DEVISEMERE, EXERCICE, IDAVOIR, ETAT, MTAVOIR, MONTANTREDUCTION, MONTANTMAJORATION, MONTANT, MONTANTTVA, MONTANTTTC, MOISLIB, MONTANTHTSIMPLE) AS 
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

create view CAFCFILLECOMPLET as
select "ID",
       "IDMERE",
       "DESIGNATION",
       "QUANTITE",
       "PU",
       "COMPTE",
       "IDPRODUIT",
       "DEVISE",
       "TAUX",
       "IDACTIVITE",
       "TVA",
       "DATEFACT",
       "RUBRIQUE",
       "MOIS",
       "ANNEE",
       "HEUREDEBUT",
       "HEUREFIN",
       "REDUCTION",
       "MAJORATION",
       "TEST",
       "RANG",
       "DUREE",
       "MONTANTAV",
       "RUBRIQUECPL",
       "DATY",
       "TIERS",
       "IDCATEGORIE",
       "TYPE",
       "DEVISEMERE",
       "EXERCICE",
       "IDAVOIR",
       "ETAT",
       "MTAVOIR",
       "MONTANTREDUCTION",
       "MONTANTMAJORATION",
       "MONTANT",MONTANTTVA,MONTANTTTC,
       moislib,
       MONTANTHTSIMPLE
from fcfillecomplet ff
where FF.IDCATEGORIE <> 'CATFCO2';



  CREATE OR REPLACE VIEW COMPTECAFACTURE (ID, VAL, DESCE, IDMERE, DESIGNATION, QUANTITE, PU, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION, REDUCTION, DATEFACT, RUBRIQUE, RANG, DATY, VALMERECA, DESCEMERECA, MOIS, ANNEE, COMPTE, TYPE, MERECA) AS 
  select fdc.ID,
       cca.VAL,
       cca.DESCE,
       IDMERE,
       DESIGNATION,
       QUANTITE,
       PU,
       IDPRODUIT,
       DEVISE,
       TAUX,
       cast(0 as NUMBER(10, 2))     as QTELIVREE,
       cast(0 as NUMBER(10, 2))     as RESTEALIVRER,
       MONTANT                      as MONTANTTAUX,
       MONTANT,
       MTAVOIR                      as MONTANTAVOIRSANSTAUX,
       MTAVOIR                      as MONTANTAVOIRAVECTAUX,
       TVA,
       IDACTIVITE,
       cast('-' as VARCHAR2(100))      ACTIVITELIB,
       HEUREDEBUT,
       HEUREFIN,
       MOISLIB,
       cast(0 as NUMBER(10,3)) as TAUXEURO,
       cast(0 as NUMBER(10,3)) as MONTANTHTEURO,
       cast(0 as NUMBER(10,3)) as MONTANTTVAEURO,
       MONTANTTVA                   as MONTANTTAXE,
       MAJORATION,
       REDUCTION,
       DATEFACT,
       RUBRIQUE,
       RANG,
       DATY,
       mca.val                      as valMereCA,
       mca.desce                    as desceMereCA,
       extract(month from fdc.daty) as mois,
       extract(year from fdc.daty)  as annee,
       fdc.compte,
       TYPE,
       cca.DESCE                    as mereca
from CompteCA cca,
     MereCA mca,
     CAFCFILLECOMPLET fdc
where fdc.compte like cca.val || '%'
  and fdc.compte is not null
  and cca.desce = mca.id;
 


create or replace view SITUATIONLC_VIDE as
SELECT 'ID'                     AS id,
       'DESIGNATION'            AS DESIGNATION,
       'COMPTE'                 AS COMPTE,
       cast(0 as number(10))    AS ANNEE,
       cast(0 as number(2))     AS MOIS,
       cast(0 as number(30, 3)) AS MONTANT,
       cast(0 as number(10))    AS ETAT,
       cast(0 as number(30, 3)) AS FACTURE,
       cast(0 as number(30, 3)) AS PAYE,
       cast(0 as number(30, 3)) AS ARECOUVRIR,
       cast(0 as number(30, 3)) AS RESTEBUDGET,
       cast(0 as number(30, 3)) AS pourcEngage,
       cast(0 as number(30, 3)) AS pourcPaye,
       CURRENT_DATE             AS daty
FROM dual;



create or replace view DETAILSFACTUREFOURNISSEUR_PAYE
            (ID, IDINGREDIENT, QTE, PU, IDMERE, COMPTE, PUDEVISE, IDDQE, MARGE, TVA, DATY, MONTANTTTC, MONTANTPAYEPOURC,
             MONTANTPAYE, EXERCICE, ANNEE, MOIS, COMPTECPL)
as
select dff.ID,
       cast('-' as varchar2(100))                                  IDINGREDIENT,
       dff.QUANTITE                                             as QTE,
       dff.PU,
       dff.IDMERE,
       dff.COMPTE,
       dff.PUDEVISE,
       dff.IDDQE,
       dff.MARGE,
       dff.TVA,
       ff.DATY,
       dff1.MONTANTTAUX + MONTANTTAUXTVA - MONTANTAVOIRAVECTAUX as MONTANTTTC,
       ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1))    as montantpayepourc,
       (dff1.MONTANTTAUX + MONTANTTAUXTVA - MONTANTAVOIRAVECTAUX) *
       ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1))    as montantpaye,
       ff.EXERCICE,
       dff.ANNEE,
       dff.MOIS,
       case
           when dff.compte is null then null
           else
               ff.code_etablissementlib || '' || ff.projetlib || '' || dff.compte
           end as  COMPTECPL
from factfourn_msum_lib ff
         right join FACTURE_FOURNISSEUR_FILLE dff on dff.IDMERE = ff.id
         right join FACTFOURN_MONTANT dff1 on dff1.id = dff.id
where ff.ETAT >= 11;


 create or replace view SITUATIONLCDEPENSEV as
select l.id,
       l.DESIGNATION,
       l.compte,
       l.ANNEE,
       l.montant                                                                   as montant,
       l.etat,
       substr(l.compte, 7, length(l.compte))                                       as comptestr,
       cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))                              as facture,
       cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3))                             as PAYE,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3)) as arecouvrir,
       cast((l.montant) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                as restebudget,
       cast(((nvl(sum(MONTANTTTC), 0)) / l.MONTANT) * 100 as NUMBER(30, 3))        as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100 as number(30, 3))       as pourcPaye,
       comptecpl
from LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
    -- on substr(l.compte, 7, length(l.compte)) = mf.compte AND mf.annee = l.annee
                   on l.compte = mf.comptecpl  AND mf.annee = l.annee
where l.etat >= 11
  --and mf.comptecpl is not null
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat, substr(l.compte, 7, length(l.compte)), comptecpl;
  CREATE OR REPLACE VIEW FACTURECLIENTFILLE_LIBCOMPTECA (LIBELLECOMPTE, MOIS, ANNEE, MONTANTHT, MONTANTTVA, MONTANTTTC, MOISLIB) AS
  select cpt.LIBELLE   libelleCompte,
       ca.mois,
       ca.annee,
         cast(ca.MONTANT as NUMBER(30,3)) as montantht,
         cast(ca.montanttva as NUMBER(30,3)),
         cast(ca.montantttc as NUMBER(30,3)),
       m.VAL as moislib
from CAFCFILLECOMPLET ca,
     compteCA cpt,
     mois m
where cpt.val = ca.compte and m.ID=ca.mois;


  CREATE OR REPLACE VIEW FACTURE_CLIENT_MF_PAYE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANTTTC, MONTANTPAYEPOURC, MONTANTPAYE, EXERCICE, MOIS, ANNEE) AS 
  select fcf.ID,
       fcf.IDMERE,
       fcf.DESIGNATION,
       fcf.QUANTITE,
       fcf.PU,
       fcf.COMPTE,
       fcf.IDPRODUIT,
       fcf.DEVISE,
       fcf.TAUX,
       fcf.DATY,
       fcf.TIERS,
       fcf.DESIGNATIONMERE,
       fcf.TYPE,
       fcf.TVA,
       fcf.REMARQUE,
       fcf.IDUSER,
       fcf.DATE_ECHEANCE,
       fcf.ETAT,
       (fcf1.MONTANTTTC) as MONTANTTTC,
       round((l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1),3)                     as montantpayepourc,
       round( (fcf1.MONTANTTTC) * ((l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1)),3) as montantpaye,
       l.EXERCICE,
       fcf.mois,
       fcf.annee
from FACTURECLIENTMSUM_LIB l
         right join FACTURE_CLIENT_MERE_FILLE fcf on fcf.IDMERE = l.id
         join FCFILLECOMPLET fcf1 on fcf1.id = fcf.id
where l.ETAT >= 11;

CREATE OR REPLACE VIEW FACTURE_CLIENT_MF_PAYE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANTTTC, MONTANTPAYEPOURC, MONTANTPAYE, EXERCICE, MOIS,
             ANNEE,IDCATEGORIE)
AS
select fcf.ID,
       fcf.IDMERE,
       fcf.DESIGNATION,
       fcf.QUANTITE,
       fcf.PU,
       fcf1.COMPTE,
       fcf.IDPRODUIT,
       fcf.DEVISE,
       fcf.TAUX,
       fcf.DATY,
       fcf.TIERS,
       fcf1.DESIGNATIONMERE,
       fcf.TYPE,
       fcf.TVA,
       fcf1.REMARQUE,
       fcf1.IDUSER,
       fcf1.DATE_ECHEANCE,
       fcf.ETAT,
       (fcf.MONTANTTTC)                                                                 as MONTANTTTC,
       round((l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1), 3)                      as montantpayepourc,
       round((fcf.MONTANTTTC) * ((l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1)), 3) as montantpaye,
       l.EXERCICE,
       fcf.mois,
       fcf.annee,
       fcf1.IDCATEGORIE
from FACTURECLIENTMSUM_LIB l
         right join FCFILLECOMPLET fcf on fcf.IDMERE = l.id
         left join FACTURE_CLIENT_MERE_FILLE fcf1 on fcf1.id = fcf.id
where l.ETAT >= 11;

 
CREATE OR REPLACE VIEW SITUATIONLCRECETTEV
            (ID, DESIGNATION, COMPTE, ANNEE, MONTANT, ETAT, FACTURE, PAYE, ARECOUVRIR, RESTEBUDGET, POURCENGAGE,
             POURCPAYE,MOIS) AS
select l.id,
       l.DESIGNATION,
       l.compte,
       l.ANNEE,
       l.montant                                                                   as montant,
       l.etat,
       cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))                              as facture,
       cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3))                             as PAYE,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3)) as arecouvrir,
       cast((l.montant) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                as restebudget,
       cast((nvl(sum(MONTANTTTC), 0) / l.MONTANT) * 100 as NUMBER(30, 3))          as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100 as number(30, 3))       as pourcPaye,
       mf.MOIS
from LIGNECREDITRECETTE l
         LEFT JOIN FACTURE_CLIENT_MF_PAYE mf
                   on mf.compte like l.compte || '%' AND mf.annee = l.annee
where l.etat >= 11
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat,mois;

---nanampy HT
CREATE OR REPLACE VIEW FACTURE_CLIENT_MF_PAYE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANTTTC,MONTANTHT, MONTANTPAYEPOURC, MONTANTPAYE, montantHTpaye,EXERCICE, MOIS,
             ANNEE, IDCATEGORIE)
AS
select fcf.ID,
       fcf.IDMERE,
       fcf.DESIGNATION,
       fcf.QUANTITE,
       fcf.PU,
       fcf1.COMPTE,
       fcf.IDPRODUIT,
       fcf.DEVISE,
       fcf.TAUX,
       fcf.DATY,
       fcf.TIERS,
       fcf1.DESIGNATIONMERE,
       fcf.TYPE,
       fcf.TVA,
       fcf1.REMARQUE,
       fcf1.IDUSER,
       fcf1.DATE_ECHEANCE,
       fcf.ETAT,
       (fcf.MONTANTTTC)                                                                 as MONTANTTTC,
       (fcf.MONTANT)                                                                    as MONTANTHT,
       round((l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1), 3)                      as montantpayepourc,
       round((fcf.MONTANTTTC) * ((l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1)), 3) as montantpaye,
       round((fcf.MONTANT) * ((l.MONTANTPAYE) / nvl(nullif(l.MONTANT, 0), 1)), 3)       as montantHTpaye,
       l.EXERCICE,
       fcf.mois,
       fcf.annee,
       fcf1.IDCATEGORIE
from FACTURECLIENTMSUM_LIB l
         right join FCFILLECOMPLET fcf on fcf.IDMERE = l.id
         left join FACTURE_CLIENT_MERE_FILLE fcf1 on fcf1.id = fcf.id
where l.ETAT >= 11;

--cast
CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIBV
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB)
AS
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
       cast(MONTANT as NUMBER(30,3)),
       cast(MONTANTTVA as NUMBER(30,3)),
       cast(MONTANTAVOIR as NUMBER(30,3)),
       cast(MONTANTTTC as NUMBER(30,3)),
       cast(MONTANTPAYE as NUMBER(30,3)),
       cast(MONTANTRESTE as NUMBER(30,3)),
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
       ETATLIB
from FACTFOURN_MSUM_LIB
where ETAT >= 11;


CREATE OR REPLACE VIEW ETATBPVRAI
            (ID, MONTANTFACTURE, MONTANTPROVISION, MONTANTPAYE, ECART, TIERS, TIERSLIB, DATY, TIERSPROVISION,
             TIERSLIBPROVISION, MONTANTRESTE, IDPROVISION)
AS
SELECT fu.id,
       cast(SUM(NVL(FCUV.MONTANTTTC, 0)) as NUMBER(30, 3))                       AS montantfacture,
       cast(SUM(fu.MONTANTTTC) as NUMBER(30, 3))                                 AS montantprovision,
       cast(SUM(fu.MONTANTPAYE) as NUMBER(30, 3))                                AS MONTANTPAYE,
       cast(SUM(fu.MONTANTPAYE) - SUM(NVL(FCUV.MONTANTTTC, 0)) as NUMBER(30, 3)) AS ecart, --RAP
       fu.TIERS,
       fu.TIERSLIB,
       fu.DATY,
       '-'                                                                       AS tiersprovision,
       '-'                                                                       AS tierslibprovision,
       cast(SUM(fu.MONTANTTTC) - NVL(SUM(FCUV.MONTANTTTC), 0) as NUMBER(30, 3))
                                                                                 AS MONTANTRESTE,
       ''
FROM factfourn_msum_lib fu
         LEFT JOIN FACTURE_fourn_VISE_gp FCUV ON fu.id = FCUV.IDPROVISION
GROUP BY fu.id,
         fu.DATY,
         fu.tiers,
         fu.tierslib;

 



