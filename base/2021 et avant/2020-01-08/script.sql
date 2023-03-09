******************************************SPAT Capitainerie****************************************
create or replace view recapitulationquais as 
select 
  q.*,
  mvt.ESCALE,
  mvt.NAVIRE as occup_navire,
  mvt.CONSIGNATAIRE as occup_consignataire,
  mvt.CARGAISON as occup_cargaison,
  mvt.DATE_DEPART as occup_date_depart,
  mvt.DATEARRIVEE as occup_date_arrivee,
  mvt.HEURE_DEPART as occup_heure_depart,
  mvt.HEURE as occup_heure_arrivee,
  mvt.DESTINATION as occup_destination,
  mvt.PROVENANCE as occup_provenance,
  '' as occup_typequaiDESTINATION,
  '' as occup_typequaiPROVENANCE,
  prev.DATE_DEPART as prev_date_depart,
  prev.DATE_ARRIVEE as prev_date_arrivee,
  prev.HEURE_DEPART as prev_heure_depart,
  prev.HEURE_ARRIVEE as prev_heure_arrivee,
  prev.nomNAVIRE as prev_navire,
  prev.valCONSIGNATAIRE as prev_consignataire,
  prev.cargval as prev_cargaison,
  prev.DESTINATION as prev_destination,
  prev.PROVENANCE as prev_provenance,
  '' as prev_typequaiDESTINATION,
  '' as prev_typequaiPROVENANCE
from quais q 
left join occupation mvt on q.ID=mvt.QUAI
left join PREVISIONLIBELLECOMPLET prev on prev.idquaiDESTINATION=q.ID
order by  q.val,q.id;

create or replace view occupation as
select 
m.ID,
m.DATY,
m.ESCALE,
n.nom as navire,
m.CONSIGNATAIRE,
m.DATEARRIVEE,
m.HEURE,
m.PROVENANCE,
m.DESTINATION,
m.REMARQUE,
m.DUREE,
m.TYPEMVT,
m.ETAT,
carg.val as CARGAISON,
m.HEURE_DEPART,
m.DATE_DEPART,
p.QUAI,
p.INTERNE,
p.PAYS,
p.LONGUEUR,
p.PROFONDEUR,
p.TIRANT
from 
mouvement m
join postedestinataire p on p.id=m.DESTINATION
join navire n on n.id=m.navire
join CARGAISON carg on carg.id = m.CARGAISON;

create materialized view histo_evo_carriere
    refresh force on demand as
        select * from spat_rh.histo_evo_carriere;
		
create table analyselien(
    id varchar(50),
    page varchar(200),
    idutilisateur integer,
    titre varchar(200),
    lien varchar(200),
    constraint PK_ANALYSELIEN primary key(id),
    constraint FK_ANALLIENREFUSER foreign key (idutilisateur) references utilisateur(refuser)
);

CREATE SEQUENCE seqanalyselien
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 30
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION getseqanalyselien
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqanalyselien.nextval INTO retour FROM dual;
  return retour;
