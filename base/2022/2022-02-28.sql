
alter table as_bondecommande
add iduser number(10) references  utilisateur;



alter table utilisateur
add codeEtablissement varchar2(100) references codeEtablissement;

create or replace view UTILISATEURROLE as
select u.refuser,
       u.LOGINUSER,
       u.PWDUSER,
       u.NOMUSER,
       d.ID as adruser,
       u.TELUSER,
       u.IDROLE,
       s.ID,
       r.rang,
       u.CODEETABLISSEMENT
from utilisateur u,
     log_direction d,
     roles r,
     log_service s,
     log_personnel p,
     annulationutilisateur a
where u.TELUSER = p.ID
  and p.DIRECTION = d.id
  and p.SERVICE = s.id
  and u.IDROLE = r.IDROLE
  and u.refuser = a.REFUSER(+)
  and a.REFUSER is null;

INSERT INTO CODEETABLISSEMENT (ID,VAL,DESCE)
	VALUES ('CDEETB0095','130d','COMPTA MATIERES ET APPROVISIONNEMENTS');
	
update utilisateur set CODEETABLISSEMENT = 'CDEETB0003' where LOGINUSER = 'adminge';
update utilisateur set CODEETABLISSEMENT = 'CODE000023' where LOGINUSER = 'sadmif';
update utilisateur set CODEETABLISSEMENT = 'CODE000042' where LOGINUSER = 'log';
update utilisateur set CODEETABLISSEMENT = 'CDEETB0006' where LOGINUSER = 'gestcour';
update utilisateur set CODEETABLISSEMENT = 'CDEETB0007' where LOGINUSER = 'techappro';
update utilisateur set CODEETABLISSEMENT = 'CDEETB0095' where LOGINUSER = 'appro';
update utilisateur set CODEETABLISSEMENT = 'CDEETB0008' where LOGINUSER = 'comm';
update utilisateur set CODEETABLISSEMENT = 'CDEETB0009' where LOGINUSER = 'scomm';
update utilisateur set CODEETABLISSEMENT = 'CDEETB0010' where LOGINUSER = 'prod';


UPDATE UTILISATEUR
SET LOGINUSER='prod', PWDUSER='142kmj8', NOMUSER='prod', ADRUSER='DIR0000000094093042', TELUSER='1002067', IDROLE='ROLE001', CODEETABLISSEMENT=NULL
WHERE REFUSER=1506;

UPDATE PARAMCRYPT
SET NIVEAU=5, CROISSANTE=1, IDUTILISATEUR='1506'
WHERE ID='CRY0000000455093420';

UPDATE UTILISATEUR
SET LOGINUSER='appro', PWDUSER='9b8lixxzw', NOMUSER='appro', ADRUSER='DIR00004', TELUSER='1002067', IDROLE='ROL0000001261171742', CODEETABLISSEMENT=NULL
WHERE REFUSER=1343;

UPDATE PARAMCRYPT
SET NIVEAU=8, CROISSANTE=0, IDUTILISATEUR='1343'
WHERE ID='CRY000292175646';


INSERT INTO UTILISATEUR
(REFUSER, LOGINUSER, PWDUSER, NOMUSER, ADRUSER, TELUSER, IDROLE, CODEETABLISSEMENT)
VALUES(1529, 'adminge', '12014d9e75', 'adminge', 'DIR00001', '1002067', 'ROL0000001261171742', NULL);

INSERT INTO PARAMCRYPT
(ID, NIVEAU, CROISSANTE, IDUTILISATEUR)
VALUES('CRY0000000478101420', 9, 1, '1529');


INSERT INTO ROLES
(IDROLE, DESCROLE, RANG)
VALUES('ROL0000001261171742', 'ChargesSansOP', 6);


INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('UM020', NULL, 'MEN00500', 'ROL0000001261171742', NULL, NULL, NULL);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('UM016', NULL, 'MENUM01', 'ROL0000001261171742', NULL, NULL, NULL);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('UM017', NULL, 'MENBDG00021', 'ROL0000001261171742', NULL, NULL, NULL);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('UM018', NULL, 'MEN009', 'ROL0000001261171742', NULL, NULL, NULL);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('UM019', NULL, 'MEN008', 'ROL0000001261171742', NULL, NULL, NULL);




