
------------------------------------------------------
DELETE FROM MENUDYNAMIQUE
WHERE ID='MENBDG00031';
DELETE FROM USERMENU
WHERE ID='1MENP0000121';
DELETE FROM USERMENU
WHERE ID='UM008';



create or replace view SITUATIONLCDEPENSETOUS as
select l.id,
       l.DESIGNATION,
       l.compte,
       l.ANNEE,
       nvl(nullif(l.montant,0),1)                                                                   as montant,
       l.etat,
       substr(l.compte, 7, length(l.compte))                                       as comptestr,
       cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))                              as facture,
       cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3))                             as PAYE,
       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3)) as arecouvrir,
       cast((l.montant) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                as restebudget,
       cast(((nvl(sum(MONTANTTTC), 0)) /  nvl(nullif(l.montant,0),1) ) * 100 as NUMBER(30, 3))        as pourcEngage,
       cast(((nvl(sum(MONTANTPAYE), 0)) /  nvl(nullif(l.montant,0),1) ) * 100 as number(30, 3))       as pourcPaye,
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
         l.PROJET,         l.CODEETABLISSEMENT
/

