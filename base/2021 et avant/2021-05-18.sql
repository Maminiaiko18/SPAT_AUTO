create table as_bondelivraison_cl
(
    id varchar2(100) constraint as_bondelivraison_cl_pk primary key ,
        idbc varchar2(100) constraint fk_factureclient_bc_cli references FACTURECLIENT,
        remarque varchar2(4000),
        daty date,
        point varchar2(500),
        etat number(10)
);

CREATE SEQUENCE seqas_bondelivraison_cl
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqas_bondelivraison_cl
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqas_bondelivraison_cl.nextval INTO retour FROM dual;
  return retour;
END;


    create table as_bondelivraison_cl_fille
    (
        id varchar2(500) constraint as_bondelivraison_cl_fille_pk primary key ,
            produit varchar2(500) ,
            numbl varchar2(500),
            quantite number(10,2),
            iddetailsfacturefournisseur varchar2(100) constraint fk_facture_client_fille references FACTURE_CLIENT_FILLE
    );
	CREATE SEQUENCE seqasbondelivraison_cl_fille
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

  create or replace FUNCTION get_seqasbondelivraisonclfille
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqasbondelivraison_cl_fille.nextval INTO retour FROM dual;
  return retour;
END;

create table facture_prof_mere
(
    ID            VARCHAR2(500) not null
        constraint facture_prof_mere_PK
            primary key,
    DATY          DATE,
    TIERS         VARCHAR2(500),
    DESIGNATION   VARCHAR2(4000),
    TYPE          VARCHAR2(500),
    TVA           NUMBER(10, 2),
    REMARQUE      VARCHAR2(500),
    IDUSER        VARCHAR2(500),
    DATE_ECHEANCE DATE,
    ETAT          NUMBER(10)
)
/




CREATE SEQUENCE seqfacture_prof_fille
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqfacture_prof_fille
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqfacture_prof_fille.nextval INTO retour FROM dual;
  return retour;
END;

CREATE SEQUENCE seqfacture_prof_mere
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;
  
 create or replace FUNCTION get_seqfacture_prof_mere
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqfacture_prof_mere.nextval INTO retour FROM dual;
  return retour;
END;

create table CategorieFacturation
(
    id    varchar2(100)
        constraint CategorieFacturation_pk primary key,
    val   varchar2(500),
    desce varchar2(500)
);

create table redevance
(
    id    varchar2(100)
        constraint redevance_pk primary key,
    val   varchar2(500),
    desce varchar2(500)
);


create table unite_activite
(
    id    varchar2(100)
        constraint unite_activite_pk primary key,
    val   varchar2(500),
    desce varchar2(500)
);



create table facture_prof_fille 
(
    ID          VARCHAR2(500) not null
        constraint facture_prof_fille_PK
            primary key,
    IDMERE      VARCHAR2(500)
        constraint MERE_FILLE_prof_FK
            references facture_prof_mere,
    DESIGNATION VARCHAR2(4000),
    QUANTITE    NUMBER(10, 2),
    PU          NUMBER(30, 2),
    COMPTE      VARCHAR2(500),
    IDPRODUIT   VARCHAR2(500)
        constraint facture_prof_mereproduit_FK
            references AS_PRODUITS,
    DEVISE      VARCHAR2(500)
        constraint DEVISE_FCprof_FK
            references DEVISE,
    TAUX        NUMBER(10, 2)
)
/

create or replace view as_bondelivraison_cl_FM as
select fc.*,
       f.IDBC,
       f.REMARQUE,
       f.DATY,
       f.POINT,
       f.ETAT
from AS_BONDELIVRAISON_CL_FILLE fc
    left join AS_BONDELIVRAISON_CL f on f.ID=fc.NUMBL;

create or replace view as_bondelivraison_cl_grp as
select bl.IDDETAILSFACTUREFOURNISSEUR,
       sum(QUANTITE) as quantite
from AS_BONDELIVRAISON_CL_FM bl
where ETAT>=11
group by bl.IDDETAILSFACTUREFOURNISSEUR;

create or replace view facture_client_fille_lib_reste
as
select fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM as IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       cast(nvl(gr.QUANTITE, 0) as number(10,2)) as qteLivree,
           cast(fc.QUANTITE-nvl(gr.QUANTITE, 0) as number(10,2)) as resteAlivrer
