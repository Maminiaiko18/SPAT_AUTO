
create view  statistiqueRH as
    select TYPE,
count(*) as nombre from ANALYSE_PERSONNELMAT_ANALYSE
    group by type;

    create or replace view ANALYSE_PERSONNELMAT_ANALYSE as
(
select "SA_COMPTEURNUMERO",
       "NOM",
       "PRENOM",
       "SEXE",
       "SYNDICAT",
       "CADRE",
       "TYPE",
       "RUE1",
       "COMMUNE",
       "DATENAISSANCE",
       "MATRICULESALARIE",
       "TELEPHONE",
       "MODEDEPAIEMENT",
       "EMAIL",
       "EMPLOIOCCUPE",
       "QUALIFICATION",
       "NIVEAU",
       "INDICE",
       "CATEGORIE",
       "NUMSALARIE",
       "VALEURCUMUL",
       "NOMBRE",
       1 as effectif
from analyse_personnelmat);

alter table historiquesyndicat add date_fin date;

alter table Poste add rang number(10);

create table ElementChantier
(
    id              varchar2(50) not null
        constraint ElementChantier_pkey
            primary key,
    code            varchar2(50),
    libelle         varchar2(200),
    caracteristique varchar2(50),
    unite           varchar2(50),
    etat            number(10)
);

create table ElementChantier
(
    id              varchar2(50) not null
        constraint ElementChantier_pkey
            primary key,
    code            varchar2(50),
    libelle         varchar2(200),
    caracteristique varchar2(50),
    unite           varchar2(50),
    etat            number(10)
);

CREATE SEQUENCE seqElementChantier
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqElementChantier
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqElementChantier.nextval INTO retour FROM dual;
  return retour;
END;

 create table detailChantier
    (
        id varchar2(100) constraint detailchantier_pk primary key ,
        mere varchar2(100) constraint fk_chantier references CHANTIER,
        idelement varchar2(100) constraint fk_elementChantier references ElementChantier,
        qte number(10,2),
        pu number(10,2),
        etat number(10)
    );
CREATE SEQUENCE seqdetailChantier
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqdetailChantier
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqdetailChantier.nextval INTO retour FROM dual;
  return retour;
END;

create view chantierMontant as
select ch.ID,
       ch.IDTRAVAUX,
       ch.NOM,
       ch.DATYDEBUT,
       ch.DATYFIN,
       (select sum(dc.qte)*sum(dc.pu)from detailChantier dc where dc.etat>=11 and ch.id=dc.mere) as MONTANT,
       ch.AVANCEMENT,
       ch.IDTIERS,
       ch.ETAT
from chantier ch;


create table facturefournisseur
(
    id                   varchar2(50) not null
        constraint pk_facturefournisseur
            primary key,
    daty                 date,
    idfournisseur        varchar2(150)
        constraint facturefournisseurprestaire
            references tiers,
    idtva                number(10,2) default 0,
    montantttc           number(10,2),
    remarque             varchar2(4000)             default '-',
    dateemission         date,
    designation          varchar2(500),
    iddevise             varchar2(5),
    numfact              varchar2(100),
    resp                 varchar2(50)      default '-',
    datyecheance         date,
    etat                 number(10),
    idfacturefournisseur varchar2(50),
    budget               varchar2(100),
    montantdevise        number(10,2),
    exercice             number(10)
);


CREATE SEQUENCE seqfacturefournisseur
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqfacturefournisseur
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqfacturefournisseur.nextval INTO retour FROM dual;
    return retour;
END;


create table detailsfacturefournisseur
(
    id           varchar2(100) not null
        constraint ajoutdetailsfacture_pk
            primary key,
    idingredient varchar2(100),
    qte          number(10,2),
    pu           number(10,2),
    idmere       varchar2(100),
    compte       varchar2(100),
    pudevise     number(10,2),
    iddqe        varchar2(100),
    marge        varchar2(100)
);


