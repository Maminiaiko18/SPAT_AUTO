-- auto-generated definition
create table BORDEREAUFF
(
    ID          VARCHAR2(100) not null
        constraint BORDEREAUFF_PK
            primary key,
    DATY        DATE,
    NUMERO      VARCHAR2(100),
    DESIGNATION VARCHAR2(4000),
    ETAT        NUMBER(10),
    TIERS       VARCHAR2(100)
)
/

CREATE SEQUENCE SEQBORDEREAUFF
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQBORDEREAUFF
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT SEQBORDEREAUFF.nextval INTO retour FROM dual;
  return retour;
END;



-- auto-generated definition
create table LIAISONBORDEREAUFF(
    ID          VARCHAR2(100) not null
        constraint LIAISONBORDEREAUFF_PK
            primary key,
    IDBORDEREAU VARCHAR2(100)
        constraint BORDEREAUFF_LIE_FK
            references BORDEREAUFF,
    IDOP        VARCHAR2(100)
        constraint FF_BORDEREAU_FK
            references FACTUREFOURNISSEUR
)
/

CREATE SEQUENCE SEQLIAISONBORDEREAUFF
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQBORDEREAUFF
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT SEQBORDEREAUFF.nextval INTO retour FROM dual;
  return retour;
END;

