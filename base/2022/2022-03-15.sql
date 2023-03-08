

  CREATE OR REPLACE VIEW AVOIRFCFILLE_FACTURE
      (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, REMISE, DATY, IDFACTURE,
          ETAT, DESIGNATION, CODE, CATEGORIE, MOTIF, TYPE, RUBRIQUE,montantar) AS
  SELECT fc.ID,
          fc.IDMERE,
          fc.IDDETAILFACTURE,
          fc.MONTANT,
          fcf.COMPTE,
          fc.REMISE,
          fcf.DATY,
          fc.IDFACTURE,
          fc.ETAT,
          fc.DESIGNATION,
          fc.CODE,
          fc.CATEGORIE,
          fc.MOTIF,
          fc.TYPE,
          fcf.RUBRIQUE,
         MONTANTAVOIRAVECTAUX as montantAR
     FROM AVOIRFCFILLE_FM fc
          LEFT JOIN FACTURE_CLIENT_MONTANT fcf ON fc.IDDETAILFACTURE = fcf.ID;


create or replace view COMPTECAAVOIR as
select fdc.ID,
       IDMERE,
       IDDETAILFACTURE,
       fdc.MONTANTAR as MONTANT,
       --COMPTE,
       REMISE,
       DATY,
       IDFACTURE,
       ETAT,
       DESIGNATION,
       CODE,
       CATEGORIE,
       MOTIF,
       TYPE,
       extract(month from fdc.daty) as mois,
       extract(year from fdc.daty)  as annee,
       cca.val                      as compte,
       fdc.RUBRIQUE,
       cca.desce
from CompteCA cca,
     MereCA mca,
     AVOIRFCFILLE_FACTURE fdc
where fdc.compte like cca.val || '%'
  and fdc.compte is not null
  and cca.desce = mca.id
/



create or replace view COMPTECAAVOIR as
select fdc.ID,
       IDMERE,
       IDDETAILFACTURE,
       fdc.MONTANT as MONTANT,
       --COMPTE,
       REMISE,
       DATY,
       IDFACTURE,
       ETAT,
       DESIGNATION,
       CODE,
       CATEGORIE,
       MOTIF,
       TYPE,
       extract(month from fdc.daty) as mois,
       extract(year from fdc.daty)  as annee,
       cca.val                      as compte,
       fdc.RUBRIQUE,
       cca.desce,
       fdc.MONTANTAR

from CompteCA cca,
     MereCA mca,
     AVOIRFCFILLE_FACTURE fdc
where fdc.compte like cca.val || '%'
  and fdc.compte is not null
  and cca.desce = mca.id;


create or replace view COMPTECAAVOIRMOISAN as
select cca.rubrique,
       cca.compte,
       cca.DESCE                           as mere,
       cast(sum(MONTANT) as number(32, 3)) as montant,
       cca.mois,
       cca.annee
from CompteCAAvoir cca
group by cca.rubrique, cca.DESCE, cca.mois, cca.annee, cca.compte
/


CREATE OR REPLACE FORCE VIEW DETAILSFACTUREFOURNISSEUR_PAYE AS
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
       TYPEENGAGEMENT,
       dff1.MONTANTTAUX as MONTANT
from factfourn_msum_lib ff
         right join FACTURE_FOURNISSEUR_FILLE dff on dff.IDMERE = ff.id
         right join FACTFOURN_MONTANT dff1 on dff1.id = dff.id
where ff.ETAT >= 11 and ff.IDCATEGORIE!='CATGFF002';

create or replace view SITUATIONLCDEPENSETOUS as
select l.id,
       l.DESIGNATION,
       l.compte,
       l.ANNEE,
       cast(nvl(nullif(l.montant, 0), 1) as NUMBER(30,2))                                                             as montant,
       l.etat,
       substr(l.compte, 7, length(l.compte))                                                    as comptestr,
       cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))                                           as facture,
       cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3))                                          as PAYE,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3))              as arecouvrir,
       cast((l.montant) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                             as restebudget,
       cast(((nvl(sum(MONTANTTTC), 0)) / nvl(nullif(l.montant, 0), 1)) * 100 as NUMBER(30, 3))  as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) / nvl(nullif(l.montant, 0), 1)) * 100 as number(30, 3)) as pourcPaye,
       comptecpl,
       substr(l.COMPTE, 7) || substr(l.COMPTE, 1, 6)                                            as compteinv,
       substr(l.COMPTE, 7)                                                                      as comptesimple,
       substr(l.COMPTE, 1, 6)                                                                   as directionProjet,
       substr(substr(l.COMPTE, 1, 6), 1, 3)                                                     as direction,
       substr(substr(l.COMPTE, 1, 6), 4, 7)                                                     as projet,
       ----  mf.DATY,
       l.PROJET                                                                                 as idprojet,
       l.CODEETABLISSEMENT                                                                      as idCODEETABLISSEMENT

from LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
    -- on substr(l.compte, 7, length(l.compte)) = mf.compte AND mf.annee = l.annee
                   on l.compte = mf.COMPTE AND mf.annee = l.annee and length(mf.COMPTE) = 11
where l.etat >= 11
      --and mf.comptecpl is not null
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat, substr(l.compte, 7, length(l.compte)), comptecpl,
         l.PROJET, l.CODEETABLISSEMENT
/



  CREATE OR REPLACE VIEW FACTFOURN_FILL_LIB_REST_TAXE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE,
      IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX,
      TVA, IDACTIVITE, ACTIVITELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO,
      MONTANTTAXE, MAJORATION, REDUCTION, DATEFACT, RUBRIQUE, RANG, DATY, MONTANTTTC, COMPTESTR,CATEGORIE) AS
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
           end                                              as comptestr,
         idcategorie as CATEGORIE
