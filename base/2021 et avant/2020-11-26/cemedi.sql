CREATE TABLE seuilarticlemagasin(
	id varchar2(100) CONSTRAINT seuilarticlemagasin_pk PRIMARY KEY,
	idarticle varchar2(100)CONSTRAINT artcile_magasin_fk references st_article,
	idmagasin varchar2(100)CONSTRAINT magasin_seuil_fk  references  st_magasin,
	seuil number(10,2)
);

CREATE SEQUENCE seqseuilarticlemagasin
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqseuilarticlemagasin
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqseuilarticlemagasin.nextval INTO retour FROM dual;
  return retour;
END;

CREATE SEQUENCE seqconfigremboursement
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqconfigremboursement
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqconfigremboursement.nextval INTO retour FROM dual;
  return retour;
END;

CREATE TABLE lienemploye(
	id varchar2(100)CONSTRAINT lienemploye_pk ,
	val varchar2(500),
	desce varchar2(500)
);

CREATE SEQUENCE seqlienemploye
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqlienemploye
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT  seqlienemploye.nextval INTO retour FROM dual;
  return retour;
END;

CREATE TABLE statutemploye (
	id varchar2(100) CONSTRAINT STATUTEMPLOYE_PK PRIMARY KEY,
	val varchar2(500),
	desce varchar2(500)
);

CREATE SEQUENCE seqstatutemploye
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqstatutemploye
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT  seqstatutemploye.nextval INTO retour FROM dual;
  return retour;
END;

CREATE TABLE actionemploye (
	id varchar2(100) CONSTRAINT actionemploye_PK PRIMARY KEY,
	val varchar2(500),
	desce varchar2(500)
);

CREATE SEQUENCE seqactionemploye
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqactionemploye
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT  seqactionemploye.nextval INTO retour FROM dual;
  return retour;
END;

CREATE TABLE configremboursement(
id varchar2(100)CONSTRAINT configremboursement_pk PRIMARY KEY,
actionemploye varchar2(100) CONSTRAINT remboursement_action_fk references actionemploye,
identite varchar2(100) CONSTRAINT identite_cofif_fk references entite,
statutemploye varchar2(100) CONSTRAINT status_config_fk  references statutemploye,
lienemploye varchar2(100) CONSTRAINT lien_employe_fk references lienemploye,
pourcentage number(10,2)
);

CREATE SEQUENCE seqconfigremboursement
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqconfigremboursement
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT  seqconfigremboursement.nextval INTO retour FROM dual;
  return retour;
END;

CREATE VIEW seuilarticlemagasinlib as
SELECT mag.id,
		sa.DESIGNATION as idarticle,
		SM.DESCE AS idmagasin,
		mag.seuil
FROM seuilarticlemagasin mag
		JOIN ST_ARTICLE sa  ON sa.id=mag.idarticle
		JOIN ST_MAGASIN sm ON sm.id=mag.idmagasin;

         CREATE VIEW montantavoirparfacture as
   SELECT IDFACTURE ,SUM(MONTANT)AS MONTANT FROM avoir GROUP BY IDFACTURE ;

  CREATE TABLE requete_a_envoyer_groupe 
   (	ID VARCHAR2(200), 
	ACTION VARCHAR2(200), 
	TABLECONCERNE VARCHAR2(200), 
	REQUETE VARCHAR2(4000), 
	DATYG varchar2(100), 
	HEURE VARCHAR2(200), 
	SERVEUR VARCHAR2(200), 
	idrequeteAenvoyer varchar2(100),
	etat number(10),
	
	 PRIMARY KEY (ID)
 
   ) ;
   
  CREATE TABLE requete_recu_groupe 
   (	ID VARCHAR2(200), 
	ACTION VARCHAR2(200), 
	TABLECONCERNE VARCHAR2(200), 
	REQUETE VARCHAR2(4000), 
	DATYG varchar2(100), 
	HEURE VARCHAR2(200), 
	SERVEUR VARCHAR2(200), 
	ETAT NUMBER(10), 
	 PRIMARY KEY (ID)

   );
  

     CREATE SEQUENCE seqrequete_a_envoyer_groupe
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqrequete_a_envoyer_groupe
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqrequete_a_envoyer_groupe.nextval INTO retour FROM dual;
  return retour;
