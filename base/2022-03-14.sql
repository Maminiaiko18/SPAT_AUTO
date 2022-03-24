CREATE OR REPLACE VIEW BPNonREgul AS
  SELECT * from factfourn_msum_lib f
  where 1<2
  AND id NOT in (select idprovision from factfourn_msum_libV e where e.IDPROVISION=f.id )
  and f.etat>=11 and f.idcategorie='CATGFF002';
create or replace view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                     as compte,
       sum(l.montant)                                                   as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
            nvl(bc.montant, 0)+nvl(bp.montant,0) as NUMBER(30, 3))                        as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                        as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                           as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))      as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))       as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3)) as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))    as pourcPaye,
       cast(sum(l.montant) - (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
                              nvl(bc.montant, 0)+nvl(bp.montant,0)) as NUMBER(30, 3))     as resteApresEngmt
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))  as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE

                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    WHERE 1 < 2
                    --  and mf.daty >= '01/01/2022'
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTE, 1, 6) as compte, sum(MONTANTTTC) as montant, annee
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
         left join (select sum(MONTANT)  as montant,  CODE_ETABLISSEMENTLIB || PROJETLIB as compte
                    from BPNonRegul
                    group by  CODE_ETABLISSEMENTLIB || PROJETLIB ) bp on bp.compte=l.COMPTEFULL
where 1 < 2
GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.idprojet, l.iddirection, bc.montant,bp.montant;