CREATE SEQUENCE seqdetailsfacturefournisseur
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqdetailsfacturefourniss
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqdetailsfacturefournisseur.nextval INTO retour FROM dual;
    return retour;
END;

create or replace view PREVISION_STAT_ACTIVITE_LIB as
select
        distinct idprevision as id,
        NOMCLT as idclient,
        rubriqueprevision as rubrique,
        datyprevision as daty,
        cumulprevision as cumul
    from stat_activite_libcomplet
/
create view statistiquePatrimoine as
select IDTYPEPATRIMOINE,tp.VAL as patrimoine, count(*) as nombre, sum(montant) as montant
from PATRIMOINE p join TYPEPATRIMOINE tp on tp.ID=p.IDTYPEPATRIMOINE
group by idtypepatrimoine,tp.VAL;

create view HISTORIQUESYNDICATLIBCOMPLETE as
select
			histo.id as "IDHISTORIQUE",
			histo."IDSYNDICAT",
			histo."IDPOSTE",
			histo."IDPERSONNEL",
			histo."DATY",
			histo.etat as "ETATHISTORIQUE",
			s.nom as "NOMSYNDICAT",
			s.description as "DESCSYNDICAT",
			s.etat as "ETATSYNDICAT",
			poste.val as "VALPOSTE",
			poste.desce as "DESCEPOSTE",
			info.id,info.nom,info.prenom,info.datenaissance, info.civilite, info.matriculeSalarie, info.telephone, info.email,
            poste.RANG
		from
			HISTORIQUESYNDICAT histo
		join SYNDICAT s on histo.IDSYNDICAT = s.ID
		join POSTE poste on histo.IDPOSTE = poste.ID
		join v_union_personnel info on histo.IDPERSONNEL = info.ID
/
create or replace view HISTORIQUESYNDICATLIB as
select
        IDHISTORIQUE as id,
        NOMSYNDICAT as IDSYNDICAT,
        VALPOSTE as IDPOSTE,
        cast((nom || ' ' || prenom) as varchar2(500)) as IDPERSONNEL,
        daty,
        ETATHISTORIQUE as etat, RANG
    from historiquesyndicatlibcomplete
order by RANG desc
/

create table tva
(
    idtva          varchar2(100) not null
        constraint pk_tva
            primary key,
    valeurtva      number(10,2) default 0,
    datydebutvalid date
);

create  or replace view mouvementLibComplete as
select mvlb.ID,
       DATY,
       ESCALE,
       NAVIRE,
       CONSIGNATAIRE,
       DATEARRIVEE,
       HEURE,
       PROVENANCE,
       DESTINATION,
       REMARQUE,
       trunc(to_date(date_depart||' '||heure_depart,'dd-mm-yy hh24:mi:ss')) - trunc(to_date(dateArrivee||' '||heure,'dd-mm-yy hh24:mi:ss')) ||' jours' as DUREE,
       TYPEMVT,
       ETAT,
       CARGAISON,
       HEURE_DEPART,
       DATE_DEPART,
       VALMVT,
       DESCEMVT,
       VALCARGAISON,
       DESCECARGAISON,
       QUAIPROVENANCE,
       INTERNEPROVENANCE,
       PAYSPROVENANCE,
       VALQUAISPROVENANCE,
       DESCEQUAISPROVENANCE,
       TYPEQUAISPROVENANCE,
       TIRANTPROVENANCE,
       LONGUEURPROVENANCE,
       PROFONDEURPROVENANCE,
       VALPAYSPROVENANCE,
       DESCEPAYSPROVENANCE,
       QUAISDESTINATION,
       INTERNEDESTINATION,
       PAYSDESTINATION,
       VALQUAISDESTINATION,
       DESCEQUAISDESTINATION,
       TYPEQUAISDESTIANANTION,
       TIRANTDESTINATION,
       LONGUEURDESTINATION,
       PROFONDEURDESTINATION,
       VALPAYSDESTINATION,
       DESCEPAYSDESTINATION,
       REFERENCENAVIRE,
       NOMNAVIRE,
       PAVILLONNAVIRE,
       JNTNAVIRE,
       JBTNAVIRE,
       PLTNAVIRE,
       LHTNAVIRE,
       LMNAVIRE,
       TENAVIRE,
       VOLUMENAVIRE,
       REMARQUENAVIRE,
       ETATNAVIRE,
       VALCONSIGNATAIRE,
       DESCECONSIGNATAIRE,
       VALTYPEQUAISPROVENANCE,
       DESCETYPEQUAISPROVENANCE,
       VALTYPEQUAISDESTINATION,
       DESCETYPEQUAISDESTINATION
