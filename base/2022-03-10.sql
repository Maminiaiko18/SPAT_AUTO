
create or replace view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                                         as compte,
       sum(l.montant)                                                                       as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) as NUMBER(30, 3))   as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                                            as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                                               as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))                          as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))                           as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3))                     as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))                        as pourcPaye,
       cast(sum(l.montant) -
            (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0)) as NUMBER(30, 3)) as resteApresEngmt,
       l.IDPROJET                                                                           as idprojet,
       l.IDDIRECTION                                                                        as idcodeEtablissement
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))  as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE
                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTECPL, 1, 6) as compte, sum(MONTANTTTC) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
                    group by substr(COMPTECPL, 1, 6), annee) n on n.compte = l.COMPTE
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev

                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                          --and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.IDPROJET, l.IDDIRECTION
/


create or replace view AS_BONDECOMMANDE_LIBELLE_LIB
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB, MONTANTREMISE, IDENGAGEMENTLIB, IDENGAGEMENT, CODEETABLISSEMENT,
             comptebdg)
as
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       bc.modepaiement,
       ti.NOM                                                                      as fournisseur,
       cast(bc.tva as NUMBER(10)),
       bc.NUMBC,
       cast(nvl(c.montantht, 0) as number(32, 2)),
       cast(nvl(c.montanttva, 0) as number(32, 2)),
       cast(nvl(c.montantttc, 0) as NUMBER(32, 2)),
       ''                                                                          as idfacture,
       cast(nvl(lfac.montantpayer, 0) as number(32, 2))                            as montant_paye_reel,
       cast((nvl(c.montantttc, 0) - nvl((bl.MONTANTTTC), 0)) as NUMBER(32, 2))     as resteapayegeneral,
       cast((nvl(c.montantttc, 0) - nvl((lfac.montantpayer), 0)) as NUMBER(32, 2)) as resteapayerreel,
       cast(nvl(bl.montantttc, 0) as NUMBER(32, 2))                                as montant_a_payer,
       bc.PROJET,
       bc.CODE_ETAB,
       cast(lfac.montantttc as NUMBER(32, 2))                                      as montantfacture,
       case
           when bcf.RESTELIVRE > 0 then 'VISE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture > 0
               THEN 'LIVRE(E)'
           WHEN bcf.restelivre = 0 AND Bcf.restefacture = 0 and
                (lfac.montantttc - nvl(lfac.montantpayer, 0) is not null)
               THEN 'FACTURE(E)'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) > 0
               THEN 'EN ATTENTE'
           WHEN Bcf.restelivre = 0 AND Bcf.restefacture = 0 and lfac.montantttc - nvl(lfac.montantpayer, 0) = 0
               THEN 'PAYE(E)'
           else 'CREE(E)'
           END                                                                     as etatlib,
       cast(MONTANTREMISE as NUMBER(32, 2)),
       idengagementlib,
       IDENGAGEMENT,
       CODEETABLISSEMENT,
       CODE_ETAB || PROJET                                                         as comptebdg
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
         left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
         LEFT JOIN BONDELIVRAISONPARBC bl ON bl.IDBC = bc.ID
         left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur
/



create or replace view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                                                              as compte,
       sum(l.montant)                                                                                            as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
            nvl(bc.montant, 0) as NUMBER(30, 3))                                                                 as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                                                                 as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                                                                    as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))                                               as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))                                                as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3))                                          as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))                                             as pourcPaye,
       cast(sum(l.montant) -
            (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0)) +
            nvl(bc.montant, 0) as NUMBER(30, 3))                                                                 as resteApresEngmt,
       l.IDPROJET                                                                                                as idprojet,
       l.IDDIRECTION                                                                                             as idcodeEtablissement
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))  as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE
                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTECPL, 1, 6) as compte, sum(MONTANTTTC) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
                    group by substr(COMPTECPL, 1, 6), annee) n on n.compte = l.COMPTE
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev

                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                          --and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
         left join(select COMPTEBDG, sum(MONTANT) as montant
                   from AS_BONDECOMMANDE_SANSFACT_ENG bc
                   group by COMPTEBDG) bc on bc.COMPTEBDG = l.COMPTEFULL

GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.IDPROJET, l.IDDIRECTION, bc.montant
/




create or replace view AS_BONDECOMMANDE_SANSFACT_ENG as
select *from AS_BONDECOMMANDE_LIBELLE_LIB where ID not in(
select ID_BC
from AS_BONDELIVRAISON bl
where bl.id in (select ff.IDBL from FACTURE_FOURNISSEUR_MERE ff where IDBL=bl.ID));



