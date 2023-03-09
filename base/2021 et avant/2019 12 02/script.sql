create or replace view  rubrique_client_concess as
select 
	rc.id,
	rc.val,
	rc.desce,
	cc.id as idClientConcessionnaire,
	cc.val as valClientConcessionnaire,
	cc.desce as desceClientConcessionnaire
from rubrique_concessionnaire rc 
join client_concessionnaire cc
on rc.val=cc.id;

create or replace view  rubrique_client_concessSMMC as
select * from RUBRIQUE_CLIENT_CONCESS where idClientConcessionnaire='0120047';

create or replace view  rubrique_client_concessPTT as
select * from RUBRIQUE_CLIENT_CONCESS where idClientConcessionnaire='0120093';

create or replace view  rubrique_client_concessMICTSL as
select * from RUBRIQUE_CLIENT_CONCESS where idClientConcessionnaire='clt1';

create table statistiqueSMMC(
	daty date,
	debarquement number(10),
	embarquement number(10)
);

create table statistiqueMICTSL(
	daty date,
	conteneursPleins number(10),
	conteneursVides number(10)
);
create table statistiquePTP(
	daty date,
	dechargement number(10),
	chargement number(10)
);


drop view PREVISIONLIBELLECOMPLET;
drop view MOUVEMENTLIBELLECOMPLET;

  CREATE OR REPLACE FORCE VIEW PREVISIONLIBELLECOMPLET AS 
  select
    prev.id,
    prev.DATE_RADE,
    prev.PROVENANCE,
    prev.NAVIRE,
    prev.CONSIGNATAIRE,
    prev.CARGAISON,
    prev.PILOTE,
    prev.DATE_ARRIVEE,
    prev.HEURE_ARRIVEE,
    prev.DATE_DEPART,
    prev.HEURE_DEPART,
    prev.DESTINATION,
    prev.etat,
    c2.nomclt          as valCONSIGNATAIRE,
    c2.nomclt        as desceCONSIGNATAIRE,
    n1.reference    as referenceNAVIRE,
    n1.nom          as nomNAVIRE,
    p3.VAL          as pavillonNAVIRE,
    n1.jnt          as jntNAVIRE,
    n1.jbt          as jbtNAVIRE,
    n1.plt          as pltNAVIRE,
    n1.lht          as lhtNAVIRE,
    n1.lm           as lmNAVIRE,
    n1.te           as teNAVIRE,
    n1.volume       as volumeNAVIRE,
    n1.remarque     as remarqueNAVIRE,
    q1.VAL          as quaiPROVENANCE,
    prov.interne    as internePROVENANCE,
    p1.VAL          as paysPROVENANCE,
    prov.longueur   as longueurPROVENANCE,
    prov.profondeur as profondeurPROVENANCE,
    prov.tirant     as tirantPROVENANCE,
    q2.VAL          as quaiDESTINATION,
    dest.interne    as interneDESTINATION,
    p2.VAL          as paysDESTINATION,
    dest.longueur   as longueurDESTINATION,
    dest.profondeur as profondeurDESTINATION,
    dest.tirant     as tirantDESTINATION,
    q1.id           as idquaiPROVENANCE,
    q2.id           as idquaiDESTINATION,
    carg.val        as cargval,
    carg.val        as cargdesce,
    tpq1.id         as idtypequaiPROVENANCE,
    tpq1.val        as typequaiPROVENANCE,
    tpq2.id         as idtypequaiDESTINATION,
    tpq2.val        as typequaiDESTINATION
