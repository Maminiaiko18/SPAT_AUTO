alter table  factureclient add pourCompte varchar(100);
alter table  factureclient add estAncienne integer default 0;



  CREATE OR REPLACE VIEW FACTURECLIENTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER,
      DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE,
      CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE,
      ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB, EXERCICE, IDAVOIR,pourcompte,pourcomptelib) AS
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
          CAST (NVL (grp.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER (32, 3)) AS montantavoir,
          CAST (NVL (MONTANTTTC, 0)-NVL (grp.MONTANTAVOIRAVECTSAUX, 0) AS NUMBER (30, 3)) AS MONTANTTTC,
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
          fc.IDAVOIR,
          fc.pourcompte,
          fup.NOM as pourcomptelib
     FROM FACTURECLIENT fc
          LEFT JOIN CAFCFILLECOMPLET_GRP grp ON grp.idmere = fc.id
          LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
          LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
          LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
          LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
          LEFT JOIN CODE_PRESTATION cp ON fc.codePrestation = cp.id
          LEFT JOIN NAVIRELIBCOMPLET nv ON pr.NAVIRE = nv.id
          left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID=fc.POURCOMPTE;



  CREATE OR REPLACE VIEW FACTURECLIENTMSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER,
      DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE,
      TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL,
      DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, NAVIRE, ARMATEURLIB,
      EXERCICE, IDAVOIR,pourcompte,pourcomptelib) AS
  SELECT m.ID,
          m.DATY,
          m.TIERS,
          m.DESIGNATION,
          m.TYPE,
          m.TVA,
          '--' || m.remarque AS remarque,
          m.IDUSER,
          m.DATE_ECHEANCE,
          m.ETAT,
          m.idprevision,
          CAST (m.MONTANT AS NUMBER (32, 3)),
          CAST (M.MONTANTTVA AS NUMBER (32, 3)),
          CAST (M.MONTANTAVOIR AS NUMBER (32, 3)),
          CAST (M.MONTANTTTC AS NUMBER (32, 3)),
         -- CAST (LEAST (NVL (pf.montant, 0),(m.montant-m.montantavoir)) AS NUMBER (32, 3)) AS montantpaye,
          CAST ((NVL (pf.montant, 0)) AS NUMBER (32, 3)) AS montantpaye,
          CAST (M.MONTANTTTC - NVL (pf.montant, 0) AS NUMBER (32, 3))
             AS montantreste,
          fup.NOM AS tierslib,
          fup.CONTACT,
          fup.ADRESSE,
          M.ESCALE,
          TYPELIB,
          m.IDCATEGORIE,
          m.CATEGORIELIB,
          IDPROVISION,
          IDPROVISIONLIB,
          m.ESTDDPMICTSL,
          m.devisemere,
          m.codePrestation,
          m.codePrestationlib,
          m.CODE,
          m.ESTMICTSL,
          codeprovision,
          CAST (m.MONTANTTTCVRAI AS NUMBER (32, 3)),
          m.NAVIRE,
          m.ARMATEURLIB,
          m.EXERCICE,
          IDAVOIR,
         pourcompte,pourcomptelib
     FROM factureclientMSum m
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
          LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id;





create or replace view FACTURE_CLIENT_UNION
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ARMATEURLIB, EXERCICE, IDAVOIR,pourcompte,pourcomptelib)
as
SELECT ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       CAST(TVA AS NUMBER(20, 3)) AS tva,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       CAST(ETAT AS NUMBER(10))   AS etat,
       CAST(MONTANT AS NUMBER(32, 3)),
       CAST(MONTANTTVA AS NUMBER(32, 3)),
       CAST(MONTANTAVOIR AS NUMBER(32, 3)),
       CAST(MONTANTTTC AS NUMBER(32, 3)),
       CAST(MONTANTPAYE AS NUMBER(32, 3)),
       CAST(MONTANTRESTE AS NUMBER(32, 3)),
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       CASE WHEN ETAT = 1 THEN 'CREE(E)' WHEN ETAT = 11 THEN 'VISE(E)' END
                                  AS ETATLIB,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       DEVISEMERE,
       codePrestation,
       codePrestationlib,
       code,
       ESTMICTSL,
       CODEPROVISION,
       CAST(MONTANTTTCVRAI AS NUMBER(32, 3)),
       ARMATEURLIB,
       EXERCICE,
       idavoir,pourcompte,pourcomptelib