from facture_client_fille fc
         left join AS_PRODUITS pr on pr.ID = fc.IDPRODUIT
         left join as_bondelivraison_cl_grp gr on gr.IDDETAILSFACTUREFOURNISSEUR=fc.ID;

create OR REPLACE view FACTURE_CLIENT_PROFMERE_FILLE as
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
from facture_prof_fille fi
         left join facture_prof_mere fc on fi.IDMERE = fc.id
/

create OR REPLACE view FACTURE_CLIENT_PROFMONTANT as
select fm.ID,
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
       cast(fm.pu * fm.quantite as number(30, 2))                 as Montant,
       cast((fm.pu * fm.quantite) * fm.taux as NUMBER(30, 2))     as montanttaux,
       cast(0 as NUMBER(30,2))                                   as montantavoirsanstaux,
       cast(0 as number(30, 2)) as montantavoiravectaux
from FACTURE_CLIENT_PROFMERE_FILLE fm
/

create OR REPLACE view FACTURE_CLIENT_PROFGRP as
select sum(fm.MONTANT) as montant,
       sum(fm.montanttaux) as montanttaux,
       sum(fm.MONTANTAVOIRSANSTAUX)as MONTANTAVOIRSANSTAUX,
       sum(fm.montantavoiravectaux)as montantavoiravectaux,
       fm.idmere
from FACTURE_CLIENT_PROFMONTANT fm
group by fm.idmere
/

create OR REPLACE view FACTURECLIENPROFTMSUM as
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
       cast(nvl(grp.montanttaux, 0) as number(30, 2))                  as montant,
       cast(nvl((grp.montanttaux * fc.TVA) / 100, 0) as number(30, 2)) as montanttva,
       nvl(grp.montantavoiravectaux, 0)                                as montantavoir,
       cast(nvl(((grp.montanttaux * fc.TVA) / 100) + grp.montanttaux, 0) -
            nvl(grp.montantavoiravectaux, 0) as number(30, 2))         AS MONTANTTTC

from facture_prof_mere fc
         left join FACTURE_CLIENT_PROFGRP grp on grp.idmere = fc.id
/

CREATE OR REPLACE VIEW factureprofMSum_lib  (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, TIERSLIB) AS
  select m.ID,
       m.DATY,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       m.REMARQUE,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.MONTANT,
       M.MONTANTTVA,
       M.MONTANTAVOIR,
       M.MONTANTTTC,
       fup.NOM as tierslib
from FACTURECLIENPROFTMSUM m
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = m.tiers;


CREATE OR REPLACE VIEW factureprofMSum_libC AS
SELECT *
FROM factureprofMSum_lib WHERE ETAT=1;

CREATE OR REPLACE VIEW factureprofMSum_libV AS
SELECT *
FROM factureprofMSum_lib WHERE ETAT=11;

CREATE OR REPLACE VIEW factureprofMSum_libA AS
SELECT *
FROM factureprofMSum_lib WHERE ETAT=0;

INSERT INTO CATEGORIEFACTURATION (ID, VAL, DESCE) VALUES ('CATFC001', 'Capitainerie', 'Capitainerie');

INSERT INTO CATEGORIEFACTURATION (ID, VAL, DESCE) VALUES ('CATFC002', 'Conteneur', 'Conteneur');

INSERT INTO CATEGORIEFACTURATION (ID, VAL, DESCE) VALUES ('CATFC003', 'Hydrocarbure', 'Hydrocarbure');

INSERT INTO CATEGORIEFACTURATION (ID, VAL, DESCE) VALUES ('CATFC004', 'Conventionnel', 'Conventionnel');

INSERT INTO CATEGORIEFACTURATION (ID, VAL, DESCE) VALUES ('CATFC005', 'Loyer', 'Loyer');

INSERT INTO CATEGORIEFACTURATION (ID, VAL, DESCE) VALUES ('CATFC006', 'Droit de port', 'Droit de port');

INSERT INTO CATEGORIEFACTURATION (ID, VAL, DESCE) VALUES ('CATFC007', 'Droit communale', 'Droit communale');

