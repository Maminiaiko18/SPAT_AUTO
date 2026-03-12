create view COMPTECAFACTUREDATY as
select cca.rubrique,
       r.DESIGNATION                                              as rubriquelib,
       cca.compte,
       cc.LIBELLE,
       c.VAL as comptemere,
       c.DESCE comptemerelib,
       cca.DESCE as mere,
       cca.DATY,
       mois,
       ANNEE,
       -- mereca,
       sum(case when TYPE = 'TFC001' then 1 else 0 end)           as nbreacredit,
       sum(case when TYPE = 'TFC002' then 1 else 0 end)           as aucomptant,
       sum(case when TYPE = 'TFC001' then MONTANTTAUX else 0 end) as montantacredit,
       sum(case when TYPE = 'TFC002' then MONTANTTAUx else 0 end) as montantaucomptant,
       sum(case when TYPE = 'TFC001' then MONTANTTAUX else 0 end) +
       sum(case when TYPE = 'TFC002' then MONTANTTAUx else 0 end) as montant,
       c.IDGRANDRUBRIQUE ,
       cc.rang AS rangcompteca
from CompteCAFacture cca
         left join MERECA c on c.ID = cca.DESCE
         left join COMPTECA cc on cc.VAL = cca.VAL
         left join RUBRIQUE_ACTIVITE r on r.id = cca.RUBRIQUE
group by cca.rubrique,
         cca.compte,
         cca.DESCE, cca.DATY, mois, ANNEE, c.VAL, c.DESCE, r.DESIGNATION,cc.LIBELLE,c.IDGRANDRUBRIQUE,cc.rang;

create view COMPTECAAVOIRDATY as
SELECT cca.rubrique,
       cca.compte,
       cca.DESCE                           AS mere,
       CAST(SUM(CASE WHEN TYPE = 1 then MONTANT else 0 end) AS NUMBER(32, 3)) AS montantavoirinterne,
       CAST(SUM(CASE WHEN TYPE != 1 then MONTANT else 0 end) AS NUMBER(32, 3)) AS montantavoirexterne,
       cca.DATY,
       cca.mois,
       cca.annee,
       cca.idca,
       cca.moisFact,
       cca.anneeFact
FROM CompteCAAvoir cca
where cca.etat >= 11
GROUP BY cca.rubrique,
         cca.DESCE,
         cca.DATY,
         cca.mois,
         cca.annee,
         cca.compte,
         cca.idca,
         cca.moisFact,
         cca.anneeFact;

create view COMPTECAFACTAVOIR_daty as
SELECT nvl(cca.RUBRIQUE, CCAVOIR.RUBRIQUE)               as rubrique,
       nvl(cca.RUBRIQUELIB, ra.designation)              as RUBRIQUELIB,
       nvl(cca.COMPTE, CCAVOIR.COMPTE)                   as compte,
       nvl(cca.LIBELLE, coa.libelle)                     as libelle,
       nvl(cca.COMPTEMERE, mca.val)                      as comptemere,
       nvl(cca.COMPTEMERELIB, mca.desce)                 as COMPTEMERELIB,
       nvl(cca.MERE, CCAVOIR.MERE)                       as mere,
       nvl(cca.DATY, ccavoir.DATY)                       as DATY,
       nvl(cca.MOIS, ccavoir.mois)                       as mois,
       nvl(cca.ANNEE, ccavoir.annee)                     as annee,
       CAST(nvl(cca.NBREACREDIT, 0) AS NUMBER(10))       AS nbCredit,
       CAST(nvl(cca.AUCOMPTANT, 0) AS NUMBER(10))        AS nbComptant,
       CAST(nvl(cca.MONTANTACREDIT, 0) AS NUMBER(30, 3)) AS credit,
       CAST(nvl(cca.MONTANTAUCOMPTANT, 0) AS NUMBER(30, 3)) comptant,
       CAST(nvl(cca.MONTANT, 0) AS NUMBER(30, 3))        AS MONTANT,
       CAST(NVL(ccavoir.montantavoirexterne + ccavoir.montantavoirinterne, 0) AS NUMBER(30, 3))    AS avoir,
       nvl(ccavoir.moisfact, cca.mois)                   as moisFact,
       nvl(ccavoir.anneefact, cca.annee)                 as anneeFact,
       nvl(cca.idgrandrubrique, mca.IDGRANDRUBRIQUE)     AS idgrandrubrique,
       nvl(cca.rangcompteca, coa.rang)                   AS rangcompteca,
       CAST(nvl(ccavoir.MONTANTAVOIREXTERNE, 0) AS NUMBER(30, 3)) as avoirexterne,
       CAST(nvl(ccavoir.MONTANTAVOIRINTERNE, 0) AS NUMBER(30, 3)) as avoirinterne
