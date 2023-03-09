create or replace view REMBOURSEMENTPLACEMENTLIB as
select r."ID",r."DATY",r."IDPLACEMENT",r."MONTANTPLACE",r."INTERET",r."CAISSE",r."ETAT",
       p.entite,
       p.banque,
       c.val as caisselib
from remboursementPlacement r
    left join placementlib p on r.idplacement=p.ID
    left join caisse c on r.caisse=c.ID
/



CREATE OR REPLACE VIEW SITUATIONLCDEPENSEV
            (ID, DESIGNATION, COMPTE, ANNEE, MONTANT, ETAT, COMPTESTR, FACTURE, PAYE, ARECOUVRIR, RESTEBUDGET,
             POURCENGAGE, POURCPAYE)
AS
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
       cast(((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100 as number(30, 3))       as pourcPaye
from LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
                  -- on substr(l.compte, 7, length(l.compte)) = mf.compte AND mf.annee = l.annee
                   on l.compte = mf.compte AND mf.annee = l.annee
where l.etat >= 11
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat, substr(l.compte, 7, length(l.compte));



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
FROM dual
/
 




  CREATE OR REPLACE VIEW COMPTECAFACTUREMOISAN (RUBRIQUE, RUBRIQUELIB, COMPTE, LIBELLE, COMPTEMERE, COMPTEMERELIB, MERE, MOIS, ANNEE, NBREACREDIT, AUCOMPTANT, MONTANTACREDIT, MONTANTAUCOMPTANT, MONTANT) AS
  select cca.rubrique,
       r.DESIGNATION                                              as rubriquelib,
       cca.compte,
       cc.LIBELLE,
       c.VAL as comptemere,
       c.DESCE comptemerelib,
       cca.DESCE as mere,
       mois,
       ANNEE,
       -- mereca,
       sum(case when TYPE = 'TFC001' then 1 else 0 end)           as nbreacredit,
       sum(case when TYPE = 'TFC002' then 1 else 0 end)           as aucomptant,
       sum(case when TYPE = 'TFC001' then MONTANTTAUX else 0 end) as montantacredit,
       sum(case when TYPE = 'TFC002' then MONTANTTAUx else 0 end) as montantaucomptant,
       sum(case when TYPE = 'TFC001' then MONTANTTAUX else 0 end) +
       sum(case when TYPE = 'TFC002' then MONTANTTAUx else 0 end) as montant

from CompteCAFacture cca
         left join MERECA c on c.ID = cca.DESCE
         left join COMPTECA cc on cc.VAL = cca.VAL
         left join RUBRIQUE_ACTIVITE r on r.id = cca.RUBRIQUE
group by cca.rubrique,
         cca.compte,
         cca.DESCE, mois, ANNEE, c.VAL, c.DESCE, r.DESIGNATION,cc.LIBELLE;

create or replace view COMPTECAFACTAVOIR_GRPNET as
select "RUBRIQUE",
       "RUBRIQUELIB",
       "COMPTE",
       "LIBELLE",
       "COMPTEMERE",
       "COMPTEMERELIB",
       "MERE",
       "MOIS",
       "ANNEE",
       "NBCREDIT",
       "NBCOMPTANT",
       "CREDIT",
       "COMPTANT",
       "MONTANT",
       "AVOIR"
from CompteCAFactAvoir_grp
/

create  or replace view FACTURE_CLIENT_GRP as
SELECT CAST (SUM (fm.MONTANT) as number(30,3)) AS montant,
            cast(SUM (fm.MONTANT) as number(30,3)) AS montanttaux,
            cast(SUM (fm.MTAVOIR) as number(30,3)) AS MONTANTAVOIRSANSTAUX,
            cast(SUM (fm.MTAVOIR) as number(30,3)) AS montantavoiravectaux,
            CAST (SUM (fm.MONTANTTVA) AS NUMBER (30, 3))               AS montantTva,
            CAST (SUM (fm.MONTANTTTC) AS NUMBER (30, 3))               AS MONTANTTTC,
            fm.idmere
       FROM FCFILLECOMPLET fm
   GROUP BY fm.idmere
/

  CREATE OR REPLACE VIEW FACTURECLIENTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR) AS 
  SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       fc.idprevision,
       CAST(NVL(grp.montant, 0) AS NUMBER(30, 3))    AS montant,--montanttaux
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3)) AS montanttva,
       cast(NVL(grp.MONTANTAVOIRAVECTAUX, 0) as NUMBER(32, 3))  AS montantavoir,
       CAST(NVL(MONTANTTTC, 0) AS NUMBER(30, 3))     AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                       AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                     AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                               AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                        as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                      as codeprovision,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.MONTANT, 0) AS NUMBER(30, 3))
                                                     AS MONTANTTTCVRAI,
       pr.NAVIRE,
       nv.armateurlib,
       fc.exercice,
       fc.IDAVOIR
FROM FACTURECLIENT fc
         LEFT JOIN FACTURE_CLIENT_GRP  grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id
         left join NAVIRELIBCOMPLET nv on pr.NAVIRE = nv.id;

create or replace view CAFCFILLECOMPLET_GRP as
select 
    idmere, 
    sum(montantav) as montantav,
    sum(mtavoir) as mtavoir,
    sum(montantreduction) as montantreduction,
    sum(montantmajoration) as montantmajoration,
    sum(montant) as montant,
    sum(montanttva) as montanttva,
    sum(montantttc) as montantttc,
    sum(montanthtsimple) as montanthtsimple
from FCFILLECOMPLET
group by idmere;

CREATE OR REPLACE VIEW FACTURECLIENTMSUM
AS
   SELECT fc.ID,
          fc.DATY,
          fc.TIERS,
          fc.DESIGNATION,
          fc.TYPE,
          fc.TVA,
          fc.REMARQUE,
          fc.IDUSER,
          fc.DATE_ECHEANCE,
          fc.ETAT,
          fc.idprevision,
          CAST (NVL (grp.montant, 0) AS NUMBER (30, 3)) AS montant, --montanttaux
          CAST (NVL (grp.MONTANTTVA, 0) AS NUMBER (30, 3)) AS montanttva,
          CAST (NVL (grp.mtavoir, 0) AS NUMBER (32, 3)) AS montantavoir,
          CAST (NVL (MONTANTTTC, 0) AS NUMBER (30, 3)) AS MONTANTTTC,
          pr.ESCALE,
          tfc.VAL AS typelib,
          fc.IDCATEGORIE,
          catfc.VAL AS CATEGORIELIB,
          fc.IDPROVISION,
          fcf.DESIGNATION AS IDPROVISIONlib,
          fc.ESTDDPMICTSL,
          fc.DEVISEMERE,
          fc.codePrestation,
          cp.VAL AS codePrestationlib,
          fc.code,
          fc.ESTMICTSL,
          fcf.CODE AS codeprovision,
          CAST (
             NVL (NVL (grp.MONTANTTVA, 0) + grp.MONTANT, 0) AS NUMBER (30, 3))
             AS MONTANTTTCVRAI,
          pr.NAVIRE,
          nv.armateurlib,
          fc.exercice,
          fc.IDAVOIR
     FROM FACTURECLIENT fc
          LEFT JOIN CAFCFILLECOMPLET_GRP grp ON grp.idmere = fc.id
          LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
          LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
          LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
          LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
          LEFT JOIN CODE_PRESTATION cp ON fc.codePrestation = cp.id
          LEFT JOIN NAVIRELIBCOMPLET nv ON pr.NAVIRE = nv.id;
 