INSERT INTO CATEGORIEFACTURATION (ID, VAL, DESCE) VALUES ('CATFC008', 'Autre', 'Autre');

 INSERT INTO REDEVANCE (ID, VAL, DESCE) VALUES ('REDV001', 'fixe', 'fixe');

 INSERT INTO REDEVANCE (ID, VAL, DESCE) VALUES ('REDV002', 'variable', 'variable');

 INSERT INTO REDEVANCE (ID, VAL, DESCE) VALUES ('REDV003', 'normale', 'normale');

INSERT INTO UNITE_ACTIVITE (ID, VAL, DESCE) VALUES ('UA001', 'unité', 'unité');
INSERT INTO UNITE_ACTIVITE (ID, VAL, DESCE) VALUES ('UA002', 'heure', 'heure');

create table RUBRIQUE_ACTIVITE
(
    ID          VARCHAR2(100) not null
        constraint RUBRIQUE_ACTIVITE_PK
            primary key,
    DESIGNATION VARCHAR2(1000),
    CODE        VARCHAR2(500),
    CATEGORIE   VARCHAR2(100)
        constraint FK_CATEGORIEFACTURATION
            references CATEGORIEFACTURATION,
    REDEVANCE   VARCHAR2(100)
        constraint FK_REDEVANCE_RUBRIQUE
            references REDEVANCE,
    PU          NUMBER(30, 2),
    DEVISE      VARCHAR2(100)
        constraint FK_DEVISE_RUBRIQUE
            references DEVISE,
    COMPTE      VARCHAR2(100),
    UNITE       VARCHAR2(100)
        constraint FK_UNITE_ACTIVITE_RUBRIQUE
            references UNITE_ACTIVITE,
    OBJET       VARCHAR2(500),
    TVA         NUMBER(10, 2),
    DIRECTION   VARCHAR2(100)
        constraint FK_DIRECTION_RUBRIQUE
            references DIRECTION,
    CONDITION   VARCHAR2(100)
)
/

CREATE SEQUENCE seqrubrique_activite
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqrubrique_activite
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqrubrique_activite.nextval INTO retour FROM dual;
  return retour;
END;
create table detFormuFact
(
    id varchar2(100)
        constraint detFormuFact_pk primary key,
    min number(10),
       formule varchar2(500),
        unite varchar2(100) constraint fk_unite_activite_det references UNITE_ACTIVITE,
        rem varchar2(1000),
        mere varchar2(100) constraint fk_rubrique_activite_det references RUBRIQUE_ACTIVITE,
        condition varchar2(100)
);

CREATE SEQUENCE seqdetFormuFact
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;



create or replace FUNCTION get_seqdetFormuFact
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqdetFormuFact.nextval INTO retour FROM dual;
  return retour;
END;

create or replace view rubrique_activitelib
as
select ra.ID,
       ra.DESIGNATION,
       ra.CODE,
       c2.VAL as CATEGORIE,
       ra.REDEVANCE,
       ra.PU,
       de.VAL as DEVISE,
       ra.COMPTE,
       ua.VAL as UNITE,
       ra.OBJET,
       ra.TVA,
       d.LIBELLEDIR as DIRECTION,
       ra.CONDITION
from rubrique_activite ra
    left join CATEGORIEFACTURATION C2 on ra.CATEGORIE = C2.ID
    left join REDEVANCE r on r.ID=ra.REDEVANCE
    left join DEVISE de on de.ID=ra.DEVISE
    left join UNITE_ACTIVITE ua on ua.ID=ra.UNITE
    left join DIRECTION d on d.IDDIR=ra.DIRECTION;

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00068412', 'Facture proforma', 'fa fa-list', '#', 5, 3, 'MEN00068');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0006841201', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=facture/facture-proforma-saisie.jsp', 1, 4, 'MEN00068412');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0006841202', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=facture/facture-proforma-liste.jsp', 2, 4, 'MEN00068412');

create or replace view detFormuFactlib as
select fc.ID,
       fc.MIN,
       fc.FORMULE,
       ua.VAL as UNITE,
       fc.REM,
       fc.MERE,
       fc.CONDITION
from detFormuFact fc
         left join UNITE_ACTIVITE ua on ua.id = fc.UNITE;