FROM (SELECT ID,
             DATY,
             TIERS,
             DESIGNATION,
             TYPE,
             CAST(TVA AS NUMBER(20, 3))          AS TVA,
             REMARQUE,
             IDUSER,
             DATE_ECHEANCE,
             CAST(ETAT AS NUMBER(10))            AS etat,
             CAST(MONTANT AS NUMBER(32, 3))      AS MONTANT,
             CAST(MONTANTTVA AS NUMBER(32, 3))   AS MONTANTTVA,
             CAST(MONTANTAVOIR AS NUMBER(32, 3)) AS MONTANTAVOIR,
             CAST(MONTANTTTC AS NUMBER(32, 3))   AS MONTANTTTC,
             CAST(MONTANTPAYE AS NUMBER(32, 3))  AS MONTANTPAYE,
             CAST(MONTANTRESTE AS NUMBER(32, 3)) AS MONTANTRESTE,
             TIERSLIB,
             CONTACT,
             ADRESSE,
             IDPREVISION,
             ESCALE,
             TYPELIB,
             IDCATEGORIE,
             CATEGORIELIB,
             IDPROVISION,
             IDPROVISIONLIB,
             DEVISEMERE,
             codePrestation,
             codePrestationlib,
             code,
             ESTMICTSL,
             CODEPROVISION,
             MONTANTTTCVRAI,
             ARMATEURLIB,
             EXERCICE,
             IDAVOIR,pourcompte,pourcomptelib
      FROM FACTURECLIENTMSUM_LIB
      WHERE DATY >= TO_DATE('2021-10-01', 'YYYY-MM-DD')
         OR id IN ('FCL0000002807173811',
                   'FCL0000002925101054',
                   'FCL0000002927101507',
                   'FCL0000002931102002',
                   'FCL0000002928101607',
                   'FCL0000002932102011',
                   'FCL0000002933102303',
                   'FCL0000002935102536',
                   'FCL0000002965181050',
                   'FCL0000002966094139',
                   'FCL0000003178153952',
                   'FCL0000003181155500',
                   'FCL0000003183160402', 'FCL0000003578151628', 'FCL0000003693085622', 'FCL0000003694085929',
                   'FCL0000003787161357', 'FCL0000003789161638', 'FCL0000003790161820', 'FCL0000003791162003',
                   'FCL0000003793162155', 'FCL0000003794162414', 'FCL0000003796162605', 'FCL0000003797162812',
                   'FCL0000003799163014', 'FCL0000003800163329', 'FCL0000003802163523', 'FCL0000003696090527',
                   'FCL0000003803163709', 'FCL0000003807164847', 'FCL0000003808165204', 'FCL0000003809165400',
                   'FCL0000003810165541', 'FCL0000003926173013', 'FCL0000003927173330', 'FCL0000003928173629',
                   'FCL0000004147165503')
      UNION ALL
      SELECT ID,
             DATY,
             TIERS,
             DESIGNATION,
             TYPE,
             CAST(TVA AS NUMBER(20, 3))          AS TVA,
             REMARQUE,
             IDUSER,
             DATE_ECHEANCE,
             CAST(ETAT AS NUMBER(10))            AS etat,
             CAST(MONTANT AS NUMBER(32, 3))      AS MONTANT,
             CAST(MONTANTTVA AS NUMBER(32, 3))   AS MONTANTTVA,
             CAST(MONTANTAVOIR AS NUMBER(32, 3)) AS MONTANTAVOIR,
             CAST(MONTANTTTC AS NUMBER(32, 3))   AS MONTANTTTC,
             CAST(MONTANTPAYE AS NUMBER(32, 3))  AS MONTANTPAYE,
             CAST(MONTANTRESTE AS NUMBER(32, 3)) AS MONTANTRESTE,
             TIERSLIB,
             CONTACT,
             ADRESSE,
             '-'                                 AS PREVISION,
             '-'                                 AS ESCALE,
             TYPE                                AS typelib,
             '-'                                 AS IDCATEGORIE,
             '-'                                 AS CATEGORIELIB,
             '-'                                 AS IDPROVISION,
             '-'                                 AS IDPROVISIONLIB,
             '-'                                 AS DEVISEMERE,
             ''                                  AS codePrestation,
             ''                                  AS codePrestationlib,
             ''                                  AS code,
             ''                                  AS ESTMICTSL,
             ''                                  AS CODEPROVISION,
             MONTANTTTC - MONTANTAVOIR           AS MONTANTTTCVRAI,
             CAST('-' AS VARCHAR2(500))             ARMATEURLIB,
             CAST(0 AS NUMBER(10))                  EXERCICE,
             '-'                                    idavoir,
             '-'                                    pourcompte,
             '-'                                    pourcomptelib

      FROM analyseglobaleantsika)