from mouvementLibComplet mvlb;

create or replace view MouvementlibDepartArrivee as
select* from mouvementLibComplete where TYPEMVT in('TPMM00003','TPMM00004');

create table devise
(
    id    varchar2(120) not null
        constraint pk_devise
            primary key,
    val   varchar2(130) default '-',
    desce varchar2(100) default '-'
);

create or replace view statistiquePatrimoine as
select tp.id as IDTYPEPATRIMOINE, tp.VAL as patrimoine, count(tp.ID) as nombre, nvl(sum(montant),0) as montant
from PATRIMOINE p
        right join TYPEPATRIMOINE tp on tp.ID = p.IDTYPEPATRIMOINE
group by idtypepatrimoine, tp.VAL,tp.id;

create table AS_BONDELIVRAISON_FILLE
(
    ID                          VARCHAR2(100) not null
        constraint AS_BONDELIVRAISON_FILLEPK
            primary key,
    PRODUIT                     VARCHAR2(100)
        constraint PRODUITFILLE_FK
            references ElementChantier,
    NUMBL                       VARCHAR2(100)
        constraint NONFILLE_FK
            references AS_BONDELIVRAISON,
    QUANTITE                    NUMBER(10, 2),
    QUANTITEPARPACK             NUMBER(10, 2),
    IDDETAILSFACTUREFOURNISSEUR VARCHAR2(100)
        constraint DETAILSBONDELIVRAISON_FK
            references DETAILSFACTUREFOURNISSEUR
)
;

create view AS_BONDELIVRAISON_FILLE_LIB as
select bcf.id, prd.libelle as produit, bcf.numbl, bcf.quantite,  bcf.quantiteparpack ,bcf.iddetailsfacturefournisseur
from as_bondelivraison_fille bcf join ElementChantier prd on bcf.produit = prd.id
;
create view DETAILSFFBONLIVRAISON as
select
    Detfac.id,
    Detfac.QTE,
    Detfac.pu,
    Detfac.IDMERE,
    Detfac.COMPTE,
       Detfac.IDINGREDIENT,
    NVL((select sum(bonF.quantite) from AS_BONDELIVRAISON_fille bonF join as_bondelivraison bon  on bon.id=bonF.NUMBL where etat=11 and bonF.iddetailsfacturefournisseur=Detfac.id group by iddetailsfacturefournisseur),0) as livre,
    QTE- NVL((select sum(bonF.quantite)from AS_BONDELIVRAISON_fille bonF join as_bondelivraison bon  on bon.id=bonF.NUMBL where etat=11 and bonF.iddetailsfacturefournisseur=Detfac.id group by iddetailsfacturefournisseur),0) as reste
    from detailsfacturefournisseur Detfac
/

create view DETAILSFFBONLIVRAISONLIB as
select
    dl.id,
    dl.QTE,
    dl.pu,
    dl.IDMERE,
    dl.COMPTE,
    i.LIBELLE as IDINGREDIENT,
    dl.livre,
    dl.reste
    from
        Detailsffbonlivraison dl
    join ElementChantier i on i.id=dl.IDINGREDIENT
/

create view DETAILSFFBONLIVRAISONID as
select
dts."ID",dts."QTE",dts."PU",dts."IDMERE",dts."COMPTE",dts."IDINGREDIENT",dts."LIVRE",dts."RESTE",
f.quantite,
(dts.reste-f.quantite) as restelivre,
f.id as idblfille,
f.numbl as idblmere
from
detailsffbonlivraisonlib dts join
AS_BONDELIVRAISON_FILLE f on dts.id=f.iddetailsfacturefournisseur
/

