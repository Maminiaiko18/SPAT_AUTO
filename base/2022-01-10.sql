
create view REDEVANCECOMMUNALEFACTURE as
select e.id,
       e.code,
       e.typelib,
       e.daty,
       e.tierslib,
       cast(a.MONTANTTAUX as NUMBER(30,3)) as montantHT,--(avy amin'ny d‚tails where rubrique=redevance communale)
       e.tva,-- (valeur tva ho an'ilay ligne)
       cast(a.MONTANTTAUX + MONTANTTAXE as NUMBER(30,3)) as montantTTC-- (an'ilay d‚tails foana)
from FACTURE_CLIENT_UNIONV e
        left join FACT_CLT_FILL_LIB_REST_TAXE  a on a.IDMERE=e.id
where COMPTE='46731'
/

CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIB
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, IDPRODUITLIB, IDACTIVITE,
             CATEGORIEFACTURELIB, CATEGORIECLIENTLIB, RUBRIQUELIB, CLIENTLIB, MAJORATION, REDUCTION, ANNEE,
             MOIS, moislib)
AS
select ID,
       IDMERE,
       DESIGNATION,
       cast(QUANTITE as NUMBER(33, 3))             as QUANTITE,
       cast(PU as NUMBER(32, 3))                   as PU,
       COMPTE,
       IDPRODUIT,
       DEVISE,
       TAUX,
       cast(QTELIVREE as number(32, 3))            as QTELIVREE,
       cast(RESTEALIVRER as NUMBER(32, 3))         as RESTEALIVRER,
       cast(MONTANTTAUX as NUMBER(32, 3))          as MONTANTTAUX,
       cast(MONTANT as NUMBER(32, 3))              as MONTANT,
       cast(MONTANTAVOIRSANSTAUX as NUMBER(32, 3)) as MONTANTAVOIRSANSTAUX,
       cast(MONTANTAVOIRAVECTAUX as NUMBER(32, 3)) as MONTANTAVOIRAVECTAUX,
       IDPRODUITLIB,
       IDACTIVITE,
       CATEGORIEFACTURELIB,
       CATEGORIECLIENTLIB,
       RUBRIQUELIB,
       clientlib,
       MAJORATION,
       REDUCTION,
       ANNEE,
       MOIS,
       moislib
from (
         select fc.ID,
                fc.IDMERE,
                fc.DESIGNATION,
                fc.QUANTITE,
                fc.PU,
                fc.COMPTE,
                fc.IDPRODUIT,
                fc.DEVISE,
                fc.TAUX,
                cast(nvl(gr.QUANTITE, 0) as number(10, 3))               as qteLivree,
                cast(fc.QUANTITE - nvl(gr.QUANTITE, 0) as number(10, 3)) as resteAlivrer,
                cast(fcm.MONTANTTAUX as number(32, 3))                   as MONTANTTAUX,
                cast(fcm.MONTANT as NUMBER(32, 3))                       as MONTANT,
                cast(fcm.MONTANTAVOIRSANSTAUX as number(32, 3))          as MONTANTAVOIRSANSTAUX,
                cast(fcm.MONTANTAVOIRAVECTAUX as NUMBER(32, 3))          as MONTANTAVOIRAVECTAUX,
                pr.nom                                                   AS IDPRODUITlib,
                fc.IDACTIVITE,
                al.CATEGORIELIB                                          as categorieFacturelib,
                fcm.CATEGORIE                                            as categorieclientlib,
                nvl(RUBRIQUELIB, ra.DESIGNATION)                         as RUBRIQUELIB,
                v.NOMCLT                                                 as clientlib,
                nvl(fc.MAJORATION, 0)                                    as MAJORATION,
                nvl(fc.REDUCTION, 0)                                     as REDUCTION,
                fc.ANNEE,
                fc.MOIS,
                m.VAL                                                    as moislib

         from facture_client_fille fc
                  left join AS_PRODUITS pr on pr.ID = fc.IDPRODUIT
                  left join as_bondelivraison_cl_grp gr on gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
                  left join FACTURE_CLIENT_MONTANT_LIB fcm on fcm.id = fc.id
                  left join ACTIVITELIBCOMPLET al on al.id = fc.IDACTIVITE
                  left join RUBRIQUE_ACTIVITE ra on ra.id = fc.RUBRIQUE
                  join factureclientmsum_v f on fc.IDMERE = f.ID
                  left join V_CLIENT_CATEGORIE v on v.CDCLT = f.TIERS
                  left join mois m on m.id = fc.MOIS
         union all
         select a.*,
                cast('-' as VARCHAR2(500)) as RUBRIQUELIB,
                cast('-' as VARCHAR2(500)) as clientlib,
                0                          as MAJORATION,
                0                          as REDUCTION,
                cast(2022 as NUMBER(10))   as annee,
                cast(1 as NUMBER(10))      as mois,
                cast('-' as VARCHAR2(500)) as moislib
         from ANALYSEGLOBALFACTURE_FAC a);



UPDATE UTILISATEUR SET IDROLE = 'ROL001301' WHERE REFUSER = 1245;


create view  droitDeRegion as
    select e.id,
       e.code,
       e.typelib,
       e.daty,
       e.tierslib,
       cast(a.MONTANTTAUX as NUMBER(30,3)) as montantHT,--(avy amin'ny d‚tails where rubrique=redevance communale)
       e.tva,-- (valeur tva ho an'ilay ligne)
       cast(a.MONTANTTAUX + MONTANTTAXE as NUMBER(30,3)) as montantTTC-- (an'ilay d‚tails foana)
from FACTURE_CLIENT_UNIONV e
        left join FACT_CLT_FILL_LIB_REST_TAXE  a on a.IDMERE=e.id
where COMPTE='46732'
/

INSERT ROLES
(IDROLE, DESCROLE, RANG)
VALUES('ROL10012022', 'CONTROLE DE GESTION', 5);

INSERT USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('UMENU100120220', NULL, 'MEN0002', 'ROL10012022', NULL, NULL, NULL);

INSERT USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENU100120220', NULL, 'MEN0006', 'ROL10012022', NULL, NULL, NULL);


INSERT USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENU100120220', NULL, 'MENBDG0001', 'ROL10012022', NULL, NULL, 1);

INSERT USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENU100120221', NULL, 'MEN00068', 'ROL10012022', NULL, NULL, 1);

INSERT USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENU100120222', NULL, 'MEN0021', 'ROL10012022', NULL, NULL, 1);

INSERT USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENU100120223', NULL, 'MEN0041', 'ROL10012022', NULL, NULL, 1);

INSERT USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENU100120224', NULL, 'MEN00211', 'ROL10012022', NULL, NULL, 1);

INSERT USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENU100120225', NULL, 'MEN00505', 'ROL10012022', NULL, NULL, 1);

INSERT USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENU100120226', NULL, 'MEN0051', 'ROL10012022', NULL, NULL, 1);

INSERT USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENU100120227', NULL, 'MEN0005066', 'ROL10012022', NULL, NULL, 1);


INSERT UTILISATEUR
(REFUSER, LOGINUSER, PWDUSER, NOMUSER, ADRUSER, TELUSER, IDROLE)
VALUES(1050, 'CDG', '9ad22q8a', 'CDG', 'DIR000044', '1002067', 'ROL10012022');


INSERT PARAMCRYPT
(ID, NIVEAU, CROISSANTE, IDUTILISATEUR)
VALUES('CRY100120220', 3, 1, '1050');

INSERT CNAPS_USER
(ID, CODE_DR, USER_INIT, AGENT_MO, AGENT_DISPONIBLE, USERNAME, CODE_SERVICE, ID_UTILISATEUR)
VALUES('CNP100120220', 'DIR00001', '1', '1', '1', 'CDG', '2030', '1050');


INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MEN0006812', 'Droit de region', 'fa fa-money',
        '/spat/pages/globalnegoce.jsp?but=facture/droit-de-region-liste.jsp', 11, 3, 'MEN00068');

create or replace view JOURNALCAISSELIBDEPENSEV as
select * from JOURNALCAISSELIBDEPENSE where etat>=11;

create or replace view JOURNALCAISSELIBRECETTE_VISE as
select *
from JOURNALCAISSELIBRECETTE
where etat = 11;


create view ficheSuiviBudgetVide as
select cast('-' as VARCHAR2(500)) as codeEtb,
       cast('-' as VARCHAR2(500)) as codeProjet,
       cast(sysdate as date) as daty,
       cast(0 as number(10))annee,
       cast('-' as VARCHAR2(500)) as numFacture  from dual;
