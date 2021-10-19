create table CATEGORIEFF
(
    ID    VARCHAR2(100) not null
        constraint PK_CATEGORIEFF
            primary key,
    VAL   VARCHAR2(150),
    DESCE VARCHAR2(150)
);

CREATE SEQUENCE seq_CATEGORIEFF
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create FUNCTION get_seq_CATEGORIEFF
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_CATEGORIEFF.nextval INTO retour FROM dual;
    return retour;
END;


INSERT INTO CATEGORIEFF (ID, VAL, DESCE) VALUES ('CATGFF001', 'definitive', 'definitive');
INSERT INTO CATEGORIEFF (ID, VAL, DESCE) VALUES ('CATGFF002', 'bon provisoire', 'bon provisoire');

create table PAIEMENTFACTURE
(
    ID      VARCHAR2(100) not null
        constraint PK_PAIEMENTFACTURE
            primary key,
    IDMVT   VARCHAR2(50)
        constraint FK_PAIEMENTFACT_JOURNALCAISSE
            references JOURNALCAISSE,
    IDFACT  VARCHAR2(500)
        constraint FK_PAIEMENTFACT_FACTURECLIENT
            references FACTURECLIENT,
    MONTANT NUMBER(30, 3)
);




create table facture_Fournisseur_Mere
(
    ID             VARCHAR2(500) not null
        constraint pk_factfournmere
            primary key,
    DATY           DATE,
    TIERS          VARCHAR2(100) ,
    DESIGNATION    VARCHAR2(4000),
    TYPE           VARCHAR2(500)
        constraint FK_factfournmere_TYPEFC
            references TYPEFC,
    TVA            NUMBER(10, 2),
    REMARQUE       VARCHAR2(500),
    IDUSER         VARCHAR2(500),
    DATE_ECHEANCE  DATE,
    ETAT           NUMBER(10),
    IDPREVISION    VARCHAR2(100)
        constraint FK_factfournmere_IDPREVISION
            references PREVISION,
    IDCATEGORIE    VARCHAR2(100)
        constraint FK_factfourn_mere_CATEGORIEFF
            references CATEGORIEFF,
    IDPROVISION    VARCHAR2(100) default ''
         ,
    DEVISEMERE     VARCHAR2(100) default 'Ar'
        references DEVISE,
    ESTDDPMICTSL   VARCHAR2(200),
    CODEPRESTATION VARCHAR2(100),
    CODE           VARCHAR2(500),
    ESTMICTSL      VARCHAR2(500)
);

alter table facture_Fournisseur_Mere add constraint FK_factfournmere_PROVISION foreign key (IDPROVISION)
            references facture_Fournisseur_Mere;
			
CREATE SEQUENCE seq_facture_Fournisseur_Mere
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_factFournMere
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_facture_Fournisseur_Mere.nextval INTO retour FROM dual;
    return retour;
END;




create table FACTURE_FOURNISSEUR_FILLE
(
    ID          VARCHAR2(500) not null
        constraint FACTURE_FOURNISSEUR_FILLE_PK
            primary key,
    IDMERE      VARCHAR2(500)
        constraint fk_factfourn_MERE_FILLE
            references FACTURE_FOURNISSEUR_MERE,
    DESIGNATION VARCHAR2(4000),
    QUANTITE    NUMBER(10, 3),
    PU          NUMBER(30, 3),
    COMPTE      VARCHAR2(500),
    IDPRODUIT   VARCHAR2(500)
        constraint fk_FACTFOURNFILLE_PRODUIT
            references AS_PRODUITS,
    DEVISE      VARCHAR2(500)
        constraint fk_factfournfille_DEVISE
            references DEVISE,
    TAUX        NUMBER(10, 2),
    IDACTIVITE  VARCHAR2(100)
        constraint fk_factfournfille_IACTIVITE
            references ACTIVITE,
    TVA         NUMBER(20, 2),
    DATEFACT    DATE,
    RUBRIQUE    VARCHAR2(100),
    MOIS        NUMBER(10),
    ANNEE       NUMBER(10),
    HEUREDEBUT  VARCHAR2(100),
    HEUREFIN    VARCHAR2(100),
    REDUCTION   NUMBER(20, 2),
    MAJORATION  NUMBER(20, 2),
    TEST        NUMBER(10, 3)
);


CREATE SEQUENCE seq_FACTURE_FOURNISSEUR_FILLE
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create FUNCTION get_seq_factFournfille
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_FACTURE_FOURNISSEUR_FILLE.nextval INTO retour FROM dual;
    return retour;
END;


create table PAIEMENTFACTUREF
(
    ID      VARCHAR2(100) not null
        constraint PK_PAIEMENTFACTUREF
            primary key,
    IDMVT   VARCHAR2(50)
        constraint FK_PAIEFACTUREF_JOURNCAISSE
            references JOURNALCAISSE,
    IDFACT  VARCHAR2(50)
        constraint FK_PAIEFACTUREF_FACTFOURN
            references FACTURE_FOURNISSEUR_MERE,
    MONTANT NUMBER(30, 3)
);
-- auto-generated definition



CREATE SEQUENCE seq_PaiementFactureF
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create FUNCTION get_seq_PaiementFactureF
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_PaiementFactureF.nextval INTO retour FROM dual;
    return retour;
END;
/

create table AVOIRFF
(
    ID          VARCHAR2(500) not null
        constraint AVOIRFF_PK
            primary key,
    DATY        DATE,
    IDFACTURE   VARCHAR2(500)
        constraint FACTUREF_AVOIR_FF_FK
            references FACTURE_FOURNISSEUR_MERE,
    ETAT        NUMBER(10),
    DESIGNATION VARCHAR2(500),
    CODE        VARCHAR2(500),
    CATEGORIE   VARCHAR2(100)
        constraint FK_AVOIRFF_CATEGORIEAVOIRFC
            references CATEGORIEAVOIRFC,
    MOTIF       VARCHAR2(100)
        constraint FK_AVOIRFF_MOTIFAVOIRFC
            references MOTIFAVOIRFC,
    TYPE        VARCHAR2(500)
);


CREATE SEQUENCE SEQ_AVOIRFF
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

  create FUNCTION get_seq_AVOIRFF
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_AVOIRFF.nextval INTO retour FROM dual;
    return retour;
END;
/


create table AVOIRFFFILLE
(
    ID              VARCHAR2(500) not null
        constraint AVOIRFFFILLE_PK
            primary key,
    IDMERE          VARCHAR2(500)
        constraint FK_AVOIRFFFILLE_DETAILSFACTF
            references AVOIRFF,
    IDDETAILFACTURE VARCHAR2(500)
        constraint AVOIRFFFILLE_DF_FK
            references FACTURE_FOURNISSEUR_FILLE,
    MONTANT         NUMBER(30, 3),
    COMPTE          VARCHAR2(500),
    REMISE          NUMBER(30, 3)
);

CREATE SEQUENCE seq_AVOIRFFFILLE
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create FUNCTION get_seq_AVOIRFFFILLE
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_AVOIRFFFILLE.nextval INTO retour FROM dual;
    return retour;
END;
/

create table CATEGORIEAVOIRFF
(
    ID    VARCHAR2(100) not null
        constraint PK_CATEGORIEAVOIRFF
            primary key,
    VAL   VARCHAR2(500),
    DESCE VARCHAR2(500),
    TYPE  VARCHAR2(500)
);




-- auto-generated definition






-- auto-generated definition









CREATE OR REPLACE VIEW FACTFOURN_MERE_LIBCOMPLET
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDCATEGORIE,
             IDPROVISION, DEVISEMERE, ESTDDPMICTSL, CODEPRESTATION, CODE, ESTMICTSL, TIERSLIB, CATEGORIELIB, TYPELIB)
AS
select fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       fc.IDPREVISION,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.DEVISEMERE,
       fc.ESTDDPMICTSL,
       fc.CODEPRESTATION,
       fc.CODE,
       fc.ESTMICTSL,
       fup.NOM as tierslib,
       cat.VAL as categorielib,
       tf.VAL  as typelib
from FACTURE_FOURNISSEUR_MERE fc
         left join TIERS fup on fup.ID = fc.TIERS
         left join CATEGORIEFF cat on cat.ID = fc.IDCATEGORIE
         left join TYPEFC tf on tf.ID = fc.TYPE;



CREATE OR REPLACE VIEW FACTFOURN_FILLEMONTANT (IDFACTURE, MONTANT, MONTANTTVA, MONTANTREMISE) AS
select fcd.idmere as idfacture,
       nvl(sum(fcd.pu * fcd.quantite), 0)                        as montant,
       nvl((sum(fcd.pu * fcd.quantite * fc.TVA) / 100), 0)       as montanttva,
       nvl((sum(fcd.pu * fcd.quantite * fcd.REDUCTION) / 100), 0) as montantremise
from FACTURE_FOURNISSEUR_FILLE fcd
         left join FACTURE_FOURNISSEUR_MERE fc on fc.id = fcd.IDMERE
group by fcd.idmere;




CREATE OR REPLACE VIEW FACTFOURN_MEREMONTANT
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
       ff.devisemere as devise,
       cast('' as varchar2(100))       as numfact,
       cast('' as varchar2(100))       as resp,
       (select current_date from dual) as date_echeance,
       ff.etat,
       cast('' as varchar2(100))       as idfacturefournisseur,
       '' as entite,
       fcm.montant + fcm.montanttva    as montantttc,
       fcm.montantremise               as remise
from FACTURE_FOURNISSEUR_MERE ff
         join FACTFOURN_FILLEMONTANT fcm on fcm.IDFACTURE = ff.id;



CREATE OR REPLACE VIEW FACTFOURN_MERELETTRE
            (ID, DATY, IDFOURNISSEUR, IDTVA, MONTANTTTC, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT,
             DATYECHEANCE, REMISE, ETAT)
AS
SELECT ff.id,
       ff.daty,
       c.NOM as idFournisseur,
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
FROM FACTFOURN_MEREMONTANT ff,
     TIERS c
where c.id (+) = ff.IDFOURNISSEUR;



CREATE OR REPLACE VIEW FACTFOURN_MERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION,
             IDACTIVITE, DATEFACT, RUBRIQUE)
AS
SELECT fi.ID,
       fi.IDMERE,
       fi.DESIGNATION,
       fi.QUANTITE,
       fi.PU,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fc.daty,
       fc.tiers,
       fc.designation        AS designationmere,
       fc.TYPE,
       decode(fi.tva, null, fc.tva, fi.tva),
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.IDPREVISION,
       nvl(fi.REDUCTION, 0)  as REDUCTION,
       nvl(fi.MAJORATION, 0) as MAJORATION,
       fi.IDACTIVITE,
       fi.DATEFACT,
       fi.RUBRIQUE
FROM FACTURE_FOURNISSEUR_FILLE fi
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fc ON fi.idmere = fc.id;



CREATE OR REPLACE VIEW FACTFOURN_MONTANT
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDPROVISION, IDCATEGORIE, MONTANT, MONTANTTAUX,
             MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MAJORATION, REDUCTION, MONTANTMAJORATION, MONTANTREDUCTION,
             IDACTIVITE, DATEFACT, RUBRIQUE)
AS
SELECT fm.ID,
       fm.IDMERE,
       fm.DESIGNATION,
       fm.QUANTITE,
       fm.PU,
       fm.COMPTE,
       fm.IDPRODUIT,
       fm.DEVISE,
       fm.TAUX,
       fm.DATY,
       fm.TIERS,
       fm.DESIGNATIONMERE,
       fm.TYPE,
       fm.TVA,
       fm.REMARQUE,
       fm.IDUSER,
       fm.DATE_ECHEANCE,
       fm.ETAT,
       IDPREVISION,
       IDPROVISION,
       IDCATEGORIE,
       CAST(fm.pu * fm.quantite AS NUMBER(30, 3))                                             AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3))
                                                                                              AS montanttaux,
       NVL(montantsanstaux, 0)                                                                AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 3))
                                                                                              AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)                                                                  as MAJORATION,
       NVL(fm.REDUCTION, 0)                                                                   as REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3)) as montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) AS NUMBER(30, 3))  as montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;



CREATE OR REPLACE VIEW FACTFOURN_GRP
            (MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MONTANTTVA, IDMERE) AS
SELECT CAST(SUM(fm.MONTANT) as number(30, 3))              AS montant,
       cast(SUM(fm.montanttaux) as number(30, 3))          AS montanttaux,
       cast(SUM(fm.MONTANTAVOIRSANSTAUX) as number(30, 3)) AS MONTANTAVOIRSANSTAUX,
       cast(SUM(fm.montantavoiravectaux) as number(30, 3)) AS montantavoiravectaux,
       CAST(SUM(fm.montanttaux * fm.tva / 100) AS NUMBER(30, 3))
                                                           AS montantTva,
       fm.idmere
FROM FACTFOURN_MONTANT fm
GROUP BY fm.idmere;



CREATE OR REPLACE VIEW FACTFOURN_MSUM
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION,
             IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL,
             CODEPROVISION)
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 3)) AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3))  AS montanttva,
       NVL(grp.montantavoiravectaux, 0)               AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 3))
                                                      AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                        AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                      AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                         as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                       as codeprovision
FROM FACTURE_FOURNISSEUR_MERE fc
         LEFT JOIN FACTFOURN_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFF catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN factureclient fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id;



CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION,ETATLIB)
AS
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
       IDPROVISION,
       IDPROVISIONLIB,
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
           else '' end                           as etatlib
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id;



CREATE OR REPLACE VIEW FACTFOURN_MSUM_V
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION)
AS
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
       CODEPROVISION
from FACTFOURN_MSUM_LIB
where etat >= 11;



CREATE OR REPLACE VIEW MONTANTREMISEFACTFOURN (IDFACTURE, MONTANTTOTALEREMISE) AS
select IDMERE as IDFACTURE, sum(fcd.pu*fcd.REDUCTION * FCD.QUANTITE) as montantTotaleRemise
from FACTURE_FOURNISSEUR_FILLE fcd
group by IDMERE;



CREATE OR REPLACE VIEW FACTFOURN_FILLE_LIBELLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, PRODUIT_LIB,
             ACTIVITELIB, DATEFACT, RUBRIQUE, RUBRIQUELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION,
             RANG, DATY)
