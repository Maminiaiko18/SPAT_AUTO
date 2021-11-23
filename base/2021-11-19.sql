
alter table prevision add tonnage number(10,2);


CREATE OR REPLACE VIEW PREVISIONLIBCOMPLET (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE,
    CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT,
    QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE, VALPAYSPROVENANCE, QUAIDESTINATION,
    VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION, INTERNEPOVENANCE, LONGUEURPROVENANCE,
    TIRANTPROVENANCE, PROFONDEURPROVENANCE, REFERENCENAVIRE, NOMNAVIRE, PAVILLONNAVIRE, JNTNAVIRE,
    JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE,
    VALCONSIGNATAIRE, DESCECONSIGNATAIRE, VALCARGAISON, DESCECARGAISON, VALPILOTE, DESCEPILOTE,
    INTERNEDESTINATION, LONGUEURDESTINATION, TIRANTDESTINATION, PROFONDEURDESTINATION, DESCEPROVENANCE,
    DESCEDESTINATION, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION,
    DESCETYPEQUAISDESTINATION, DESCEQUAISPROVENANCE, DESCEQUAISDESTINATION, TYPEQUAISPROVENANCE,
    TYPEQUAISDESTINATION, TYPENAVIRE, TYPENAVIRELIB, ESCALE, NOVOYAGE, ARMATEUR, ARMATEURLIB, MAJORATION,
    REDUCTION, PAVILLONLIB, DESIGNATION, CODE,TONNAGE) AS
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
          pre.destination,
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
          fc.DESIGNATION,
          fc.CODE,
         pre.TONNAGE
     FROM prevision pre
          LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
          LEFT JOIN NAVIRE na ON na.id = pre.NAVIRE
          LEFT JOIN PAYS pay ON pay.id = na.pavillon
          LEFT JOIN CONSIGNATAIREMAT con ON con.CDCLT = pre.CONSIGNATAIRE
          LEFT JOIN CARGAISON car ON car.id = pre.CARGAISON
          LEFT JOIN commandant pi ON pi.ID = pre.PILOTE
          LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = pre.DESTINATION
          LEFT JOIN QUAIS q ON q.id = pro.QUAI
          LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
          LEFT JOIN PAYS pa ON pa.id = q.PAYS
          LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
          LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
          LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
          LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
          LEFT JOIN CONSIGNATAIREMAT cons ON cons.CDCLT = pre.ARMATEUR
          LEFT JOIN FACTURECLIENT fc ON fc.IDPREVISION = pre.id;
		  
	CREATE OR REPLACE VIEW PREVISIONFICHE
            (ID, NOMNAVIRE, VALCONSIGNATAIRE, VALCARGAISON,
             VALPILOTE, VALQUAISPROVENANCE, VALPAYSPROVENANCE, VALQUAISDESTINATION, VALPAYSDESTINATION,
             DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, ETAT, TYPE, ESCALE, NOVOYAGE, IDNAVIRE,
             ARMATEUR, ARMATEURLIB,TONNAGE)
AS
select id
     , nomnavire
     , valconsignataire
     , valcargaison
     , valpilote
     , valquaisprovenance
     , valpaysprovenance
     , valquaisdestination
     , valpaysdestination
     , date_arrivee
     , heure_arrivee
     , date_depart
     , heure_depart
     , etat
     , typenavirelib as type
     , ESCALE
     , NOVOYAGE
     , NAVIRE        as idnavire
     , ARMATEUR
     , ARMATEURLIB
     , TONNAGE
from previsionLibComplet;

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('ANDC001', 'Analyse', 'fa fa-line-chart', NULL, 5, 2, 'MEN0001');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('ANDC002', 'Tonnage marchandise', 'fa fa-ship', '/spat/pages/globalnegoce.jsp?but=capitainerie/quais/marchandise-analyse.jsp', 1, 3, 'ANDC001');

  CREATE OR REPLACE VIEW PREVISIONFICHE_ORDRE (ID, NOMNAVIRE, VALCONSIGNATAIRE, VALCARGAISON,TONNAGE,
VALPILOTE, VALQUAISPROVENANCE, VALPAYSPROVENANCE, VALQUAISDESTINATION, VALPAYSDESTINATION,
 DATE_ARRIVEE, HEURE_ARRIVEE, DATE_DEPART, HEURE_DEPART, ETAT, TYPE, ESCALE, NOVOYAGE,
IDNAVIRE, ARMATEUR, ARMATEURLIB) AS
  select id
     , nomnavire
     , valconsignataire
     , valcargaison
	, TONNAGE
     , valpilote
     , valquaisprovenance
     , valpaysprovenance
     , valquaisdestination
     , valpaysdestination
     , date_arrivee
     , heure_arrivee
     , date_depart
     , heure_depart
     , etat
     , typenavirelib as type
     , ESCALE
     , NOVOYAGE
     , NAVIRE        as idnavire
     , ARMATEUR
     , ARMATEURLIB

