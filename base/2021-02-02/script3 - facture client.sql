-- auto-generated definition
create table TYPE_FACTURE_CLIENT
(
    ID    VARCHAR2(100) not null
        primary key,
    VAL   VARCHAR2(500),
    DESCE VARCHAR2(500)
);

create table ANTENNE
(
    ID    VARCHAR2(50) not null
        primary key,
    VAL   VARCHAR2(150),
    DESCE VARCHAR2(200)
);


-- auto-generated definition
create table CATEGORIE_CENTRE
(
    ID    VARCHAR2(100) not null
        constraint CATEGORIE_CENTRE_PK
            primary key,
    VAL   VARCHAR2(500),
    DESCE VARCHAR2(500)
);

-- auto-generated definition
create table TYPE_CENTRE
(
    ID    VARCHAR2(100) not null
        constraint TYPECENTRE_PK
            primary key,
    VAL   VARCHAR2(500),
    DESCE VARCHAR2(500)
);




-- auto-generated definition
create table CENTRE
(
    ID    VARCHAR2(100) not null
        constraint CENTRE_PK
            primary key,
    VAL   VARCHAR2(500),
    DESCE VARCHAR2(500)
        constraint CENTRE_CATEGORIE
            references CATEGORIE_CENTRE,
    TYPE  VARCHAR2(500)
        constraint TYPE_CENTRE_FK
            references TYPE_CENTRE
);
create table FACTURE_CLIENT
(
    ID          VARCHAR2(100) not null
        primary key,
    DATY        DATE,
    TIERS       VARCHAR2(100),
    DESIGNATION VARCHAR2(200),
    MONTANT     NUMBER(30, 2),
    TYPEE       VARCHAR2(100),
    TVA         NUMBER(30, 2),
    MONTANTTVA  NUMBER(30, 2),
    ETAT        NUMBER,
    DEVISE      VARCHAR2(100),
    COMPTE      VARCHAR2(100),
    REMARQUE    VARCHAR2(255),
    COURSDEVISE NUMBER(30, 2),
    ENTITE      VARCHAR2(100),
    ANTENNE     VARCHAR2(100)
        constraint FACTURE_CLIENT_ANTENNE_FK
            references ANTENNE
        references CENTRE,
    IDJOURNAL   VARCHAR2(100)
);
-- auto-generated definition
create table FACTURE_CLIENT_DETAIL
(
    ID            VARCHAR2(50)  not null,
    DESIGNATION   VARCHAR2(500) not null,
    QUANTITE      NUMBER(18, 2) not null,
    MONTANT       NUMBER(18, 2) not null,
    REMARQUE      VARCHAR2(500),
    IDFACTURE     VARCHAR2(50)  not null,
    COMPTEDEBIT   VARCHAR2(50),
    COMPTECREDIT  VARCHAR2(50),
    ANALDEBIT     VARCHAR2(50),
    ANALCREDIT    VARCHAR2(50),
    IDACTE        VARCHAR2(50),
    MONTANTT      NUMBER(18, 2),
    MEDICAMENT    VARCHAR2(50),
    MONTANTREMISE NUMBER(10, 2)
);



CREATE OR REPLACE VIEW FACTURECLIENTDETAILSMONTANT (IDFACTURE, MONTANT, MONTANTTVA, MONTANTREMISE) AS
select idfacture,
       nvl(sum(fcd.montant * fcd.quantite), 0)                        as montant,
       nvl((sum(fcd.montant * fcd.quantite * fc.TVA) / 100), 0)       as montanttva,
       nvl((sum(fcd.montant * fcd.quantite * fcd.MONTANTT) / 100), 0) as montantremise
from facture_client_detail fcd
         join FACTURE_CLIENT fc on fc.id = fcd.IDFACTURE
group by idfacture;



CREATE OR REPLACE VIEW FACTURECLIENTMONTANT
            (ID, DATY, IDFOURNISSEUR, TVA, REMARQUE, DATEEMISSION, DESIGNATION, DEVISE, NUMFACT, RESP, DATE_ECHEANCE,
             ETAT, IDFACTUREFOURNISSEUR, ENTITE, MONTANTTTC, REMISE)
AS
select ff.id,
       ff.daty,
       ff.TIERS                        as idfournisseur,
       ff.tva,
       ff.remarque,
       (select current_date from dual) as dateemission,
       ff.designation,
       ff.devise,
       cast('' as varchar2(100))       as numfact,
       cast('' as varchar2(100))       as resp,
       (select current_date from dual) as date_echeance,
       ff.etat,
       cast('' as varchar2(100))       as idfacturefournisseur,
       ff.entite,
       fcm.montant + fcm.montanttva    as montantttc,
       fcm.montantremise               as remise