AS
SELECT fi.ID,
       fi.IDMERE,
       fi.DESIGNATION,
       fi.QUANTITE,
       fi.PU,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fi.IDACTIVITE,
       fi.TVA,
       pr.nom                                               AS produit_lib,
       ac.DESIGNATION                                       AS activitelib,
       TO_DATE(fi.DATEFACT, 'dd/MM/YY')                     AS DATEFACT,
       fi.RUBRIQUE,
       ra.DESIGNATION                                       AS rubriquelib,
       fi.MOIS,
       fi.ANNEE,
       fi.HEUREDEBUT,
       fi.HEUREFIN,
       nvl(fi.MAJORATION, 0)                                as MAJORATION,
       nvl(fi.REDUCTION, 0)                                 as REDUCTION,
       case when fi.IDACTIVITE is not null then ra.RANG end as rang,
       case when fi.IDACTIVITE is not null then ac.DATY end as daty
FROM FACTURE_FOURNISSEUR_FILLE fi
         LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
         LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = ac.RUBRIQUE;


CREATE OR REPLACE VIEW FACTFOURN_FILLE_VM
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, TIERS, MAJORATION, REDUCTION)
AS
select fcf.ID,
       fcf.IDMERE,
       fcf.DESIGNATION,
       fcf.QUANTITE,
       fcf.PU,
       fcf.COMPTE,
       fcf.IDPRODUIT,
       fcf.DEVISE,
       fcf.TAUX,
       fcf.IDACTIVITE,
       fcf.TVA,
       fcf.DATEFACT,
       fcf.RUBRIQUE,
       mois,
       ANNEE,
       TIERS,
       nvl(fcf.MAJORATION, 0) as MAJORATION,
       nvl(fcf.REDUCTION, 0)  as REDUCTION
from FACTURE_FOURNISSEUR_FILLE fcf
         join FACTURE_FOURNISSEUR_MERE fc on fcf.IDMERE = fc.ID
where fc.etat >= 11;


CREATE OR REPLACE VIEW FACTFOURN_FILLE_VM_lib as
SELECT fi.ID,
       fi.IDMERE,
       fi.DESIGNATION,
       fi.QUANTITE,
       fi.PU,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fi.IDACTIVITE,
       fi.TVA,
       pr.nom                                               AS produit_lib,
       ac.DESIGNATION                                       AS activitelib,
       TO_DATE(fi.DATEFACT, 'dd/MM/YY')                     AS DATEFACT,
       fi.RUBRIQUE,
       ra.DESIGNATION                                       AS rubriquelib,
       fi.MOIS,
       fi.ANNEE,
       fi.MAJORATION,
       fi.REDUCTION,
       case when fi.IDACTIVITE is not null then ra.RANG end as rang,
       case when fi.IDACTIVITE is not null then ac.DATY end as daty
FROM FACTFOURN_FILLE_VM fi
         LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
         LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = ac.RUBRIQUE;



CREATE OR REPLACE VIEW FACTFOURN_FILLEHT
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE)
AS
select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       cast(ff.quantite * ff.pu as number(30, 3)) as montantHTSimple
from FACTURE_FOURNISSEUR_FILLE ff;



CREATE OR REPLACE VIEW FACTFOURN_FILLEMR
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE, MONTANTMAJ,
             MONTANTRED)
AS
select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       cast((montantHTSimple * majoration) / 100 as number(30, 3)) as montantMaj,
       cast((montantHTSimple * reduction) / 100 as number(30, 3))  as montantRed
from FACTFOURN_FILLEHT ff;



CREATE OR REPLACE VIEW FACTFOURN_FILLENET
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE, MONTANTMAJ,
             MONTANTRED, MONTANTNET)
AS
select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.MONTANTMAJ,
       ff.MONTANTRED,
       cast(montantHTSimple + montantMaj - montantRed as number(30, 3)) as montantNET
from FACTFOURN_FILLEMR ff;



CREATE OR REPLACE VIEW FACTFOURN_FILLEWITHTVA
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE, MONTANTMAJ,
             MONTANTRED, MONTANTNET, MONTANTTVA)
AS
select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.MONTANTMAJ,
       ff.MONTANTRED,
       ff.MONTANTNET,
       cast((montantNET * tva) / 100 as number(30, 3)) as montantTVA
from FACTFOURN_FILLENET ff;



CREATE OR REPLACE VIEW FACTFOURN_FILLETTC
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE, MONTANTMAJ,
             MONTANTRED, MONTANTNET, MONTANTTVA, MONTANTTTC)
AS
select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.MONTANTMAJ,
       ff.MONTANTRED,
       ff.MONTANTNET,
       ff.MONTANTTVA,
       cast(montantNET + montantTVA as number(30, 3)) as montantTTC
from FACTFOURN_FILLEWITHTVA ff;


CREATE OR REPLACE VIEW FACTFOURN_FILL_LIB_REST_TAXE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION,
             REDUCTION, DATEFACT, RUBRIQUE, RANG, DATY)
AS
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                               AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))           AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                            AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3))               as MONTANTTAUX,
       CAST(fcm.MONTANT AS NUMBER(32, 5))                   as MONTANT,
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3))      as MONTANTAVOIRSANSTAUX,
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3))      as MONTANTAVOIRAVECTAUX,
       CAST(fcm.tva AS NUMBER(20, 3))                       as tva,
       fc.idactivite,
       ra.DESIGNATION                                       AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                             AS moislib,
       CAST(0 AS NUMBER(32, 2))                             AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                             AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                             AS montantTVAEuro,
       CAST((fc.pu * fc.QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                            AS montanttaxe,
       nvl(fc.majoration, 0)                                as majoration,
       nvl(fc.reduction, 0)                                 as reduction,
       fc.DATEFACT,
       fc.RUBRIQUE,
       case when fc.IDACTIVITE is not null then r.RANG end  as rang,
       case when fc.IDACTIVITE is not null then ra.DATY end as daty
FROM FACTURE_FOURNISSEUR_FILLE fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTFOURN_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE;




CREATE OR REPLACE VIEW FACTFOURN_FILLE_PLUS
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, MONTANT, TVA, IDACTIVITE, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION)
AS
SELECT f.ID,
       f.IDMERE,
       f.DESIGNATION,
       f.QUANTITE,
       f.PU,
       f.COMPTE,
       f.IDPRODUIT,
       f.DEVISE,
       f.TAUX,
       CAST(0.0 AS NUMBER(30, 3)) AS montant,
       f.tva,
       f.IDACTIVITE,
       f.DATEFACT,
       f.RUBRIQUE,
       f.MOIS,
       f.ANNEE,
       f.HEUREDEBUT,
       f.HEUREFIN,
       f.MAJORATION,
       f.REDUCTION
FROM FACTURE_FOURNISSEUR_FILLE f
WHERE 1 > 2;


CREATE OR REPLACE VIEW AS_BONDELIVRAISON_LIBELLE (ID, IDBC, REMARQUE, DATY, POINT, ETAT, DESIGNATIONFACTURE, ETATLIB) AS
select cl.ID,
       cl.IDBC,
       cl.REMARQUE,
       cl.DATY,
       cl.POINT,
       cl.ETAT,
       f.DESIGNATION                             as designationfacture,
       case
           when cl.etat = 1 then 'CREE(E)'
           WHEN cl.ETAT = 11 THEN 'VISE(E)'
           WHEN cl.ETAT = 0 THEN 'ANNULE(E)' END AS ETATLIB
from as_bondelivraison_cl cl
         left join FACTURE_FOURNISSEUR_MERE F on cl.IDBC = F.ID;




create view FACTFOURN_MSUM_LIBV as
select * from FACTFOURN_MSUM_LIB where ETAT>=11;

create view FACTFOURN_MSUM_LIBC as
select * from FACTFOURN_MSUM_LIB where ETAT=1;


CREATE OR REPLACE VIEW FACTFOURN_MONTANTTC
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX,
             MONTANTAVOIRAVECTAUX, MONTANTTVA, MONTANTTAXE, MONTANTTC, IDACTIVITE, DATEFACT, RUBRIQUE)
AS
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       fc.IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATIONMERE,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(fc.MONTANT as number(32, 3))              as MONTANT,
       cast(fc.MONTANTTAUX as number(32, 3))          as MONTANTTAUX,
       cast(fc.MONTANTAVOIRSANSTAUX as number(32, 3)) as MONTANTAVOIRSANSTAUX,
       cast(fc.MONTANTAVOIRAVECTAUX as number(32, 3)) as MONTANTAVOIRAVECTAUX,
       CAST((fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                      AS montanttva,
       CAST((fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                      AS montanttaxe,
       CAST(
               (fc.pu * QUANTITE) + (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                      AS montanttc,
       fc.IDACTIVITE,
       fc.DATEFACT,
       fc.RUBRIQUE
FROM FACTFOURN_MONTANT fc;



CREATE OR REPLACE VIEW FACTFOURN_UNION
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION)
AS
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
       CODEPROVISION
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
             CODEPROVISION
      FROM FACTFOURN_MSUM_LIB
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
             ''                                  as codePrestation,
             ''                                  as codePrestationlib,
             ''                                  as code,
             ''                                  as ESTMICTSL,
             ''                                  as CODEPROVISION
      FROM analyseglobaleantsika);


CREATE OR REPLACE VIEW FACTFOURN_VALIDE
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL)
AS
SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       cast(fc.TVA as number(30, 3))          as TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(fc.MONTANT as NUMBER(30, 3))      as MONTANT,
       cast(fc.MONTANTTVA as NUMBER(30, 3))   as MONTANTTVA,
       cast(fc.MONTANTAVOIR as NUMBER(30, 3)) as MONTANTAVOIR,
       cast(fc.MONTANTTTC as NUMBER(30, 3))   as MONTANTTTC,
       cast(fc.MONTANTPAYE as NUMBER(30, 3))  as MONTANTPAYE,
       cast(fc.MONTANTRESTE as NUMBER(30, 3)) as MONTANTRESTE,
       fc.TIERSLIB,
       fc.CONTACT,
       fc.ADRESSE,
       fc.IDPREVISION,
       fc.ESCALE,
       fc.ETATLIB,
       fc.TYPELIB,
       fc.IDCATEGORIE,
       fc.CATEGORIELIB,
       fc.IDPROVISION,
       fc.IDPROVISIONLIB,
       fc.DEVISEMERE,
       fc.CODEPRESTATION,
       fc.CODEPRESTATIONLIB,
       fc.CODE,
       ESTMICTSL
FROM FACTFOURN_UNION fc
WHERE id NOT IN (SELECT id FROM ProvisionFactureDefinitive);





alter table PAIEMENTFACTUREF add constraint FK_PAIEFACTUREF_FACTFOURN
    foreign key (IDFACT) references FACTURE_FOURNISSEUR_MERE;

	create or replace view PAIEMENTFACTURESUM as
select sum(montant) as montant, idfact
from paiementfacturef
group by idfact;


  CREATE OR REPLACE VIEW FACTFOURN_MSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION) AS
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 3)) AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3))  AS montanttva,
       NVL(grp.montantavoiravectaux, 0)               AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 3))
                                                      AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                        AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                      AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                         as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                       as codeprovision
FROM FACTURE_FOURNISSEUR_MERE fc
         LEFT JOIN FACTFOURN_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFf tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFF catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id;


  CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB) AS
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
       IDPROVISION,
       IDPROVISIONLIB,
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
           else '' end                           as etatlib
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id;

CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIBC
AS
select *
from FACTFOURN_MSUM_LIB
where ETAT = 1;

CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIBV
AS
select *
from FACTFOURN_MSUM_LIB
where ETAT >= 11;

CREATE OR REPLACE VIEW FACTFOURN_MSUM_V as
select *
from FACTFOURN_MSUM_LIB
where etat >= 11;

create or replace view FACTFOURN_UNION
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION)
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
       CODEPROVISION
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
             CODEPROVISION
      FROM FACTFOURN_MSUM_LIB);

	  CREATE OR REPLACE  VIEW PAIEMENTFF ("ID", "DATEEFFET", "CAISSE", "TIERSLIB", "LIBELLE", "MONTANT", "IDFACT") AS
  select
    jc.id,
    JC.DATEEFFET,
    jc.caisse,
    jc.tierslib,
    jc.libelle,
    pf.montant,
    pf.idfact
    from
   journalcaisselib_vise jc
   left join PAIEMENTFACTUREF pf
   on pf.idmvt=jc.id;

   create view facture_fournisseur_msum_libep as
select *
from FACTFOURN_msum_lib
where id in (select DED_ID from ORDONNERPAYEMENT_VISE)and id not in(select IDFACT from PAIEMENTFACTUREF);


  CREATE OR REPLACE VIEW AS_BONDELIVRAISON_CL_PDT_FF (ID, PRODUIT, NUMBL, QUANTITE, IDDETAILSFACTUREFOURNISSEUR, PDT) AS
  select fi.ID,
       nvl(fil.idPRODUIT, fil.DESIGNATION) as produit,
       fi.NUMBL,
       fi.QUANTITE,
       fi.IDDETAILSFACTUREFOURNISSEUR,
       cast('' as varchar2(400))           as pdt
from as_bondelivraison_fille fi
         left join FACTURE_FOURNISSEUR_FILLE fil on fi.IDDETAILSFACTUREFOURNISSEUR = fil.ID;



  CREATE OR REPLACE VIEW AS_BONDELIVRAISON_LIBELLE (ID, IDBC, REMARQUE, DATY, POINT, ETAT, DESIGNATIONFACTURE, ETATLIB) AS
  select cl.ID,
       cl.IDBC,
       cl.REMARQUE,
       cl.DATY,
       cl.POINT,
       cl.ETAT,
       f.DESIGNATION                             as designationfacture,
       case
           when cl.etat = 1 then 'CREE(E)'
           WHEN cl.ETAT = 11 THEN 'VISE(E)'
           WHEN cl.ETAT = 0 THEN 'ANNULE(E)' END AS ETATLIB
from as_bondelivraison_cl cl
         left join FACTURE_FOURNISSEUR_MERE F on cl.IDBC = F.ID;


  CREATE OR REPLACE VIEW AVOIRFFAVECTAUX (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, TAUX, DEVISE, MONTANTAVECTSAUX, ETAT) AS
  select ac.ID,
       ac.IDMERE,
       ac.IDDETAILFACTURE,
       ac.MONTANT,
       ac.COMPTE,
       cast(nvl(fc.taux, 1) as number(30, 3))              as taux,
       nvl(fc.DEVISE, 'Ar')                                       as devise,
       cast(ac.MONTANT * nvl(fc.TAUX, 1) as number(30, 3)) as montantavectsaux,
       a.ETAT
