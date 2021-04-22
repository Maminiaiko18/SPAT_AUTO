UPDATE MENUDYNAMIQUE t SET t.ID_PERE = 'MEN0005a' WHERE t.ID LIKE 'MEN00187' ;
UPDATE MENUDYNAMIQUE t SET t.ID_PERE = 'MD00000001a' WHERE t.ID LIKE 'MD00000005' ;
UPDATE MENUDYNAMIQUE t SET t.LIBELLE = 'Tiers' WHERE t.ID LIKE 'MD00000002' ;

INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00505', 'Configurations', 'fa fa-cog', null, 6, 2, 'MEN0006');
UPDATE MENUDYNAMIQUE t SET t.RANG = 1, t.ID_PERE = 'MEN00505' WHERE t.ID LIKE 'MEN00215' ;



create or replace view TRAVAUX_TIERSLIBCOMPLET as
select tlib."ID",
       tlib."NOM",
       tlib."DATEDEBUT",
       tlib."DATEFIN",
       tlib."MONTANT",
       tlib."AVANCEMENT",
       tlib."DESCRIPTION",
       tlib."ETAT",
       tlib."IDTYPETRAVAUX",
       tlib."VALTYPETRAVAUX",
       tlib."DESCETYPETRAVAUX",
       tt.ID             as idtravauxtiers,
       tt.MONTANT        as montanttravauxtiers,
       tt.DESCRIPTION    as descriptiontravauxtiers,
       tiers.NOM         as nomtiers,
       tiers.DESCRIPTION as descriptiontiers,
       tiers.NIF,
       tiers.STAT,
       tiers.CONTACT,
       tiers.RESPONSABLE,
       tiers.ADRESSE     as adressetiers,
       tiers.TYPE        as typetiers,
       tiers.ETAT        as etattiers
from TRAVAUXLIBCOMPLET tlib
         join TRAVAUX_TIERS tt on tlib.ID = tt.IDTRAVAUX
         join tiers tiers on tt.IDTIERS = tiers.ID order by DATEDEBUT desc;


create view pourcentageProjet_cpl as
select pp.ID,
       pp.IDCHANTIER,
       pp.DATY,
       pp.POURCENTAGE,
       pp.OBSERVATION,
       pp.IDUTILISATEUR,
       pp.ETAT,
       ch.NOM as idchantierlib,
       ut.NOMUSER as utilisateurlib

from POURCENTAGEPROJET pp
        left join CHANTIER ch on ch.id=pp.IDCHANTIER
        left  join UTILISATEUR ut on ut.REFUSER = pp.IDUTILISATEUR;


create or replace view CHANTIERLIBCOMPLET as
select
        ch."ID",ch."IDTRAVAUX",ch."NOM",ch."DATYDEBUT",ch."DATYFIN",ch."MONTANT",ch."AVANCEMENT",ch."IDTIERS",ch."ETAT",
        tiers.NOM as nomtiers, tiers.DESCRIPTION desctiers, tiers.NIF, tiers.STAT, tiers.CONTACT, tiers.RESPONSABLE, tiers.ADRESSE, tiers.TYPE, tiers.ETAT as etattiers,
        tlib.NOM as nomtravaux, tlib.DATEDEBUT as datedebuttravaux, tlib.DATEFIN as datefintravaux, tlib.MONTANT as montanttravaux, tlib.AVANCEMENT as avancementtravaux, tlib.DESCRIPTION as desctravaux, tlib.ETAT as etattravaux, tlib.IDTYPETRAVAUX, tlib.VALTYPETRAVAUX, tlib.DESCETYPETRAVAUX
    from chantier ch
        left join tiers tiers on ch.IDTIERS = tiers.ID
        left join TRAVAUXLIBCOMPLET tlib on tlib.id = ch.IDTRAVAUX;
create or replace view CHANTIERLIBELLE as
select id,
       NOMTRAVAUX as idtravaux,
       nom,
       DATYDEBUT,
       DATYFIN,
       MONTANT,
       nvl((select sum(pourcentage) from POURCENTAGEPROJET p where p.IDCHANTIER=cc.id group by IDCHANTIER),0)AVANCEMENT,
       NOMTIERS   as idtiers,
       ETAT
from CHANTIERLIBCOMPLET cc;

alter table CHANTIER modify montant number(20,2);
alter table TRAVAUX modify montant number(20,2);

create or replace view CHANTIERLIBELLE as
select id,
       NOMTRAVAUX as idtravaux,
       nom,
       DATYDEBUT,
       DATYFIN,
       MONTANT,
       nvl((select max(pourcentage) from POURCENTAGEPROJET p where p.IDCHANTIER=cc.id group by IDCHANTIER),0)AVANCEMENT,
       NOMTIERS   as idtiers,
       ETAT
from CHANTIERLIBCOMPLET cc;

UPDATE MENUDYNAMIQUE t SET t.NIVEAU = 5 WHERE t.ID LIKE 'MEN0010' ;
UPDATE MENUDYNAMIQUE t SET t.NIVEAU = 5 WHERE t.ID LIKE 'MEN0009' ;