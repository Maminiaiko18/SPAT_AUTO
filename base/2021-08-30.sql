create table paiementfacture
(
    id      varchar2(100)
        constraint pk_paiementfacture primary key,
    idMvt   varchar2(50)
        constraint fk_paiementfact_journalcaisse references JOURNALCAISSE (id)
,
    idFact  varchar2(500)
        constraint fk_paiementfact_factureclient references FACTURECLIENT (id)
,
    montant number(30, 3)
);

CREATE SEQUENCE seq_paiementfacture
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_paiementfacture
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_paiementfacture.nextval INTO retour FROM dual;
    return retour;
END;



create table categorieAvoirFC
(
    id      varchar2(100)
        constraint pk_categorieAvoirFC primary key,
    val varchar2(500),
    desce varchar2(500)
);

CREATE SEQUENCE seq_categorieAvoirFC
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_categorieAvoirFC
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_categorieAvoirFC.nextval INTO retour FROM dual;
    return retour;
END;

alter table AVOIRFC add designation varchar2(500);
alter table AVOIRFC add code varchar2(500);
alter table AVOIRFC add categorie varchar2(100) constraint fk_AVOIRFC_categorieAvoirFC references categorieAvoirFC(id);



INSERT INTO CATEGORIEAVOIRFC (ID, VAL, DESCE) VALUES ('CT001', 'TCN', 'total credit non remboursable');
INSERT INTO CATEGORIEAVOIRFC (ID, VAL, DESCE) VALUES ('CT002', 'PCN', 'partiel credit non remboursable');
INSERT INTO CATEGORIEAVOIRFC (ID, VAL, DESCE) VALUES ('CT003', 'TCR', 'total comptant remboursable');
INSERT INTO CATEGORIEAVOIRFC (ID, VAL, DESCE) VALUES ('CT004', 'PCR', 'partiel comptant remboursable');
INSERT INTO CATEGORIEAVOIRFC (ID, VAL, DESCE) VALUES ('CT005', 'CTR', 'credit total remboursable');
INSERT INTO CATEGORIEAVOIRFC (ID, VAL, DESCE) VALUES ('CT006', 'CPR', 'credit partiel remboursable');



alter table avoirFCFille add remise number(30,3);

create table motifAvoirFC (
id varchar2(100) constraint motifAvoirFC_pk primary key ,
val varchar2(500),
desce varchar2(500));

INSERT INTO MOTIFAVOIRFC (ID, VAL, DESCE) VALUES ('MT001', 'Erreur de taxateur', 'interne');
INSERT INTO MOTIFAVOIRFC (ID, VAL, DESCE) VALUES ('MT002', 'Bourrage a l impression de la facture', 'interne');
INSERT INTO MOTIFAVOIRFC (ID, VAL, DESCE) VALUES ('MT003', 'Taxation en double emploi', 'interne');
INSERT INTO MOTIFAVOIRFC (ID, VAL, DESCE) VALUES ('MT004', 'Desistement du client', 'interne');
INSERT INTO MOTIFAVOIRFC (ID, VAL, DESCE) VALUES ('MT005', 'Prestations non realisees', 'externe');
INSERT INTO MOTIFAVOIRFC (ID, VAL, DESCE) VALUES ('MT006', 'Erreur de taxation', 'externe');
INSERT INTO MOTIFAVOIRFC (ID, VAL, DESCE) VALUES ('MT007', 'Documents du client imprecis', 'externe');
INSERT INTO MOTIFAVOIRFC (ID, VAL, DESCE) VALUES ('MT008', 'Remise accordee par la direction', 'externe');
create view paiementfactureProvision as
select tp.*
from paiementfacture pf
         join TOUSPROVISION tp on pf.idfact = tp.id;

		 create or replace view paiementfactureProvision as
select pf.*
from paiementfacture pf
         join TOUSPROVISION tp on pf.idfact = tp.id;
		 
create view ementfactureHorsProvision as
select *
from paiementfacture
where id not in (select id from paiementfactureProvision);


create view ordonnerpayementAvoirFC  as
select op.*, av.idfacture
from ordonnerpayement op
         join avoirFC av on op.DED_ID = av.id;
		 
create view AVOIRFC_SEQUENCE as
select fc.ID,
       DATY,
       DESIGNATION,

       ETAT,
       CODE,
       substr((CODE), 2, 2) || '/' || substr((CODE), 4, 2) || '/01/'
           || substr((CODE), length((CODE)) - 5, 6)                                        as datemoisseq,
       cast('01/' || substr((CODE), 4, 2) || '/' || substr((CODE), 2, 2) as VARCHAR2(100)) as
                                                                                              datemois,
       substr((CODE), length((CODE)) - 5, 6)                                               as maxidparmoisane
from AVOIRFC fc;