from AVOIRFFFILLE ac
         left join avoirff a on ac.IDMERE = a.ID
         left join FACTURE_FOURNISSEUR_FILLE fc on fc.ID = ac.IDDETAILFACTURE;



  CREATE OR REPLACE VIEW AVOIRFFAVECTAUX_GRP (IDDETAILFACTURE, MONTANTSANSTAUX, MONTANTAVECTSAUX) AS
  SELECT ac.IDDETAILFACTURE,
       CAST(SUM(MONTANT) as number(30, 3))          AS montantsanstaux,
       CAST(SUM(montantavectsaux) as number(30, 3)) AS montantavectsaux
FROM avoirffavectaux ac
WHERE etat >= 11
GROUP BY ac.IDDETAILFACTURE;


  CREATE OR REPLACE VIEW AVOIRFFAVECTAUX_GRP_MERE (IDMERE, MONTANT) AS
  select at.IDMERE,
       cast(sum(at.MONTANTAVECTSAUX) as NUMBER(30, 2)) as montant
from avoirffavectaux at
group by at.IDMERE;


  CREATE OR REPLACE VIEW AVOIRFFFILLE_MONTANTFACTURE (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, MONTANTDF, MONTANTDFTAUX, DESIGNATION, DEVISE) AS
  select fc.ID,
       fc.IDMERE,
       fc.IDDETAILFACTURE,
       fc.MONTANT,
       fc.COMPTE,
       cast(fcf.MONTANT as NUMBER(30, 2))                     as MONTANTDF,
       cast(fcf.MONTANTTAUX * fcf.MONTANT as NUMBER(30, 2)) as MONTANTDFTAUX,
       cast(fcf.DESIGNATION as varchar2(500))                 as designation,
       cast(fcf.DEVISE as varchar2(500))                    as devise
from AVOIRFFFILLE fc
         left join FACTFOURN_MONTANT fcf on fc.IDDETAILFACTURE = fcf.ID;



  CREATE OR REPLACE VIEW AVOIRFFFILLE_PLUS (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, MONTANTDF, DESIGNATION, DEVISE, REMISE) AS
  select fc.ID,
       fc.IDMERE,
       fc.IDDETAILFACTURE,
       fc.MONTANT,
       fc.COMPTE,
       cast(0.0 as NUMBER(30, 2)) as montantdf,
       cast('-' as varchar2(500)) as designation,
       cast('-' as varchar2(500)) as devise,
       fc.REMISE
from AvoirFFFille fc;


  CREATE OR REPLACE VIEW AVOIRFF_DESIGNATION_FC (ID, DATY, IDFACTURE, ETAT, DESIGNATIONFACTURE) AS
  SELECT a.ID,
       a.DATY,
       a.IDFACTURE,
       a.ETAT,
       f.DESIGNATION AS DESIGNATIONfacture
FROM AVOIRFF a
         LEFT JOIN FACTURE_FOURNISSEUR_MERE f ON a.IDFACTURE = f.id;



  CREATE OR REPLACE VIEW AVOIRFF_FACTURE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDAVOIR, IDAVOIRFILLE) AS
  (
SELECT fc.ID,
       fc.DATY,
       fc.TIERS as tiers,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA         as tva,
       fc.REMARQUE,
       ''               as IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       a.ID             AS idavoir,
       af.ID            AS idavoirfille
FROM FACTURE_FOURNISSEUR_MERE fc
         JOIN AVOIRFF a ON a.IDFACTURE = fc.ID
         LEFT JOIN AVOIRFFFILLE af ON af.idmere = a.id
    );


  CREATE OR REPLACE VIEW AVOIRFF_MONTANT (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, MONTANTPAYE, MONTANTRESTE, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION) AS
  SELECT fc.ID,
       fc.DATY,
       fc.IDFACTURE,
       fc.ETAT,
       CAST(NVL(mr.montant, 0.0) AS NUMBER(30, 3)) AS montant,
       f.TIERS                                     as TIERS,
       f.TIERSLIB                                  as tierslib,
       CAST(NVL(op.DEBIT, 0) AS NUMBER(30, 3))     AS montantpaye,
       CAST(NVL(mr.montant, 0.0) - NVL(op.DEBIT, 0) AS NUMBER(30, 3))
                                                   AS montantreste,
       fc.CATEGORIE,
       c.VAL                                       AS categorielib,
       fc.MOTIF,
       mo.val                                      AS motiflib,
       fc.CODE,
       fc.TYPE,
       CASE
           WHEN fc.TYPE = '1' THEN 'interne'
           WHEN fc.TYPE = '2' THEN 'externe'
           END
                                                   AS typelib,
       fc.DESIGNATION
FROM AVOIRFF fc
         LEFT JOIN CATEGORIEAVOIRFF c ON fc.CATEGORIE = c.id
         LEFT JOIN MOTIFAVOIRFC mo ON fc.MOTIF = mo.id
         LEFT JOIN avoirffavectaux_grp_mere mr ON mr.IDMERE = fc.ID
         LEFT JOIN FACTFOURN_MERE_LIBCOMPLET f ON fc.IDFACTURE = f.ID
         LEFT JOIN ordonnerpayement_jc_vise op ON op.ded_id = fc.ID;


  CREATE OR REPLACE VIEW AVOIRFF_MONTANT_C (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, MONTANTPAYE, MONTANTRESTE, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION) AS
  select ID,DATY,IDFACTURE,ETAT,MONTANT,TIERS,TIERSLIB,MONTANTPAYE,MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION
from avoirFF_montant
where etat = 1


create or replace view AVOIRFF_MONTANT_V as
select ID,DATY,IDFACTURE,ETAT,MONTANT,TIERS,TIERSLIB,MONTANTPAYE,MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION
from avoirFF_montant
where etat >= 11
/


  CREATE OR REPLACE VIEW AVOIRFF_MONTANTLIBETAT (ID, CODE, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, MONTANTPAYE, MONTANTRESTE, ETATLIB) AS
  SELECT op.ID,
          op.CODE,
          op.DATY,
          op.IDFACTURE,
          op.ETAT,
          cast(op.MONTANT as number(30,3)) as MONTANT,
          op.TIERS,
          op.TIERSLIB,
          cast(op.MONTANTPAYE as number(30,3)) as MONTANTPAYE,
          cast(op.MONTANTRESTE as number(30,3)) as MONTANTRESTE,
          CASE
             WHEN op.etat = 0 THEN 'annule'
             WHEN op.etat = 1 THEN 'cree'
             WHEN op.etat = 11 THEN 'vise'
          END
             AS etatlib
     FROM AVOIRFF_MONTANT op;



  CREATE OR REPLACE VIEW AVOIRFF_SEQUENCE (ID, DATY, DESIGNATION, ETAT, CODE, DATEMOISSEQ, DATEMOIS, MAXIDPARMOISANE) AS
  SELECT fc.ID,
       DATY,
       DESIGNATION,
       ETAT,
       CODE,
       SUBSTR((CODE), 2, 2)
           || '/'
           || SUBSTR((CODE), 4, 2)
           || '/01/'
           || SUBSTR((CODE), LENGTH((CODE)) - 5, 6)
                                             AS datemoisseq,
       CAST(
               '01/' || SUBSTR((CODE), 4, 2) || '/' || SUBSTR((CODE), 2, 2) AS VARCHAR2(100))
                                             AS datemois,
       SUBSTR((CODE), LENGTH((CODE)) - 2, 6) AS maxidparmoisane
FROM AVOIRFF fc;



  CREATE OR REPLACE VIEW AVOIRFF_VISE (ID, DATY, IDFACTURE, ETAT) AS
  select ID,DATY,IDFACTURE,ETAT from avoirfF where etat>=11;


  CREATE OR REPLACE VIEW FACTFOURN_FILLEHT (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE) AS
  select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       cast(ff.quantite * ff.pu as number(30, 3)) as montantHTSimple
from FACTURE_FOURNISSEUR_FILLE ff;


  CREATE OR REPLACE VIEW FACTFOURN_FILLEMONTANT (IDFACTURE, MONTANT, MONTANTTVA, MONTANTREMISE) AS
  select fcd.idmere as idfacture,
       nvl(sum(fcd.pu * fcd.quantite), 0)                        as montant,
       nvl((sum(fcd.pu * fcd.quantite * fc.TVA) / 100), 0)       as montanttva,
       nvl((sum(fcd.pu * fcd.quantite * fcd.REDUCTION) / 100), 0) as montantremise
from FACTURE_FOURNISSEUR_FILLE fcd
         left join FACTURE_FOURNISSEUR_MERE fc on fc.id = fcd.IDMERE
group by fcd.idmere;


  CREATE OR REPLACE VIEW FACTFOURN_FILLENET (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE, MONTANTMAJ, MONTANTRED, MONTANTNET) AS
  select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.MONTANTMAJ,
       ff.MONTANTRED,
       cast(montantHTSimple + montantMaj - montantRed as number(30, 3)) as montantNET
from FACTFOURN_FILLEMR ff;


  CREATE OR REPLACE VIEW FACTFOURN_FILLETTC (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE, MONTANTMAJ, MONTANTRED, MONTANTNET, MONTANTTVA, MONTANTTTC) AS
  select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.MONTANTMAJ,
       ff.MONTANTRED,
       ff.MONTANTNET,
       ff.MONTANTTVA,
       cast(montantNET + montantTVA as number(30, 3)) as montantTTC
from FACTFOURN_FILLEWITHTVA ff;



  CREATE OR REPLACE VIEW FACTFOURN_FILLEWITHTVA (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE, MONTANTMAJ, MONTANTRED, MONTANTNET, MONTANTTVA) AS
  select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.MONTANTMAJ,
       ff.MONTANTRED,
       ff.MONTANTNET,
       cast((montantNET * tva) / 100 as number(30, 3)) as montantTVA
from FACTFOURN_FILLENET ff;


  CREATE OR REPLACE VIEW FACTFOURN_FILLE_LIBELLE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, PRODUIT_LIB, ACTIVITELIB, DATEFACT, RUBRIQUE, RUBRIQUELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION, RANG, DATY) AS
  SELECT fi.ID,
       fi.IDMERE,
       fi.DESIGNATION,
       fi.QUANTITE,
       fi.PU,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fi.IDACTIVITE,
       fi.TVA,
       pr.nom                                               AS produit_lib,
       ac.DESIGNATION                                       AS activitelib,
       TO_DATE(fi.DATEFACT, 'dd/MM/YY')                     AS DATEFACT,
       fi.RUBRIQUE,
       ra.DESIGNATION                                       AS rubriquelib,
       fi.MOIS,
       fi.ANNEE,
       fi.HEUREDEBUT,
       fi.HEUREFIN,
       nvl(fi.MAJORATION, 0)                                as MAJORATION,
       nvl(fi.REDUCTION, 0)                                 as REDUCTION,
       case when fi.IDACTIVITE is not null then ra.RANG end as rang,
       case when fi.IDACTIVITE is not null then ac.DATY end as daty
FROM FACTURE_FOURNISSEUR_FILLE fi
         LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
         LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = ac.RUBRIQUE;


  CREATE OR REPLACE VIEW FACTFOURN_FILLE_LIB_RESTE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MAJORATION, REDUCTION) AS
  SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       fc.IDPRODUIT                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANT AS NUMBER(32, 5)),
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3)),
       CAST(fcm.tva AS NUMBER(20, 3)),
       fc.idactivite,
       ra.DESIGNATION                             AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                   AS moislib,
       CAST(0 AS NUMBER(32, 2))                   AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                   AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                   AS montantTVAEuro,
       nvl(fc.majoration, 0)                      as majoration,
       nvl(fc.reduction, 0)                       as reduction
FROM FACTURE_FOURNISSEUR_FILLE fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTFOURN_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois;



  CREATE OR REPLACE VIEW FACTFOURN_FILLE_PLUS (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, MONTANT, TVA, IDACTIVITE, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION) AS
  SELECT f.ID,
       f.IDMERE,
       f.DESIGNATION,
       f.QUANTITE,
       f.PU,
       f.COMPTE,
       f.IDPRODUIT,
       f.DEVISE,
       f.TAUX,
       CAST(0.0 AS NUMBER(30, 3)) AS montant,
       f.tva,
       f.IDACTIVITE,
       f.DATEFACT,
       f.RUBRIQUE,
       f.MOIS,
       f.ANNEE,
       f.HEUREDEBUT,
       f.HEUREFIN,
       f.MAJORATION,
       f.REDUCTION
FROM FACTURE_FOURNISSEUR_FILLE f
WHERE 1 > 2;


  CREATE OR REPLACE VIEW FACTFOURN_FILLE_VM (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT, RUBRIQUE, MOIS, ANNEE, TIERS, MAJORATION, REDUCTION) AS
  select fcf.ID,
       fcf.IDMERE,
       fcf.DESIGNATION,
       fcf.QUANTITE,
       fcf.PU,
       fcf.COMPTE,
       fcf.IDPRODUIT,
       fcf.DEVISE,
       fcf.TAUX,
       fcf.IDACTIVITE,
       fcf.TVA,
       fcf.DATEFACT,
       fcf.RUBRIQUE,
       mois,
       ANNEE,
       TIERS,
       nvl(fcf.MAJORATION, 0) as MAJORATION,
       nvl(fcf.REDUCTION, 0)  as REDUCTION
from FACTURE_FOURNISSEUR_FILLE fcf
         join FACTURE_FOURNISSEUR_MERE fc on fcf.IDMERE = fc.ID
where fc.etat >= 11;



  CREATE OR REPLACE VIEW FACTFOURN_FILLE_VM_LIB (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, PRODUIT_LIB, ACTIVITELIB, DATEFACT, RUBRIQUE, RUBRIQUELIB, MOIS, ANNEE, MAJORATION, REDUCTION, RANG, DATY) AS
  SELECT fi.ID,
       fi.IDMERE,
       fi.DESIGNATION,
       fi.QUANTITE,
       fi.PU,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fi.IDACTIVITE,
       fi.TVA,
       pr.nom                                               AS produit_lib,
       ac.DESIGNATION                                       AS activitelib,
       TO_DATE(fi.DATEFACT, 'dd/MM/YY')                     AS DATEFACT,
       fi.RUBRIQUE,
       ra.DESIGNATION                                       AS rubriquelib,
       fi.MOIS,
       fi.ANNEE,
       fi.MAJORATION,
       fi.REDUCTION,
       case when fi.IDACTIVITE is not null then ra.RANG end as rang,
       case when fi.IDACTIVITE is not null then ac.DATY end as daty
