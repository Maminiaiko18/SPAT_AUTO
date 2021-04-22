------------------------ SPAT_CAPITAINERIE ------------------------

create table occupantpatrimoine(
    id varchar2(100),
    idpatrimoine varchar2(100),
    idoccupant varchar2(100),
    debutcontrat date,
    fincontrat date,
    montant number(10,2),
    iddevise varchar2(100),
    datechange date,
    courschange number(10,2),
    constraint PK_OCCUPATIONPATRIMOINE primary key (id),
    constraint FK_PATRIMOINEOCCUPPATR foreign key (idpatrimoine) references PATRIMOINE(id)
);

CREATE SEQUENCE seqoccupantpatrimoine
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETSEQoccupantpatrimoine
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqoccupantpatrimoine.nextval INTO retour FROM dual;
  return retour;
END;

alter table PATRIMOINE add valeur number(10,2);