FROM COMPTECAFACTUREDATY cca
         FULL OUTER JOIN COMPTECAAVOIRDATY ccavoir
                         ON cca.mois = ccavoir.mois
                             AND cca.annee = ccavoir.annee
                             AND cca.compte = ccavoir.compte
                             AND cca.mere = ccavoir.mere
                             AND cca.RUBRIQUE = ccavoir.RUBRIQUE
                             and cca.daty = ccavoir.daty
                             and cca.mois = ccavoir.moisfact
                             and cca.annee = ccavoir.ANNEEFACT
         left join compteca coa on coa.id = ccavoir.idca
         left join mereca mca on mca.id = ccavoir.mere
         left join rubrique_activite ra on ra.id = ccavoir.rubrique;


create view COMPTECAFACTAVOIR_GRP_daty
            (RUBRIQUE, RUBRIQUELIB, COMPTE, LIBELLE, COMPTEMERE, COMPTEMERELIB, MERE, DATY, MOIS, ANNEE, MOISFACT, ANNEEFACT,
             NBCREDIT, NBCOMPTANT, CREDIT, COMPTANT, MONTANT, AVOIR, CHECKREPORT, IDGRANDRUBRIQUE, RANGCOMPTECA,
             AVOIRINTERNE, AVOIREXTERNE)
as
SELECT CAST('-' AS VARCHAR2(100))           AS RUBRIQUE,
       CAST('-' AS VARCHAR2(100))              RUBRIQUELIB,
       COMPTE,
       LIBELLE,
       COMPTEMERE,
       COMPTEMERELIB,
       MERE,
       DATY,
       CAST(MOIS AS NUMBER(10)),
       CAST(ANNEE AS NUMBER(10)),
       CAST(MOISFact AS NUMBER(10)),
       CAST(ANNEEFact AS NUMBER(10)),
       CAST(SUM(NBCREDIT) AS NUMBER(10))    AS NBCREDIT,
       CAST(SUM(NBCOMPTANT) AS NUMBER(10))  AS NBCOMPTANT,
       CAST(SUM(CREDIT) AS NUMBER(30, 3))   AS CREDIT,
       CAST(SUM(COMPTANT) AS NUMBER(30, 3)) AS COMPTANT,
       CAST(SUM(MONTANT) AS NUMBER(30, 3))  AS MONTANT,
       CAST(SUM(AVOIR) AS NUMBER(30, 3))    AS AVOIR,
       CASE
           WHEN ANNEE = ANNEEFACT THEN 0
           ELSE 1 END                       AS checkreport,
       IDGRANDRUBRIQUE,
       rangcompteca,
       CAST(SUM(AVOIRINTERNE) AS NUMBER(30, 3))    AS AVOIRINTERNE,
       CAST(SUM(AVOIREXTERNE) AS NUMBER(30, 3))    AS AVOIREXTERNE
FROM COMPTECAFACTAVOIR_daty
GROUP BY CAST('-' AS VARCHAR2(100)),
         CAST('-' AS VARCHAR2(100)),
         COMPTE,
         LIBELLE,
         COMPTEMERE,
         COMPTEMERELIB,
         MERE,
         DATY,
         MOIS,
         ANNEE,
         moisFact,
         AnneeFact,
         IDGRANDRUBRIQUE, rangcompteca;


INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN0005066CAE2D', 'CA entre 2 dates', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=ca/chiffreAffaire-entre2date.jsp', 3, 3, 'MENUI0002');