create view NUMEROAVOIRFC as
select cast('-' as VARCHAR2(100))                                          as id,
       cast(nvl(cast(max(maxidparmoisane) + 1 as NUMBER(10)),1) as VARCHAR2(500)) as val,
       '-'                                                                 as desce
from AVOIRFC_SEQUENCE;

create view ETATPROVISIONVRAI as
select fac.id,
       fac.MONTANTTTC                 as montantfacture,
       fu.MONTANTTTC                  as montantprovision,
       fac.MONTANTPAYE,
       fac.MONTANTTTC - fac.MONTANTPAYE as ecart,
       fac.TIERS,fac.TIERSLIB,
       fu.DATY as datyprovision,
       fu.tiers  as tiersprovision,
       fu.tierslib  as tierslibprovision
from FACTURE_CLIENT_UNION fac
         join FACTURE_CLIENT_UNION fu on fu.id = fac.IDPROVISION;
		 
alter table AVOIRFC add motif varchar2(100) constraint fk_AVOIRFC_motifAvoirFC references motifAvoirFC(id);

create or replace view ETATPROVISIONVRAI as
select fac.id,
       fac.MONTANTTTC                 as montantfacture,
       fu.MONTANTTTC                  as montantprovision,
       fac.MONTANTPAYE,
       fac.MONTANTTTC - fac.MONTANTPAYE as ecart,
       fac.TIERS,fac.TIERSLIB,
       fu.DATY ,
       fu.tiers  as tiersprovision,
       fu.tierslib  as tierslibprovision
from FACTURE_CLIENT_UNION fac
         join FACTURE_CLIENT_UNION fu on fu.id = fac.IDPROVISION;
		 
alter table AVOIRFC add motif varchar2(100) constraint fk_AVOIRFC_motifAvoirFC references motifAvoirFC(id);

create view FACTURECLIENT_LIBCOMPLET as
select fc."ID",
       fc."DATY",
       fc."TIERS",
       fc."DESIGNATION",
       fc."TYPE",
       fc."TVA",
       fc."REMARQUE",
       fc."IDUSER",
       fc."DATE_ECHEANCE",
       fc."ETAT",
       fc."IDPREVISION",
       fc."IDCATEGORIE",
       fc."IDPROVISION",
       fc."DEVISEMERE",
       fc."ESTDDPMICTSL",
       fc."CODEPRESTATION",
       fc."CODE",
       fc."ESTMICTSL",
       fup.NOM as tierslib,
       cat.VAL as categorielib,
       tf.VAL  as typelib
from FACTURECLIENT fc
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = fc.TIERS
         left join CATEGORIEFC cat on cat.ID = fc.IDCATEGORIE
         left join TYPEFC tf on tf.ID = fc.TYPE;

create or replace view JOURNALCAISSELIB_VISE_GRP as
select cast(sum(DEBIT) as NUMBER(30, 3)) as DEBIT, IDPLACEMENT
from JOURNALCAISSELIB_VISE
group by IDPLACEMENT;

CREATE OR REPLACE VIEW AVOIRFC_MONTANT
            (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, MONTANTPAYE, MONTANTRESTE,
                categorie,categorielib,motif,motiflib) AS
select fc.ID,
       fc.DATY,
       fc.IDFACTURE,
       fc.ETAT,
       cast(nvl(mr.montant, 0.0) as NUMBER(30, 3))                    as montant,
       f.TIERS,
       f.tierslib,
       cast(nvl(gr.DEBIT, 0) as NUMBER(30, 3))                        as montantpaye,
       cast(nvl(mr.montant, 0.0) - nvl(gr.DEBIT, 0) as NUMBER(30, 3)) as montantreste,
       fc.CATEGORIE,
       c.VAL                                                          as categorielib,
       fc.MOTIF,
       mo.val                                                         as motiflib
from AVOIRFC fc
         left join CATEGORIEAVOIRFC c on fc.CATEGORIE = c.id
         left join MOTIFAVOIRFC mo on fc.MOTIF = mo.id
         left join avoirfcavectaux_grp_mere mr on mr.IDMERE = fc.ID
         left join FACTURECLIENT_libcomplet f on fc.IDFACTURE = f.ID
         left join JOURNALCAISSELIB_VISE_grp gr on gr.IDPLACEMENT = fc.ID;



CREATE OR REPLACE VIEW AVOIRFCFILLE_PLUS
            (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, MONTANTDF, DESIGNATION, DEVISE,remise) AS
select fc.ID,
       fc.IDMERE,
       fc.IDDETAILFACTURE,
       fc.MONTANT,
       fc.COMPTE,
       cast(0.0 as NUMBER(30, 2)) as montantdf,
       cast('-' as varchar2(500)) as designation,
       cast('-' as varchar2(500)) as devise,
       fc.REMISE
from AvoirFCFille fc