FROM FACTFOURN_FILLE_VM fi
         LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
         LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = ac.RUBRIQUE;



  CREATE OR REPLACE VIEW FACTFOURN_FILL_LIB_REST_TAXE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION, REDUCTION, DATEFACT, RUBRIQUE, RANG, DATY) AS
  SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                               AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))           AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                            AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3))               as MONTANTTAUX,
       CAST(fcm.MONTANT AS NUMBER(32, 5))                   as MONTANT,
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3))      as MONTANTAVOIRSANSTAUX,
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3))      as MONTANTAVOIRAVECTAUX,
       CAST(fcm.tva AS NUMBER(20, 3))                       as tva,
       fc.idactivite,
       ra.DESIGNATION                                       AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                             AS moislib,
       CAST(0 AS NUMBER(32, 2))                             AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                             AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                             AS montantTVAEuro,
       CAST((fc.pu * fc.QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                            AS montanttaxe,
       nvl(fc.majoration, 0)                                as majoration,
       nvl(fc.reduction, 0)                                 as reduction,
       fc.DATEFACT,
       fc.RUBRIQUE,
       case when fc.IDACTIVITE is not null then r.RANG end  as rang,
       case when fc.IDACTIVITE is not null then ra.DATY end as daty
FROM FACTURE_FOURNISSEUR_FILLE fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTFOURN_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE;


  CREATE OR REPLACE VIEW FACTFOURN_GRP (MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MONTANTTVA, IDMERE) AS
  SELECT CAST(SUM(fm.MONTANT) as number(30, 3))              AS montant,
       cast(SUM(fm.montanttaux) as number(30, 3))          AS montanttaux,
       cast(SUM(fm.MONTANTAVOIRSANSTAUX) as number(30, 3)) AS MONTANTAVOIRSANSTAUX,
       cast(SUM(fm.montantavoiravectaux) as number(30, 3)) AS montantavoiravectaux,
       CAST(SUM(fm.montanttaux * fm.tva / 100) AS NUMBER(30, 3))
                                                           AS montantTva,
       fm.idmere
FROM FACTFOURN_MONTANT fm
GROUP BY fm.idmere;



  CREATE OR REPLACE VIEW FACTFOURN_MERELETTRE (ID, DATY, IDFOURNISSEUR, IDTVA, MONTANTTTC, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT, DATYECHEANCE, REMISE, ETAT) AS
  SELECT ff.id,
       ff.daty,
       c.NOM as idFournisseur,
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
FROM FACTFOURN_MEREMONTANT ff,
     TIERS c
where c.id (+) = ff.IDFOURNISSEUR;


  CREATE OR REPLACE VIEW FACTFOURN_MEREMONTANT (ID, DATY, IDFOURNISSEUR, TVA, REMARQUE, DATEEMISSION, DESIGNATION, DEVISE, NUMFACT, RESP, DATE_ECHEANCE, ETAT, IDFACTUREFOURNISSEUR, ENTITE, MONTANTTTC, REMISE) AS
  select ff.id,
       ff.daty,
       ff.TIERS                        as idfournisseur,
       ff.tva,
       ff.remarque,
       (select current_date from dual) as dateemission,
       ff.designation,
       ff.devisemere as devise,
       cast('' as varchar2(100))       as numfact,
       cast('' as varchar2(100))       as resp,
       (select current_date from dual) as date_echeance,
       ff.etat,
       cast('' as varchar2(100))       as idfacturefournisseur,
       '' as entite,
       fcm.montant + fcm.montanttva    as montantttc,
       fcm.montantremise               as remise
from FACTURE_FOURNISSEUR_MERE ff
         join FACTFOURN_FILLEMONTANT fcm on fcm.IDFACTURE = ff.id;


  CREATE OR REPLACE VIEW FACTFOURN_MERE_FILLE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION, IDACTIVITE, DATEFACT, RUBRIQUE) AS
  SELECT fi.ID,
       fi.IDMERE,
       fi.DESIGNATION,
       fi.QUANTITE,
       fi.PU,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fc.daty,
       fc.tiers,
       fc.designation        AS designationmere,
       fc.TYPE,
       decode(fi.tva, null, fc.tva, fi.tva),
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.IDPREVISION,
       nvl(fi.REDUCTION, 0)  as REDUCTION,
       nvl(fi.MAJORATION, 0) as MAJORATION,
       fi.IDACTIVITE,
       fi.DATEFACT,
       fi.RUBRIQUE
FROM FACTURE_FOURNISSEUR_FILLE fi
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fc ON fi.idmere = fc.id;


  CREATE OR REPLACE VIEW FACTFOURN_MERE_LIBCOMPLET (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDCATEGORIE, IDPROVISION, DEVISEMERE, ESTDDPMICTSL, CODEPRESTATION, CODE, ESTMICTSL, TIERSLIB, CATEGORIELIB, TYPELIB) AS
  select fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       fc.IDPREVISION,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.DEVISEMERE,
       fc.ESTDDPMICTSL,
       fc.CODEPRESTATION,
       fc.CODE,
       fc.ESTMICTSL,
       fup.NOM as tierslib,
       cat.VAL as categorielib,
       tf.VAL  as typelib
from FACTURE_FOURNISSEUR_MERE fc
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = fc.TIERS
         left join CATEGORIEFF cat on cat.ID = fc.IDCATEGORIE
         left join TYPEFC tf on tf.ID = fc.TYPE;


  CREATE OR REPLACE VIEW FACTFOURN_MONTANT (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDPROVISION, IDCATEGORIE, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MAJORATION, REDUCTION, MONTANTMAJORATION, MONTANTREDUCTION, IDACTIVITE, DATEFACT, RUBRIQUE) AS
  SELECT fm.ID,
       fm.IDMERE,
       fm.DESIGNATION,
       fm.QUANTITE,
       fm.PU,
       fm.COMPTE,
       fm.IDPRODUIT,
       fm.DEVISE,
       fm.TAUX,
       fm.DATY,
       fm.TIERS,
       fm.DESIGNATIONMERE,
       fm.TYPE,
       fm.TVA,
       fm.REMARQUE,
       fm.IDUSER,
       fm.DATE_ECHEANCE,
       fm.ETAT,
       IDPREVISION,
       IDPROVISION,
       IDCATEGORIE,
       CAST(fm.pu * fm.quantite AS NUMBER(30, 3))                                             AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3))
                                                                                              AS montanttaux,
       NVL(montantsanstaux, 0)                                                                AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 3))
                                                                                              AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)                                                                  as MAJORATION,
       NVL(fm.REDUCTION, 0)                                                                   as REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3)) as montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) AS NUMBER(30, 3))  as montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirfcavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;


  CREATE OR REPLACE VIEW FACTFOURN_MONTANTTC (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MONTANTTVA, MONTANTTAXE, MONTANTTC, IDACTIVITE, DATEFACT, RUBRIQUE) AS
  SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       fc.IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATIONMERE,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(fc.MONTANT as number(32, 3))              as MONTANT,
       cast(fc.MONTANTTAUX as number(32, 3))          as MONTANTTAUX,
       cast(fc.MONTANTAVOIRSANSTAUX as number(32, 3)) as MONTANTAVOIRSANSTAUX,
       cast(fc.MONTANTAVOIRAVECTAUX as number(32, 3)) as MONTANTAVOIRAVECTAUX,
       CAST((fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                      AS montanttva,
       CAST((fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                      AS montanttaxe,
       CAST(
               (fc.pu * QUANTITE) + (fc.pu * QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                      AS montanttc,
       fc.IDACTIVITE,
       fc.DATEFACT,
       fc.RUBRIQUE
FROM FACTFOURN_MONTANT fc;



  CREATE OR REPLACE VIEW FACTFOURN_MSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION) AS
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 3)) AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3))  AS montanttva,
       NVL(grp.montantavoiravectaux, 0)               AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 3))
                                                      AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                        AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                      AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                         as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                       as codeprovision
FROM FACTURE_FOURNISSEUR_MERE fc
         LEFT JOIN FACTFOURN_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFf tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFF catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id;


  CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB) AS
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
       IDPROVISION,
       IDPROVISIONLIB,
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
           else '' end                           as etatlib
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id;


  CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIBC (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB) AS
  select ID,DATY,TIERS,DESIGNATION,TYPE,TVA,REMARQUE,IDUSER,DATE_ECHEANCE,ETAT,IDPREVISION,MONTANT,MONTANTTVA,MONTANTAVOIR,MONTANTTTC,MONTANTPAYE,MONTANTRESTE,TIERSLIB,CONTACT,ADRESSE,ESCALE,TYPELIB,IDCATEGORIE,CATEGORIELIB,IDPROVISION,IDPROVISIONLIB,ESTDDPMICTSL,DEVISEMERE,CODEPRESTATION,CODEPRESTATIONLIB,CODE,ESTMICTSL,CODEPROVISION,ETATLIB
from FACTFOURN_MSUM_LIB
where ETAT = 1;

create or replace view FACTFOURN_MSUM_LIBV as
select ID,DATY,TIERS,DESIGNATION,TYPE,TVA,REMARQUE,IDUSER,DATE_ECHEANCE,ETAT,IDPREVISION,MONTANT,MONTANTTVA,MONTANTAVOIR,MONTANTTTC,MONTANTPAYE,MONTANTRESTE,TIERSLIB,CONTACT,ADRESSE,ESCALE,TYPELIB,IDCATEGORIE,CATEGORIELIB,IDPROVISION,IDPROVISIONLIB,ESTDDPMICTSL,DEVISEMERE,CODEPRESTATION,CODEPRESTATIONLIB,CODE,ESTMICTSL,CODEPROVISION,ETATLIB
from FACTFOURN_MSUM_LIB
where ETAT >= 11;


  CREATE OR REPLACE VIEW FACTFOURN_MSUM_V (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB) AS
  select ID,DATY,TIERS,DESIGNATION,TYPE,TVA,REMARQUE,IDUSER,DATE_ECHEANCE,ETAT,IDPREVISION,MONTANT,MONTANTTVA,MONTANTAVOIR,MONTANTTTC,MONTANTPAYE,MONTANTRESTE,TIERSLIB,CONTACT,ADRESSE,ESCALE,TYPELIB,IDCATEGORIE,CATEGORIELIB,IDPROVISION,IDPROVISIONLIB,ESTDDPMICTSL,DEVISEMERE,CODEPRESTATION,CODEPRESTATIONLIB,CODE,ESTMICTSL,CODEPROVISION,ETATLIB
from FACTFOURN_MSUM_LIB
where etat >= 11;


  CREATE OR REPLACE VIEW FACTFOURN_UNION (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION) AS
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
       CODEPROVISION
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
             CODEPROVISION
      FROM FACTFOURN_MSUM_LIB);



  CREATE OR REPLACE VIEW FACTFOURN_VALIDE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL) AS
  SELECT fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       cast(fc.TVA as number(30, 3))          as TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(fc.MONTANT as NUMBER(30, 3))      as MONTANT,
       cast(fc.MONTANTTVA as NUMBER(30, 3))   as MONTANTTVA,
       cast(fc.MONTANTAVOIR as NUMBER(30, 3)) as MONTANTAVOIR,
       cast(fc.MONTANTTTC as NUMBER(30, 3))   as MONTANTTTC,
       cast(fc.MONTANTPAYE as NUMBER(30, 3))  as MONTANTPAYE,
       cast(fc.MONTANTRESTE as NUMBER(30, 3)) as MONTANTRESTE,
       fc.TIERSLIB,
       fc.CONTACT,
       fc.ADRESSE,
       fc.IDPREVISION,
       fc.ESCALE,
       fc.ETATLIB,
       fc.TYPELIB,
       fc.IDCATEGORIE,
       fc.CATEGORIELIB,
       fc.IDPROVISION,
       fc.IDPROVISIONLIB,
       fc.DEVISEMERE,
       fc.CODEPRESTATION,
       fc.CODEPRESTATIONLIB,
       fc.CODE,
       ESTMICTSL
FROM FACTFOURN_UNION fc
WHERE id NOT IN (SELECT id FROM ProvisionFactureDefinitive);


create or replace view FACTURE_CLIENT_UNION_VI as
select
       sum(MONTANT)as montant,
       sum(MONTANTTVA)as MONTANTTVA,
       sum(MONTANTAVOIR)as MONTANTAVOIR,
       sum(MONTANTPAYE)as MONTANTPAYE,
       sum(MONTANTTTC)as MONTANTTTC,
       IDPROVISION
from FACTURE_CLIENT_UNION
where ETAT>=11
group by IDPROVISION;



  CREATE OR REPLACE VIEW FACTURE_FOURNISSEUR_MERE_FILLE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDCATEGORIE, IDPROVISION, IDPREVISION, REDUCTION, MAJORATION, IDACTIVITE, DATEFACT, RUBRIQUE) AS
  SELECT fi.ID,
       fi.IDMERE,
       fi.DESIGNATION,
       fi.QUANTITE,
       fi.PU,
       fi.COMPTE,
       fi.IDPRODUIT,
       fi.DEVISE,
       fi.TAUX,
       fc.daty,
       fc.tiers,
       fc.designation        AS designationmere,
       fc.TYPE,
       decode(fi.tva, null, fc.tva, fi.tva),
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat,
       fc.IDCATEGORIE,
       fc.IDPROVISION,
       fc.IDPREVISION,
       nvl(fi.REDUCTION, 0)  as REDUCTION,
       nvl(fi.MAJORATION, 0) as MAJORATION,
       fi.IDACTIVITE,
       fi.DATEFACT,
       fi.RUBRIQUE
FROM FACTURE_FOURNISSEUR_FILLE fi
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fc ON fi.idmere = fc.id;



  CREATE OR REPLACE VIEW FACTURE_FOURNISSEUR_MSUM_LIBEP (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB) AS
  select ID,DATY,TIERS,DESIGNATION,TYPE,TVA,REMARQUE,IDUSER,DATE_ECHEANCE,ETAT,IDPREVISION,MONTANT,MONTANTTVA,MONTANTAVOIR,MONTANTTTC,MONTANTPAYE,MONTANTRESTE,TIERSLIB,CONTACT,ADRESSE,ESCALE,TYPELIB,IDCATEGORIE,CATEGORIELIB,IDPROVISION,IDPROVISIONLIB,ESTDDPMICTSL,DEVISEMERE,CODEPRESTATION,CODEPRESTATIONLIB,CODE,ESTMICTSL,CODEPROVISION,ETATLIB
