CREATE SEQUENCE seqas_LiaisonDetailsBCProduit
MINVALUE 1
MAXVALUE 999999999999999999999999999
START WITH 1
INCREMENT BY 1
CACHE 20;

create or replace FUNCTION getseqas_LiaisonDetailsBCProd
RETURN NUMBER IS
retour NUMBER;
BEGIN
SELECT seqas_LiaisonDetailsBCProduit.nextval INTO retour FROM dual;
return retour;
END;