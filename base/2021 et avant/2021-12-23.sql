create table typeclient
(
    id    varchar2(100)
        constraint typeclient_pk primary key,
    val   varchar2(500),
    desce varchar2(500)
);

CREATE SEQUENCE seqtypeclient
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqtypeclient
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqtypeclient.nextval INTO retour FROM dual;
  return retour;
END;


INSERT INTO SPAT_CAPITAINERIE.TYPECLIENT (ID, VAL, DESCE)
VALUES ('TC001', 'Partenaire', 'Partenaire');

INSERT INTO SPAT_CAPITAINERIE.TYPECLIENT (ID, VAL, DESCE)
VALUES ('TC002', 'Prestataire', 'Prestataire');

INSERT INTO SPAT_CAPITAINERIE.TYPECLIENT (ID, VAL, DESCE)
VALUES ('TC003', 'Concessionnaire', 'Concessionnaire');

commit;



alter table tiers   add cin varchar2(100) constraint unicin unique ;
alter table tiers   add cp varchar2(100);

update TIERS t set t.TYPE=(select e.id from TYPECLIENT e where lower(e.VAL)=lower(t.TYPE)) where id=id;


alter table tiers   add  constraint typefourn foreign key(TYPE) references TYPECLIENT;


create or replace view tiers_lib as
select t.ID,
       NOM,
       DESCRIPTION,
       NIF,
       STAT,
       CONTACT,
       RESPONSABLE,
       ADRESSE,
       tc.VAL as TYPE,
       ETAT,
       COMPTEAUXFOURNISSEUR,
       COMPTEAUXCLIENT,
       CIN,
       CP
from tiers t
    left join TYPECLIENT tc on t.TYPE = tc.ID;


  CREATE OR REPLACE VIEW FOURNISSEUR_UNION_PERSONNEL (ID, NOM, DESCRIPTION, NIF, STAT, CONTACT, RESPONSABLE, ADRESSE, TYPE, ETAT, COMPTEAUXFOURNISSEUR, COMPTEAUXCLIENT) AS
  SELECT tp.ID,
       tp.NOM,
       tp.DESCRIPTION,
       tp.NIF,
       tp.STAT,
       tp.CONTACT,
       '',
       tp.ADRESSE,
       tp.TYPE,
       tp.ETAT,
       tp.COMPTEAUXFOURNISSEUR,
       tp.COMPTEAUXCLIENT
FROM TIERS tp
UNION
SELECT an.SA_COMPTEURNUMERO       AS ID,
       an.NOM || ' ' || an.PRENOM AS nom,
       ''                         AS DESCRIPTION,
       ''                         AS NIF,
       ''                         AS STAT,
       an.TELEPHONE               AS CONTACT,
       ''                         AS RESPONSABLE,
       an.RUE1                    AS ADRESSE,
       '',
       11                         AS etat,
       ''                         as COMPTEAUXFOURNISSEUR,
       ''                         as COMPTEAUXCLIENT
FROM ANALYSEPERSONNELUNION an

union
select cl.cdclt    as ID,
       cl.nomclt   as nom,
       ''          AS DESCRIPTION,
       cl.nif      AS NIF,
       cl.nmsttclt AS STAT,
       cl.telclt   AS CONTACT,
       ''          AS RESPONSABLE,
       cl.adrclt   AS ADRESSE,
       cl.cdcat    as TYPE,
       11          AS etat,
       ''          as COMPTEAUXFOURNISSEUR,
       ''          as COMPTEAUXCLIENT
from V_CLIENT_CATEGORIE cl;



CREATE OR REPLACE VIEW FOURNISSEUR_UNION_PERSONNEL
            (ID, NOM, DESCRIPTION, NIF, STAT,
             CONTACT, RESPONSABLE, ADRESSE, TYPE, ETAT, COMPTEAUXFOURNISSEUR, COMPTEAUXCLIENT)
AS
SELECT tp.ID,
       tp.NOM,
       tp.DESCRIPTION,
       tp.NIF,
       tp.STAT,
       tp.CONTACT,
       '',
       tp.ADRESSE,
       tp.TYPE,
       tp.ETAT,
       tp.COMPTEAUXFOURNISSEUR,
       tp.COMPTEAUXCLIENT
FROM TIERS_LIB tp
UNION
SELECT an.SA_COMPTEURNUMERO       AS ID,
       an.NOM || ' ' || an.PRENOM AS nom,
       ''                         AS DESCRIPTION,
       ''                         AS NIF,
       ''                         AS STAT,
       an.TELEPHONE               AS CONTACT,
       ''                         AS RESPONSABLE,
       an.RUE1                    AS ADRESSE,
       '',
       11                         AS etat,
       ''                         as COMPTEAUXFOURNISSEUR,
       ''                         as COMPTEAUXCLIENT
FROM ANALYSEPERSONNELUNION an

union
select cl.cdclt    as ID,
       cl.nomclt   as nom,
       ''          AS DESCRIPTION,
       cl.nif      AS NIF,
       cl.nmsttclt AS STAT,
       cl.telclt   AS CONTACT,
       ''          AS RESPONSABLE,
       cl.adrclt   AS ADRESSE,
       cl.cdcat    as TYPE,
       11          AS etat,
       ''          as COMPTEAUXFOURNISSEUR,
       ''          as COMPTEAUXCLIENT
from V_CLIENT_CATEGORIE cl;

INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MENUDI00000123', 'Type client', 'fa fa-cog', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=typeclient', 16, 3, 'MEN00505');


create view client_union
            (CDCLT,
             CDCAT,
             NOMCLT,
             ADRCLT,
             NMSTTCLT,
             TELCLT,
             FAXCLT,
             NMCIN,
             NIF,
             RC,
             CATEGORIE)
as
select CDCLT,
       CDCAT,
       NOMCLT,
       ADRCLT,
       NMSTTCLT,
       TELCLT,
       FAXCLT,
       NMCIN,
       NIF,
       RC,
       CATEGORIE
from V_CLIENT_CATEGORIE
union
select ID ,
       '000' as  CDCAT,
       nom,
       adresse,
       '' NMSTTCLT,
       CONTACT,
       stat,
       cin,
       nif,
       cp,
       type as categorie
from tiers_lib;