from PREVISION prev
    join NAVIRE n1 on n1.id = prev.NAVIRE
    join clientmat C2 on prev.CONSIGNATAIRE = C2.CDCLT
    join POSTEDESTINATAIRE prov on prov.id = prev.PROVENANCE
    join POSTEDESTINATAIRE dest on dest.id = prev.DESTINATION
    join pays p1 on prov.PAYS = p1.ID
    join pays p2 on dest.PAYS = p2.ID
    join QUAIS q1 on q1.id = prov.QUAI
    join TYPEQUAIS tpq1 on tpq1.ID = q1.TYPEQUAIS
    join QUAIS q2 on q2.id = dest.QUAI
    join TYPEQUAIS tpq2 on tpq2.ID = q2.TYPEQUAIS
    join pays p3 on p3.id = n1.pavillon
    join CARGAISON carg on carg.id = prev.CARGAISON;
 
	
 
 CREATE OR REPLACE FORCE VIEW MOUVEMENTLIBELLECOMPLET AS 
 select m.id,
       m.daty,
       m.escale,
       m.navire,
       m.consignataire,
       m.datearrivee,
       m.heure,
       m.provenance,
       m.destination,
       m.remarque,
       m.duree,
       m.CARGAISON,
       m.DATE_DEPART,
       m.HEURE_DEPART,
       tm.VAL          as typemvt,
       m.etat,
       c2.nomclt          as valCONSIGNATAIRE,
       c2.nomclt        as desceCONSIGNATAIRE,
       n1.reference    as referenceNAVIRE,
       n1.nom          as nomNAVIRE,
       p3.VAL          as pavillonNAVIRE,
       n1.jnt          as jntNAVIRE,
       n1.jbt          as jbtNAVIRE,
       n1.plt          as pltNAVIRE,
       n1.lht          as lhtNAVIRE,
       n1.lm           as lmNAVIRE,
       n1.te           as teNAVIRE,
       n1.volume       as volumeNAVIRE,
       n1.remarque     as remarqueNAVIRE,
       q1.VAL          as quaiPROVENANCE,
       prov.interne    as internePROVENANCE,
       p1.VAL          as paysPROVENANCE,
       prov.longueur   as longueurPROVENANCE,
       prov.profondeur as profondeurPROVENANCE,
       prov.tirant     as tirantPROVENANCE,
       q2.VAL          as quaiDESTINATION,
       dest.interne    as interneDESTINATION,
       p2.VAL          as paysDESTINATION,
       dest.longueur   as longueurDESTINATION,
       dest.profondeur as profondeurDESTINATION,
       dest.tirant     as tirantDESTINATION,
       m.typemvt       as idtypemvt,
       q1.id           as idquaiPROVENANCE,
       q2.id           as idquaiDESTINATION,
       carg.val        as cargval,
       carg.val        as cargdesce,
       tpq1.id         as idtypequaiPROVENANCE,
       tpq1.val        as typequaiPROVENANCE,
       tpq2.id         as idtypequaiDESTINATION,
       tpq2.val        as typequaiDESTINATION

from MOUVEMENT m
         join NAVIRE n1 on n1.id = m.NAVIRE
         join clientmat C2 on m.CONSIGNATAIRE = C2.cdclt
         join POSTEDESTINATAIRE prov on prov.id = m.PROVENANCE
         join POSTEDESTINATAIRE dest on dest.id = m.DESTINATION
         join pays p1 on prov.PAYS = p1.ID
         join pays p2 on dest.PAYS = p2.ID
         join QUAIS q1 on q1.id = prov.QUAI
         join TYPEQUAIS tpq1 on tpq1.ID = q1.TYPEQUAIS
         join QUAIS q2 on q2.id = dest.QUAI
         join TYPEQUAIS tpq2 on tpq2.ID = q2.TYPEQUAIS
         join TYPEMVT tm on tm.id = m.TYPEMVT
         join pays p3 on p3.id = n1.pavillon
         join CARGAISON carg on carg.id = m.CARGAISON;

	drop view RECAP_MOUVEMENT_QUAIS;
	
  CREATE OR REPLACE FORCE VIEW RECAP_MOUVEMENT_QUAIS  AS 
  select
    coalesce(mvt.IDQUAIDESTINATION,prev.IDQUAIDESTINATION) as IDQUAIDESTINATION,
    coalesce(mvt.QUAIDESTINATION,prev.QUAIDESTINATION) as QUAIDESTINATION,
    mvt.ESCALE,
    mvt.NOMNAVIRE as occup_navire,
    mvt.VALCONSIGNATAIRE as occup_consignataire,
    mvt.CARGVAL as occup_cargaison,
    mvt.DATE_DEPART as occup_date_depart,
    mvt.DATEARRIVEE as occup_date_arrivee,
    mvt.HEURE_DEPART as occup_heure_depart,
    mvt.HEURE as occup_heure_arrivee,
    mvt.QUAIDESTINATION as occup_destination,
    mvt.QUAIPROVENANCE as occup_provenance,
    mvt.typequaiDESTINATION as occup_typequaiDESTINATION,
    mvt.typequaiPROVENANCE as occup_typequaiPROVENANCE,
    prev.DATE_DEPART as prev_date_depart,
    prev.DATE_ARRIVEE as prev_date_arrivee,
    prev.HEURE_DEPART as prev_heure_depart,
    prev.HEURE_ARRIVEE as prev_heure_arrivee,
    prev.NOMNAVIRE as prev_navire,
    prev.VALCONSIGNATAIRE as prev_consignataire,
    prev.CARGVAL as prev_cargaison,
    prev.QUAIDESTINATION as prev_destination,
    prev.QUAIPROVENANCE as prev_provenance,
    prev.typequaiDESTINATION as prev_typequaiDESTINATION,
    prev.typequaiPROVENANCE as prev_typequaiPROVENANCE
from
    MOUVEMENTLIBELLECOMPLET mvt
    full outer join PREVISIONLIBELLECOMPLET prev on prev.IDQUAIDESTINATION = mvt.IDQUAIDESTINATION;
 
