FROM FACTURE_FOURNISSEUR_FILLE fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTFOURN_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE
         left join CODEETABLISSEMENT cet on cet.ID=fcm.CODE_ETABLISSEMENT
         left join projet pro on pro.id=fcm.PROJET;


create view FACTFOURN_FILL_LIB_RESTTAXESBP as
    select * from FACTFOURN_FILL_LIB_REST_TAXE
where CATEGORIE!='CATGFF002';
/



create or replace view SITUATIONLCDEPENSE as
SELECT l.id                                                                                     AS id,
       l.DESIGNATION                                                                            AS designation,
       l.COMPTE                                                                                 AS compte,
       l.ANNEE                                                                                  AS annee,
       cast((l.MONTANT) as NUMBER(30, 3))                                                    AS montant,
       l.etat,
       CAST(nvl(sum(MONTANTTTC), 0) AS NUMBER(30, 3))
                                                                                                AS facture,
       CAST(NVL(SUM(montantpaye), 0) AS NUMBER(30, 2))                                             paye,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3))              as arecouvrir,
       cast((sum(l.montant)) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                        as restebudget,
       cast(((nvl(sum(MONTANTTTC), 0)) / nvl(nullif(l.montant, 0), 1)) * 100 as NUMBER(30, 3))  as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) / nvl(nullif(l.montant, 0), 1)) * 100 as number(30, 3)) as pourcPaye,
       substr(substr(l.COMPTE, 1, 6), 1, 3)                                                     as direction,
       substr(substr(l.COMPTE, 1, 6), 4, 7)                                                     as projet
FROM LIGNECREDITDEPENSEVRAI l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
                   ON mf.COMPTE = l.COMPTE and length(mf.COMPTE) = 11

where l.ETAT >= 11
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.etat,
         l.montant
/

create or replace view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                     as compte,
       cast(sum(l.montant) as NUMBER(30,2))                                                   as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
            nvl(bc.montant, 0)+nvl(bp.montant,0) as NUMBER(30, 3))                        as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                        as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                           as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))      as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))       as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3)) as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))    as pourcPaye,
       cast(sum(l.montant) - (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
                              nvl(bc.montant, 0)+nvl(bp.montant,0)) as NUMBER(30, 3))     as resteApresEngmt,
       l.IDPROJET,
       l.iddirection,
       l.IDDIRECTION idcodeEtablissement
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANT), 0) as NUMBER(30, 3))  as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE

                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    WHERE 1 < 2
                    --  and mf.daty >= '01/01/2022'
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTE, 1, 6) as compte, sum(MONTANT) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
             --         and daty >= '01/01/2022'
                    group by substr(COMPTE, 1, 6), annee) n on n.compte = l.COMPTEFULL
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev
                    WHERE 1 < 2
               --      and ev.daty >= '01/01/2022'
                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                    --  and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
         left join (select comptebdg, sum(montant) as montant
                    from AS_BONDECOMMANDE_SANSFACT_ENG bc
                    WHERE 1 < 2
                    --  and bc.daty >= '01/01/2022'
                    group by comptebdg) bc on bc.comptebdg = l.comptefull
         left join (select sum(MONTANT)  as montant, daty, CODE_ETABLISSEMENTLIB || PROJETLIB as compte
                    from BPNonRegul
                    group by DATY, CODE_ETABLISSEMENTLIB || PROJETLIB ) bp on bp.compte=l.COMPTEFULL
where 1 < 2
GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.idprojet, l.iddirection, bc.montant,bp.montant
/




create or replace view COMPTECAFACTAVOIR as
select cca."RUBRIQUE",
       cca."RUBRIQUELIB",
       cca."COMPTE",
       cca."LIBELLE",
       cca."COMPTEMERE",
       cca."COMPTEMERELIB",
       cca."MERE",
       cca."MOIS",
       cca."ANNEE",
       cast(cca."NBREACREDIT" as NUMBER(10)) as nbCredit,
       cast(cca."AUCOMPTANT" as number(10)) as nbComptant,
       cast(cca."MONTANTACREDIT" as NUMBER(30,3)) as credit,
       cast(cca."MONTANTAUCOMPTANT" as NUMBER(30,3)) comptant,
       cast(cca."MONTANT" as NUMBER(30,3)) as MONTANT,
       cast(nvl(ccavoir.montant, 0) as NUMBER(30,3)) as avoir
from CompteCAFactureMoisAn cca
         left join CompteCAAvoirMoisAn ccavoir on cca.mois = ccavoir.mois and cca.annee = ccavoir.annee and
                                                  cca.compte = ccavoir.compte and cca.mere = ccavoir.mere and cca.RUBRIQUE=ccavoir.RUBRIQUE
/



  CREATE OR REPLACE VIEW DETAILSFACTUREFOURNISSEUR_PAYE (ID, IDINGREDIENT, QTE, PU, IDMERE, COMPTE, PUDEVISE, IDDQE, MARGE, TVA, DATY, MONTANTTTC, MONTANTPAYEPOURC, MONTANTPAYE, EXERCICE, ANNEE, MOIS, COMPTECPL, IDENGAGEMENT, IDLC, TYPEENGAGEMENT, MONTANT) AS
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
       dff.COMPTE as  COMPTECPL,
       dff1.IDENGAGEMENT,
       dff1.IDLC,
       TYPEENGAGEMENT,
       dff1.MONTANTTAUX as MONTANT
from factfourn_msum_lib ff
         right join FACTURE_FOURNISSEUR_FILLE dff on dff.IDMERE = ff.id
         right join FACTFOURN_MONTANT dff1 on dff1.id = dff.id
where ff.ETAT >= 11 and ff.IDCATEGORIE!='CATGFF002';