UPDATE ROLES
SET DESCROLE='Charges', RANG=4
WHERE IDROLE='ROLE001';
UPDATE ROLES
SET DESCROLE='ChargesBC', RANG=4
WHERE IDROLE='ROLE002';
UPDATE ROLES
SET DESCROLE='ChargesSansOP', RANG=4
WHERE IDROLE='ROL0000001261171742';

CREATE OR REPLACE VIEW AS_BONDECOMMANDE_LIBELLE
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, CODE_ETAB, PROJET,
             IDENGAGEMENT, IDENGAGEMENTLIB,codeetablissement)
AS
select bc.id,
       bc.daty,
       bc.etat,
       bc.remarque,
       bc.designation,
       mp.val         as modepaiement,
       bc.fournisseur,
       bc.tva,
       bc.NUMBC,
       ce.val         as CODE_ETAB,
       pe.designation as PROJET,
       IDENGAGEMENT,
       en.DESIGNATION as idengagementlib,
       bc.CODE_ETAB   as codeetablissement
from union_bc_spat_cemedi bc
         join modepaiement mp on bc.modepaiement = mp.id
         left join CODEETABLISSEMENT ce on ce.id = bc.code_etab
         left join PROJET pe on pe.id = bc.projet
         left join ENGAGEMENT en on ce.ID = bc.IDENGAGEMENT;

create or replace view AS_BONDECOMMANDE_LIBELLE_LIB
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB, MONTANTREMISE, IDENGAGEMENTLIB, IDENGAGEMENT,CODEETABLISSEMENT)
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
       CODEETABLISSEMENT
from AS_BONDECOMMANDE_LIBELLE bc
         left join AS_BONDECOMMANDE_FILLE_FINAL bcf on bcf.IDBC = bc.id
         left join BONDELIVRAISON_CMPL_GROUPER lfac on lfac.ID_BC = bc.ID
         left join AS_BONDECOMMANDE_FILLE_grouper c on c.IDBC = bc.ID
         LEFT JOIN BONDELIVRAISONPARBC bl ON bl.IDBC = bc.ID
         left join union_tiers_tbd_cemedi ti on ti.ID = bc.fournisseur;

CREATE OR REPLACE VIEW AS_BONDECOMMANDE_LIBELLE_CREE
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB,CODEETABLISSEMENT)
AS
select ID,
       DATY,
       ETAT,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       NUMBC,
       MONTANT,
       MONTANTTVA,
       MONTANTTTC,
       IDFACTURE,
       MONTANT_PAYE_REEL,
       RESTEPAYERGENERAL,
       RESTEAPAYERREEL,
       MONTANT_A_PAYER,
       PROJET,
       CODE_ETAB,
       MONTANTFACTURE,
       ETATLIB,
       CODEETABLISSEMENT
from AS_BONDECOMMANDE_LIBELLE_lib
where ETATLIB = 'CREE(E)';


CREATE OR REPLACE VIEW AS_BONDECOMMANDE_LIBELLE_VISE
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB,CODEETABLISSEMENT)
AS
select ID,
       DATY,
       ETAT,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       NUMBC,
       MONTANT,
       MONTANTTVA,
       MONTANTTTC,
       IDFACTURE,
       MONTANT_PAYE_REEL,
       RESTEPAYERGENERAL,
       RESTEAPAYERREEL,
       MONTANT_A_PAYER,
       PROJET,
       CODE_ETAB,
       MONTANTFACTURE,
       ETATLIB,
       CODEETABLISSEMENT
from AS_BONDECOMMANDE_LIBELLE_lib
where ETATLIB = 'VISE(E)';

CREATE OR REPLACE VIEW AS_BONDECOMMANDE_LIBELLECREE
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, CODE_ETAB, PROJET,CODEETABLISSEMENT) AS
select ID,
       DATY,
       ETAT,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       NUMBC,
       CODE_ETAB,
       PROJET,
       CODEETABLISSEMENT
from AS_BONDECOMMANDE_LIBELLE
where etat = 1;

CREATE OR REPLACE VIEW AS_BONDECOMMANDE_LIBELLE_LIVRE
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB,CODEETABLISSEMENT)
AS
select ID,
       DATY,
       ETAT,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       NUMBC,
       MONTANT,
       MONTANTTVA,
       MONTANTTTC,
       IDFACTURE,
       MONTANT_PAYE_REEL,
       RESTEPAYERGENERAL,
       RESTEAPAYERREEL,
       MONTANT_A_PAYER,
       PROJET,
       CODE_ETAB,
       MONTANTFACTURE,
       ETATLIB,
       CODEETABLISSEMENT
