create table AS_SOUSCATEGORIE
(
    ID    VARCHAR2(50) not null
        primary key,
    VAL   VARCHAR2(100),
    DESCE VARCHAR2(100)
);
create table CATEGORIEINGREDIENT
(
    ID    VARCHAR2(100) not null
        primary key,
    VAL   VARCHAR2(100),
    DESCE VARCHAR2(100),
    CDG   VARCHAR2(200),
    CCG   VARCHAR2(200),
    CDA   VARCHAR2(200),
    CCA   VARCHAR2(200)
);
create table AS_PRODUITS
(
    ID                  VARCHAR2(50) not null
        primary key,
    NOM                 VARCHAR2(500),
    DESIGNATION         VARCHAR2(1000),
    PHOTO               VARCHAR2(200),
    CALORIE             VARCHAR2(500),
    POIDS               NUMBER(10, 2),
    PA                  VARCHAR2(500),
    IDINGREDIENT        VARCHAR2(1000),
    IDSOUSCATEGORIE     VARCHAR2(50)
        constraint FK_SOUSCATEGORIE_PRODUIT
            references AS_SOUSCATEGORIE,
    NUMEROPLAT          NUMBER,
    PRIXL               NUMBER(10, 2),
    POIDSPRECUIT        NUMBER(10, 2),
    CATEGORIEINGREDIENT VARCHAR2(100)
        references CATEGORIEINGREDIENT,
    CDG                 VARCHAR2(200),
    CCG                 VARCHAR2(200),
    CDA                 VARCHAR2(200),
    CCA                 VARCHAR2(200)
);

CREATE TABLE liaisonDetailsBCProduit (
	id varchar2(100) CONSTRAINT liaisonDetBCProduit_pk PRIMARY KEY,
	idDetailsBC varchar2(100) CONSTRAINT detailbc_fk  REFERENCES AS_BONDECOMMANDE,
	idProduit varchar2(100) CONSTRAINT produit_fk  REFERENCES AS_PRODUITS
);

CREATE SEQUENCE seqAS_SOUSCATEGORIE
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqAS_SOUSCATEGORIE
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqas_bondecommande.nextval INTO retour FROM dual;
    return retour;
END;

CREATE SEQUENCE seqCATEGORIEINGREDIENT
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;
create or replace FUNCTION getseqCATEGORIEINGREDIENT
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqas_bondecommande.nextval INTO retour FROM dual;
    return retour;
END;

CREATE SEQUENCE seqAS_PRODUITS
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqAS_PRODUITS
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqas_bondecommande.nextval INTO retour FROM dual;
    return retour;
END;


CREATE OR REPLACE FORCE VIEW MOUVEMENTLIBCOMPLET as
select
            mvt.ID,
            mvt.daty,
            mvt.ESCALE,
            mvt.NAVIRE,
            mvt.CONSIGNATAIRE,
            mvt.DATEARRIVEE,
            mvt.heure,
            mvt.PROVENANCE,
            mvt.DESTINATION,
            mvt.REMARQUE,
            mvt.DUREE,
            mvt.TYPEMVT,
            mvt.etat,
            mvt.CARGAISON,
            mvt.HEURE_DEPART,
            mvt.DATE_DEPART,
            tm.VAL as valmvt,
            tm.desce as descemvt,
            car.VAL as valcargaison,
            car.desce as descecargaison,
            pro.QUAI as quaiprovenance,
            pro.INTERNE as interneprovenance,
            q.PAYS as paysprovenance,
            q.val as valquaisprovenance,
            q.DESCE as descequaisprovenance,
            q.TYPEQUAIS as typequaisprovenance,
            q.TIRANT as tirantprovenance,
            q.LONGUEUR as longueurprovenance,
            q.PROFONDEUR as profondeurprovenance,
            p.VAL as valpaysprovenance,
            p.DESCE as descepaysprovenance,
            des.QUAI as quaisdestination,
            des.INTERNE as internedestination,
            q1.PAYS as paysdestination,
            q1.VAL as valquaisdestination,
            q1.DESCE as descequaisdestination,
            q1.TYPEQUAIS as typequaisdestianantion,
            q1.TIRANT as tirantdestination,
            q1.LONGUEUR as longueurdestination,
            q1.PROFONDEUR as profondeurdestination,
            p1.VAL as valpaysdestination,
            p1.DESCE as descepaysdestination,
            na.REFERENCE as referencenavire,
            na.NOM as nomnavire,
            na.PAVILLON as pavillonnavire,
            na.JNT as jntnavire,
            na.JBT as jbtnavire,
            na.PLT as pltnavire,
            na.LHT as lhtnavire,
            na.LM as lmnavire,
            na.TE as tenavire,
            na.VOLUME as volumenavire,
            na.REMARQUE as remarquenavire,
            na.ETAT as etatnavire,
            cons.VAL as valconsignataire,
            cons.DESCE as desceconsignataire,
            t.VAL as valtypequaisprovenance,
            t.DESCE as descetypequaisprovenance,
            t2.val as valtypequaisdestination,
            t2.DESCE as descetypequaisdestination
        from MOUVEMENT mvt
        left join  NAVIRE na on na.ID=MVT.NAVIRE
        left join CONSIGNATAIRETAB cons on cons.ID =mvt.CONSIGNATAIRE
        left join POSTEDESTINATAIRE pro on pro.id=mvt.PROVENANCE
        left join POSTEDESTINATAIRE des on des.id=mvt.DESTINATION
        left join TYPEMVT tm on  tm.id=mvt.TYPEMVT
        left join CARGAISON car on car.id=mvt.CARGAISON
        left join quais q on q.id=pro.QUAI
        left join pays p on p.id=q.PAYS
        left join  quais q1 on q1.id=des.QUAI
        left join pays p1 on p1.id=q1.PAYS
        left JOIN TYPEQUAIS T on q.TYPEQUAIS = T.ID
        left JOIN TYPEQUAIS T2 ON T2.ID=Q1.TYPEQUAIS;