create view DETAILSFFBONLIVRAISONID as
select
dts."ID",dts."QTE",dts."PU",dts."IDMERE",dts."COMPTE",dts."IDINGREDIENT",dts."LIVRE",dts."RESTE",
f.quantite,
(dts.reste-f.quantite) as restelivre,
f.id as idblfille,
f.numbl as idblmere
from
detailsffbonlivraisonlib dts join
AS_BONDELIVRAISON_FILLE f on dts.id=f.iddetailsfacturefournisseur
/
create view detailschantierlibelle as
select dc.*,
       ec.libelle as libellechantier,
       ec.caracteristique ,
       c.NOM as nom
from DetailChantier dc
         left join elementChantier ec on ec.ID=dc.idelement
         left join Chantier c on c.ID=dc.mere;

         create or replace view detailschantierlibelle as
select dc.*,
       ec.libelle as libellechantier,
       ec.caracteristique ,
       ec.unite,
       c.NOM as nom
from DetailChantier dc
         left join elementChantier ec on ec.ID=dc.idelement
         left join Chantier c on c.ID=dc.mere;

create or replace view CHANTIERLIB as
select id,
       NOMTRAVAUX as idtravaux,
       nom,
       DATYDEBUT,
       DATYFIN,
       MONTANT,
       AVANCEMENT,
       idtiers,
       ETAT
from CHANTIERLIBCOMPLET
/

INSERT INTO tva (idtva, valeurtva, datydebutvalid) VALUES ('tva0001', 20, to_date('2020-10-05 00:00:00','yyyy-mm-dd hh24:mi:ss' ));
INSERT INTO tva (idtva, valeurtva, datydebutvalid) VALUES ('tva0002', 18, to_date('2020-10-05','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tva (idtva, valeurtva, datydebutvalid) VALUES ('C', 0, to_date('2020-10-30','yyyy-mm-dd hh24:mi:ss'));

create table unitechantier
(
    id    varchar2(50) not null
        constraint unite_pkey
            primary key,
    val   varchar2(100),
    desce varchar2(100)
);

INSERT INTO unitechantier (id, val, desce) VALUES ('UN0001', 'FFT', 'Forfaitaire');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0002', 'HxM', 'Homme mois');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0003', 'KG', 'Kilogrammme');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0004', 'KM', 'Kilomètre');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0005', 'KM*M', 'Kilomètre mois');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0006', 'L', 'Linéaire');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0007', 'M', 'Mètre');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0008', 'M2', 'Mètre carre');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0009', 'M3', 'Mètre cube');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0010', 'ML', 'Mètre linéaire');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0011', 'T', 'Tonne');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0012', 'U', 'Unité');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0013', 'DM3', 'Décimètre cube');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0014', 'MOIS', 'Mois');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0015', 'BAR*M', 'Barrière mois');
INSERT INTO unitechantier (id, val, desce) VALUES ('UN0016', 'JxM', 'Jour mois');
create table AS_BONDECOMMANDE
(
    ID           VARCHAR2(50) not null
        primary key,
    DATY         DATE,
    ETAT         NUMBER,
    REMARQUE     VARCHAR2(500),
    DESIGNATION  VARCHAR2(500),
    MODEPAIEMENT VARCHAR2(50),
    FOURNISSEUR  VARCHAR2(50),
    TVA          NUMBER
);
create table AS_BONDECOMMANDE_FILLE
(
    ID              VARCHAR2(50) not null
        primary key,
    PRODUIT         VARCHAR2(1500),
    IDBC            VARCHAR2(50),
    QUANTITE        NUMBER(10, 2),
    PU              NUMBER(38, 2),
    QUANTITEPARPACK NUMBER(10, 2),
    MONTANT         FLOAT,
    REMARQUE        VARCHAR2(500)
);