from AS_BONDECOMMANDE_LIBELLE_lib
where ETATLIB = 'LIVRE(E)';

CREATE OR REPLACE VIEW AS_BONDECOMMANDE_LIBELLE_FACT
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB,CODEETABLISSEMENT)
AS
select ID,
       DATY,
       ETAT,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       NUMBC,
       MONTANT,
       MONTANTTVA,
       MONTANTTTC,
       IDFACTURE,
       MONTANT_PAYE_REEL,
       RESTEPAYERGENERAL,
       RESTEAPAYERREEL,
       MONTANT_A_PAYER,
       PROJET,
       CODE_ETAB,
       MONTANTFACTURE,
       ETATLIB,
       CODEETABLISSEMENT
from AS_BONDECOMMANDE_LIBELLE_lib
where ETATLIB = 'FACTURE(E)';

create or replace
    view AS_BONDECOMMANDE_LIB_ATTPAY
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB, CODEETABLISSEMENT)
as
select ID,
       DATY,
       ETAT,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       NUMBC,
       MONTANT,
       MONTANTTVA,
       MONTANTTTC,
       IDFACTURE,
       MONTANT_PAYE_REEL,
       RESTEPAYERGENERAL,
       RESTEAPAYERREEL,
       MONTANT_A_PAYER,
       PROJET,
       CODE_ETAB,
       MONTANTFACTURE,
       ETATLIB,
       CODEETABLISSEMENT
from AS_BONDECOMMANDE_LIBELLE_lib
where ETATLIB = 'EN ATTENTE'
/

create or replace view AS_BONDECOMMANDE_LIBELLE_PAYE
            (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA, NUMBC, MONTANT, MONTANTTVA,
             MONTANTTTC, IDFACTURE, MONTANT_PAYE_REEL, RESTEPAYERGENERAL, RESTEAPAYERREEL, MONTANT_A_PAYER, PROJET,
             CODE_ETAB, MONTANTFACTURE, ETATLIB, CODEETABLISSEMENT)
as
select ID,
       DATY,
       ETAT,
       REMARQUE,
       DESIGNATION,
       MODEPAIEMENT,
       FOURNISSEUR,
       TVA,
       NUMBC,
       MONTANT,
       MONTANTTVA,
       MONTANTTTC,
       IDFACTURE,
       MONTANT_PAYE_REEL,
       RESTEPAYERGENERAL,
       RESTEAPAYERREEL,
       MONTANT_A_PAYER,
       PROJET,
       CODE_ETAB,
       MONTANTFACTURE,
       ETATLIB,
       CODEETABLISSEMENT
from AS_BONDECOMMANDE_LIBELLE_lib
where ETATLIB = 'PAYE(E)'
/


create or replace view FACTUREFOURNVALIDE_TOUS
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET,
             CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE,
             IDENGAGEMENT, IDENGAGEMENTLIB, codeetablissement )
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
       ETAT,
       IDPREVISION,
       cast(MONTANT as number(30, 2)),
       cast(MONTANTTVA as number(30, 2)),
       cast(MONTANTAVOIR as NUMBER(30, 2)),
       cast(MONTANTTTC as number(30, 2)),
       cast(MONTANTPAYE as number(30, 2)),
       cast(MONTANTRESTE as number(30, 2)),
       TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       ESTDDPMICTSL,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       cast(MONTANTTTCVRAI as number(30, 3)),
       ETATLIB,
       IDBL,
       NUMEROOP,
       PROJET,
       CODE_ETABLISSEMENT,
       PROJETLIB,
       CODE_ETABLISSEMENTLIB,
       NATURE,
       NATURELIB,
       IDBC,
       numop,
       exercice,
       IDENGAGEMENT,
       IDENGAGEMENTLIB,
       codeetablissement
