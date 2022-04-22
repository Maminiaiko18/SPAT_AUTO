CREATE OR REPLACE FORCE VIEW "SITUATIONLCDEPENSEGRP" ("DIRECTION", "PROJET", "COMPTE", "MONTANT", "ENGAGEER", "FACTURE", "PAYE", "ARECOUVRIR", "RESTEBUDGET", "POURCENGAGE", "POURCPAYE", "RESTEAPRESENGMT", "IDPROJET", "IDCODEETABLISSEMENT", "ANNEE") AS 
  select l.direction,
       l.projet,
       l.COMPTEFULL                                                     as compte,
       cast(sum(l.montant)  as number(30,3))                                                 as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) + nvl(bc.montant, 0) +
            nvl(bp.montant, 0) as NUMBER(30, 3))                        as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                        as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                           as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))      as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))       as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3)) as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))    as pourcPaye,
       cast(sum(l.montant) - (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
                              nvl(bc.montant, 0)) as NUMBER(30, 3))     as resteApresEngmt,
       l.idprojet,
       l.iddirection                                                    AS idcodeEtablissement,
       l.ANNEE
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANT), 0) as NUMBER(30, 3))     as facture,
                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,
                           substr(mf.COMPTE, 1, 6)                         as comptefull,
                           mf.ANNEE

                    FROM DETAILSFACTUREFOURNISSEUR_paye mf
                    WHERE 1 < 2 and (typeengagement!='ED' or TYPEENGAGEMENT is null)
                          --  and mf.daty >= '01/01/2022'
                    group by substr(mf.COMPTE, 1, 6), mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull
         left join (select substr(COMPTE, 1, 6) as compte, sum(MONTANT) as montant, annee
                    from DETAILSFACTUREFOURNISSEUR_paye
                    where IDENGAGEMENT is null
                          --   and daty >= '01/01/2022'
                    group by substr(COMPTE, 1, 6), annee) n on n.compte = l.COMPTEfull
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev
                    WHERE 1 < 2
                          --    and ev.daty >= '01/01/2022'
                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                          -- and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
         left join (select comptebdg, sum(MONTANTNONFACTURE) as montant
                    from SITUATION_BC_SANSENG bc
                    WHERE 1 < 2
                          --  and bc.daty >= '01/01/2022'
                    group by comptebdg) bc on bc.comptebdg = l.comptefull
         left join (select sum(MONTANTRESTE) as montant, COMPTEFULL as compte
                    from ETATBPVRAI bp
                    WHERE 1 < 2
                          --  and bp.daty >= '01/01/2022'
                    group by COMPTEFULL) bp on bp.compte = l.COMPTEFULL
where 1 < 2
GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.idprojet, l.iddirection, bc.montant, bp.montant, l.idprojet,
         l.iddirection, l.ANNEE;



CREATE OR REPLACE FORCE VIEW "FACTURECLIENT_LIBCOMPLET" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDPREVISION", "IDCATEGORIE", "IDPROVISION", "DEVISEMERE", "ESTDDPMICTSL", "CODEPRESTATION", "CODE", "ESTMICTSL", "TIERSLIB", "CATEGORIELIB", "TYPELIB","ARMATEUR","ARMATEURLIB") AS 
  select fc."ID",
       fc."DATY",
       fc."TIERS",
       fc."DESIGNATION",
       fc."TYPE",
       fc."TVA",
       fc."REMARQUE",
       fc."IDUSER",
       fc."DATE_ECHEANCE",
       fc."ETAT",
       fc."IDPREVISION",
       fc."IDCATEGORIE",
       fc."IDPROVISION",
       fc."DEVISEMERE",
       fc."ESTDDPMICTSL",
       fc."CODEPRESTATION",
       fc."CODE",
       fc."ESTMICTSL",
       fup.NOM as tierslib,
       cat.VAL as categorielib,
       tf.VAL  as typelib,
       fc.armateur as armateur, 
       a.val as armateurlib
from FACTURECLIENT fc
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = fc.TIERS
         left join CATEGORIEFC cat on cat.ID = fc.IDCATEGORIE
         left join TYPEFC tf on tf.ID = fc.TYPE
         left join armateur_TBD a on a.id=fc.armateur; 