/

create view MOUVEMENTDEPART_ESC as
select *
from MOUVEMENTDEPART ma
where to_date(ma.DATE_DEPART || '' || ma.HEURE_DEPART, 'YYYY-MM-DD HH24:MI:SS') =
      (select max(to_date(m.DATE_DEPART || '' || case
                                                     when m.HEURE_DEPART is null then '00:00:00'
                                                     else m.HEURE_DEPART end, 'YYYY-MM-DD HH24:MI:SS'))
       from MOUVEMENTDEPART m
       where m.ESCALE = ma.ESCALE)
/



  CREATE OR REPLACE VIEW PREVISIONLIBCOMPLETPDF (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE, CARGAISON, PILOTE,
      DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT, QUAIPROVENANCE, VALQUAISPROVENANCE,
      PAYSPROVENANCE, VALPAYSPROVENANCE, QUAIDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION,
      INTERNEPOVENANCE, LONGUEURPROVENANCE, TIRANTPROVENANCE, PROFONDEURPROVENANCE, REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE,
      JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALCONSIGNATAIRE,
      DESCECONSIGNATAIRE, VALCARGAISON, DESCECARGAISON, VALPILOTE, DESCEPILOTE, INTERNEDESTINATION, LONGUEURDESTINATION,
      TIRANTDESTINATION, PROFONDEURDESTINATION, DESCEPROVENANCE, DESCEDESTINATION, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE,
      VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, DESCEQUAISPROVENANCE, DESCEQUAISDESTINATION, TYPEQUAISPROVENANCE,
      TYPEQUAISDESTINATION, TYPENAVIRE, TYPENAVIRELIB, ESCALE, NOVOYAGE, ARMATEUR, ARMATEURLIB, MAJORATION, REDUCTION, PAVILLONLIB,
      DESIGNATION, CODE, TONNAGE) AS
  SELECT pre.ID,
          pre.date_rade,
          pre.provenance,
          pre.navire,
          pre.consignataire,
          pre.cargaison,
          pre.pilote,
          pre.date_arrivee,
          pre.heure_arrivee,
          pre.date_depart,
          pre.heure_depart,
          esca.DESTINATION as destination,
          pre.etat,
          pro.QUAI AS QUAIPROVENANCE,
          q.VAL AS valquaisprovenance,
          q.PAYS AS paysprovenance,
          pa.VAL AS valpaysprovenance,
          pr.QUAI AS QUAIDESTINATION,
          q1.val AS valquaisdestination,
          q1.PAYS AS paysdestination,
          pa1.VAL AS valpaysdestination,
          pro.INTERNE AS INTERNEPOVENANCE,
          q.LONGUEUR AS longueurprovenance,
          q.TIRANT AS tirantprovenance,
          q.PROFONDEUR AS profondeurprovenance,
          na.REFERENCE AS referencenavire,
          na.NOM AS nomnavire,
          na.PAVILLON AS pavillonnavire,
          na.JNT AS jntnavire,
          na.JBT AS jbtnavire,
          na.PLT AS pltnavire,
          na.LHT AS lhtnavire,
          na.LM AS lmnavire,
          na.TE AS tenavire,
          na.VOLUME AS volumenavire,
          na.REMARQUE AS remarquenavire,
          na.ETAT AS etatnavire,
          con.NOMCLT AS valconsignataire,
          con.ADRCLT AS desceconsignataire,
          car.VAL AS valcargaison,
          car.DESCE AS descecargaison,
          pi.VAL AS valpilote,
          pi.DESCE AS descepilote,
          pr.INTERNE AS INTERNEDESTINATION,
          q1.LONGUEUR AS longueurdestination,
          q1.TIRANT AS tirantdestination,
          q1.PROFONDEUR AS profondeurdestination,
          pa.DESCE AS desceprovenance,
          pa1.DESCE AS descedestination,
          t.VAL AS valtypequaisprovenance,
          t.DESCE AS descetypequaisprovenance,
          t2.val AS valtypequaisdestination,
          t2.DESCE AS descetypequaisdestination,
          q.DESCE AS descequaisprovenance,
          q1.DESCE AS descequaisdestination,
          q.TYPEQUAIS AS typequaisprovenance,
          q1.TYPEQUAIS AS typequaisdestination,
          na.TYPE AS typenavire,
          tn.VAL AS typenavirelib,
          pre.escale,
          pre.NOVOYAGE,
          pre.ARMATEUR,
          cons.NOMCLT AS ARMATEURLIB,
          0 AS majoration,
          0 AS reduction,
          pay.val AS pavillonlib,
          CAST ('' AS VARCHAR2 (500)) AS DESIGNATION,
          CAST ('' AS VARCHAR2 (500)) AS CODE,
          pre.TONNAGE
     FROM prevision pre
          LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
          LEFT JOIN NAVIRE na ON na.id = pre.NAVIRE
          LEFT JOIN PAYS pay ON pay.id = na.pavillon
          LEFT JOIN clientmat con ON con.CDCLT = pre.CONSIGNATAIRE
          LEFT JOIN CARGAISON car ON car.id = pre.CARGAISON
          LEFT JOIN commandant pi ON pi.ID = pre.PILOTE
          left join MOUVEMENTDEPART_ESC esca on esca.ESCALE=pre.id
          LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = esca.ESCALE
          LEFT JOIN QUAIS q ON q.id = pro.QUAI
          LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
          LEFT JOIN PAYS pa ON pa.id = q.PAYS
          LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
          LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
          LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
          LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
          LEFT JOIN clientmat cons ON cons.CDCLT = pre.ARMATEUR;