from FACTFOURN_msum_lib
where id in (select DED_ID from ORDONNERPAYEMENT_VISE)and id not in(select IDFACT from PAIEMENTFACTUREF);


  CREATE OR REPLACE VIEW FACTURE_FOURNISSEUR_MSUM_LIBP (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB) AS
  select ID,DATY,TIERS,DESIGNATION,TYPE,TVA,REMARQUE,IDUSER,DATE_ECHEANCE,ETAT,IDPREVISION,MONTANT,MONTANTTVA,MONTANTAVOIR,MONTANTTTC,MONTANTPAYE,MONTANTRESTE,TIERSLIB,CONTACT,ADRESSE,ESCALE,TYPELIB,IDCATEGORIE,CATEGORIELIB,IDPROVISION,IDPROVISIONLIB,ESTDDPMICTSL,DEVISEMERE,CODEPRESTATION,CODEPRESTATIONLIB,CODE,ESTMICTSL,CODEPROVISION,ETATLIB
from FACTFOURN_MSUM_LIB
where id in (select idfact from paiementfacturef);



  CREATE OR REPLACE VIEW MONTANTREMISEFACTFOURN (IDFACTURE, MONTANTTOTALEREMISE) AS
  select IDMERE as IDFACTURE, sum(fcd.pu*fcd.REDUCTION * FCD.QUANTITE) as montantTotaleRemise
from FACTURE_FOURNISSEUR_FILLE fcd
group by IDMERE;



  CREATE OR REPLACE VIEW MOUVEMENTLIBCOMPLET_TESTE (ID, DATY, ESCALE, NAVIRE, CONSIGNATAIRE, PROVENANCE, DESTINATION, REMARQUE, DUREE, TYPEMVT, CARGAISON, REFERENCENAVIRE, NOMNAVIRE, VALMVT, DESCEMVT, VALCARGAISON, DESCECARGAISON, VALCONSIGNATAIRE, DESCECONSIGNATAIRE, QUAIPROVENANCE, VALQUAISPROVENANCE, PAYSPROVENANCE, VALPAYSPROVENANCE, QUAISDESTINATION, VALQUAISDESTINATION, PAYSDESTINATION, VALPAYSDESTINATION, DATEARRIVEE, HEURE, DATE_DEPART, HEURE_DEPART, INTERNEPROVENANCE, DESCEQUAISPROVENANCE, TYPEQUAISPROVENANCE, TIRANTPROVENANCE, LONGUEURPROVENANCE, PROFONDEURPROVENANCE, DESCEPAYSPROVENANCE, INTERNEDESTINATION, DESCEQUAISDESTINATION, TYPEQUAISDESTIANANTION, TIRANTDESTINATION, LONGUEURDESTINATION, PROFONDEURDESTINATION, DESCEPAYSDESTINATION, PAVILLONNAVIRE, JNTNAVIRE, JBTNAVIRE, PLTNAVIRE, LHTNAVIRE, LMNAVIRE, TENAVIRE, VOLUMENAVIRE, REMARQUENAVIRE, ETATNAVIRE, VALTYPEQUAISPROVENANCE, DESCETYPEQUAISPROVENANCE, VALTYPEQUAISDESTINATION, DESCETYPEQUAISDESTINATION, ETAT, ETATLIB, ESCALELIB, NOVOYAGE) AS
  SELECT mvt.ID,
       mvt.daty,
       mvt.ESCALE,
       mvt.NAVIRE,
       mvt.CONSIGNATAIRE,
       mvt.PROVENANCE,
       mvt.DESTINATION,
       mvt.REMARQUE,
       mvt.DUREE,
       mvt.TYPEMVT,
       mvt.CARGAISON,
       na.REFERENCE      AS referencenavire,
       na.NOM            AS nomnavire,
       tm.VAL            AS valmvt,
       tm.desce          AS descemvt,
       car.VAL           AS valcargaison,
       car.desce         AS descecargaison,
       mvt.CONSIGNATAIRE AS valconsignataire,
       cons.NOMCLT       AS desceconsignataire,
       pro.QUAI          AS quaiprovenance,
       q.val             AS valquaisprovenance,
       q.PAYS            AS paysprovenance,
       p.VAL             AS valpaysprovenance,
       des.QUAI          AS quaisdestination,
       q1.VAL            AS valquaisdestination,
       q1.PAYS           AS paysdestination,
       p1.VAL            AS valpaysdestination,
       mvt.DATEARRIVEE,
       mvt.heure,
       mvt.DATE_DEPART,
       mvt.HEURE_DEPART,
       pro.INTERNE       AS interneprovenance,
       q.DESCE           AS descequaisprovenance,
       q.TYPEQUAIS       AS typequaisprovenance,
       q.TIRANT          AS tirantprovenance,
       q.LONGUEUR        AS longueurprovenance,
       q.PROFONDEUR      AS profondeurprovenance,
       p.DESCE           AS descepaysprovenance,
       des.INTERNE       AS internedestination,
       q1.DESCE          AS descequaisdestination,
       q1.TYPEQUAIS      AS typequaisdestianantion,
       q1.TIRANT         AS tirantdestination,
       q1.LONGUEUR       AS longueurdestination,
       q1.PROFONDEUR     AS profondeurdestination,
       p1.DESCE          AS descepaysdestination,
       na.PAVILLON       AS pavillonnavire,
       na.JNT            AS jntnavire,
       na.JBT            AS jbtnavire,
       na.PLT            AS pltnavire,
       na.LHT            AS lhtnavire,
       na.LM             AS lmnavire,
       na.TE             AS tenavire,
       na.VOLUME         AS volumenavire,
       na.REMARQUE       AS remarquenavire,
       na.ETAT           AS etatnavire,
       t.VAL             AS valtypequaisprovenance,
       t.DESCE           AS descetypequaisprovenance,
       t2.val            AS valtypequaisdestination,
       t2.DESCE          AS descetypequaisdestination,
       mvt.etat,
       case
           when mvt.etat = 1 then 'CREE(E)'
           when mvt.etat = 11 then 'VISE(E)'
           END           AS ETATLIB,
       pre.ESCALE,
       pre.NOVOYAGE
FROM MOUVEMENT mvt
         LEFT JOIN NAVIRE na ON na.ID = MVT.NAVIRE
    --LEFT JOIN CONSIGNATAIRETAB cons ON cons.id = mvt.CONSIGNATAIRE
         LEFT JOIN CLIENTMAT cons ON cons.CDCLT = mvt.CONSIGNATAIRE
         LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = mvt.PROVENANCE
         LEFT JOIN POSTEDESTINATAIRE des ON des.id = mvt.DESTINATION
         LEFT JOIN TYPEMVT tm ON tm.id = mvt.TYPEMVT
         LEFT JOIN CARGAISON car ON car.id = mvt.CARGAISON
         LEFT JOIN quais q ON q.id = pro.QUAI
         LEFT JOIN pays p ON p.id = q.PAYS
         LEFT JOIN quais q1 ON q1.id = des.QUAI
         LEFT JOIN pays p1 ON p1.id = q1.PAYS
         LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
         LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS
         left join PREVISION pre on pre.id = mvt.ESCALE;


create or replace view NUMEROAVOIRFF as
SELECT CAST('-' AS VARCHAR2(100)) AS id,
       CAST(
               NVL(CAST(MAX(maxidparmoisane) + 1 AS NUMBER(10)), 1) AS VARCHAR2(500))
                                  AS val,
       CAST('-' AS VARCHAR2(10))  AS desce
FROM AVOIRFF_SEQUENCE;


  CREATE OR REPLACE VIEW ORDONNERPAYEMENTAVOIRFF (ID, DED_ID, IDLIGNE, DATY, MONTANT, REMARQUE, ETAT, NUMEROOP, DESTINATION, MODEPAIEMENT, TIERS, IDUSER, NUMEROBED, IDFACTURE, TYPE) AS
  SELECT op.ID,
       op.DED_ID,
       op.IDLIGNE,
       op.DATY,
       op.MONTANT,
       op.REMARQUE,
       op.ETAT,
       op.NUMEROOP,
       op.DESTINATION,
       op.MODEPAIEMENT,
       op.TIERS,
       op.IDUSER,
       op.NUMEROBED,
       av.idfacture,
       av.type
FROM ordonnerpayement op
         JOIN avoirFF av ON op.DED_ID = av.id;



  CREATE OR REPLACE VIEW PAIEMENTFACTUREF_GROUP (MONTANT, IDFACT) AS
  select cast(sum(MONTANT) as number(30,3)) as montant,IDFACT from PAIEMENTFACTUREf group by IDFACT;


  CREATE OR REPLACE VIEW PAIEMENTFACTUREF_GRP (IDFACT, MONTANT) AS
  select IDFACT, sum(montant) as montant from PAIEMENTFACTUREF group by IDFACT;


  CREATE OR REPLACE VIEW PAIEMENTFF (ID, DATEEFFET, CAISSE, TIERSLIB, LIBELLE, MONTANT, IDFACT) AS
  select
    jc.id,
    JC.DATEEFFET,
    jc.caisse,
    jc.tierslib,
    jc.libelle,
    pf.montant,
    pf.idfact
    from
   journalcaisselib_vise jc
   left join PAIEMENTFACTUREF pf
   on pf.idmvt=jc.id;



  CREATE OR REPLACE VIEW PROVISIONFACTURENONDEFINITIVE (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE, ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, IDDEFINITIVE) AS
  SELECT facture_client_union.ID,
       facture_client_union.DATY,
       facture_client_union.TIERS,
       facture_client_union.DESIGNATION,
       facture_client_union.TYPE,
       facture_client_union.TVA,
      facture_client_union.REMARQUE,
       facture_client_union.IDUSER,
       facture_client_union.DATE_ECHEANCE,
       facture_client_union.ETAT,
       cast(MONTANT as number(32, 3))      as MONTANT,
       cast(MONTANTTVA as number(32, 3))   as montanttva,
       cast(MONTANTAVOIR as number(32, 3)) as MONTANTAVOIR,
       cast(MONTANTTTC as number(32, 3))   as MONTANTTTC,
       cast(MONTANTPAYE as number(32, 3))  as MONTANTPAYE,
       cast(MONTANTRESTE as number(32, 3)) as MONTANTRESTE,
       facture_client_union.TIERSLIB,
       facture_client_union.CONTACT,
       facture_client_union.ADRESSE,
       facture_client_union.IDPREVISION,
       facture_client_union.ESCALE,
       facture_client_union.ETATLIB,
       facture_client_union.TYPELIB,
       facture_client_union.IDCATEGORIE,
       facture_client_union.CATEGORIELIB,
       facture_client_union.IDPROVISION,
       facture_client_union.IDPROVISIONLIB,
       facturemrevise.ID as iddefinitive
FROM facture_client_union
        join facturemrevise on facturemrevise.IDPROVISION=FACTURE_CLIENT_UNION.ID
WHERE FACTURE_CLIENT_UNION.idcategorie = 'CATFCO2'
  /*AND id IN (SELECT idProvision
             FROM factureclient
             WHERE etat >= 11)*/
  AND FACTURE_CLIENT_UNION.etat = 1;



  CREATE OR REPLACE VIEW SETATPROVISIONVRAI (ID, MONTANTFACTURE, MONTANTPROVISION, MONTANTPAYE, ECART, TIERS, TIERSLIB, DATY, TIERSPROVISION, TIERSLIBPROVISION, IDPROVISION) AS
  select fac.id,
       fac.MONTANTTTC                 as montantfacture,
       fu.MONTANTTTC                  as montantprovision,
       fac.MONTANTPAYE,
       fac.MONTANTTTC - fac.MONTANTPAYE as ecart,
       fac.TIERS,fac.TIERSLIB,
       fu.DATY ,
       fu.tiers  as tiersprovision,
       fu.tierslib  as tierslibprovision,
         fac.IDPROVISION
from FACTURE_CLIENT_UNION fac
         join FACTURE_CLIENT_UNION fu on fu.id = fac.IDPROVISION;


create or replace force view SITUATIONLCRECETTE as
SELECT l.id AS id,
            l.DESIGNATION AS designation,
            l.COMPTE AS compte,
            l.ANNEE AS annee,
            l.MONTANT AS montant,
            l.etat,
            CAST (SUM (mf.QUANTITE * mf.pu * mf.TAUX) AS NUMBER (30, 3))
               AS facture,
            CAST (SUM (montantpaye) AS NUMBER (30, 3)) paye
       FROM LIGNECREDITRECETTE l
            LEFT JOIN FACTURE_CLIENT_MEREF_paye mf
               ON     SUBSTR (mf.COMPTE, 0, LENGTH (l.COMPTE)) LIKE l.COMPTE
                  AND EXTRACT (YEAR FROM DATY) = l.ANNEE and mf.IDMERE not in
                                                             (select id from  ProvisionFactureDefinitive)
   GROUP BY l.id,
            l.DESIGNATION,
            l.COMPTE,
            l.ANNEE,
            l.MONTANT, l.etat;



  CREATE OR REPLACE VIEW SITUATIONLCRECETTEC (ID, DESIGNATION, COMPTE, ANNEE, MONTANT, ETAT, FACTURE, PAYE) AS
  select ID,DESIGNATION,COMPTE,ANNEE,MONTANT,ETAT,FACTURE,PAYE from SITUATIONLCRECETTE where etat=1;


create or replace view SITUATIONLCRECETTEV as
select ID,DESIGNATION,COMPTE,ANNEE,MONTANT,ETAT,FACTURE,PAYE from SITUATIONLCRECETTE where etat>=11;


  CREATE OR REPLACE VIEW UNION_AVOIRFF_MONTANT (ID, DATY, IDFACTURE, ETAT, MONTANT, TIERS, TIERSLIB, MONTANTPAYE, MONTANTRESTE, CATEGORIE, CATEGORIELIB, MOTIF, MOTIFLIB, CODE, TYPE, TYPELIB, DESIGNATION) AS
  select ID,DATY,IDFACTURE,ETAT,MONTANT,TIERS,TIERSLIB,MONTANTPAYE,MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION from AVOIRFF_MONTANT
    union