create view facturefournisseurmontant
            (id, daty, idfournisseur, idtva, montantttc, remarque, dateemission, designation, iddevise, numfact, resp,
             datyecheance, etat, idfacturefournisseur, budget)
as
SELECT ff.id,
       ff.daty,
       ff.idfournisseur,
       ff.idtva,
       COALESCE((SELECT sum(detailsfacturefournisseur.pu * detailsfacturefournisseur.qte) +
                        ff.idtva * sum(detailsfacturefournisseur.pu * detailsfacturefournisseur.qte) /
                        100
                 FROM detailsfacturefournisseur
                 WHERE ff.id = detailsfacturefournisseur.idmere), 0) AS montantttc,
       ff.remarque,
       ff.dateemission,
       ff.designation,
       ff.iddevise,
       ff.numfact,
       ff.resp,
       ff.datyecheance,
       ff.etat,
       ff.idfacturefournisseur,
       ff.budget
FROM facturefournisseur ff;

create view facturefournisseurlettremtt
            (id, daty, idfournisseur, idtva, montantttc, remarque, dateemission, designation, iddevise, numfact,
             datyecheance, entite, etat, budget)
as
SELECT ff.id,
       ff.daty,
       ff.idfournisseur AS idfournisseur,
       ff.idtva,
       ff.montantttc,
       ff.remarque,
       ff.dateemission,
       ff.designation,
       ff.iddevise,
       ff.numfact,
       ff.datyecheance,
       ''                                       AS entite,
       CASE
           WHEN ff.etat = 1 THEN 'CREER'
           WHEN ff.etat = 11 THEN 'VALIDER'
           ELSE 'AUTRE'
           END                                  AS etat,
       ff.budget
FROM facturefournisseurmontant ff
         LEFT JOIN TIERS c ON c.id = ff.idfournisseur;

create table ordonnerpayement
(
    id       varchar2(50) not null
        constraint pk_ordonnerpayement
            primary key,
    ded_id   varchar2(50),
    idligne  varchar2(50),
    daty     date,
    montant  number(10,2),
    remarque varchar2(250),
    etat     number(10)
);
create view ordonnerpayementgroupefact(id, ded_id, daty, montant, remarque, etat) as
SELECT '-'             AS id,
       op.ded_id,
       max(op.daty)    AS daty,
       sum(op.montant) AS montant,
       '-'             AS remarque,
       op.etat
FROM ordonnerpayement op
WHERE op.etat >= 11
GROUP BY op.ded_id, op.etat;

create view etatfacturemontant
            (id, daty, idfournisseur, idtva, montantttc, remarque, dateemission, designation, iddevise, numfact,
             datyecheance, etat, montantpaye, reste, entite, nomfournisseur)
as
SELECT f.id,
       f.daty,
       f.idfournisseur,
       f.idtva,
       f.montantttc,
       f.remarque,
       f.dateemission,
       f.designation,
       f.iddevise,
       f.numfact,
       f.datyecheance,
       f.etat,
       COALESCE(op.montant, 0)                AS montantpaye,
       f.montantttc - COALESCE(op.montant, 0) AS reste,
       f.entite,
       f.designation                                            AS nomfournisseur
FROM facturefournisseurlettremtt f
         LEFT JOIN ordonnerpayementgroupefact op ON f.id = op.ded_id;

create table mvtcaisse
(
    id            varchar2(50) not null
        constraint mvtcaisse_pk
            primary key,
    daty          date        not null,
    designation   varchar2(1500),
    debit         number(10,2),
    credit        number(10,2),
    iddevise      varchar2(50),
    idmode        varchar2(50),
    idcaisse      varchar2(50),
    remarque      varchar2(100),
    tiers         varchar2(50),
    numpiece      varchar2(50),
    typemvt       varchar2(50)
        constraint fk_mvtcaiss_reference_typemvt
            references typemvt,
    datyvaleur    date,
    idordre       varchar2(50),
    numcheque     varchar2(50),
    etat          number(10)default 1,
    agence        varchar2(50),
    idmvtor       varchar2(50),
    etablissement varchar2(50)
);

