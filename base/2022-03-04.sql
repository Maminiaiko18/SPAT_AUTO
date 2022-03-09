create or replace view SITUATIONLCDEPENSE as
SELECT l.id                                  AS        id,
       l.DESIGNATION                         AS        designation,
       l.COMPTE                              AS        compte,
       l.ANNEE                               AS        annee,
       cast(sum(l.MONTANT) as NUMBER(30, 3)) AS        montant,
       l.etat,
       CAST(nvl(sum(MONTANTTTC), 0) AS NUMBER(30, 3))
                                             AS        facture,
       CAST(NVL(SUM(montantpaye), 0) AS NUMBER(30, 2)) paye,
       substr(substr(l.COMPTE, 1, 6), 1, 3)  as        direction,
       substr(substr(l.COMPTE, 1, 6), 4, 7)  as        projet
FROM LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
                   ON SUBSTR(mf.COMPTE, 0, LENGTH(l.COMPTE)) LIKE l.COMPTE
                       AND EXTRACT(YEAR FROM daty) = l.ANNEE
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.etat
/

create or replace view SITUATIONLCDEPENSEC as
select * from SITUATIONLCDEPENSE where etat=1
/

create or replace view LIBERER_GRP as
select en.ID, sum(en.MONTANT) as MONTANT, DATY as DATYENGAGEMENT
from LIBERER li
         left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
where en.ETAT >= 11
group by en.ID, DATY
/


UPDATE SPAT_CAPITAINERIE.MENUDYNAMIQUE
SET LIBELLE='Liste', ICONE='fa fa-list', HREF='/spat/pages/globalnegoce.jsp?but=ligneCredit/liste-ligneCreditDepense.jsp', RANG=2, NIVEAU=4, ID_PERE='MENBDG00021'
WHERE ID='MENBDG000212';
INSERT INTO SPAT_CAPITAINERIE.MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENBDG000213', 'FCC', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=ligneCredit/situation-ligneCreditDepense.jsp', 3, 4, 'MENBDG00021');


create or replace view FACTFOURN_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION,
             IDACTIVITE, DATEFACT, RUBRIQUE, IDENGAGEMENT, ANNEE,TYPEENGAGEMENT)
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
       fc.IDENGAGEMENT,ANNEE,
       TYPEENGAGEMENT
FROM FACTURE_FOURNISSEUR_FILLE fi
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fc ON fi.idmere = fc.id
/


create or replace view FACTFOURN_MONTANT as
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
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2)) * fm.tva /
       100                                                                                    as montanttauxtva,
       fm.IDENGAGEMENT,
       en.IDLC,
       en.DATY as datyengagement,
       annee,
       TYPEENGAGEMENT
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirffavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID
         left join engagement en on en.id = fm.IDENGAGEMENT
/

create or replace view DETAILSFACTUREFOURNISSEUR_PAYE as
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
           end as  COMPTECPL,
       dff1.IDENGAGEMENT,
       dff1.IDLC,
       TYPEENGAGEMENT
from factfourn_msum_lib ff
         right join FACTURE_FOURNISSEUR_FILLE dff on dff.IDMERE = ff.id
         right join FACTFOURN_MONTANT dff1 on dff1.id = dff.id
where ff.ETAT >= 11
/


create or replace view SITUATIONLCDEPENSE as
SELECT l.id                                                                        AS id,
       l.DESIGNATION                                                               AS designation,
       l.COMPTE                                                                    AS compte,
       l.ANNEE                                                                     AS annee,
       cast(sum(l.MONTANT) as NUMBER(30, 3))                                       AS montant,
       l.etat,
       CAST(nvl(sum(MONTANTTTC), 0) AS NUMBER(30, 3))
                                                                                   AS facture,
       CAST(NVL(SUM(montantpaye), 0) AS NUMBER(30, 2))                                paye,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3)) as arecouvrir,
       cast((sum(l.montant)) - nvl(sum(montantttc), 0) as NUMBER(30, 3))           as restebudget,
       cast(((nvl(sum(MONTANTTTC), 0)) / sum(l.MONTANT)) * 100 as NUMBER(30, 3))   as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) / sum(l.MONTANT)) * 100 as number(30, 3))  as pourcPaye,
       substr(substr(l.COMPTE, 1, 6), 1, 3)                                        as direction,
       substr(substr(l.COMPTE, 1, 6), 4, 7)                                        as projet
FROM LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
                   ON SUBSTR(mf.COMPTE, 0, LENGTH(l.COMPTE)) LIKE l.COMPTE
                       AND EXTRACT(YEAR FROM daty) = l.ANNEE
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.etat;

create or replace view SITUATIONLCDEPENSEC as
select *
from SITUATIONLCDEPENSE
where etat = 1;


create or replace view SITUATIONLCDEPENSE as
SELECT l.id                                                                        AS id,
       l.DESIGNATION                                                               AS designation,
       l.COMPTE                                                                    AS compte,
       l.ANNEE                                                                     AS annee,
       cast(sum(l.MONTANT) as NUMBER(30, 3))                                       AS montant,
       l.etat,
       CAST(nvl(sum(MONTANTTTC), 0) AS NUMBER(30, 3))
                                                                                   AS facture,
       CAST(NVL(SUM(montantpaye), 0) AS NUMBER(30, 2))                                paye,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3)) as arecouvrir,
       cast((sum(l.montant)) - nvl(sum(montantttc), 0) as NUMBER(30, 3))           as restebudget,
       cast(((nvl(sum(MONTANTTTC), 0)) / sum(l.MONTANT)) * 100 as NUMBER(30, 3))   as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) / sum(l.MONTANT)) * 100 as number(30, 3))  as pourcPaye,
       substr(substr(l.COMPTE, 1, 6), 1, 3)                                        as direction,
       substr(substr(l.COMPTE, 1, 6), 4, 7)                                        as projet
FROM LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
                   ON mf.COMPTECPL=l.COMPTE
                       AND mf.ANNEE = l.ANNEE
where l.ETAT>=11
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.etat;


create or replace view FACTFOURN_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION,
             IDACTIVITE, DATEFACT, RUBRIQUE, IDENGAGEMENT, ANNEE, TYPEENGAGEMENT, CODE_ETABLISSEMENT, PROJET)
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
       fc.IDENGAGEMENT,
       ANNEE,
       TYPEENGAGEMENT,
       CODE_ETABLISSEMENT,
       PROJET
FROM FACTURE_FOURNISSEUR_FILLE fi
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fc ON fi.idmere = fc.id
/

create or replace view FACTFOURN_MONTANT as
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
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 2)) * fm.tva /
       100                                                                                    as montanttauxtva,
       fm.IDENGAGEMENT,
       en.IDLC,
       en.DATY as datyengagement,
       annee,
       TYPEENGAGEMENT,
       CODE_ETABLISSEMENT,
       en.PROJET
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirffavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID
         left join engagement en on en.id = fm.IDENGAGEMENT
/


create or replace view FACTFOURN_FILL_LIB_REST_TAXE as
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
       case when fc.IDACTIVITE is not null then ra.DATY end as daty,
       cast(MONTANTtaux + MONTANTTAUXTVA as NUMBER(30, 2))  as montantttc,
       case
           when fc.compte is null then null
           else
               cet.VAL || '' || pro.DESIGNATION || '' || fc.compte
           end                                              as comptestr
FROM FACTURE_FOURNISSEUR_FILLE fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTFOURN_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE
         left join CODEETABLISSEMENT cet on cet.ID=fcm.CODE_ETABLISSEMENT
         left join projet pro on pro.id=fcm.PROJET
/