END;

 CREATE SEQUENCE seqrequete_recu_groupe
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqrequete_recu_groupe
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqrequete_recu_groupe.nextval INTO retour FROM dual;
  return retour;
END;
   

   CREATE view REQUETE_EXECUTE_SERVEUR (ID, ACTION, TABLECONCERNE, REQUETE, DATY, HEURE, SERVEUR) AS 
  SELECT rae.ID, rae.ACTION, rae.TABLECONCERNE, rae.REQUETE, rae.DATY, rae.HEURE, re.SERVEUR
FROM REQUETE_A_ENVOYER rae 
JOIN REQUETE_EXECUTE re on rae.ID = re.IDREQUETE ;



CREATE OR REPLACE FORCE VIEW CEMEDI.PAIEMENTFACTURECLIENTREMISE_NV (ID, DATY, TIERS, DESIGNATION, TYPEE, TVA, ETAT, DEVISE, COMPTE, REMARQUE, COURSDEVISE, MONTANT, MONTANTTVA, MONTANTTOTAL, MONTANTPAYER, RESTEAPAYER, MONTANTTOTALEREMISE,AVOIR) AS 
  SELECT ID,DATY,TIERS,DESIGNATION,TYPEE,TVA,ETAT,DEVISE,COMPTE,REMARQUE,COURSDEVISE,MONTANT,MONTANTTVA,MONTANTTOTAL,MONTANTPAYER,RESTEAPAYER,MONTANTTOTALEREMISE,AVOIR 
        FROM PAIEMENT_FACTURECLIENT_REMISE
        WHERE ETAT=1;
       
      CREATE OR REPLACE FORCE VIEW CEMEDI.PAIEMENTFACTURECLIENTREMISE_V (ID, DATY, TIERS, DESIGNATION, TYPEE, TVA, ETAT, DEVISE, COMPTE, REMARQUE, COURSDEVISE, MONTANT, MONTANTTVA, MONTANTTOTAL, MONTANTPAYER, RESTEAPAYER, MONTANTTOTALEREMISE,avoir) AS 
  SELECT ID,DATY,TIERS,DESIGNATION,TYPEE,TVA,ETAT,DEVISE,COMPTE,REMARQUE,COURSDEVISE,MONTANT,MONTANTTVA,MONTANTTOTAL,MONTANTPAYER,RESTEAPAYER,MONTANTTOTALEREMISE,AVOIR 
        FROM PAIEMENT_FACTURECLIENT_REMISE
        WHERE ETAT=11;

CREATE VIEW remboursementfacturelibelle as
SELECT r.ID ,r.IDFACTUREMERE ,r.POURCENTAGE ,r.DESIGNATION ,st.RAISONSOCIAL  AS SOCIETE FROM remboursementfacturelib r
		JOIN ST_TIERS st ON st.id=r.SOCIETE ;

        CREATE OR REPLACE  VIEW REMBOURSEMENT_LIBELLE  AS 
  select
r.*
from remboursementfacturelibelle r;

CREATE VIEW etatFactureDetailFournisseur as
SELECT fdf.*,ff.ETAT FROM FACTURE_DETAIL_FOURNISSEUR fdf 
		JOIN FACTURE_FOURNISSEUR ff ON ff.id=fdf.IDMERE ;

CREATE OR REPLACE VIEW etatFactureDetailFournisseur as
SELECT fdf.*,ff.ETAT,ff.DATY FROM FACTURE_DETAIL_FOURNISSEUR fdf 
		JOIN FACTURE_FOURNISSEUR ff ON ff.id=fdf.IDMERE;