create table activite
(
    id          varchar2(100)
        constraint activite_pk primary key,
    designation varchar2(1000),
    client      varchar2(500),
    rubrique    varchar2(100)
        constraint fk_rubrique_activite references RUBRIQUE_ACTIVITE,
    qte         number(10, 2),
    mois        number(10),
    annee       number(10),
    daty        date,
    bateau      varchar2(100)
        constraint fk_navire_activite_rub references NAVIRE
);

CREATE SEQUENCE seqactivite
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;


create or replace FUNCTION get_seqactivite
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqactivite.nextval INTO retour FROM dual;
  return retour;
END;

create table edition_facture_vide
(
    client    varchar2(500),
    categorie varchar2(500),
    mois      number(10),
    annee     number(10),
    redevance varchar2(500)
);

create or replace view facture_prof_fille_0 as
select fp.*,
       cast(0 as NUMBER(30,2)) as montant
from facture_prof_fille fp;

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00300', 'Rubriques', 'fa fa-list', '#', 1, 2, 'MEN0002');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENF00301', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=exploitants/rubrique-saisie.jsp', 1, 3, 'MEN00300');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENF00302', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=exploitants/rubrique-liste.jsp', 2, 3, 'MEN00300');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENF00303', 'Catégorie', 'fa fa-wrench', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp'||'&'||'ciblename=categoriefacturation', 6, 3, 'MENM01');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENF00304', 'Redevance', 'fa fa-wrench', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp'||'&'||'ciblename=redevance', 7, 3, 'MENM01');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENF00305', 'Unité', 'fa fa-wrench', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp'||'&'||'ciblename=unite_activite', 8, 3, 'MENM01');



create or replace view activitelibcomplet as
select ac.*,
       ra.DESIGNATION as rubriquelib,
       nv.NOM as bateaulib
from ACTIVITE ac
    left join RUBRIQUE_ACTIVITE ra on ra.id=ac.RUBRIQUE
    left join NAVIRE nv on nv.ID=ac.BATEAU;
	
create or replace view as_bondelivraison_cl_libelle as 
select cl.*,
       f.DESIGNATION as designationfacture
from as_bondelivraison_cl cl
    left join FACTURECLIENT F on cl.IDBC = F.ID;

	create or replace view as_bondelivraison_cl_Fille_lib as
select cl.*,
       pr.NOM as produitlib
from as_bondelivraison_cl_fille cl
    left join AS_PRODUITS pr on pr.id=cl.PRODUIT;
	
UPDATE MENUDYNAMIQUE
SET HREF='/spat/pages/globalnegoce.jsp?but=facture/analyse-facture-client-vaovao.jsp' WHERE ID='MEN000683';


create or replace view as_bondelivraison_cl_pdt as
select fi.*,
       cast('' as varchar2(400)) as pdt
from as_bondelivraison_cl_fille fi;

create or replace view RUBRIQUE_ACTIVITELIB as
select ra.ID,
       ra.DESIGNATION,
       ra.CODE,
       c2.VAL as CATEGORIE,
       r.VAL as REDEVANCE,
       ra.PU,
       de.VAL as DEVISE,
       ra.COMPTE,
       ua.VAL as UNITE,
       ra.OBJET,
       ra.TVA,
       d.LIBELLEDIR as DIRECTION,
       ra.CONDITION
from rubrique_activite ra
    left join CATEGORIEFACTURATION C2 on ra.CATEGORIE = C2.ID
    left join REDEVANCE r on r.ID=ra.REDEVANCE
    left join DEVISE de on de.ID=ra.DEVISE
    left join UNITE_ACTIVITE ua on ua.ID=ra.UNITE
    left join DIRECTION d on d.IDDIR=ra.DIRECTION
/

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0074100', 'Activité', 'fa fa-pie-chart', '#', 1, 2, 'MEN0002');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00741001', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but= exploitants/activites-saisie.jsp', 1, 3, 'MEN0074100');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00741002', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but= exploitants/activites-liste.jsp', 2, 3, 'MEN0074100');

UPDATE MENUDYNAMIQUE SET RANG=4 WHERE ID='MEN00144';
UPDATE MENUDYNAMIQUE SET RANG=5 WHERE ID='MEN00150';
UPDATE MENUDYNAMIQUE SET  RANG=6 WHERE ID='MENM01';

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0074100', 'Activité', 'fa fa-pie-chart', '#', 2, 2, 'MEN0002');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00741001', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=exploitants/activites-saisie.jsp', 1, 3, 'MEN0074100');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00741002', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=exploitants/activites-liste.jsp', 2, 3, 'MEN0074100');