from FACTURE_CLIENT ff
         join factureclientdetailsmontant fcm on fcm.IDFACTURE = ff.id;



CREATE OR REPLACE VIEW FACTURECLIENTLETTRE
            (ID, DATY, IDFOURNISSEUR, IDTVA, MONTANTTTC, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT,
             DATYECHEANCE, REMISE, ETAT)
AS
SELECT ff.id,
       ff.daty,
       c.NOMCLT as idFournisseur,
       ff.tva,
       ff.montantttc,
       ff.remarque,
       ff.dateemission,
       ff.designation,
       ff.devise,
       ff.numfact,
       ff.date_echeance,
       ff.REMISE,
       ff.etat
FROM FACTURECLIENTmontant ff,
     V_CLIENT_CATEGORIE c
where c.CDCLT (+) = ff.IDFOURNISSEUR;



CREATE OR REPLACE VIEW ETATFACTURE
            (ID, DATY, IDFOURNISSEUR, IDTVA, MONTANTTTC, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT,
             DATYECHEANCE, ETAT, MONTANTPAYE, RESTE, REMISE)
AS
select f.ID,
       f.DATY,
       f.IDFOURNISSEUR,
       f.IDTVA,
       cast(f.MONTANTTTC as NUMBER(10, 2))                        as MONTANTTTC,
       f.REMARQUE,
       f.DATEEMISSION,
       f.DESIGNATION,
       f.IDDEVISE,
       f.NUMFACT,
       f.DATYECHEANCE,
       f.ETAT,
       cast(nvl(op.montant, 0) as NUMBER(10, 2))                  as montantPaye,
       cast((f.montantTTC - nvl(op.montant, 0)) as NUMBER(10, 2)) as reste,
       REMISE                                                     as remise
from FACTURECLIENTLettre f,
     ORDONNERPAYEMENTGROUPEFACT op
where f.ID = op.DED_ID(+);



CREATE OR REPLACE FORCE VIEW PAIEMENTFACTURECLIENT1
            (ID, DATY, TIERS, DESIGNATION, TYPEE, TVA, ETAT, DEVISE, COMPTE, REMARQUE, COURSDEVISE, MONTANT, MONTANTTVA,
             MONTANTTOTAL, MONTANTPAYER, RESTEAPAYER, REMISE)
AS
select ef.id,
       ef.daty,
       ef.idfournisseur,
       ef.designation,
       CAST('' as varchar2(100))  as typee,
       ef.idtva,
       EF.etat,
       EF.iddevise,
       cast('' as varchar2(100))  as compte,
       ef.remarque,
       cast('' as varchar2(100))  as coursdesvise,
       ef.montantttc,
       (ef.montantttc * ef.IDTVA) AS MONTANTTVA,
       ef.montantttc,
       EF.montantpaye,
       EF.reste,
       ef.remise
from etatfacture ef;



create view MONTANTAVOIRPARFACTURE as
SELECT IDFACTURE, SUM(MONTANT) AS MONTANT
FROM avoir
GROUP BY IDFACTURE;


create or replace view PAIEMENT_FACTURECLIENT_REMISE as
SELECT  PFCC.ID,
                PFCC.DATY,
                PFCC.TIERS,
                PFCC.DESIGNATION,
                PFCC.TYPEE,
                PFCC.TVA,
                PFCC.ETAT,
                PFCC.DEVISE,
                PFCC.COMPTE,
                PFCC.REMARQUE,
                PFCC.COURSDEVISE,
                PFCC.MONTANT,
                PFCC.MONTANTTVA,
                nvl(fa.montant, 0)                                           AS avoir,
                fcd.montantremise * FCD.QUANTITE                             as montantTotaleRemise,
                PFCC.MONTANTTOTAL - nvl(fa.montant, 0)                       AS MONTANTTOTAL,
                PFCC.MONTANTPAYER,
                (PFCC.MONTANTTOTAL - nvl(fa.montant, 0)) - PFCC.MONTANTPAYER as RESTEAPAYER,
                (PFCC.MONTANTTOTAL - nvl(fa.montant, 0)) - PFCC.MONTANTPAYER as RESTEAVOIR
FROM PAIEMENTFACTURECLIENT1 PFCC
         join facture_client_detail fcd on fcd.IDFACTURE = pfcc.id
         LEFT JOIN montantavoirparfacture fa ON fa.idfacture = pfcc.id
/


create view PAIEMENTFACTURECLIENTREMISE_NV as
SELECT *
FROM PAIEMENT_FACTURECLIENT_REMISE
WHERE ETAT = 1;

create view PAIEMENTFACTURECLIENTREMISE_V as
SELECT*
FROM PAIEMENT_FACTURECLIENT_REMISE
WHERE ETAT = 11
  and RESTEAPAYER > 0;

