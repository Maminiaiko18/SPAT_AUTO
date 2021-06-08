create table ligneCreditRecette
(
    id          varchar2(200)
        constraint ligneCreditRecette_pk primary key,
    designation varchar2(4000),
    quantite    number(20, 2),
    montant     number(30, 2),
    annee       number(10),
    compte      varchar2(100),
    etat        number(10)
);

CREATE SEQUENCE seqligneCreditRecette
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;
  
  create or replace FUNCTION get_seqligneCreditRecette
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqligneCreditRecette.nextval INTO retour FROM dual;
  return retour;
END;

create table ligneCreditDepense
(
    id          varchar2(200)
        constraint ligneCreditDepense_pk primary key,
    designation varchar2(4000),
    quantite    number(20, 2),
    montant     number(30, 2),
    annee       number(10),
    compte      varchar2(100),
    etat        number(10)
);

CREATE SEQUENCE seqligneCreditDepense
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;
  
  create or replace FUNCTION get_seqligneCreditDepense
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqligneCreditDepense.nextval INTO retour FROM dual;
  return retour;
END;

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENBDG0001', 'Budget', 'fa fa-line-chart', '#', 7, 1, NULL);

INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMEN0001', '1060', 'MENBDG0001', 'dg', NULL, NULL, 0);

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENBDG00011', 'Ligne crédit recette', 'fa fa-money', '#', 1, 2, 'MENBDG0001');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENBDG00021', 'Ligne crédit dépense', 'fa fa-money', '#', 2, 2, 'MENBDG0001');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENBDG000111', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=ligneCredit/saisie-ligneCreditRecette.jsp', 1, 3, 'MENBDG00011');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENBDG000112', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=ligneCredit/situation-ligneCreditRecette.jsp', 2, 3, 'MENBDG00011');


INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENBDG000211', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=ligneCredit/saisie-ligneCreditDepense.jsp', 1, 3, 'MENBDG00021');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENBDG000212', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=ligneCredit/situation-ligneCreditDepense.jsp', 2, 3, 'MENBDG00021');

alter table activite add refobjet varchar(50);
alter table activite add typeSource varchar(50);
alter table activite add  dateFact date;

alter table activite drop constraint FK_NAVIRE_ACTIVITE_RUB;
update activite set bateau=null; --manadio données
alter table activite modify bateau  varchar2(100) constraint FK_NAVIRE_PREVISION references prevision(id);