create or replace view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                     as compte,
       sum(l.montant)                                                   as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
            nvl(bc.montant, 0) as NUMBER(30, 3))                        as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                        as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                           as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))      as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))       as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3)) as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))    as pourcPaye,
       cast(sum(l.montant) -
            (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0)) +
            nvl(bc.montant, 0) as NUMBER(30, 3))                        as resteApresEngmt,
       l.IDPROJET                                                       as idprojet,
       l.IDDIRECTION                                                    as idcodeEtablissement
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))  as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE
                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTECPL, 1, 6) as compte, sum(MONTANTTTC) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
                    group by substr(COMPTECPL, 1, 6), annee) n on n.compte = l.COMPTE
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev

                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                          --and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
         left join(select COMPTEBDG, sum(MONTANT) as montant
                   from AS_BONDECOMMANDE_SANSFACT_ENG bc
                   group by COMPTEBDG) bc on bc.COMPTEBDG = l.COMPTEFULL

GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.IDPROJET, l.IDDIRECTION, bc.montant
/





create or replace
view AS_BONDECOMMANDE_SANSFACT_ENG as
select "ID",
       "DATY",
       "ETAT",
       "REMARQUE",
       "DESIGNATION",
       "MODEPAIEMENT",
       "FOURNISSEUR",
       "TVA",
       "NUMBC",
       "MONTANT",
       "MONTANTTVA",
       "MONTANTTTC",
       "IDFACTURE",
       "MONTANT_PAYE_REEL",
       "RESTEPAYERGENERAL",
       "RESTEAPAYERREEL",
       "MONTANT_A_PAYER",
       "PROJET",
       "CODE_ETAB",
       "MONTANTFACTURE",
       "ETATLIB",
       "MONTANTREMISE",
       "IDENGAGEMENTLIB",
       "IDENGAGEMENT",
       "CODEETABLISSEMENT",
       "COMPTEBDG"
from AS_BONDECOMMANDE_LIBELLE_LIB
where etat>=11 and ID not in (
    select ID_BC
    from AS_BONDELIVRAISON bl
    where bl.id in (select ff.IDBL from FACTURE_FOURNISSEUR_MERE ff where IDBL = bl.ID))
/



create or replace view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                     as compte,
       sum(l.montant)                                                   as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
            nvl(bc.montant, 0) as NUMBER(30, 3))                        as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                        as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                           as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))      as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))       as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3)) as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))    as pourcPaye,
       cast(sum(l.montant) -(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
            nvl(bc.montant, 0)) as NUMBER(30, 3))                        as resteApresEngmt,
       l.IDPROJET                                                       as idprojet,
       l.IDDIRECTION                                                    as idcodeEtablissement
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))  as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE
                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTECPL, 1, 6) as compte, sum(MONTANTTTC) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
                    group by substr(COMPTECPL, 1, 6), annee) n on n.compte = l.COMPTE
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev

                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                          --and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
         left join(select COMPTEBDG, sum(MONTANT) as montant
                   from AS_BONDECOMMANDE_SANSFACT_ENG bc
                   group by COMPTEBDG) bc on bc.COMPTEBDG = l.COMPTEFULL

GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.IDPROJET, l.IDDIRECTION, bc.montant
/




create or replace view AS_BONDECOMMANDE_SANSFACT_ENG as
select "ID",
       "DATY",
       "ETAT",
       "REMARQUE",
       "DESIGNATION",
       "MODEPAIEMENT",
       "FOURNISSEUR",
       "TVA",
       "NUMBC",
       "MONTANT",
       "MONTANTTVA",
       "MONTANTTTC",
       "IDFACTURE",
       "MONTANT_PAYE_REEL",
       "RESTEPAYERGENERAL",
       "RESTEAPAYERREEL",
       "MONTANT_A_PAYER",
       "PROJET",
       "CODE_ETAB",
       "MONTANTFACTURE",
       "ETATLIB",
       "MONTANTREMISE",
       "IDENGAGEMENTLIB",
       "IDENGAGEMENT",
       "CODEETABLISSEMENT",
       "COMPTEBDG"
from AS_BONDECOMMANDE_LIBELLE_LIB
where etat>=11 and ID not in (
    select ID_BC
    from AS_BONDELIVRAISON bl
    where bl.id in (select ff.IDBL from FACTURE_FOURNISSEUR_MERE ff where IDBL = bl.ID and ff.ETAT>=11) and bl.ETAT>=11)
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
       cast(((nvl(sum(MONTANTTTC), 0)) / nvl(nullif(l.montant,0),1)) * 100 as NUMBER(30, 3))   as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) / nvl(nullif(l.montant,0),1)) * 100 as number(30, 3))  as pourcPaye,
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
         l.etat,
         l.montant
/


create or replace view SITUATIONLCDEPENSEC as
select *
from SITUATIONLCDEPENSE
where etat = 1
/