create view PAIEMENTFACTURECLIENTREMISE_P as
SELECT *
FROM PAIEMENT_FACTURECLIENT_REMISE
WHERE ETAT = 11
  and RESTEAPAYER = 0;


create view FACTURE_CLIENT_DETAIL_LIB as
select
            fcd.ID,
            fcd.DESIGNATION,
            fcd.QUANTITE,
            fcd.MONTANT,
            fcd.REMARQUE,
            fcd.IDFACTURE,
            fcd.COMPTEDEBIT,
            fcd.COMPTECREDIT,
            fcd.ANALDEBIT,
            fcd.ANALCREDIT,
            fcd.IDACTE,
            fcd.MONTANTT,
            ' ' as MEDICAMENT,
            fcd.MONTANTREMISE
        from FACTURE_CLIENT_DETAIL fcd;

CREATE OR REPLACE FORCE VIEW PAIEMENTFACTURECLIENT
            (ID, DATY, TIERS, DESIGNATION, TYPEE, TVA, ETAT, DEVISE, COMPTE, REMARQUE, COURSDEVISE, MONTANT, MONTANTTVA,
             MONTANTTOTAL, MONTANTPAYER, RESTEAPAYER, REMISE)
AS
select ef.id,
       ef.daty,
       ef.idfournisseur,
       ef.designation,
       CAST('' as varchar2(100)) as typee,
       ef.idtva,
       EF.etat,
       EF.iddevise,
       cast('' as varchar2(100)) as compte,
       ef.remarque,
       cast('' as varchar2(100)) as coursdesvise,
       ef.montantttc,
       ef.montantttc,
       ef.montantttc,
       EF.montantpaye,
       EF.reste,
       ef.remise
from etatfacture ef;



CREATE SEQUENCE seqfactureclient
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqfactureclient
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqfactureclient.nextval INTO retour FROM dual;
    return retour;
END;

CREATE SEQUENCE seqfactureclientdetails
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqfactureclientdetails
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqfactureclientdetails.nextval INTO retour FROM dual;
    return retour;
END;
CREATE SEQUENCE seqtype_facture_client
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqtype_facture_client
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqtype_facture_client.nextval INTO retour FROM dual;
    return retour;
END;

CREATE OR REPLACE VIEW FACTURE_CLIENT_CONTACT
            (ID, DATY, TIERS, DESIGNATION, MONTANT, TYPEE, TVA, MONTANTTVA, ETAT, DEVISE, COMPTE, REMARQUE, COURSDEVISE,
             ENTITE, ANTENNE)
AS
SELECT FC.ID,
       DATY,
       SP.NOMCLT AS TIERS,
       DESIGNATION,
       MONTANT,
       TYPEE,
       TVA,
       MONTANTTVA,
       ETAT,
       DEVISE,
       FC.COMPTE,
       SP.TELCLT                    AS REMARQUE,
       COURSDEVISE,
       ENTITE,
       ANTENNE

FROM facture_client FC
         JOIN V_CLIENT_CATEGORIE SP ON SP.CDCLT = FC.TIERS;

create view montantremisefactureclient as
select IDFACTURE, sum(fcd.montantremise * FCD.QUANTITE) as montantTotaleRemise
from FACTURE_CLIENT_DETAIL fcd
group by IDFACTURE;

create or replace view PAIEMENT_FACTURECLIENT_REMISE as
SELECT PFCC.ID,
       PFCC.DATY,
       PFCC.TIERS,
       PFCC.DESIGNATION,
       PFCC.TYPEE,
       PFCC.TVA,
       PFCC.ETAT,
       PFCC.DEVISE,
       PFCC.COMPTE,
       PFCC.REMARQUE,
       PFCC.COURSDEVISE,
       PFCC.MONTANT,
       PFCC.MONTANTTVA,
       nvl(fa.montant, 0)                                           AS avoir,
       fcd.montantTotaleRemise                                      as montantTotaleRemise,
       PFCC.MONTANTTOTAL - nvl(fa.montant, 0)                       AS MONTANTTOTAL,
       PFCC.MONTANTPAYER,
       (PFCC.MONTANTTOTAL - nvl(fa.montant, 0)) - PFCC.MONTANTPAYER as RESTEAPAYER,
       (PFCC.MONTANTTOTAL - nvl(fa.montant, 0)) - PFCC.MONTANTPAYER as RESTEAVOIR
FROM PAIEMENTFACTURECLIENT1 PFCC
         join montantremisefactureclient fcd on fcd.IDFACTURE = pfcc.id
         LEFT JOIN montantavoirparfacture fa ON fa.idfacture = pfcc.id
/