CREATE TABLE AS_BONDECOMMANDE 
   (	ID VARCHAR2(50) NOT NULL ENABLE, 
	DATY DATE, 
	ETAT NUMBER, 
	REMARQUE VARCHAR2(500), 
	DESIGNATION VARCHAR2(500), 
	MODEPAIEMENT VARCHAR2(50), 
	FOURNISSEUR VARCHAR2(50), 
	TVA NUMBER, 
	 PRIMARY KEY (ID)

  
   ) ;

   CREATE VIEW configremboursementlib
   AS
   SELECT 
   cr.ID ,
   ac.VAL  AS ACTIONEMPLOYE ,
   en.VAL AS IDENTITE ,
   se.val as STATUTEMPLOYE ,
   l.VAL  AS LIENEMPLOYE ,
   cr.POURCENTAGE 
   FROM configremboursement cr
   JOIN actionemploye ac ON ac.id=cr.ACTIONEMPLOYE 
  	JOIN entite en ON en.id=cr.IDENTITE 
  	JOIN statutemploye se ON se.id=cr.STATUTEMPLOYE 
  	JOIN LIENEMPLOYE l ON l.id=cr.LIENEMPLOYE ;


 CREATE TABLE AS_BONDECOMMANDE_FILLE 
   (	ID VARCHAR2(50) NOT NULL ENABLE, 
	PRODUIT VARCHAR2(1500), 
	IDBC VARCHAR2(50), 
	QUANTITE NUMBER(10,2), 
	PU NUMBER(38,2), 
	QUANTITEPARPACK NUMBER(10,2), 
	MONTANT FLOAT(126), 
	REMARQUE VARCHAR2(500), 
	 PRIMARY KEY (ID)
   );

   CREATE SEQUENCE SEQAS_BONDECOMMANDE
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQAS_BONDECOMMANDE
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT SEQAS_BONDECOMMANDE.nextval INTO retour FROM dual;
  return retour;
END;
 
CREATE SEQUENCE SEQAS_BONDECOMMANDE_FILLE
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQAS_BONDECOMMANDE_FILLE
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT SEQAS_BONDECOMMANDE_FILLE.nextval INTO retour FROM dual;
  return retour;
END;


CREATE TABLE MODEPAIEMENT 
   (	ID VARCHAR2(20) NOT NULL ENABLE, 
	VAL VARCHAR2(20) DEFAULT '-', 
	DESCE VARCHAR2(100) DEFAULT '-', 
	 CONSTRAINT PK_MODEPAIEMENT PRIMARY KEY (ID)
   ) ;

CREATE  VIEW AS_BONDECOMMANDE_LIBELLE (ID, DATY, ETAT, REMARQUE, DESIGNATION, MODEPAIEMENT, FOURNISSEUR, TVA) AS 
  select bc.id, bc.daty, bc.etat, bc.remarque, bc.designation, mp.val as modepaiement, bc.fournisseur,
bc.tva from as_bondecommande bc join modepaiement mp on bc.modepaiement = mp.id;

CREATE  VIEW AS_BONDECOMMANDE_FILLE_LIBELLE (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, REMARQUE) AS 
  select bcf.id,ec.LIBELLE as produit, bcf.idbc, bcf.quantite, bcf.pu, bcf.quantiteparpack, bcf.remarque
from as_bondecommande_fille bcf 
join detailchantier prd on bcf.produit = prd.id
JOIN elementchantier ec ON ec.id=prd.idelement;

INSERT INTO MODEPAIEMENT
(ID, VAL, DESCE)
VALUES('pay1', 'espece', 'Payement espece');
INSERT INTO MODEPAIEMENT
(ID, VAL, DESCE)
VALUES('pay2', 'cheque', 'Payement par cheque');
INSERT INTO MODEPAIEMENT
(ID, VAL, DESCE)
VALUES('pay3', 'virement', 'Payement par virement');


