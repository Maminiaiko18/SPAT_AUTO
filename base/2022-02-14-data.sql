--changer lib
UPDATE MENUDYNAMIQUE
SET LIBELLE='Analyse croisée activité', ICONE='fa fa-line-chart', HREF='/spat/pages/globalnegoce.jsp?but=exploitants/activites-analyse-tc-resume.jsp', RANG=1, NIVEAU=3, ID_PERE='MENUDSIA21'
WHERE ID='MENUDSIA211';
UPDATE MENUDYNAMIQUE
SET LIBELLE='Analyse activité', ICONE='fa fa-line-chart', HREF='/spat/pages/globalnegoce.jsp?but=exploitants/activite-analyse-simple-resume.jsp', RANG=2, NIVEAU=3, ID_PERE='MENUDSIA21'
WHERE ID='MENUDSIA212';
--nouveau user
INSERT INTO UTILISATEUR
(REFUSER, LOGINUSER, PWDUSER, NOMUSER, ADRUSER, TELUSER, IDROLE)
VALUES(1401, 'dg', '7a22mj4n', 'dg', 'DIR42', '1002067', 'ROL001301');
--menu a cacher pour DSIA
INSERT INTO SPAT_CAPITAINERIE.USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('UM002', NULL, 'MENUDSIA112', 'ROL001301', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('UM003', NULL, 'MENUDSIA3322', 'ROL001301', NULL, NULL, 1);

create or replace view FCFILLECOMPLET_ANALYSE AS
select fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       cast(fc.QUANTITE as NUMBER(20, 3))           as QUANTITE,
       cast(fc.PU as NUMBER(30, 3))                 as PU,
       fc.COMPTE,
       fc.IDPRODUIT,
       fc.DEVISE,
       cast(fc.TAUX as NUMBER(10, 2))               as TAUX,
       fc.IDACTIVITE,
       cast(fc.TVA as NUMBER(20, 2))                as TVA,
       fc.DATEFACT,
       fc.RUBRIQUE,
       fc.MOIS,
       fc.ANNEE,
       fc.HEUREDEBUT,
       fc.HEUREFIN,
       cast(fc.REDUCTION as NUMBER(20, 2))          as REDUCTION,
       cast(fc.MAJORATION as NUMBER(20, 2))         as MAJORATION,
       cast(TEST as NUMBER(10, 2))                  as TEST,
       fc.RANG,
       cast(fc.DUREE as NUMBER(10, 2))              as DUREE,
       cast(MONTANTAV as NUMBER(30, 3))             as MONTANTAV,
       RUBRIQUECPL,
       DATY,
       TIERS,
       IDCATEGORIE,
       TYPE,
       DEVISEMERE,
       EXERCICE,
       IDAVOIR,
       ETAT,
       cast(MTAVOIR as number(30, 3))               as MTAVOIR,
       cast(MONTANTREDUCTION as NUMBER(30, 3))      as MONTANTREDUCTION,
       cast(MONTANTMAJORATION as NUMBER(30, 3))     as MONTANTMAJORATION,
       cast(MONTANT as NUMBER(30, 3))               as MONTANT,
       cast(MONTANTTVA as NUMBER(30, 3))            as MONTANTTVA,
       cast(MONTANTTTC as NUMBER(30, 3))            as MONTANTTTC,
       MOISLIB,
       cast(MONTANTHTSIMPLE as NUMBER(30, 3))       as MONTANTHTSIMPLE,
       fc.CLIENT,
       cast(MONTANTAVOIRAVECTSAUX as NUMBER(30, 3)) as MONTANTAVOIRAVECTSAUX,
       ra.DESIGNATION                               as libelleRubrique,
       cu.CATEGORIE                                 as catClient
from FCFILLECOMPLET fc
         left join RUBRIQUE_ACTIVITE ra on fc.RUBRIQUECPL = ra.id
         left join CLIENT_UNION cu on cu.CDCLT = fc.TIERS
where fc.etat >= 11;