create or replace view FACTURE_CLIENT_FILLE_LIB_RESTE as
select fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM as IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       cast(nvl(gr.QUANTITE, 0) as number(10,2)) as qteLivree,
           cast(fc.QUANTITE-nvl(gr.QUANTITE, 0) as number(10,2)) as resteAlivrer,
       fcm.MONTANTTAUX,
       fcm.MONTANT,
       fcm.MONTANTAVOIRSANSTAUX,
       fcm.MONTANTAVOIRAVECTAUX
from facture_client_fille fc
         left join AS_PRODUITS pr on pr.ID = fc.IDPRODUIT
         left join as_bondelivraison_cl_grp gr on gr.IDDETAILSFACTUREFOURNISSEUR=fc.ID
         left join FACTURE_CLIENT_MONTANT fcm on fcm.id=fc.id
/


create or replace view ACTIVITELIBCOMPLET as
select ac.*,
       ra.DESIGNATION as rubriquelib,
       nv.NOM         as bateaulib,
       nv.PLT as poids,
       nv.LHT as  longueur,
       nv.LM as largeur,
       cast('-' as varchar2(100)) as autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM as clientlib
from ACTIVITE ac
         left join RUBRIQUE_ACTIVITE ra on ra.id = ac.RUBRIQUE
         left join NAVIRE nv on nv.ID = ac.BATEAU
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id=ac.CLIENT
/



alter table EDITION_FACTURE_VIDE add id varchar2(100) constraint EDITION_FACTURE_VIDE_PK primary key ;
alter table ACTIVITE add etat number(10);


create or replace view ACTIVITELIBCOMPLET as
select ac.*,
       ra.DESIGNATION as rubriquelib,
       nv.NOM         as bateaulib,
       nv.PLT as poids,
       nv.LHT as  longueur,
       nv.LM as largeur,
       cast('-' as varchar2(100)) as autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM as clientlib,
       ra.DESIGNATION as redevancelib,
       di.LIBELLEDIR as directionlib
from ACTIVITE ac
         left join RUBRIQUE_ACTIVITE ra on ra.id = ac.RUBRIQUE
         left join NAVIRE nv on nv.ID = ac.BATEAU
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id=ac.CLIENT
          left join REDEVANCE re on re.id=ra.REDEVANCE
         left join direction di on di.IDDIRECTEUR =ra.DIRECTION
/

create or replace view ACTIVITELIBCOMPLET as
select ac.*,
       ra.DESIGNATION as rubriquelib,
       nv.NOM         as bateaulib,
       nv.PLT as poids,
       nv.LHT as  longueur,
       nv.LM as largeur,
       cast('-' as varchar2(100)) as autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM as clientlib,
       ra.DESIGNATION as redevancelib
      -- di.LIBELLEDIR as directionlib
from ACTIVITE ac
         left join RUBRIQUE_ACTIVITE ra on ra.id = ac.RUBRIQUE
         left join NAVIRE nv on nv.ID = ac.BATEAU
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id=ac.CLIENT
          left join REDEVANCE re on re.id=ra.REDEVANCE
         left join direction di on cast(di.IDDIRECTEUR as varchar2(100)) =cast(ra.DIRECTION as varchar2(100))
/

create or replace view ACTIVITELIBCOMPLET as
select ac.*,
       ra.DESIGNATION as rubriquelib,
       nv.NOM         as bateaulib,
       nv.PLT as poids,
       nv.LHT as  longueur,
       nv.LM as largeur,
       cast('-' as varchar2(100)) as autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM as clientlib,
       ra.DESIGNATION as redevancelib,
       di.LIBELLEDIR as directionlib
from ACTIVITE ac
         left join RUBRIQUE_ACTIVITE ra on ra.id = ac.RUBRIQUE
         left join NAVIRE nv on nv.ID = ac.BATEAU
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id=ac.CLIENT
          left join REDEVANCE re on re.id=ra.REDEVANCE
         left join direction di on cast(di.IDDIRECTEUR as varchar2(100)) =cast(ra.DIRECTION as varchar2(100))
/


