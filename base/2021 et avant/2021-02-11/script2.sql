create table tarifRubriqueFactureClient
(
    id           varchar2(100)
        constraint tarifRubriqueFactureClient_pk primary key,
    borne_inf    number(10),
    borne_sup    number(10),
    prixUnitaire number(10, 2),
    iddevise     varchar2(100)
        constraint tarifRuFactureC_devise_fk references DEVISE,
    idNature     varchar2(100)
        constraint tarifRuFactureC_nature_fk references NATUREOPERATION,
    unite        number(10)
        ,
    etat number(10)
);
CREATE SEQUENCE seqtarifrubriquefactureCl
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION getseqtarifrubriquefactureCl
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seqtarifrubriquefactureCl.nextval INTO retour FROM dual;
    return retour;
END;

create or replace view tarifRubriqueFactureClient_lib as
select trfc.id,
       trfc.borne_inf,
       trfc.borne_sup,
       trfc.prixUnitaire,
       dev.VAL as iddevise,
       nat.VAL as idNature,
       trfc.unite,
       trfc.etat
from tarifRubriqueFactureClient trfc
         join DEVISE dev on dev.ID = trfc.iddevise
         join NATUREOPERATION nat on nat.ID = trfc.idNature;

create or replace view tarifRubriqueFactureClientcree
as
select *
from tarifRubriqueFactureClient_lib
where etat = 1;

create or replace view tarifRubriqueFactureClientvise
as
select *
from tarifRubriqueFactureClient_lib
where etat = 11;