CREATE TABLE TYPE_CONTRAT (
	 id varchar2(100) CONSTRAINT TYPE_CONTRAT_pk PRIMARY KEY,
	 val  varchar2(100),
	 desce  varchar2(100)
);

INSERT INTO TYPE_CONTRAT (ID,VAL,DESCE) VALUES ('TC00001','CDI','CDI');
INSERT INTO TYPE_CONTRAT (ID,VAL,DESCE) VALUES ('TC00002','CDD','CDD');


-- Auto-generated SQL script #202012071200
UPDATE INFOPERSONNELGLOBAL x
	SET x.TYPE_CONTRAT='TC00001'
	WHERE x.ID='IPG000021';
UPDATE INFOPERSONNELGLOBAL x
	SET x.TYPE_CONTRAT='TC00001'
	WHERE x.ID='IPG000041';
UPDATE INFOPERSONNELGLOBAL x
	SET x.TYPE_CONTRAT='TC00002'
	WHERE x.ID='IPG000061';
UPDATE INFOPERSONNELGLOBAL x
	SET x.TYPE_CONTRAT='TC00001'
	WHERE x.ID='IPG000121';
UPDATE INFOPERSONNELGLOBAL x
	SET x.TYPE_CONTRAT='TC00001'
	WHERE x.ID='IPG000082';
UPDATE INFOPERSONNELGLOBAL x
	SET x.TYPE_CONTRAT='TC00002'
	WHERE x.ID='IPG000124';
UPDATE INFOPERSONNELGLOBAL x
	SET x.TYPE_CONTRAT='TC00002'
	WHERE x.ID='IPG000122';
UPDATE INFOPERSONNELGLOBAL x
	SET x.TYPE_CONTRAT='TC00001'
	WHERE x.ID='IPG000123';
UPDATE INFOPERSONNELGLOBAL x
	SET x.TYPE_CONTRAT='TC00001'
	WHERE x.ID='IPG000141';
UPDATE INFOPERSONNELGLOBAL x
	SET x.TYPE_CONTRAT='TC00002'
	WHERE x.ID='IPG000142';
UPDATE INFOPERSONNELGLOBAL x
	SET x.TYPE_CONTRAT='TC00002'
	WHERE x.ID='IPG000143';
UPDATE INFOPERSONNELGLOBAL x
	SET x.TYPE_CONTRAT='TC00002'
	WHERE x.ID='IPG000144';

ALTER TABLE INFOPERSONNELGLOBAL ADD CONSTRAINT type_fk FOREIGN KEY (TYPE_CONTRAT) REFERENCES TYPE_CONTRAT (id);

CREATE OR REPLACE
VIEW INFOPERSONNELGLOBAL_union AS
SELECT
	i.ID AS SA_COMPTEURNUMERO,
	i.NOM AS NOM ,
	i.PRENOM AS PRENOM ,
CASE
		WHEN i.GENRE = 'M' THEN 'Masculin'
		ELSE 'Feminin'
	END AS SEXE,
	'' AS SYNDICAT,
	'' AS CADRE,
