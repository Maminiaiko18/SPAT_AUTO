create table regulFCProvision(
    id varchar2(100) constraint pk_regulFCProvision primary key ,
    idprovision varchar2(100) constraint fk_factprov_regulFCProvision references FACTURECLIENT(id),
    idfacture varchar2(100) constraint fk_facture_regulFCProvision references FACTURECLIENT(id),
    etat number(10)
);

CREATE SEQUENCE seq_regulFCProvision
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_regulFCProvision
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_regulFCProvision.nextval INTO retour FROM dual;
    return retour;
END;



create view regulFCProvisionlib as
select r.*,
       f2.code as idprovisioncode,
       f.CODE  as idfacturecode,
       case
           when r.etat = 1 then 'CREE'
           when r.etat >= 11 then 'VISE'
           end as etatlib
from regulFCProvision r
         left join FACTURECLIENT F on r.IDFACTURE = F.ID
         left join FACTURECLIENT F2 on r.IDPROVISION = F2.ID;




create table PaiementFactureF (
    id varchar2(100) constraint pk_PaiementFactureF primary key ,
    idMvt varchar2(50) constraint fk_PaieFactureF_journcaisse references JOURNALCAISSE(id),
    idFact varchar2(50) constraint fk_PaieFactureF_factfourn references FACTUREFOURNISSEUR(id),
    montant number(30,3)
);

CREATE SEQUENCE seq_PaiementFactureF
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_PaiementFactureF
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_PaiementFactureF.nextval INTO retour FROM dual;
    return retour;
END;


create view PaiementFactureF_grp as
select IDFACT, sum(montant) as montant from PAIEMENTFACTUREF group by IDFACT;