from previsionLibComplet




CREATE OR REPLACE VIEW PREVISIONLIBCOMPLET_ORDRE
            (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE, CARGAISON, TONNAGE, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE,
             DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE,
             VALPAYSPROVENANCE, QUAIDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION,
             INTERNEPOVENANCE, LONGUEURPROVENANCE, TIRANTPROVENANCE, PROFONDEURPROVENANCE, REFERENCENAVIRE, NOMNAVIRE,
             PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE,
             REMARQUENAVIRE, ETATNAVIRE, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, VALCARGAISON, DESCECARGAISON, VALPILOTE,
             DESCEPILOTE, INTERNEDESTINATION, LONGUEURDESTINATION, TIRANTDESTINATION, PROFONDEURDESTINATION,
             DESCEPROVENANCE, DESCEDESTINATION, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE,
             VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, DESCEQUAISPROVENANCE, DESCEQUAISDESTINATION,
             TYPEQUAISPROVENANCE, TYPEQUAISDESTINATION, TYPENAVIRE, TYPENAVIRELIB, ESCALE, NOVOYAGE, ARMATEUR,
             ARMATEURLIB, MAJORATION, REDUCTION, PAVILLONLIB, DESIGNATION, CODE)
AS
SELECT pre.ID,
       pre.date_rade,
       pre.provenance,
       pre.navire,
       pre.consignataire,
       pre.cargaison,

       pre.TONNAGE,
       pre.pilote,
       pre.date_arrivee,
       pre.heure_arrivee,
       pre.date_depart,
       pre.heure_depart,
       pre.destination,
       pre.etat,
       pro.QUAI      AS QUAIPROVENANCE,
       q.VAL         AS valquaisprovenance,
       q.PAYS        AS paysprovenance,
       pa.VAL        AS valpaysprovenance,
       pr.QUAI       AS QUAIDESTINATION,
       q1.val        AS valquaisdestination,
       q1.PAYS       AS paysdestination,
       pa1.VAL       AS valpaysdestination,
       pro.INTERNE   AS INTERNEPOVENANCE,
       q.LONGUEUR    AS longueurprovenance,
       q.TIRANT      AS tirantprovenance,
       q.PROFONDEUR  AS profondeurprovenance,
       na.REFERENCE  AS referencenavire,
       na.NOM        AS nomnavire,
       na.PAVILLON   AS pavillonnavire,
       na.JNT        AS jntnavire,
       na.JBT        AS jbtnavire,
       na.PLT        AS pltnavire,
       na.LHT        AS lhtnavire,
       na.LM         AS lmnavire,
       na.TE         AS tenavire,
       na.VOLUME     AS volumenavire,
       na.REMARQUE   AS remarquenavire,
       na.ETAT       AS etatnavire,
       con.NOMCLT    AS valconsignataire,
       con.ADRCLT    AS desceconsignataire,
       car.VAL       AS valcargaison,
       car.DESCE     AS descecargaison,
       pi.VAL        AS valpilote,
       pi.DESCE      AS descepilote,
       pr.INTERNE    AS INTERNEDESTINATION,
       q1.LONGUEUR   AS longueurdestination,
       q1.TIRANT     AS tirantdestination,
       q1.PROFONDEUR AS profondeurdestination,
       pa.DESCE      AS desceprovenance,
       pa1.DESCE     AS descedestination,
       t.VAL         AS valtypequaisprovenance,
       t.DESCE       AS descetypequaisprovenance,
       t2.val        AS valtypequaisdestination,
       t2.DESCE      AS descetypequaisdestination,
       q.DESCE       AS descequaisprovenance,
       q1.DESCE      AS descequaisdestination,
       q.TYPEQUAIS   AS typequaisprovenance,
       q1.TYPEQUAIS  AS typequaisdestination,
       na.TYPE       AS typenavire,
       tn.VAL        AS typenavirelib,
       pre.escale,
       pre.NOVOYAGE,
       pre.ARMATEUR,
       cons.NOMCLT   AS ARMATEURLIB,
       0             AS majoration,
       0             AS reduction,
       pay.val       AS pavillonlib,
       fc.DESIGNATION,
       fc.CODE