CREATE OR REPLACE FORCE VIEW ETATFACTUREFOURNISSEUR (ID, DATY, IDFOURNISSEUR, TIERS, TVA, MONTANTTTC, REMARQUE, DATEEMISSION, DESIGNATION, DEVISE, NUMFACT, DATE_ECHEANCE, ETAT, MONTANTPAYE, RESTE, REMISE, TYPEE,AVOIR) AS 
  select distinct f.ID,
                f.DATY,
                f.IDFOURNISSEUR,
                f.tiers,
                f.TVA,
                cast(f.MONTANTTTC as NUMBER(10, 2))                               as MONTANTTTC,
                f.REMARQUE,
                f.DATEEMISSION,
                f.DESIGNATION,
                f.DEVISE,
                f.NUMFACT,
                f.DATE_ECHEANCE,
                f.ETAT,
                cast(nvl(op.montant, 0) as NUMBER(10, 2))                           as montantPaye,
                cast((f.montantTTC - nvl(op.montant, 0) - REMISE) as NUMBER(10, 2)) as reste,
                REMISE                                                              as remise,
                '' as typee,
                AV.MONTANT AS avoir
from FACTUREFOURNISSEURLETTRE1 f,
     ORDONNERPAYEMENTGROUPEFACT op,
     AVOIR   AV 
where f.ID = op.DED_ID(+)
		AND AV.IDFACTURE =F.ID;

CREATE OR REPLACE FORCE VIEW CEMEDI.DETAILSPRESCRIPTIONLIB (ID, IDMEDICAMENT, QUANTITE, POSOLOGIE, IDORDONNANCE, IDUSER, PRIX, MAGASIN, MEDICAMENT, ETAT,MONTANT) AS 
  SELECT LIB.id,
       LIB.idmedicament,
       LIB.quantite,
       LIB.posologie,
       LIB.idordonnance,
       LIB.iduser,
       LIB.prix,
       mb.VAL         as magasin,
       AR.OBSERVATION AS MEDICAMENT,
       LIB.etat,
       LIB.prix*lib.QUANTITE AS montant
FROM detailsprescription lib
         left JOIN MED_CONF_PRIX AR ON lib.IDMEDICAMENT = AR.ID
         left join MED_BRANCHE mb on mb.id = lib.magasin;

CREATE OR REPLACE VIEW AS_BONDECOMMANDE_FILLE_LIBELLE (ID, PRODUIT, IDBC, QUANTITE, PU, QUANTITEPARPACK, REMARQUE) AS 
  select bcf.id,ST.DESIGNATION as produit, bcf.idbc, bcf.quantite, bcf.pu, bcf.quantiteparpack, bcf.remarque
from as_bondecommande_fille bcf 
join ST_ARTICLE ST ON ST.ID=BCF.produit;

ALTER TABLE requete_recu_groupe ADD idrequeteAenvoyer VARCHAR2(100);

CREATE OR REPLACE FORCE VIEW CEMEDI.INVENTAIREDETAILSLIBINVENTCPS 
(ID, IDMERE, IDINGREDIENT, IDUSER, QUANTITER, EXPLICATION, ETAT, IDCATEGORIEINGREDIENT, DATY, IDING, UNITE, COMPOSE, IDCATING, MAGASIN, PU, PUGROS, PUDONATION, TYPEMAGASIN,SEUIL ) AS 
  select
           invdet.id,
           invDet.idmere as idmere,
           ing.DESIGNATION as idingredient,
           0 as idUser,
           invDet.quantiter,
           p.DESCE as explication,
           im.etat,
           TA.VAL as idcategorieingredient,
           im.DATY,
           invdet.idingredient as IDING,
           uni.val as unite,
           ing.SEUIL as  compose,
           ing.TYPE as IDCATING,
           p.id AS magasin,
           ing.SEUIL AS pu,
           ing.PUGROS AS pugros,
           ing.PUDONATION AS pudonation,
           p.TYPE AS typemagasin ,
           ING.SEUIL 
        from INVENTAIREDETAILS invDet
        left join ST_ARTICLE ing on ing.id=invDet.idingredient
        left join st_inventaire im on invDet.idmere=im.id
        join st_unite uni on ing.unite=uni.id
        LEFT join ST_MAGASIN  p on p.id=im.MAGASIN
        JOIN ST_TYPE_ARTICLE TA ON TA.ID=ING.TYPE
        where im.etat>=11;
        