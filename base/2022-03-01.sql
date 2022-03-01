create or replace view engagementlibC as
select *
from engagementlib where etat=1;

CREATE OR REPLACE  VIEW LIGNECREDITDEPENSEGRP
(
   IDPROJET,
   IDCODEETABLISSEMENT,
   MONTANT,
   FACTURE,
   PAYE,
   ARECOUVRIR,
   RESTEBUDGET
)
AS
     SELECT idprojet,
            idcodeEtablissement,
            CAST(SUM (montant) as number(30,3)) AS montant,
            cast(SUM (facture) as number(30,3)) AS facture,
            cast(SUM (paye) as number(30,3)) AS paye,
            cast(SUM (arecouvrir) as number(30,3)) AS arecouvrir,
            cast(SUM (restebudget)as number(30,3)) AS restebudget
       FROM SITUATIONLCDEPENSEVSD
   GROUP BY idcodeEtablissement, idprojet;

UPDATE MENUDYNAMIQUE x
	SET x.RANG=6
	WHERE x.ID='MEND0000200';
UPDATE MENUDYNAMIQUE x
	SET x.RANG=3
	WHERE x.ID='MEN00212';
UPDATE MENUDYNAMIQUE x
	SET x.RANG=4
	WHERE x.ID='MEN00500';
UPDATE MENUDYNAMIQUE x
	SET x.RANG=1
	WHERE x.ID='MEN008';
UPDATE MENUDYNAMIQUE x
	SET x.RANG=2
	WHERE x.ID='MEN009';
UPDATE MENUDYNAMIQUE x
	SET x.RANG=5
	WHERE x.ID='MENUM01';	

UPDATE MENUDYNAMIQUE x
	SET x.ID_PERE='MEN00500', x.RANG=5, x.NIVEAU=4
	WHERE x.ID='MEND00112100';



create or replace view ENGAGEMENTLIB as
select e."ID",
       e."DESIGNATION",
       nvl(e."CODEETABLISSEMENT",lp.CODEETABLISSEMENT) as CODEETABLISSEMENT,
       nvl(e."PROJET",lp.PROJET) as PROJET,
       e."MONTANT",
       e."DISPONIBLE",
       e."DISPOAVANT",
       e."DISPOAPRES",
       e."COMPTE",
       e."ETAT",
       nvl(ce.VAL,ce1.val)        as codeetablissementlib ,
       nvl(p.DESIGNATION,p1.designation) as projetlib,
       e.IDLC,
       lp.DESIGNATION as idLClib,
       DATY
from engagement e
         left join CODEETABLISSEMENT ce on ce.ID = e.CODEETABLISSEMENT
         left join PROJET p on p.ID = e.PROJET
         left join LIGNECREDITDEPENSE lp on e.IDLC = lp.ID
         left join CODEETABLISSEMENT ce1 on ce1.ID = lp.CODEETABLISSEMENT
         left join PROJET p1 on p1.ID = lp.PROJET
/

create table engagement_fille
(
    id varchar2(100) constraint engagement_fille_pk primary key ,
        idmere varchar2(100) constraint fk_engagementmre references ENGAGEMENT,
        designation varchar2(1000),
        montant number(30,2)
);
alter table engagement_fille allocate extent ;
CREATE SEQUENCE seqengagement_fille
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqengagement_fille
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqengagement_fille.nextval INTO retour FROM dual;
  return retour;
END;

alter table engagement add avecFacture number(10) default 1;

INSERT INTO USERMENU (ID, IDMENU, IDROLE, INTERDIT) VALUES ('1MENP000011', 'MEN00212', 'ROL0000001261171742', '0');
INSERT INTO USERMENU (ID, IDMENU, IDROLE, INTERDIT) VALUES ('1MENP000012', 'MEND00002009', 'ROL0000001261171742', '1');

UPDATE UTILISATEUR SET IDROLE = 'ROL0000001261171742' WHERE ID = '1343';
UPDATE UTILISATEUR SET IDROLE = 'ROL0000001261171742' WHERE ID = '1424';

INSERT INTO ROLES(IDROLE, DESCROLE, RANG) VALUES ('ROLE0021', 'chargeSimple ', '4');


Insert into USERMENU (ID,REFUSER,IDMENU,IDROLE,CODESERVICE,CODEDIR,INTERDIT) values ('UM01501',null,'MEN00500','ROLE0021',null,null,'0');
Insert into USERMENU (ID,REFUSER,IDMENU,IDROLE,CODESERVICE,CODEDIR,INTERDIT) values ('UM01502',null,'MENUM01','ROLE0021',null,null,'0');
Insert into USERMENU (ID,REFUSER,IDMENU,IDROLE,CODESERVICE,CODEDIR,INTERDIT) values ('UM01503',null,'MENBDG0001','ROLE0021',null,null,'0');
Insert into USERMENU (ID,REFUSER,IDMENU,IDROLE,CODESERVICE,CODEDIR,INTERDIT) values ('UM01505',null,'MENM07','ROLE0021',null,null,'0');
Insert into USERMENU (ID,REFUSER,IDMENU,IDROLE,CODESERVICE,CODEDIR,INTERDIT) values ('UM01506',null,'MEN00213','ROLE0021',null,null,'0');
Insert into USERMENU (ID,REFUSER,IDMENU,IDROLE,CODESERVICE,CODEDIR,INTERDIT) values ('UM01507',null,'MENBDG00011','ROLE0021',null,null,'1');
Insert into USERMENU (ID,REFUSER,IDMENU,IDROLE,CODESERVICE,CODEDIR,INTERDIT) values ('UM01508',null,'MEND00002009','ROLE0021',null,null,'1');


UPDATE UTILISATEUR SET IDROLE = 'ROLE0021' WHERE REFUSER = '1421';
UPDATE UTILISATEUR SET IDROLE = 'ROLE0021' WHERE REFUSER = '1422';
UPDATE UTILISATEUR SET IDROLE = 'ROLE0021' WHERE REFUSER = '1426';
UPDATE UTILISATEUR SET IDROLE = 'ROLE0021' WHERE REFUSER = '1506';


create table payementEngagement
(
    id varchar2(100) constraint payementEngagement_pk primary key ,
        idEngagement varchar2(100) constraint fk_engagement_paye references ENGAGEMENT,
        idOP varchar2(100) constraint fk_ordonnerpayement_en references ORDONNERPAYEMENT
);

alter table payementEngagement allocate extent ;


CREATE SEQUENCE seqpayementEngagement
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;
create or replace FUNCTION getseqpayementEngagement
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqpayementEngagement.nextval INTO retour FROM dual;
  return retour;
END;;