FROM prevision pre
         LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = pre.PROVENANCE
         LEFT JOIN NAVIRE na ON na.id = pre.NAVIRE
         LEFT JOIN PAYS pay ON pay.id = na.pavillon
         LEFT JOIN CONSIGNATAIREMAT con ON con.CDCLT = pre.CONSIGNATAIRE
         LEFT JOIN CARGAISON car ON car.id = pre.CARGAISON
         LEFT JOIN commandant pi ON pi.ID = pre.PILOTE
         LEFT JOIN POSTEDESTINATAIRE pr ON pr.ID = pre.DESTINATION
         LEFT JOIN QUAIS q ON q.id = pro.QUAI
         LEFT JOIN QUAIS q1 ON q1.id = pr.QUAI
         LEFT JOIN PAYS pa ON pa.id = q.PAYS
         LEFT JOIN PAYS pa1 ON pa1.id = q1.PAYS
         LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
         LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
         LEFT JOIN TYPENAVIRE tn ON tn.id = na.TYPE
         LEFT JOIN CONSIGNATAIREMAT cons ON cons.CDCLT = pre.ARMATEUR
         LEFT JOIN FACTURECLIENT fc ON fc.IDPREVISION = pre.id;




CREATE OR REPLACE VIEW FACTFOURN_MSUM
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION,
             IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL,
             CODEPROVISION, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB, NUMEROOP, PROJET,
             PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC)
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 3))                          AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3))                           AS montanttva,
       NVL(grp.montantavoiravectaux, 0)                                        AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 3))
                                                                               AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                                                 AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                                               AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                                         AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                                                  as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                                                as codeprovision,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0) AS NUMBER(30, 3)) as MONTANTTTCVRAI,
       fc.IDBL,
       fc.CODE_ETABLISSEMENT,
       cod.VAL                                                                 as CODE_ETABLISSEMENTlib,
       fc.NUMEROOP,
       fc.PROJET,
       p.DESIGNATION                                                           as projetlib,
       fc.NUMFACT,
       fc.NATURE,
       n.VAL                                                                   as naturelib,
       bl.ID_BC
FROM FACTURE_FOURNISSEUR_MERE fc
         LEFT JOIN FACTFOURN_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFf tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFF catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id
         left join CODEETABLISSEMENT cod on fc.CODE_ETABLISSEMENT = cod.ID
         left join projet p on fc.PROJET = p.ID
         LEFT JOIN nature n on fc.NATURE = n.ID
         left join AS_BONDELIVRAISON bl on bl.ID = nvl(fc.IDBL, fc.REMARQUE    );

create or replace view FACTFOURN_MSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT,
             CODE_ETABLISSEMENTLIB, NUMEROOP, PROJET, PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC)
as
SELECT m.ID,
       m.DATY,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       '--' || m.remarque                        AS remarque,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.idprevision,
       CAST(m.MONTANT AS NUMBER(32, 3)),
       CAST(M.MONTANTTVA AS NUMBER(32, 3)),
       CAST(M.MONTANTAVOIR AS NUMBER(32, 3)),
       CAST(M.MONTANTTTC AS NUMBER(32, 3)),
       CAST(NVL(pf.montant, 0) AS NUMBER(32, 3)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(pf.montant, 0) AS NUMBER(32, 3))
                                                 AS montantreste,
       fup.NOM                                   AS tierslib,
       fup.CONTACT,
       fup.ADRESSE,
       M.ESCALE,
       TYPELIB,
       m.IDCATEGORIE,
       m.CATEGORIELIB,
       m.IDPROVISION,
       m.IDPROVISIONLIB,
       m.ESTDDPMICTSL,
       m.devisemere,
       m.codePrestation,
       m.codePrestationlib,
       m.CODE,
       m.ESTMICTSL,
       codeprovision,
       case
           when m.etat = 1 then 'CREE'
           when m.etat >= 11 then 'VISE'
           else '' end                           as etatlib,
       MONTANTTTCVRAI,
       m.IDBL,
       m.CODE_ETABLISSEMENT,
       m.CODE_ETABLISSEMENTLIB,
       m.NUMEROOP,
       m.PROJET,
       m.PROJETLIB,
       m.NUMFACT,
       m.NATURE,
       m.naturelib,
       m.IDBC
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id;



create view cargaisonanalyse as
select p.id,
       cargaison,
       VALQUAISDESTINATION as cargaisonlib,
       tonnage,
       date_arrivee,
       extract(month from DATE_ARRIVEE) as mois,
       m.VAL  as moislib
from previsionlibcomplet p
    left join MOIS m on m.ID=extract(month from DATE_ARRIVEE);

