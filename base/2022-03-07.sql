
create view PAYEMENTENGAGEMENT_TOUS as
select pe."ID",pe."IDENGAGEMENT",pe."IDOP",
       nvl(op.MONTANT,0) as montant,
       op.DED_ID,
       op.ETAT,
       ef.IDMERE as idengagementmere
from PAYEMENTENGAGEMENT pe
        left join ORDONNERPAYEMENT op on pe.IDOP = op.ID
         left join ENGAGEMENT_FILLE ef on pe.IDENGAGEMENT = ef.ID;
create or replace view ENGAGEMENT_FILLELIB as
select ef."ID",ef."IDMERE",ef."DESIGNATION",ef."MONTANT",
       case when pe.IDENGAGEMENT is null then 'NON'
            else 'OUI' end as estPaye
from engagement_fille ef
    left join PAYEMENTENGAGEMENT_TOUS pe on pe.IDENGAGEMENT=ef.ID and pe.ETAT>=11
group by ef.MONTANT,ef.DESIGNATION,ef.id,ef.IDMERE,pe.IDENGAGEMENT;

create view SITUATIONLCDEPENSE_FULL as
select l.id,
       l.DESIGNATION,
       l.compte,
       l.ANNEE,
       l.montant                                     as montant,
       l.etat,
       substr(l.compte, 7, length(l.compte))         as comptestr,
       substr(l.COMPTE, 7) || substr(l.COMPTE, 1, 6) as compteinv,
       substr(l.COMPTE, 7)                           as comptesimple,
       substr(l.COMPTE, 1, 6)                        as directionProjet,
       substr(substr(l.COMPTE, 1, 6), 1, 3)          as direction,
       substr(substr(l.COMPTE, 1, 6), 4, 7)          as projet,
       l.PROJET                                      as idprojet,
       l.CODEETABLISSEMENT                           as iddirection,
       substr(l.COMPTE, 1, 6)                        as comptefull

from LIGNECREDITDEPENSE l;

create or replace
    view SITUATIONLCDEPENSE_CPL as
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
       substr(substr(l.COMPTE, 1, 6), 4, 7)                                        as projet,
       l.PROJET as idprojet,
       l.CODEETABLISSEMENT as iddirection,
       ce.VAL||pr.DESIGNATION as comptefinal

from LIGNECREDITDEPENSE l
        left join CODEETABLISSEMENT ce on ce.ID=l.CODEETABLISSEMENT
        left join projet pr on pr.ID=l.PROJET;




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
                   ON mf.COMPTE=l.COMPTE
                       AND mf.ANNEE = l.ANNEE
where l.ETAT>=11
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.etat;



create or replace view SITUATIONLCDEPENSEVSD as
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
       comptecpl,
       substr(l.COMPTE, 7) || substr(l.COMPTE, 1, 6)                               as compteinv,
       substr(l.COMPTE, 7)                                                         as comptesimple,
       substr(l.COMPTE, 1, 6)                                                      as directionProjet,
       substr(substr(l.COMPTE, 1, 6), 1, 3)                                        as direction,
       substr(substr(l.COMPTE, 1, 6), 4, 7)                                        as projet,
     ----  mf.DATY,
       l.PROJET as idprojet ,
       l.CODEETABLISSEMENT as idCODEETABLISSEMENT

from LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
    -- on substr(l.compte, 7, length(l.compte)) = mf.compte AND mf.annee = l.annee
                   on l.compte = mf.COMPTE AND mf.annee = l.annee and length(mf.COMPTE)=11
where l.etat >= 11
      --and mf.comptecpl is not null
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat, substr(l.compte, 7, length(l.compte)), comptecpl,
         l.PROJET,         l.CODEETABLISSEMENT;


create or replace view situationLCDepenseGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                                         as compte,
       sum(l.montant)                                                                     as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) as NUMBER(30, 3)) as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                                          as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                                             as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))                        as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))                         as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3))                   as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))                      as pourcPaye
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))  as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE

                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    group by comptecpl, mf.COMPTE, mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select COMPTECPL as compte, sum(MONTANTTTC) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
                    --  and daty >= '01/01/2022' --and DATY <= '01/01/2022'
                    group by COMPTECPL, annee) n on n.compte = l.COMPTE
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev
                   -- WHERE ev.daty >= '01/01/2022' --and ev.DATY <= '01/01/2022'
                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where en.ETAT >= 11
                   --   and en.DATY >= '01/01/2022' --and en.DATY <= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