from (
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                ETAT,
                IDPREVISION,
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                ESTDDPMICTSL,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                'PAYE'             as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
                IDENGAGEMENT,
                IDENGAGEMENTLIB,
                CODE_ETABLISSEMENT as codeetablissement
         from FACTUREFOURNVALIDE_C
         union
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                ETAT,
                IDPREVISION,
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                ESTDDPMICTSL,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                'PAYE'             as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
                IDENGAGEMENT,
                IDENGAGEMENTLIB,
                CODE_ETABLISSEMENT as codeetablissement
         from FACTUREFOURNVALIDE_V
         union
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                ETAT,
                IDPREVISION,
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                ESTDDPMICTSL,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                'PAYE'             as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
                IDENGAGEMENT,
                IDENGAGEMENTLIB,
                CODE_ETABLISSEMENT as codeetablissement
         from FACTUREFOURNVALIDE_ep
         union
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                ETAT,
                IDPREVISION,
                MONTANT,
                MONTANTTVA,
                MONTANTAVOIR,
                MONTANTTTC,
                MONTANTPAYE,
                MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB,
                ESTDDPMICTSL,
                DEVISEMERE,
                CODEPRESTATION,
                CODEPRESTATIONLIB,
                CODE,
                ESTMICTSL,
                CODEPROVISION,
                MONTANTTTCVRAI,
                'PAYE'             as ETATLIB,
                IDBL,
                NUMEROOP,
                projet,
                code_etablissement,
                projetlib,
                code_etablissementlib,
                NATURE,
                NATURELIB,
                IDBC,
                numop,
                exercice,
                IDENGAGEMENT,
                IDENGAGEMENTLIB,
                CODE_ETABLISSEMENT as codeetablissement
         from FACTUREFOURNVALIDE_p)
/


CREATE OR REPLACE VIEW FACTUREFOURNVALIDE_C
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, NUMEROOP, PROJET,
             CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE,
             IDENGAGEMENT, IDENGAGEMENTLIB,CODEETABLISSEMENT)
AS
select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       ff.TVA,
       ff.REMARQUE,
       ff.IDUSER,
       ff.DATE_ECHEANCE,
       ff.ETAT,
       ff.IDPREVISION,
       ff.MONTANT,
       ff.MONTANTTVA,
       ff.MONTANTAVOIR,
       ff.MONTANTTTC,
       ff.MONTANTPAYE,
       ff.MONTANTRESTE,
       ff.TIERSLIB,
       ff.CONTACT,
       ff.ADRESSE,
       ff.ESCALE,
       ff.TYPELIB,
       ff.IDCATEGORIE,
       ff.CATEGORIELIB,
       ff.IDPROVISION,
       ff.IDPROVISIONLIB,
       ff.ESTDDPMICTSL,
       ff.DEVISEMERE,
       ff.CODEPRESTATION,
       ff.CODEPRESTATIONLIB,
       ff.CODE,
       ff.ESTMICTSL,
       ff.CODEPROVISION,
       ff.ETATLIB,
       ff.MONTANTTTCVRAI,
       ff.IDBL,
       ff.NUMEROOP,
       ff.projet,
       ff.code_etablissement,
       ff.projetlib,
       ff.code_etablissementlib,
       ff.NATURE,
       ff.NATURELIB,
       ff.IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
       IDENGAGEMENT,
       idengagementlib,
       CODE_ETABLISSEMENT as CODEETABLISSEMENT
from FACTUREFOURNVALIDE ff
         left join LIAISONINTRATABLE op on op.ID1 = ff.id
         left join ORDONNERPAYEMENT ord on op.ID2 = ord.id
where ff.etat = 1;


CREATE OR REPLACE VIEW FACTUREFOURNVALIDE_V
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, PROJET, NUMEROOP,
             CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE,
             IDENGAGEMENT, IDENGAGEMENTLIB,CODEETABLISSEMENT)
AS
select ff.ID,
       ff.DATY,
       ff.TIERS,
       ff.DESIGNATION,
       ff.TYPE,
       ff.TVA,
       ff.REMARQUE,
       ff.IDUSER,
       ff.DATE_ECHEANCE,
       ff.ETAT,
       ff.IDPREVISION,
       ff.MONTANT,
       ff.MONTANTTVA,
       ff.MONTANTAVOIR,
       ff.MONTANTTTC,
       ff.MONTANTPAYE,
       ff.MONTANTRESTE,
       ff.TIERSLIB,
       ff.CONTACT,
       ff.ADRESSE,
       ff.ESCALE,
       ff.TYPELIB,
       ff.IDCATEGORIE,
       ff.CATEGORIELIB,
       ff.IDPROVISION,
       ff.IDPROVISIONLIB,
       ff.ESTDDPMICTSL,
       ff.DEVISEMERE,
       ff.CODEPRESTATION,
       ff.CODEPRESTATIONLIB,
       ff.CODE,
       ff.ESTMICTSL,
       ff.CODEPROVISION,
       ff.ETATLIB,
       ff.MONTANTTTCVRAI,
       ff.IDBL,
       ff.PROJET,
       ff.NUMEROOP,
       ff.CODE_ETABLISSEMENT,
       ff.PROJETLIB,
       ff.CODE_ETABLISSEMENTLIB,
       ff.NATURE,
       ff.NATURELIB,
       ff.IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
       idengagement,
       idengagementlib,
       CODE_ETABLISSEMENT as CODEETABLISSEMENT