create view etatfacturemontantdatyretenu
            (id, daty, idfournisseur, nomfournisseur, idtva, montantttc, remarque, dateemission, designation, iddevise,
             numfact, datyecheance, etat, montantpaye, reste, entite, montantttdevise, budget, retenue, montant)
as
SELECT DISTINCT efm.id,
                efm.daty,
                efm.idfournisseur,
                t.nom                                                                   AS nomfournisseur,
                efm.idtva,
                efm.montantttc,
                null                                                         AS remarque,
                efm.dateemission,
                efm.designation,
                efm.iddevise,
                efm.numfact,
                efm.datyecheance,
                efm.etat,
                COALESCE(mv.debit, 0)                                 AS montantpaye,
                COALESCE(efm.reste, 0)                                AS reste,
                ''                                                               AS entite,
                dff.montantttc                                                          AS montantttdevise,
                ''                                                           AS budget,
                0 AS retenue,
               0 AS montant
FROM etatfacturemontant efm
         JOIN facturefournisseur dff ON dff.id = efm.id
         LEFT JOIN tiers t ON dff.idfournisseur= t.id
       --  LEFT JOIN budget_depense bd ON dff.budget = bd.id
        -- JOIN marcheetat m ON dff.remarque = m.id
         LEFT JOIN ordonnerpayement op ON op.ded_id = dff.id
         LEFT JOIN mvtcaisse mv ON mv.idordre= op.id;

create view etatfacturemontantdaty
            (id, daty, idfournisseur, nomfournisseur, idtva, montantttc, remarque, dateemission, designation, iddevise,
             numfact, datyecheance, etat, montantpaye, reste, entite, montantttdevise, budget, retenue, montant)
as
SELECT et.id,
       et.daty,
       et.idfournisseur,
       et.nomfournisseur,
       et.idtva,
       et.montantttc,
       et.remarque,
       et.dateemission,
       et.designation,
       et.iddevise,
       et.numfact,
       et.datyecheance,
       CASE
           WHEN et.etat = 'VALIDER' THEN '11'
           WHEN et.etat = 'CREER' THEN '1'
           ELSE '0'
           END               AS etat,
       et.montantpaye,
       et.reste - et.retenue AS reste,
       et.entite,
       et.montantttdevise,
       et.budget,
       et.retenue,
       et.montant
FROM etatfacturemontantdatyretenu et;

create table MODEPAIEMENT
(
    ID    VARCHAR2(20) not null
        constraint PK_MODEPAIEMENT
            primary key,
    VAL   VARCHAR2(20)  default '-',
    DESCE VARCHAR2(100) default '-'
);

create view AS_BONDECOMMANDE_LIBELLE as
select bc.id, bc.daty, bc.etat, bc.remarque, bc.designation, mp.val as modepaiement, bc.fournisseur,
bc.tva from as_bondecommande bc join modepaiement mp on bc.modepaiement = mp.id
/

CREATE SEQUENCE seqas_bondecommande
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqas_bondecommande
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqas_bondecommande.nextval INTO retour FROM dual;
    return retour;
END;

    CREATE SEQUENCE seqas_bondecommandefille
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqas_bondecommandefille
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqas_bondecommandefille.nextval INTO retour FROM dual;
    return retour;
END;
create or replace view CHANTIERLIB as
select id,
       NOMTRAVAUX as idtravaux,
       nom,
       DATYDEBUT,
       DATYFIN,
       MONTANT,
       AVANCEMENT,
       NOMTIERS as idtiers,
       ETAT
from CHANTIERLIBCOMPLET
/

create  view facturefournisseurlib as
select ff.id,
       daty,
       idfournisseur,
       idtva,
       montantttc,
       ch.nom  as remarque,
       dateemission,
       designation,
       iddevise,
       numfact,
       resp,
       datyecheance,
       ff.etat,
       ff.idfacturefournisseur,
       budget,
       montantdevise,
       exercice

