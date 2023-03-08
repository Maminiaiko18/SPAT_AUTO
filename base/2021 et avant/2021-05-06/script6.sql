create table annee (
    id varchar2(100) constraint annee_pk primary key ,
    val varchar2(500),
    desce varchar2(500)
);
INSERT INTO ANNEE (ID, VAL, DESCE) VALUES ('1', '2021', '2021');


CREATE SEQUENCE seqnumerobordereau
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqnumerobordereau
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqnumerobordereau.nextval INTO retour FROM dual;
  return retour;
END;