where 1 < 2
 -- and upper(l.directionProjet) like upper('%122%')
GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL;


create view OP_engagement  as
select op.ID,
       op.DED_ID,
       op.IDLIGNE,
       op.DATY,
       op.MONTANT,
       op.REMARQUE,
       op.ETAT,
       op.NUMEROOP,
       op.DESTINATION,
       op.MODEPAIEMENT,
       op.IDUSER,
       op.FOLIO,
       op.NUMCHEQUE,
       op.ETATLIB,
       op.MODEPAIEMENTLIB,
       op.TIERS,
       ff.IDENGAGEMENT
from ORDONNERPAYEMENT_LIBETAT op
         left join LIAISONINTRATABLE_OP_TOUS li on op.id = li.id2
         left join FACTURE_FOURNISSEUR_MERE ff on li.id1 = ff.id
where IDENGAGEMENT is not null;
create view LIBERER_MONTANT as
select  sum(li.MONTANT) as MONTANT, IDENGAGEMENT
from LIBERER li
where li.ETAT >= 11
group by IDENGAGEMENT
/



CREATE OR REPLACE VIEW "ENGAGEMENTLIB" ("ID", "DESIGNATION", "CODEETABLISSEMENT", "PROJET", "MONTANT", "DISPOAVANT", "DISPOAPRES", "COMPTE", "ETAT", "CODEETABLISSEMENTLIB", "PROJETLIB", "IDLC", "IDLCLIB", "DATY", "AVECFACTURE", "AVECFACTURELIB", "MONTANTOP", "DISPONIBLE") AS 
  select e."ID",
       e."DESIGNATION",
       nvl(e."CODEETABLISSEMENT", lp.CODEETABLISSEMENT) as CODEETABLISSEMENT,
       nvl(e."PROJET", lp.PROJET)                       as PROJET,
       e."MONTANT",
       --e."DISPONIBLE",
       e."DISPOAVANT",
       e."DISPOAPRES",
       e."COMPTE",
       e."ETAT",
       nvl(ce.VAL, ce1.val)                             as codeetablissementlib,
       nvl(p.DESIGNATION, p1.designation)               as projetlib,
       e.IDLC,
       lp.DESIGNATION                                   as idLClib,
       DATY,
       AVECFACTURE,
       case
           when avecFacture = 0 then 'NON'
           when avecFacture = 1 then 'OUI'
           end                                          as avecFacturelib,
       cast(nvl(gr.montant, 0) as NUMBER(30, 2))        as montantop,
       cast(e.MONTANT- nvl(eng.MONTANTTAUX,0)-nvl(lib.montant, 0) as NUMBER(30, 2))        as disponible
from engagement e
         left join CODEETABLISSEMENT ce on ce.ID = e.CODEETABLISSEMENT
         left join PROJET p on p.ID = e.PROJET
         left join LIGNECREDITDEPENSE lp on e.IDLC = lp.ID
         left join CODEETABLISSEMENT ce1 on ce1.ID = lp.CODEETABLISSEMENT
         left join PROJET p1 on p1.ID = lp.PROJET
         left join engagementOPMontant gr on gr.idengagement = e.ID
         left join FACTFOURN_ENGAGEMENT eng on eng.IDENGAGEMENT=e.id
         left join LIBERER_MONTANT lib on lib.IDENGAGEMENT=e.ID;


INSERT INTO CODEETABLISSEMENT (ID, VAL, DESCE, DEPARTEMENT, SERVICE)
VALUES ('CDEETB008877', '842', 'COMMUNICATION INTERNE ET RELATIONS AVEC LES ORGANISAMES SOCIAUX', 'DEPT0018',
        'SRV0027');


UPDATE LIGNECREDITDEPENSE SET CODEETABLISSEMENT = 'CDEETB008877' WHERE ID = 'LBD0338';
UPDATE LIGNECREDITDEPENSE SET CODEETABLISSEMENT = 'CDEETB008877' WHERE ID = 'LBD0339';