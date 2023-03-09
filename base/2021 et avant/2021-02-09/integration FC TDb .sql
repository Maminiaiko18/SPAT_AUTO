create table rubriqueFactureFournisseur
(
    id          varchar2(100)
        constraint rubriqueFactureFournisseur_pk primary key,
    designation varchar2(500),
    Montant     number(25, 2),
    duree       number(10),
    compte      varchar2(500)
);
CREATE SEQUENCE seqrubriqueFactureFournisseur
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqrubriqueFactureFourniss
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqrubriqueFactureFournisseur.nextval INTO retour FROM dual;
  return retour;
END;

    create table TypeLingeCredit
    (
        id varchar2(100) constraint TypeLingeCredit_pk primary key ,
            val varchar2(500),
            desce varchar2(500)
    );

CREATE SEQUENCE seqTypeLingeCredit
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqTypeLingeCredit
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqTypeLingeCredit.nextval INTO retour FROM dual;
    return retour;
END;



create table LIGNECREDIT
(
    id            varchar2(100)
        constraint lignecredit_pk primary key,
    designation   varchar2(500),
    creditInitial number(10, 2),
    compte        varchar2(500),
    annee         number(10),
    mois          number(10),
    idTypeLingeCredit varchar2(100) constraint  lignecredit_fk_linge references TYPELINGECREDIT
);

CREATE SEQUENCE seqLIGNECREDIT
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqLIGNECREDIT
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqLIGNECREDIT.nextval INTO retour FROM dual;
    return retour;
END;

 INSERT INTO TYPELINGECREDIT (ID, VAL, DESCE) VALUES ('TPL0001', 'recette', 'recette');
 INSERT INTO TYPELINGECREDIT (ID, VAL, DESCE) VALUES ('TPL0002', 'depense', 'depense');


 create view LIGNECREDIT_LIB AS
select lc.id,
       lc.designation,
       lc.creditInitial,
       lc.compte,
       lc.annee,
       lc.mois,
       tl.val as idTypeLingeCredit
from LIGNECREDIT lc
        join TYPELINGECREDIT tl on tl.ID=lc.idTypeLingeCredit;

create view LIGNECREDIT_LIBCOMPLET AS
select lc.id,
       lc.designation,
       lc.creditInitial,
       lc.compte,
       lc.annee,
       lc.mois,
       LC.idTypeLingeCredit,
       tl.val as idTypeLingeCreditLIB

from LIGNECREDIT lc
        join TYPELINGECREDIT tl on tl.ID=lc.idTypeLingeCredit;