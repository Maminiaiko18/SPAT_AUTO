create table as_bondelivraison_cl
(
    id varchar2(100) constraint as_bondelivraison_cl_pk primary key ,
        idbc varchar2(100) constraint fk_factureclient_bc_cli references FACTURECLIENT,
        remarque varchar2(4000),
        daty date,
        point varchar2(500),
        etat number(10)
);

CREATE SEQUENCE seqas_bondelivraison_cl
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqas_bondelivraison_cl
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqas_bondelivraison_cl.nextval INTO retour FROM dual;
  return retour;
END;


    create table as_bondelivraison_cl_fille
    (
        id varchar2(500) constraint as_bondelivraison_cl_fille_pk primary key ,
            produit varchar2(500) ,
            numbl varchar2(500),
            quantite number(10,2),
            iddetailsfacturefournisseur varchar2(100) constraint fk_facture_client_fille references FACTURE_CLIENT_FILLE
    );
	CREATE SEQUENCE seqasbondelivraison_cl_fille
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

  create or replace FUNCTION get_seqasbondelivraisonclfille
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqasbondelivraison_cl_fille.nextval INTO retour FROM dual;
  return retour;
END;