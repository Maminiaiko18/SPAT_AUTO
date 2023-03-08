CREATE SEQUENCE seq_bordereau
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seq_bordereau
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_bordereau.nextval INTO retour FROM dual;
    return retour;
END;
/


CREATE SEQUENCE seq_liaisonbordereau
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seq_liaisonbordereau
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_liaisonbordereau.nextval INTO retour FROM dual;
  return retour;
END;