
CREATE SEQUENCE seq_analyse_lien
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;
  
create or replace FUNCTION getseqanalyselien
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_analyse_lien.nextval INTO retour FROM dual;
  return retour;
END;