from facturefournisseur ff
         join chantier ch on ch.id = ff.remarque;

         create or replace view facturefournisseurlib as
select ff.id,
       daty,
       t.NOM as idfournisseur,
       idtva,
       montantttc,
       ch.nom as remarque,
       dateemission,
       designation,
       iddevise,
       numfact,
       resp,
       datyecheance,
       ff.etat,
       ff.idfacturefournisseur,
       budget,
       montantdevise,
       exercice

from facturefournisseur ff
         join chantier ch on ch.id = ff.remarque
        left join tiers t on t.id=ff.idfournisseur;

create view details_facture_reste_qtechant as
select df.id,
       df.idingredient,
       df.qte as qteff,
       d.qte-(select sum(qte)from detailsfacturefournisseur group by idmere) as qte,
       df.pu,
       df.idmere,
       df.compte,
       df.pudevise,
       df.iddqe,
       df.marge,
       d.libellechantier,
       d.qte as qtechantier,
       d.pu as puchantier
from detailsfacturefournisseur df
    left join detailschantierlibelle d on d.id=df.idingredient;

    create or replace view etatfacturemontantdaty
            (id, daty, idfournisseur, nomfournisseur, idtva, montantttc, remarque, dateemission, designation, iddevise,
             numfact, datyecheance, etat, montantpaye, reste, entite, montantttdevise, budget, retenue, montant,tierslib)
as
SELECT et.id,
       et.daty,
       et.idfournisseur,
       et.nomfournisseur,
       et.idtva,
       et.montantttc,
       et.remarque,
       et.dateemission,
       et.designation,
       et.iddevise,
       et.numfact,
       et.datyecheance,
       CASE
           WHEN et.etat = 'VALIDER' THEN '11'
           WHEN et.etat = 'CREER' THEN '1'
           ELSE '0'
           END               AS etat,
       et.montantpaye,
       et.reste - et.retenue AS reste,
       et.entite,
       et.montantttdevise,
       et.budget,
       et.retenue,
       et.montant,
       t.NOM as tierslib
FROM etatfacturemontantdatyretenu et
        left join TIERS t on t.id=et.idfournisseur;

create or replace view details_facture_reste_qtechant as
select df.id,
       df.idingredient,
       df.qte as qteff,
       d.qte-(select sum(qte)from detailsfacturefournisseur group by idmere) as qte,
       df.pu,
       df.idmere,
       df.compte,
       df.pudevise,
       df.iddqe,
       df.marge,
       d.mere as idchantier,
       d.libellechantier,
       d.qte as qtechantier,
       d.pu as puchantier
from detailsfacturefournisseur df
    left join detailschantierlibelle d on d.id=df.idingredient;

    create  view facturefournisseurlibelle as
select ff.id,
       daty,
       idfournisseur,
       t.NOM as fournisseur,
       idtva,
       montantttc,
       remarque as idchantier,
       ch.nom as remarque,
       dateemission,
       designation,
       iddevise,
       numfact,
       resp,
       datyecheance,
       ff.etat,
       ff.idfacturefournisseur,
       budget,
       montantdevise,
       exercice

from facturefournisseur ff
         join chantier ch on ch.id = ff.remarque
        left join tiers t on t.id=ff.idfournisseur;

 create or replace view detailschantierlibelle as
select dc.*,
       ec.libelle as libellechantier,
       ec.caracteristique ,
       ec.unite,
       c.NOM as nom
from DetailChantier dc
         left join elementChantier ec on ec.ID=dc.idelement
         left join Chantier c on c.ID=dc.mere;

         create view personneletsyndicat as
select psi.*,
       s.id as idsyndicat
from personnelsageinfopers psi
         join HISTORIQUESYNDICAT hs on hs.IDPERSONNEL = psi.ID
         left join SYNDICAT s on s.id = hs.IDSYNDICAT;