CASE
		WHEN t.ID = 'TC00001' THEN 'Permanent'
		WHEN t.ID = 'TC00002' THEN 'Temporaire'
		ELSE 'Autres'
	END AS "TYPE",
	i.ADRESSE AS RUE1,
	CAST ('' AS varchar2(100)) AS COMMUNE,
	i.DATENAISSANCE AS DATENAISSANCE,
	CAST ('' AS varchar2(100)) AS MATRICULESALARIE,
	i.TELEPHONE AS TELEPHONE,
	0 AS MODEDEPAIEMENT,
	i.MAIL AS EMAIL,
	CAST (i.POSTE AS CHAR(50)) AS EMPLOIOCCUPE,
	'' AS QUALIFICATION,
	'' AS NIVEAU,
	CAST (i.INDICE AS CHAR(50)) AS INDICE,
	CAST ('' AS varchar2(100)) AS CATEGORIE,
	0 AS NUMSALARIE,
	0 AS VALEURCUMUL,
	1 AS NOMBRE,
    1 AS EFFECTIF
FROM
	INFOPERSONNELGLOBAL i
JOIN TYPE_CONTRAT t ON
	i.TYPE_CONTRAT = t.ID ;


CREATE OR REPLACE
VIEW ANALYSE_PERSONNELMAT_UNION AS
SELECT
	CAST (SA_COMPTEURNUMERO AS varchar2(100)) AS SA_COMPTEURNUMERO,
	NOM,
	PRENOM,
	SEXE,
	SYNDICAT,
	CADRE,
	"TYPE",
	RUE1,
	COMMUNE,
	DATENAISSANCE,
	MATRICULESALARIE,
	TELEPHONE,
	MODEDEPAIEMENT,
	EMAIL,
	EMPLOIOCCUPE,
	QUALIFICATION,
	NIVEAU,
	INDICE,
	CATEGORIE,
	NUMSALARIE,
	VALEURCUMUL,
	NOMBRE,
	1 AS EFFECTIF
FROM
	ANALYSE_PERSONNELMAT;

CREATE OR REPLACE VIEW analysePersonnelUnion AS
SELECT
	ap.*
FROM
	ANALYSE_PERSONNELMAT_UNION ap
UNION
SELECT
	i.*
FROM
	INFOPERSONNELGLOBAL_UNION i ;

--- CHANTIER

CREATE OR REPLACE FORCE VIEW "CHANTIER_LIB_NOM" AS 
  select id,
        idtravaux,
       nom,
       DATYDEBUT,
       DATYFIN,
      cast(MONTANT as number(30,2)) as montant,
       nvl((select max(pourcentage) from POURCENTAGEPROJET p where p.IDCHANTIER=cc.id group by IDCHANTIER),0)AVANCEMENT,
       NOMTIERS ,
       idtiers,
       NOMTRAVAUX,
       ETAT
from CHANTIERLIBCOMPLET cc;

CREATE VIEW CHANTIER_LIB_NOM_CREE AS
SELECT
	*
FROM
	CHANTIER_LIB_NOM
WHERE
	etat = 1;

CREATE VIEW CHANTIER_LIB_NOM_VALIDE AS
SELECT
	*
FROM
	CHANTIER_LIB_NOM
WHERE
	etat = 11;

CREATE OR REPLACE VIEW DETAILSFACTUREFOURNISSEUR_MT AS
SELECT
	DETAILSFACTUREFOURNISSEUR.*,
	CAST (0 AS number(10,2)) AS montant
FROM
	DETAILSFACTUREFOURNISSEUR;

ALTER TABLE previsionmaterielnaval ADD idArrivee VARCHAR2(200) CONSTRAINT mouvement_fk REFERENCES MOUVEMENT;


create OR REPLACE view AS_BONDELIVRAISON_F_GROUPER as
select sum(QUANTITE) as qtelivre, IDBONDECOMMANDE
from AS_BONDELIVRAISON_FILLE blf,
AS_BONDELIVRAISON bl
where blf.NUMBL = bl.ID
and bl.ETAT >= 11
group by IDBONDECOMMANDE;


CREATE or replace VIEW BC_BL_LIVRE AS
SELECT BCF.*,
CAST(NVL(BFG.qtelivre, 0) AS NUMBER(25,2)) as quantitelivre,
CAST(BCF.QUANTITE - NVL(BFG.qtelivre, 0) AS NUMBER(25,2)) AS quantitereste
FROM AS_BONDECOMMANDE_FILLE BCF
LEFT JOIN AS_BONDELIVRAISON_F_GROUPER BFG ON BFG.IDBONDECOMMANDE = BCF.ID;