from FACTUREFOURNVALIDE ff
         left join LIAISONINTRATABLE op on op.ID1 = ff.id
         left join ORDONNERPAYEMENT ord on op.ID2 = ord.id
where ff.etat >= 11
  and ff.id not in (select id1 from LIAISONINTRATABLE);



CREATE OR REPLACE VIEW FACTUREFOURNVALIDE_EP
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET,
             CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE,
             IDENGAGEMENT, IDENGAGEMENTLIB,CODEETABLISSEMENT)
AS
select ff.ID,
       ff.DATY,
       ff.TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       ff.REMARQUE,
       ff.IDUSER,
       DATE_ECHEANCE,
       ff.ETAT,
       IDPREVISION,
       ff.MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       ESTDDPMICTSL,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       MONTANTTTCVRAI,
       'ATTENTE DE PAIEMENT' as ETATLIB,
       ff.IDBL,
       ff.NUMEROOP,
       projet,
       code_etablissement,
       projetlib,
       code_etablissementlib,
       NATURE,
       NATURELIB,
       IDBC,
       ord.NUMEROOP          as numop,
       ff.exercice,
       IDENGAGEMENT,
       IDENGAGEMENTLIB,
       CODE_ETABLISSEMENT
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
         left join ORDONNERPAYEMENT ord on li.ID2 = ord.id
where (li.IDJOURNAL is not null
    and li.ETATJC = 1)
   or (li.IDJOURNAL is null);


CREATE OR REPLACE VIEW FACTUREFOURNVALIDE_P
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, ETATLIB, IDBL, NUMEROOP, PROJET,
             CODE_ETABLISSEMENT, PROJETLIB, CODE_ETABLISSEMENTLIB, NATURE, NATURELIB, IDBC, NUMOP, EXERCICE,
             IDENGAGEMENT, IDENGAGEMENTLIB,CODEETABLISSEMENT)
AS
select ff.ID,
       ff.DATY,
       ff.TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       ff.REMARQUE,
       ff.IDUSER,
       DATE_ECHEANCE,
       ff.ETAT,
       IDPREVISION,
       ff.MONTANT,
       MONTANTTVA,
       MONTANTAVOIR,
       MONTANTTTC,
       MONTANTPAYE,
       MONTANTRESTE,
       TIERSLIB,
       CONTACT,
       ADRESSE,
       ESCALE,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB,
       ESTDDPMICTSL,
       DEVISEMERE,
       CODEPRESTATION,
       CODEPRESTATIONLIB,
       CODE,
       ESTMICTSL,
       CODEPROVISION,
       MONTANTTTCVRAI,
       'PAYE'       as ETATLIB,
       ff.IDBL,
       ff.NUMEROOP,
       projet,
       code_etablissement,
       projetlib,
       code_etablissementlib,
       NATURE,
       NATURELIB,
       IDBC,
       ord.NUMEROOP as numop,
       ff.exercice,
       IDENGAGEMENT,
       IDENGAGEMENTLIB,
       CODE_ETABLISSEMENT
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
         left join ORDONNERPAYEMENT ord on li.ID2 = ord.id
where li.IDJOURNAL is not null
  and li.ETATJC = 11;

create view SITUATIONLCDEPENSEVSD as
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
       cast(((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100 as number(30, 3))       as pourcPaye,
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
                   on l.compte = mf.comptecpl AND mf.annee = l.annee
where l.etat >= 11
      --and mf.comptecpl is not null
-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)
group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat, substr(l.compte, 7, length(l.compte)), comptecpl,
         l.PROJET,         l.CODEETABLISSEMENT;


create or replace view LIGNECREDITDEPENSEGRP as
select idprojet,
       idcodeEtablissement,
       sum(montant) as montant,
       sum(facture) as facture,
       sum(paye)as paye,
       sum(arecouvrir) as arecouvrir,
       sum(restebudget) as restebudget
        from SITUATIONLCDEPENSEVSD
        group by idcodeEtablissement, idprojet;