select ID,DATY,IDFACTURE,ETAT,MONTANT,TIERS,TIERSLIB,MONTANTPAYE,MONTANTRESTE,CATEGORIE,CATEGORIELIB,MOTIF,MOTIFLIB,CODE,TYPE,TYPELIB,DESIGNATION from AVOIRFC_MONTANT;




update AVOIRFF set CATEGORIE='CT001X' ;
alter table AVOIRFF drop constraint FK_AVOIRFF_CATEGORIEAVOIRFC;
alter table AVOIRFF add constraint FK_AVOIRFF_CATEGORIEAVOIRFF foreign key (CATEGORIE) references CATEGORIEAVOIRFF(id);

create view rubrique_MICTSL as
select * from rubrique_activite where categorie='CATFC002' and volume is not null;



alter table avoirff drop constraint FK_AVOIRFF_MOTIFAVOIRFC;

create view facture_fourn_mere_vide as
select cast('' as varchar2(500))  as id,
       cast('' as date)           as daty,
       cast('' as varchar2(100))  as tiers,
       cast('' as varchar2(1000)) as designation,
       cast('' as varchar2(500))  as type,
       cast('' as varchar2(1000)) as remarque,
       cast('' as varchar2(200))  as code,
       cast(0 as number(30, 3))   as montant
from DUAL;


alter table as_bondelivraison drop constraint AS_BON_FK;
alter table as_bondelivraison add constraint fk_as_bonliv_factfournmere foreign key (IDBC) references FACTURE_FOURNISSEUR_MERE(id);



CREATE OR REPLACE VIEW FACTFOURN_MONTANT
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, IDPROVISION, IDCATEGORIE, MONTANT, MONTANTTAUX,
             MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, MAJORATION, REDUCTION, MONTANTMAJORATION, MONTANTREDUCTION,
             IDACTIVITE, DATEFACT, RUBRIQUE)
AS
SELECT fm.ID,
       fm.IDMERE,
       fm.DESIGNATION,
       fm.QUANTITE,
       fm.PU,
       fm.COMPTE,
       fm.IDPRODUIT,
       fm.DEVISE,
       fm.TAUX,
       fm.DATY,
       fm.TIERS,
       fm.DESIGNATIONMERE,
       fm.TYPE,
       fm.TVA,
       fm.REMARQUE,
       fm.IDUSER,
       fm.DATE_ECHEANCE,
       fm.ETAT,
       IDPREVISION,
       IDPROVISION,
       IDCATEGORIE,
       CAST(fm.pu * fm.quantite AS NUMBER(30, 3))                                             AS Montant,
       CAST(((fm.pu * fm.quantite) * fm.taux) -
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) +
            NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3))
                                                                                              AS montanttaux,
       NVL(montantsanstaux, 0)                                                                AS montantavoirsanstaux,
       CAST(NVL((montantsanstaux * fm.TAUX), 0) AS NUMBER(30, 3))
                                                                                              AS montantavoiravectaux,
       NVL(fm.MAJORATION, 0)                                                                  as MAJORATION,
       NVL(fm.REDUCTION, 0)                                                                   as REDUCTION,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.MAJORATION / 100, 0) AS NUMBER(30, 3)) as montantMajoration,
       CAST(NVL(((fm.pu * fm.quantite) * fm.taux) * fm.REDUCTION / 100, 0) AS NUMBER(30, 3))  as montantReduction,
       fm.IDACTIVITE,
       fm.DATEFACT,
       fm.RUBRIQUE
FROM FACTFOURN_MERE_FILLE fm
         LEFT JOIN avoirffavectaux_grp grp ON grp.IDDETAILFACTURE = fm.ID;


alter table facture_fournisseur_mere add idBL varchar2(100) constraint fk_factfournmere_asbondeliv references AS_BONDELIVRAISON(id);
alter table facture_fournisseur_fille add idBLF varchar2(100) constraint fk_factfournfille_asbondelivfi references AS_BONDELIVRAISON_FILLE(id);


CREATE OR REPLACE VIEW FACTFOURN_FILLE_PLUS
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, MONTANT, TVA, IDACTIVITE, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION, IDBLF)
AS
SELECT f.ID,
       f.IDMERE,
       f.DESIGNATION,
       f.QUANTITE,
       f.PU,
       f.COMPTE,
       f.IDPRODUIT,
       f.DEVISE,
       f.TAUX,
       CAST(0.0 AS NUMBER(30, 3)) AS montant,
       f.tva,
       f.IDACTIVITE,
       f.DATEFACT,
       f.RUBRIQUE,
       f.MOIS,
       f.ANNEE,
       f.HEUREDEBUT,
       f.HEUREFIN,
       f.MAJORATION,
       f.REDUCTION,
       f.IDBLF
FROM FACTURE_FOURNISSEUR_FILLE f
WHERE 1 > 2;


INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MEDI0001270', 'Import Excel', 'fa fa-edit', '/spat/pages/globalnegoce.jsp?but=import/ImportExcel.jsp', 4,
        3, 'MDO000004');

		
CREATE OR REPLACE VIEW FACTURE_FOURN_MERE_VIDE
(
   ID,
   DATY,
   TIERS,
   DESIGNATION,
   TYPE,
   REMARQUE,
   CODE,
   MONTANT,
   IDCATEGORIE
)
AS
   SELECT CAST ('' AS VARCHAR2 (500)) AS id,
          CAST ('' AS DATE) AS daty,
          CAST ('' AS VARCHAR2 (100)) AS tiers,
          CAST ('' AS VARCHAR2 (1000)) AS designation,
          CAST ('' AS VARCHAR2 (500)) AS TYPE,
          CAST ('' AS VARCHAR2 (1000)) AS remarque,
          CAST ('' AS VARCHAR2 (200)) AS code,
          CAST (0 AS NUMBER (30, 3)) AS montant,
          CAST ('' AS VARCHAR2 (50)) AS idcategorie
     FROM DUAL;
	 
CREATE OR REPLACE VIEW ETATBPVRAI
(
   ID,
   MONTANTFACTURE,
   MONTANTPROVISION,
   MONTANTPAYE,
   ECART,
   TIERS,
   TIERSLIB,
   DATY,
   TIERSPROVISION,
   TIERSLIBPROVISION,
   MONTANTRESTE,
   IDPROVISION
)
AS
     SELECT fu.id,
            SUM (NVL (FCUV.MONTANTTTC, 0)) AS montantfacture,
            SUM (fu.MONTANTTTC) AS montantprovision,
            SUM (fu.MONTANTPAYE) AS MONTANTPAYE,
            0 AS ecart,
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0)
               AS MONTANTRESTE,
            ''
       FROM factfourn_msum_lib fu
            LEFT JOIN factfourn_msum_libv FCUV
               ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib;
CREATE OR REPLACE VIEW PAIEMENTFACTURESUM
(
   MONTANT,
   IDFACT
)
AS
     SELECT SUM (montant) AS montant, idfact
       FROM paiementfacture
   GROUP BY idfact;
   
CREATE OR REPLACE VIEW PAIEMENTFACTUREfSUM
(
   MONTANT,
   IDFACT
)
AS
     SELECT SUM (montant) AS montant, idfact
       FROM paiementfacturef
   GROUP BY idfact;   
   
CREATE OR REPLACE  VIEW FACTFOURN_MSUM_LIB
(
   ID,
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
   ETATLIB
)
AS
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
          CAST (NVL (pf.montant, 0) AS NUMBER (32, 3)) AS montantpaye,
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
          CASE
             WHEN m.etat = 1 THEN 'CREE'
             WHEN m.etat >= 11 THEN 'VISE'
             ELSE ''
          END
             AS etatlib
     FROM FACTFOURN_MSUM m
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
          LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id;
   
CREATE OR REPLACE VIEW ETATBPVRAI
(
   ID,
   MONTANTFACTURE,
   MONTANTPROVISION,
   MONTANTPAYE,
   ECART,
   TIERS,
   TIERSLIB,
   DATY,
   TIERSPROVISION,
   TIERSLIBPROVISION,
   MONTANTRESTE,
   IDPROVISION
)
AS
     SELECT fu.id,
            SUM (NVL (FCUV.MONTANTTTC, 0)) AS montantfacture,
            SUM (fu.MONTANTTTC) AS montantprovision,
            SUM (fu.MONTANTPAYE) AS MONTANTPAYE,
            0 AS ecart,
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0)
               AS MONTANTRESTE,
            ''
       FROM factfourn_msum_lib fu
            LEFT JOIN factfourn_msum_libv FCUV ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib;

CREATE OR REPLACE VIEW LIAISONINTRATABLE_OP_PARFACT_F (ID2, DED_ID, MONTANT, MONTANTOP, NUMFACT) AS
  select op.ID2,
       op.DED_ID,
       sum(OP.MONTANT)                                       as montant,
       sum(op.MONTANTOP)                                        as MONTANTOP,
       LISTAGG(ff.NUMFACT, ';') WITHIN GROUP ( ORDER BY OP.ID1) as numfact
from LIAISONINTRATABLE_OP_VISE OP
         JOIN etatfacturemontantdaty FF ON FF.ID = OP.ID1
group by op.ID2, op.DED_ID;


create view FACTUREFOURNVALIDE as
select * from factfourn_msum_lib where idcategorie<>'CATGFF002';


create view FACTUREFOURNVALIDE_C as
select * from FACTUREFOURNVALIDE where etat=1;

create view FACTUREFOURNVALIDE_V as
select * from FACTUREFOURNVALIDE where etat>=11 and id not in (select id1 from LIAISONINTRATABLE);

create view BPvalide as
select * from factfourn_msum_lib where IDCATEGORIE='CATGFF002';



create view BPvalide_C as
select * from BPvalide where etat=1;

create view BPvalide_V as
select * from BPvalide where etat>=11;

create table REGULFFPROVISION
(
    ID          VARCHAR2(100) not null
        constraint PK_REGULFFPROVISION
            primary key,
    IDPROVISION VARCHAR2(100)
        constraint FK_FACTFOURN_MERE_PROVISIONFF
            references FACTURE_FOURNISSEUR_MERE,
    IDFACTURE   VARCHAR2(100)
        constraint FK_FACTFOURNMERE_REGULFFPROV
            references FACTURE_FOURNISSEUR_MERE,
    ETAT        NUMBER(10)
);


CREATE SEQUENCE seq_REGULFFPROVISION
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_REGULFFPROVISION
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_REGULFFPROVISION.nextval INTO retour FROM dual;
    return retour;
END;


CREATE VIEW REGULFFPROVISIONLIB
            (ID, IDPROVISION, IDFACTURE, ETAT, IDPROVISIONCODE, IDFACTURECODE, ETATLIB) AS
select r.ID,
       r.IDPROVISION,
       r.IDFACTURE,
       r.ETAT,
       f2.code as idprovisioncode,
       f.CODE  as idfacturecode,
       case
           when r.etat = 1 then 'CREE'
           when r.etat >= 11 then 'VISE'
           end as etatlib
from regulFFProvision r
         left join FACTURE_FOURNISSEUR_MERE F on r.IDFACTURE = F.ID
         left join FACTURE_FOURNISSEUR_MERE F2 on r.IDPROVISION = F2.ID;




create view FACTUREFOURNVALIDE_EP as
    select ff.*,
           li.IDJOURNAL,
           li.ETATJC
        from FACTUREFOURNVALIDE  ff
             join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1=ff.ID
where li.IDJOURNAL is null ;

create view FACTUREFOURNVALIDE_P as
    select ff.*,
           li.IDJOURNAL,
           li.ETATJC
        from FACTUREFOURNVALIDE  ff
             join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1=ff.ID;


create or replace view FACTUREFOURNVALIDE_P as
select ff.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
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
       'PAYE' as ETATLIB
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
where li.IDJOURNAL is not null
  and li.ETATJC = 11;



create or replace view FACTUREFOURNVALIDE_EP  as
select ff.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
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
       'ATTENTE DE PAIEMENT' as ETATLIB
from FACTUREFOURNVALIDE ff
         join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
where ( li.IDJOURNAL is not null
  and li.ETATJC = 1) ;


create or replace view FACTUREFOURNVALIDE_V as
select ff.ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       TVA,
       REMARQUE,
       IDUSER,
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
       'VISE' as ETATLIB
from FACTUREFOURNVALIDE ff
       left  join LIAISONINTRATABLE_OP_JOURNAL li on li.ID1 = ff.ID
where (li.IDJOURNAL is  null);


create view FACTUREFOURNVALIDE_TOUS as
select *
from FACTUREFOURNVALIDE_C
union
    select *
from FACTUREFOURNVALIDE_V
union
    select *
from FACTUREFOURNVALIDE_ep

union
    select *
from FACTUREFOURNVALIDE_p;



UPDATE MENUDYNAMIQUE
SET LIBELLE='Saisie', ICONE='fa fa-plus', HREF='/spat/pages/globalnegoce.jsp?but=facture/facture-fournisseur-saisie-vaovao.jsp&mode=1', RANG=2, NIVEAU=5, ID_PERE='MEN00147'
WHERE ID='MEN00149';

UPDATE MENUDYNAMIQUE
SET LIBELLE='Liste', ICONE='fa fa-list', HREF='/spat/pages/globalnegoce.jsp?but=treso/bon-provisoire-liste-nouveau.jsp', RANG=1, NIVEAU=5, ID_PERE='MEN00147'
WHERE ID='MEN00148';

UPDATE MENUDYNAMIQUE
SET LIBELLE='Analyse', ICONE='fa fa-list', HREF='/spat/pages/globalnegoce.jsp?but=treso/bon-provisoire-analyse-nouveau.jsp', RANG=3, NIVEAU=5, ID_PERE='MEN00147'
WHERE ID='MEND00112251';

UPDATE MENUDYNAMIQUE
SET LIBELLE='Etat des bons', ICONE='fa fa-line-chart', HREF='/spat/pages/globalnegoce.jsp?but=treso/etat-bon-provisoire.jsp', RANG=3, NIVEAU=5, ID_PERE='MEN00147'
WHERE ID='MEN00150Z';

