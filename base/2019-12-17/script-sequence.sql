CREATE SEQUENCE seqbanque
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 30
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqbanque
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqbanque.nextval INTO retour FROM dual;
  return retour;
END;