create or replace view SITUATIONLCDEPENSEGRP as
select l.direction,
       l.projet,
       l.COMPTEFULL                                                                                              as compte,
       sum(l.montant)                                                                                            as montant,
       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) + nvl(bc.montant, 0) +
            nvl(bp.montant, 0) as NUMBER(30, 3))                                                                 as engageer,
       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                                                                 as facture,
       cast(nvl(fd.PAYE, 0) as number(30, 3))                                                                    as PAYE,
       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))                                               as arecouvrir,
       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))                                                as restebudget,
       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3))                                          as pourcEngage,
       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))                                             as pourcPaye,
       cast(sum(l.montant) - (nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) +
                              nvl(bc.montant, 0)) as NUMBER(30, 3))                                              as resteApresEngmt
from SITUATIONLCDEPENSE_FULL l
         LEFT JOIN (SELECT cast(nvl(sum(MONTANT), 0) as NUMBER(30, 3))     as facture,
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
                     -- and daty >= '01/01/2022'
                    group by substr(COMPTE, 1, 6), annee) n on n.compte = l.COMPTEfull
         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib
                    FROM engagementlibv ev
                    WHERE 1 < 2
                    --  and ev.daty >= '01/01/2022'
                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt
                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection
         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement
                    from LIBERER li
                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT
                    where li.ETAT >= 11
                      --and en.daty >= '01/01/2022'
                    group by en.ID, DATY, PROJET, codeetablissement) gr
                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT
         left join (select comptebdg, sum(montant) as montant
                    from AS_BONDECOMMANDE_SANSFACT_ENG bc
                    WHERE 1 < 2
                    --  and bc.daty >= '01/01/2022'
                    group by comptebdg) bc on bc.comptebdg = l.comptefull
         left join (select sum(MONTANT) as montant, CODE_ETABLISSEMENTLIB || PROJETLIB as compte
                    from BPNonRegul bp
                    WHERE 1 < 2
                     -- and bp.daty >= '01/01/2022'
                    group by CODE_ETABLISSEMENTLIB || PROJETLIB) bp on bp.compte = l.COMPTEFULL
where 1 < 2
GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,
         l.direction, l.projet, l.COMPTEFULL, l.idprojet, l.iddirection, bc.montant, bp.montant;

create or replace view FACTURE_CLIENT_UNION_ORDRE
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTTTCVRAI, MONTANTTTC, MONTANTAVOIR, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT,
             ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE,
             CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, ARMATEURLIB, EXERCICE,  POURCOMPTE,
       POURCOMPTELIB)
as
select ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
         cast(ETAT as number(10)),
       IDPREVISION,
         cast(MONTANT as number(30,3)),
         cast(MONTANTTVA as number(30,3)),
         cast(montantTTCvrai as number(30,3)),
         cast(MONTANTTTC as NUMBER(30,3)),
         cast(MONTANTAVOIR as NUMBER(30,3)),
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
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       ETATLIB,
       ARMATEURLIB,
       EXERCICE,
       POURCOMPTE,
       POURCOMPTELIB
from facture_client_union
/



