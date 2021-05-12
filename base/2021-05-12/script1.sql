create table Factureclient
(
    id            varchar2(500)
        constraint Factureclient_pk primary key,
    daty          date,
    tiers         varchar2(500),
    designation   varchar2(4000),
    type          varchar2(500),
    tva           number(10, 2),
    remarque      varchar2(500),
    iduser        varchar2(500),
    date_echeance date,
    etat          number(10)
);
CREATE SEQUENCE seq_Factureclient
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seq_Factureclient
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_Factureclient.nextval INTO retour FROM dual;
  return retour;
END;

create table facture_client_fille
(
    id          varchar2(500)
        constraint facture_client_fille_pk primary key,
    idmere      varchar2(500)
        constraint mere_fille_fk references Factureclient,
    designation varchar2(4000),
    quantite    number(10, 2),
    pu          number(30, 2),
    compte      varchar2(500),
    idproduit   varchar2(500),
    devise      varchar2(500)
        constraint devise_fc_fk references DEVISE,
    taux        number(10, 2)
);

CREATE SEQUENCE seq_facture_client_fille
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seq_facture_client_fille
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_facture_client_fille.nextval INTO retour FROM dual;
  return retour;
END;


create table AvoirFC
(
    id        varchar2(500)
        constraint AvoirFC_pk primary key,
    daty      date,
    idfacture varchar2(500)
        constraint facture_avoir_fc_fk references FACTURECLIENT,
    etat      number(10)

);

CREATE SEQUENCE seqAvoirFC
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqAvoirFC
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqAvoirFC.nextval INTO retour FROM dual;
  return retour;
END;

create table avoirFCfille
(
    id              varchar2(500)
        constraint avoirFCfille primary key,
    idmere          varchar2(500) constraint mere_fille references AvoirFC,
    iddetailfacture varchar2(500)
        constraint avoirFCfille_df_fk references facture_client_fille,
    montant         number(30, 2),
    compte          varchar2(500)
);

CREATE SEQUENCE seqavoirFCfille
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqavoirFCfille
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqavoirFCfille.nextval INTO retour FROM dual;
  return retour;
END;

INSERT INTO DEVISE (ID, VAL, DESCE) VALUES ('Dollars', 'Dollars', 'Dollars');
INSERT INTO COURSDEVISE (ID, IDDEVISE, MONTANT, DATY) VALUES ('CR000100', 'Dollars', 3771.26, TO_DATE('2021-05-12 10:16:41', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO COURSDEVISE (ID, IDDEVISE, MONTANT, DATY) VALUES ('CR000101', 'Eur', 4572.45, TO_DATE('2021-05-12 10:16:56', 'YYYY-MM-DD HH24:MI:SS'));
commit;	

create table typefrequence
(
    id varchar2(500) constraint typefrequence_pk primary key ,
        val varchar2(500),
        desce varchar2(500)
);

INSERT INTO TYPEFREQUENCE (ID, VAL, DESCE) VALUES ('TF001', '1', 'journalier');
INSERT INTO TYPEFREQUENCE (ID, VAL, DESCE) VALUES ('TF002', '7', 'hebdomadaire');
INSERT INTO TYPEFREQUENCE (ID, VAL, DESCE) VALUES ('TF003', '30', 'mensuel');
INSERT INTO TYPEFREQUENCE (ID, VAL, DESCE) VALUES ('TF004', '365', 'annuel');
commit;


		 
create view facture_client_Mere_fille as
select fi.*,
       fc.daty,
       fc.tiers,
       fc.designation as designationmere,
       fc.type,
       fc.tva,
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat
from facture_client_fille fi
         left join FACTURECLIENT fc on fi.idmere = fc.id;
		 
create view facture_client_montant as
select fm.*,
       cast(fm.pu*fm.quantite as number(30,2)) as Montant,
       cast((fm.pu * fm.quantite) * fm.taux as NUMBER(30,2)) as montanttaux
from facture_client_Mere_fille fm;

create view facture_client_grp as
select sum(fm.MONTANT) as montant,
       sum(fm.montanttaux) as montanttaux,
       fm.idmere
from facture_client_montant fm
group by fm.idmere;

create view factureclientMSum as
select fc.*,
       cast(nvl(grp.montanttaux,0) as number(30,2)) as montant
from FACTURECLIENT fc
         left join facture_client_grp grp on grp.idmere=fc.id;
		 
create view factureclientMSumC as
select * from factureclientMSum where etat=1;

create view factureclientMSumV as
select * from factureclientMSum where etat>=11;

create  or replace view STATISTIQUEACTIVITE_MICTSL_GR AS
select nvl(m.mois, mo.ID)                                            as mois,
       nvl(m.annee, 0)                                               as annee,
       cast(nvl(IDTYPEACTIONCONTENEURLIB, '-') as varchar2(500))        as IDTYPEMANIPULATIONLIB,
       cast(nvl(IDTYPEACTIONCONTENEUR, '-') as varchar2(500))           as IDTYPEMANIPULATION,
       cast(nvl(m.somme_plein20_vide20_plein40, 0) as number(20, 2)) as somme_plein20_vide20_plein40
from STATISTIQUEACTIVITE_MICTSL m
         right join mois mo on mo.id = m.MOIS;;

CREATE or replace VIEW recurrent AS
SELECT cast('' as varchar2(500)) AS id,
       cast('' as varchar2(500)) AS typefrequence,
       cast(0.0 as number(30,2)) AS nombre
FROM dual;