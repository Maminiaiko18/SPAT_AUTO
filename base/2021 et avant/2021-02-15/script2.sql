CREATE SEQUENCE seqbccommande
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 66
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqbccommande
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqbccommande.nextval INTO retour FROM dual;
  return retour;
END;