CREATE OR REPLACE VIEW ETATPROVISIONVRAI
(
   ID,
   MONTANTFACTURE,
   MONTANTPROVISION,
   MONTANTPAYE,
   ECART,
   TIERS,
   TIERSLIB,
   DATY,
   TIERSPROVISION,
   TIERSLIBPROVISION,
   MONTANTRESTE,
   IDPROVISION
)
AS
     SELECT fu.id,
            SUM (NVL (FCUV.MONTANTTTC, 0)) AS montantfacture,
            SUM (fu.MONTANTTTC) AS montantprovision,
            SUM (fu.MONTANTPAYE) AS MONTANTPAYE,
            SUM (fu.MONTANTPAYE) - SUM (NVL (FCUV.MONTANTTTC, 0)) AS ecart, --RAP
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0)
               AS MONTANTRESTE,
            ''
       FROM FACTURE_CLIENT_UNION fu
            --left JOIN FACTURE_CLIENT_UNION fac ON fa.id = fac.IDPROVISION
            LEFT JOIN FACTURE_CLIENT_UNION_VISE FCUV
               ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib;
CREATE OR REPLACE VIEW FACTURE_fourn_VISE_gp
        (
           MONTANT,
           MONTANTTVA,
           MONTANTAVOIR,
           MONTANTPAYE,
           MONTANTTTC,
           IDPROVISION
        )
        AS
         SELECT SUM (MONTANT) AS montant,
                SUM (MONTANTTVA) AS MONTANTTVA,
                SUM (MONTANTAVOIR) AS MONTANTAVOIR,
                SUM (MONTANTPAYE) AS MONTANTPAYE,
                SUM (MONTANTTTC) AS MONTANTTTC,
                IDPROVISION
           FROM factfourn_msum_lib
          WHERE ETAT >= 11
        GROUP BY IDPROVISION;
CREATE OR REPLACE VIEW ETATBPVRAI
(
   ID,
   MONTANTFACTURE,
   MONTANTPROVISION,
   MONTANTPAYE,
   ECART,
   TIERS,
   TIERSLIB,
   DATY,
   TIERSPROVISION,
   TIERSLIBPROVISION,
   MONTANTRESTE,
   IDPROVISION
)
AS
     SELECT fu.id,
            SUM (NVL (FCUV.MONTANTTTC, 0)) AS montantfacture,
            SUM (fu.MONTANTTTC) AS montantprovision,
            SUM (fu.MONTANTPAYE) AS MONTANTPAYE,
            SUM (fu.MONTANTPAYE) - SUM (NVL (FCUV.MONTANTTTC, 0)) AS ecart, --RAP
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0)
               AS MONTANTRESTE,
            ''
       FROM factfourn_msum_lib fu
            LEFT JOIN FACTURE_fourn_VISE_gp FCUV ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib;

CREATE OR REPLACE  VIEW FACTURE_fournisseur_FILLEHT
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          CAST (ff.quantite * ff.pu AS NUMBER (30, 3)) AS montantHTSimple
     FROM FACTURE_fournisseur_FILLE ff;

CREATE OR REPLACE VIEW FACTURE_fournisseur_FILLEMR
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE,
   MONTANTMAJ,
   MONTANTRED
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          ff."MONTANTHTSIMPLE",
          CAST ( (montantHTSimple * majoration) / 100 AS NUMBER (30, 3))
             AS montantMaj,
          CAST ( (montantHTSimple * reduction) / 100 AS NUMBER (30, 3))
             AS montantRed
     FROM facture_fournisseur_filleHT ff;

CREATE OR REPLACE VIEW FACTURE_fournisseur_FILLENET
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE,
   MONTANTMAJ,
   MONTANTRED,
   MONTANTNET
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          ff."MONTANTHTSIMPLE",
          ff."MONTANTMAJ",
          ff."MONTANTRED",
          CAST (montantHTSimple + montantMaj - montantRed AS NUMBER (30, 3))
             AS montantNET
     FROM facture_fournisseur_filleMR ff;

CREATE OR REPLACE VIEW FACTURE_fourn_FILLEWITHTVA
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE,
   MONTANTMAJ,
   MONTANTRED,
   MONTANTNET,
   MONTANTTVA
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          ff."MONTANTHTSIMPLE",
          ff."MONTANTMAJ",
          ff."MONTANTRED",
          ff."MONTANTNET",
          CAST ( (montantNET * tva) / 100 AS NUMBER (30, 3)) AS montantTVA
     FROM facture_fournisseur_filleNet ff;

CREATE OR REPLACE VIEW FACTURE_fourn_FILLETTC
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE,
   MONTANTMAJ,
   MONTANTRED,
   MONTANTNET,
   MONTANTTVA,
   MONTANTTTC
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          ff."MONTANTHTSIMPLE",
          ff."MONTANTMAJ",
          ff."MONTANTRED",
          ff."MONTANTNET",
          ff."MONTANTTVA",
          CAST (montantNET + montantTVA AS NUMBER (30, 3)) AS montantTTC
     FROM facture_fourn_filleWithTVA ff;	 
	 
	 CREATE OR REPLACE VIEW ETATPROVISIONVRAI
(
   ID,
   MONTANTFACTURE,
   MONTANTPROVISION,
   MONTANTPAYE,
   ECART,
   TIERS,
   TIERSLIB,
   DATY,
   TIERSPROVISION,
   TIERSLIBPROVISION,
   MONTANTRESTE,
   IDPROVISION
)
AS
     SELECT fu.id,
            SUM (NVL (FCUV.MONTANTTTC, 0)) AS montantfacture,
            SUM (fu.MONTANTTTC) AS montantprovision,
            SUM (fu.MONTANTPAYE) AS MONTANTPAYE,
            SUM (fu.MONTANTPAYE) - SUM (NVL (FCUV.MONTANTTTC, 0)) AS ecart, --RAP
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0)
               AS MONTANTRESTE,
            ''
       FROM FACTURE_CLIENT_UNION fu
            --left JOIN FACTURE_CLIENT_UNION fac ON fa.id = fac.IDPROVISION
            LEFT JOIN FACTURE_CLIENT_UNION_VISE FCUV
               ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib;
CREATE OR REPLACE VIEW FACTURE_fourn_VISE_gp
        (
           MONTANT,
           MONTANTTVA,
           MONTANTAVOIR,
           MONTANTPAYE,
           MONTANTTTC,
           IDPROVISION
        )
        AS
         SELECT SUM (MONTANT) AS montant,
                SUM (MONTANTTVA) AS MONTANTTVA,
                SUM (MONTANTAVOIR) AS MONTANTAVOIR,
                SUM (MONTANTPAYE) AS MONTANTPAYE,
                SUM (MONTANTTTC) AS MONTANTTTC,
                IDPROVISION
           FROM factfourn_msum_lib
          WHERE ETAT >= 11
        GROUP BY IDPROVISION;			
CREATE OR REPLACE VIEW ETATBPVRAI
(
   ID,
   MONTANTFACTURE,
   MONTANTPROVISION,
   MONTANTPAYE,
   ECART,
   TIERS,
   TIERSLIB,
   DATY,
   TIERSPROVISION,
   TIERSLIBPROVISION,
   MONTANTRESTE,
   IDPROVISION
)
AS
     SELECT fu.id,
            SUM (NVL (FCUV.MONTANTTTC, 0)) AS montantfacture,
            SUM (fu.MONTANTTTC) AS montantprovision,
            SUM (fu.MONTANTPAYE) AS MONTANTPAYE,
            SUM (fu.MONTANTPAYE) - SUM (NVL (FCUV.MONTANTTTC, 0)) AS ecart, --RAP
            fu.TIERS,
            fu.TIERSLIB,
            fu.DATY,
            '-' AS tiersprovision,
            '-' AS tierslibprovision,
            SUM (fu.MONTANTTTC) - NVL (SUM (FCUV.MONTANTTTC), 0)
               AS MONTANTRESTE,
            ''
       FROM factfourn_msum_lib fu
            LEFT JOIN FACTURE_fourn_VISE_gp FCUV ON fu.id = FCUV.IDPROVISION
   GROUP BY fu.id,
            fu.DATY,
            fu.tiers,
            fu.tierslib;		

CREATE OR REPLACE  VIEW FACTURE_fournisseur_FILLEHT
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          CAST (ff.quantite * ff.pu AS NUMBER (30, 3)) AS montantHTSimple
     FROM FACTURE_fournisseur_FILLE ff;		

CREATE OR REPLACE VIEW FACTURE_fournisseur_FILLEMR
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE,
   MONTANTMAJ,
   MONTANTRED
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          ff."MONTANTHTSIMPLE",
          CAST ( (montantHTSimple * majoration) / 100 AS NUMBER (30, 3))
             AS montantMaj,
          CAST ( (montantHTSimple * reduction) / 100 AS NUMBER (30, 3))
             AS montantRed
     FROM facture_fournisseur_filleHT ff;	 
	 
CREATE OR REPLACE VIEW FACTURE_fournisseur_FILLENET
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE,
   MONTANTMAJ,
   MONTANTRED,
   MONTANTNET
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          ff."MONTANTHTSIMPLE",
          ff."MONTANTMAJ",
          ff."MONTANTRED",
          CAST (montantHTSimple + montantMaj - montantRed AS NUMBER (30, 3))
             AS montantNET
     FROM facture_fournisseur_filleMR ff;	

CREATE OR REPLACE VIEW FACTURE_fourn_FILLEWITHTVA
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE,
   MONTANTMAJ,
   MONTANTRED,
   MONTANTNET,
   MONTANTTVA
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          ff."MONTANTHTSIMPLE",
          ff."MONTANTMAJ",
          ff."MONTANTRED",
          ff."MONTANTNET",
          CAST ( (montantNET * tva) / 100 AS NUMBER (30, 3)) AS montantTVA
     FROM facture_fournisseur_filleNet ff;	 
	 
CREATE OR REPLACE VIEW FACTURE_fourn_FILLETTC
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   IDACTIVITE,
   TVA,
   DATEFACT,
   RUBRIQUE,
   MOIS,
   ANNEE,
   HEUREDEBUT,
   HEUREFIN,
   REDUCTION,
   MAJORATION,
   TEST,
   MONTANTHTSIMPLE,
   MONTANTMAJ,
   MONTANTRED,
   MONTANTNET,
   MONTANTTVA,
   MONTANTTTC
)
AS
   SELECT ff."ID",
          ff."IDMERE",
          ff."DESIGNATION",
          ff."QUANTITE",
          ff."PU",
          ff."COMPTE",
          ff."IDPRODUIT",
          ff."DEVISE",
          ff."TAUX",
          ff."IDACTIVITE",
          ff."TVA",
          ff."DATEFACT",
          ff."RUBRIQUE",
          ff."MOIS",
          ff."ANNEE",
          ff."HEUREDEBUT",
          ff."HEUREFIN",
          ff."REDUCTION",
          ff."MAJORATION",
          ff."TEST",
          ff."MONTANTHTSIMPLE",
          ff."MONTANTMAJ",
          ff."MONTANTRED",
          ff."MONTANTNET",
          ff."MONTANTTVA",
          CAST (montantNET + montantTVA AS NUMBER (30, 3)) AS montantTTC
     FROM facture_fourn_filleWithTVA ff;	 
	 

alter table FACTURE_FOURNISSEUR_MERE add NUMFACT varchar2(100);
alter table FACTURE_FOURNISSEUR_MERE add dateemission date;
alter table FACTURE_FOURNISSEUR_MERE add numid varchar2(100);
alter table FACTURE_FOURNISSEUR_MERE add projet varchar2(100) constraint projet_ff_fk references PROJET;
alter table FACTURE_FOURNISSEUR_MERE add code_etablissement varchar2(100) constraint code_etablissement_ff_fk references codeetablissement;
alter table FACTURE_FOURNISSEUR_MERE add NUMEROOP varchar2(100) ;

alter table FACTURE_FOURNISSEUR_MERE add exercice number(10);
alter table FACTURE_FOURNISSEUR_MERE add montantdevise number(30,3);


alter table FACTURE_FOURNISSEUR_FILLE add IDINGREDIENT varchar2(100);
alter table FACTURE_FOURNISSEUR_FILLE add MARGE varchar2(100);
alter table FACTURE_FOURNISSEUR_FILLE add IDDQE varchar2(100);
alter table FACTURE_FOURNISSEUR_FILLE add PUDEVISE number(10,3);


create or replace view PAIEMENTFACTURESUM as
select sum(montant) as montant, idfact
from paiementfacture
group by idfact
/

create or replace view PAIEMENTFACTUREFSUM as
select sum(montant) as montant, idfact
from paiementfacturef
group by idfact
/


create or replace view FACTFOURN_MSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION,
             CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB)
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
       IDPROVISION,
       IDPROVISIONLIB,
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
           else '' end                           as etatlib
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id;


create OR REPLACE view DETAILSFACTUREFOURNISSEUR_PAYE as
select dff."ID",
       DFF."IDINGREDIENT",
       dff.QUANTITE as "QTE",
       dff."PU",
       dff."IDMERE",
       dff."COMPTE",
       dff."PUDEVISE",
       dff."IDDQE",
       dff."MARGE",
       dff."TVA",
       DATY,
       ff.MONTANTTTC,
       (ff.MONTANTPAYE) / nvl(nullif(MONTANTTTC, 0), 1)                        as montantpayepourc,
       (dff.QUANTITE * dff.PU) * ((ff.MONTANTPAYE) / nvl(nullif(MONTANTTTC, 0), 1)) as montantpaye
from factfourn_msum_lib  ff
         left join FACTURE_FOURNISSEUR_FILLE dff on dff.IDMERE = ff.id
where ETAT >= 11;


CREATE OR REPLACE VIEW PREVISIONTYPEBORNAGE
            (ID, DATE_RADE, PROVENANCE, NAVIRE, CONSIGNATAIRE, CARGAISON, PILOTE, DATE_ARRIVEE, HEURE_ARRIVEE,
             DATE_DEPART, HEURE_DEPART, DESTINATION, ETAT, ESCALE, NOVOYAGE, ARMATEUR, TYPE)
AS
select p.ID,
       p.DATE_RADE,
       p.PROVENANCE,
       p.NAVIRE,
       p.CONSIGNATAIRE,
       p.CARGAISON,
       p.PILOTE,
       p.DATE_ARRIVEE,
       p.HEURE_ARRIVEE,
       p.DATE_DEPART,
       p.HEURE_DEPART,
       p.DESTINATION,
       p.ETAT,
       p.ESCALE,
       p.NOVOYAGE,
       p.ARMATEUR,
       n.type
from prevision p
         join navire n on p.navire = n.id
where n.type = 'TYPES0001';

