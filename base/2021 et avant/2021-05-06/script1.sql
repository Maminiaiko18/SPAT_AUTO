CREATE SEQUENCE seqnumerobordereauFF
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqnumerobordereauFF
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqnumerobordereauFF.nextval INTO retour FROM dual;
  return retour;
END;