create or replace view DETAILSFACTUREFOURNISSEUR_PAYE as
select dff."ID",
       DFF."IDINGREDIENT",
       dff.QUANTITE                                                              as "QTE",
       dff."PU",
       dff."IDMERE",
       dff."COMPTE",
       dff."PUDEVISE",
       dff."IDDQE",
       dff."MARGE",
       dff."TVA",
       DATY,
       dff1.MONTANTTTC,
       ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1))  *100                   as montantpayepourc,
       (dff1.MONTANTTTC) * ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1)) as montantpaye
from factfourn_msum_lib ff
         right join FACTURE_FOURNISSEUR_FILLE dff on dff.IDMERE = ff.id
         right join FACTFOURN_FILLETTC dff1 on dff1.id = dff.id
where ETAT >= 11;

create or replace view DETAILSFACTUREFOURNISSEUR_PAYE as
select dff."ID",
       DFF."IDINGREDIENT",
       dff.QUANTITE                                                              as "QTE",
       dff."PU",
       dff."IDMERE",
       dff."COMPTE",
       dff."PUDEVISE",
       dff."IDDQE",
       dff."MARGE",
       dff."TVA",
       DATY,
       dff1.MONTANTTTC,
       ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1))                    as montantpayepourc,
       (dff1.MONTANTTTC) * ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1)) as montantpaye
from factfourn_msum_lib ff
         right join FACTURE_FOURNISSEUR_FILLE dff on dff.IDMERE = ff.id
         right join FACTFOURN_FILLETTC dff1 on dff1.id = dff.id
where ETAT >= 11;



create or replace view SITUATIONLCDEPENSE as
SELECT l.id          AS                                id,
       l.DESIGNATION AS                                designation,
       l.COMPTE      AS                                compte,
       l.ANNEE       AS                                annee,
       l.MONTANT     AS                                montant,
       l.etat,
       CAST(nvl(sum(MONTANTTTC),0) AS NUMBER(30, 3))
                     AS                                facture,
       CAST(NVL(SUM(montantpaye), 0) AS NUMBER(30, 2)) paye
FROM LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
                   ON SUBSTR(mf.COMPTE, 0, LENGTH(l.COMPTE)) LIKE l.COMPTE
                       AND EXTRACT(YEAR FROM daty) = l.ANNEE
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.MONTANT, l.etat;
		 
create view FACTURE_CLIENT_MF_PAYE as
select fcf."ID",
       fcf."IDMERE",
       fcf."DESIGNATION",
       fcf."QUANTITE",
       fcf."PU",
       fcf."COMPTE",
       fcf."IDPRODUIT",
       fcf."DEVISE",
       fcf."TAUX",
       fcf."DATY",
       fcf."TIERS",
       fcf."DESIGNATIONMERE",
       fcf."TYPE",
       fcf."TVA",
       fcf."REMARQUE",
       fcf."IDUSER",
       fcf."DATE_ECHEANCE",
       fcf."ETAT",
       fcf1.MONTANTTTC,
       (l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1)                     as montantpayepourc,
        fcf1.MONTANTTTC *((l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1) ) as montantpaye
from FACTURECLIENTMSUM_LIB l
         right join FACTURE_CLIENT_MERE_FILLE fcf on fcf.IDMERE = l.id
         join FACTURE_CLIENT_FILLETTC fcf1 on fcf1.id = fcf.id
where l.ETAT >= 11;


create or replace view SITUATIONLCRECETTE as
SELECT l.id          AS                        id,
       l.DESIGNATION AS                        designation,
       l.COMPTE      AS                        compte,
       l.ANNEE       AS                        annee,
       l.MONTANT     AS                        montant,
       l.etat,
       CAST(SUM(mf.QUANTITE * mf.pu * mf.TAUX) AS NUMBER(30, 3))
                     AS                        facture,
       CAST(SUM(montantpaye) AS NUMBER(30, 3)) paye
FROM LIGNECREDITRECETTE l
         LEFT JOIN FACTURE_CLIENT_MF_PAYE mf
                   ON SUBSTR(mf.COMPTE, 0, LENGTH(l.COMPTE)) LIKE l.COMPTE
                       AND EXTRACT(YEAR FROM DATY) = l.ANNEE and mf.IDMERE not in
                                                                 (select id from ProvisionFactureDefinitive)
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.MONTANT, l.etat;
		 
		 create or replace view SITUATIONLCRECETTE as
SELECT l.id          AS                        id,
       l.DESIGNATION AS                        designation,
       substr(l.COMPTE, 1, 1)        AS                        compte,
       l.ANNEE       AS                        annee,
       l.MONTANT     AS                        montant,
       l.etat,
       CAST(SUM(mf.QUANTITE * mf.pu * mf.TAUX) AS NUMBER(30, 3))
                     AS                        facture,
       CAST(SUM(montantpaye) AS NUMBER(30, 3)) paye
FROM LIGNECREDITRECETTE l
         LEFT JOIN FACTURE_CLIENT_MF_PAYE mf
                   ON substr(mf.COMPTE, 1, 1)   =substr(l.COMPTE, 1, 1)
                       AND EXTRACT(YEAR FROM DATY) = l.ANNEE and mf.IDMERE not in
                                                                 (select id from ProvisionFactureDefinitive)
GROUP BY l.id,
         l.DESIGNATION,
        substr(l.COMPTE, 1, 1)  ,
         l.ANNEE,
         l.MONTANT, l.etat;
		 
		 --------recette
		 create or replace view SITUATIONLCRECETTE as
SELECT l.id          AS                        id,
       l.DESIGNATION AS                        designation,
       l.COMPTE      AS                        compte,
       l.ANNEE       AS                        annee,
       l.MONTANT     AS                        montant,
       l.etat,
       CAST(SUM(mf.MONTANTTTC) AS NUMBER(30, 3))
                     AS                        facture,
       CAST(SUM(montantpaye) AS NUMBER(30, 3)) paye
FROM LIGNECREDITRECETTE l
         LEFT JOIN FACTURE_CLIENT_MF_PAYE mf
                   ON SUBSTR(mf.COMPTE, 0, LENGTH(l.COMPTE)) LIKE l.COMPTE
                       AND EXTRACT(YEAR FROM DATY) = l.ANNEE and mf.IDMERE not in
                                                                 (select id from ProvisionFactureDefinitive)
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.MONTANT, l.etat;
		 
----DEPENSE
create or replace view SITUATIONLCDEPENSE as
SELECT l.id          AS                                id,
       l.DESIGNATION AS                                designation,
       l.COMPTE      AS                                compte,
       l.ANNEE       AS                                annee,
       l.MONTANT     AS                                montant,
       l.etat,
       CAST(nvl(sum(MONTANTTTC),0) AS NUMBER(30, 3))
                     AS                                facture,
       CAST(NVL(SUM(montantpaye), 0) AS NUMBER(30, 2)) paye
FROM LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
                   ON SUBSTR(mf.COMPTE, 0, LENGTH(l.COMPTE)) LIKE l.COMPTE
                       AND EXTRACT(YEAR FROM daty) = l.ANNEE
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.MONTANT, l.etat;

		 

create or replace view SITUATIONLCDEPENSE as
SELECT l.id           AS                               id,
       l.DESIGNATION  AS                               designation,
       l.COMPTE       AS                               compte,
       l.ANNEE        AS                               annee,
       cast(sum(l.MONTANT) as NUMBER(30, 3)) AS                               montant,
       l.etat,
       CAST(nvl(sum(MONTANTTTC), 0) AS NUMBER(30, 3))
                      AS                               facture,
       CAST(NVL(SUM(montantpaye), 0) AS NUMBER(30, 2)) paye
FROM LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
                   ON SUBSTR(mf.COMPTE, 0, LENGTH(l.COMPTE)) LIKE l.COMPTE
                       AND EXTRACT(YEAR FROM daty) = l.ANNEE
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.etat;

		  create or replace view SITUATIONLCRECETTE as
SELECT l.id          AS                        id,
       l.DESIGNATION AS                        designation,
       l.COMPTE      AS                        compte,
       l.ANNEE       AS                        annee,
       sum(l.MONTANT)     AS                        montant,
       l.etat,
       CAST(SUM(mf.MONTANTTTC) AS NUMBER(30, 3))
                     AS                        facture,
       CAST(SUM(montantpaye) AS NUMBER(30, 3)) paye
FROM LIGNECREDITRECETTE l
         LEFT JOIN FACTURE_CLIENT_MF_PAYE mf
                   ON SUBSTR(mf.COMPTE, 0, LENGTH(l.COMPTE)) LIKE l.COMPTE
                       AND EXTRACT(YEAR FROM DATY) = l.ANNEE and mf.IDMERE not in
                                                                 (select id from ProvisionFactureDefinitive)
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
          l.etat;
		  
create or replace view ACTIVITELIBCOMPLET
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT, RUBRIQUELIB, NAVIRE,
             BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE, UNITE, DIRECTION, CONDITION, TVA, OBJET,
             REDEVANCE, CLIENTLIB, REDEVANCELIB, DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE,
             DATEFACT, POSTE, POSTELIB, DATEDEBUT, HEUREDEBUT, DATEFIN, HEUREFIN, VOLUME, VOLUMEARRONDI, CARGAISON,
             IDPRESTATION, ESTNATIONAL, ESTJOUR, ESTFERIE, MANOEUVRE, ESTWEEKEND, NATUREOPERATION, NBQUARTHEURE,
             NBHEURE, NBJOUR, TYPEQUAIS, SURFACE, NB5JOURS, QUAI, FLOTTE, CATEGORIE_FLOTTE, UNITELIB, ESTPETROLIER,
             VOLUMERUBRIQUE)
AS
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                AS rubriquelib,
       nv.id                                         AS navire,
       nv.NOM                                        AS bateaulib,
       nv.PLT                                        AS poids,
       nv.LHT                                        AS longueur,
       nv.LM                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                       AS clientlib,
       re.VAL                                        AS redevancelib,
       di.LIBELLEDIR                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                               AS DATEFACT,
       ac.POSTE,
       pd.VALQUAIS                                   AS postelib,
       ac.DATEDEBUT,
       ac.HEUREDEBUT,
       ac.DATEFIN,
       ac.HEUREFIN,
       CAST(nv.lm * nv.lht * nv.te AS NUMBER(10, 3)) AS volume,
       CAST(ROUND((nv.lm * nv.lht * nv.te) / 100) AS NUMBER(10, 3))
                                                     AS volumeArrondi,
       NVL(pre.cargaison, '-')                       AS cargaison,
       pre.id                                        AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                     AS estNational,
       CASE
           WHEN ac.heuredebut BETWEEN '05:00:00' AND '19:00:00' THEN 'JOUR'
           ELSE 'NUIT'
           END
                                                     AS estJour,
       CASE
           WHEN ac.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                     AS estFerie,
       occ.idmanoeuvrebord                           AS manoeuvre,
       CASE
           WHEN TO_CHAR(ac.daty, 'DAY') like '%DIMANCHE%'
               OR TO_CHAR(ac.daty, 'DAY') like '%SAMEDI%'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                     AS estWeekend,
       occ.IDNATUREOPERATION                         AS natureoperation,
       CASE
           WHEN ((60
               * 24
               * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                          'dd-mm-yy hh24:mi:ss')
                   - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                             'dd-mm-yy hh24:mi:ss')))
               - 60)
                    / 15 < 0
               THEN
               0
           ELSE
               ROUND(
                           ((60
                               * 24
                               * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                          'dd-mm-yy hh24:mi:ss')
                                   - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                             'dd-mm-yy hh24:mi:ss')))
                               - 60)
                           / 15)
           END
                                                     AS nbQuartHeure,
       CASE
           WHEN 24
                    * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                               'dd-mm-yy hh24:mi:ss')
                   - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                             'dd-mm-yy hh24:mi:ss')) < 0
               THEN
               0
           ELSE
               (round(24 * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                    'dd-mm-yy hh24:mi:ss')
                   - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                             'dd-mm-yy hh24:mi:ss'))))
           END
                                                     AS nbHeure,
       CASE
           WHEN (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                         'dd-mm-yy hh24:mi:ss')
               - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                         'dd-mm-yy hh24:mi:ss')) < 0
               THEN
               0
           WHEN ROUND((TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                               'dd-mm-yy hh24:mi:ss')
               - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                         'dd-mm-yy hh24:mi:ss'))) = 0
               THEN
               1
           ELSE
                   ((TO_DATE(ac.DATEFIN, 'dd-mm-yy') - TO_DATE(ac.DATEDEBUT, 'dd-mm-yy'))) + 1
           END
                                                     AS nbJour,
       q.typequais,
       CAST(nv.LHT * nv.lm AS NUMBER(20, 2))         AS surface,
       CASE
           WHEN (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                         'dd-mm-yy hh24:mi:ss')
               - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                         'dd-mm-yy hh24:mi:ss')) < 0
               THEN
               0
           ELSE
               CASE
                   WHEN ROUND(
                           (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                    'dd-mm-yy hh24:mi:ss')
                               - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                         'dd-mm-yy hh24:mi:ss'))) BETWEEN 0
                       AND 5
                       THEN
                       1
                   ELSE
                       (
                               TRUNC(
                                           (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                                    'dd-mm-yy hh24:mi:ss')
                                               - TO_DATE(
                                                    ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                                    'dd-mm-yy hh24:mi:ss'))
                                           / 5)
                               + 1)
                   END
           END
                                                     AS nb5jours,
       pd2.QUAI,
       occ.IDMATERIEL_NAVAL                          AS flotte,
       cm.IDCATEGORIE                                AS categorie_flotte,
       ua.VAL                                        AS unitelib,
       CASE WHEN nv.TYPE = 'TP0001' THEN 'TRUE' ELSE 'FALSE' END
                                                     AS estPetrolier,
       RA.VOLUME                                     AS volumeRubrique
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
         LEFT JOIN UNITE_ACTIVITE ua ON ua.ID = ra.UNITE
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
         LEFT JOIN occupationmaterielnaval occ ON occ.id = ac.REFOBJET
         LEFT JOIN MATERIEL_NAVAL cm ON cm.id = occ.IDMATERIEL_NAVAL;

-- auto-generated definition
create table REGULAVOIRFC
(
    ID        VARCHAR2(100) not null
        constraint PK_REGULAVOIRFC
            primary key,
    IDAVOIR   VARCHAR2(500)
        constraint FK_REGULAVOIRFC_AVOIRFC
            references AVOIRFC,
    IDFACTURE VARCHAR2(500)
        constraint FK_REGULAVOIRFC_FACTURECLIENT
            references FACTURECLIENT
)
/



