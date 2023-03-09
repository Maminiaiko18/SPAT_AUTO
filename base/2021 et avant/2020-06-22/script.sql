alter table quais add Pays varchar2(100) constraint pays_quais_fk references Pays;
alter table quais add Longueur number(10,2);
alter table quais add Profondeur number(10,2);
alter table quais add tirant number(10,2);
commit ;

create or replace view QUAISLIB as
select
    q.id,
    q.val,
    q.desce,
    q.LONGUEUR,
    q.tirant,
    p.val as PAYS,
    q.PROFONDEUR,
    tpq.VAL as TYPEQUAIS
from quais q
    join typequais tpq on tpq.id = q.typequais
    left join pays p on p.id=q.PAYS
/

create or replace view POSTEDESTINATAIRELIBCOMPLET as
select
       p.id,
       p.quai,
       case when interne = 1 then 'National' else 'International' end as interne,
       q.val as valquais,
       q.DESCE as descequais,
       q.TYPEQUAIS,
       q.PROFONDEUR,
       q.LONGUEUR,
       q.TIRANT,
       q.PAYS as paysquais,
       p1.val as valpays,
       p1.DESCE as descepays,
       tq.val as valtypequais,
       tq.DESCE as descetypequais

from POSTEDESTINATAIRE p
         left join quais q on q.id = p.QUAI
         left join pays p1 on p1.id = p.PAYS
         left join TYPEQUAIS tq on tq.ID=q.TYPEQUAIS
/

create OR REPLACE view previsionLibComplet as
    select
            pre.ID,
            pre.date_rade,
            pre.provenance,
            pre.navire,
            pre.consignataire,
            pre.cargaison,
            pre.pilote,
            pre.date_arrivee,
            pre.heure_arrivee,
            pre.date_depart,
            pre.heure_depart,
            pre.destination,
            pre.etat,
            pro.QUAI as QUAIPROVENANCE,
            pro.INTERNE AS INTERNEPOVENANCE,
            q.LONGUEUR as longueurprovenance,
            q.PAYS as paysprovenance,
            q.TIRANT as tirantprovenance,
            q.PROFONDEUR as profondeurprovenance,
            na.REFERENCE as referencenavire,
            na.NOM as nomnavire,
            na.PAVILLON as pavillonnavire,
            na.JNT as jntnavire,
            na.JBT as jbtnavire,
            na.PLT as pltnavire,
            na.LHT as lhtnavire,
            na.LM as lmnavire,
            na.TE as tenavire,
            na.VOLUME as volumenavire,
            na.REMARQUE as remarquenavire,
            na.ETAT as etatnavire,
            con.NOMCLT as valconsignataire,
            con.ADRCLT as desceconsignataire,
            car.VAL as valcargaison,
            car.DESCE as descecargaison,
            pi.VAL as valpilote,
            pi.DESCE as descepilote,
            pr.QUAI as QUAIDESTINATION,
            pr.INTERNE AS INTERNEDESTINATION,
            q1.LONGUEUR as longueurdestination,
            q1.PAYS as paysdestination,
            q1.TIRANT as tirantdestination,
            q1.PROFONDEUR as profondeurdestination,
            pa.VAL as valpaysprovenance,
            pa.DESCE as desceprovenance,
            pa1.VAL as valpaysdestination,
            pa1.DESCE as descedestination



        from prevision pre
        join POSTEDESTINATAIRE pro on pro.id=pre.PROVENANCE
        join NAVIRE na on na.id=pre.NAVIRE
        left join CONSIGNATAIREMAT con on con.CDCLT=pre.CONSIGNATAIRE
        join CARGAISON car on car.id=pre.CARGAISON
        join pilote pi on pi.ID=pre.PILOTE
        join POSTEDESTINATAIRE PR ON PR.ID=PRE.DESTINATION
        left join QUAIS q on q.id=pro.QUAI
        left join QUAIS q1 on q.id=pr.QUAI
        left join PAYS pa on pa.id=q.PAYS
        left join PAYS pa1 on pa1.id=q1.PAYS;


create or replace view mouvementLibComplet as
    select
            mvt.ID,
            mvt.daty,
            mvt.ESCALE,
            mvt.NAVIRE,
            mvt.CONSIGNATAIRE,
            mvt.DATEARRIVEE,
            mvt.heure,
            mvt.PROVENANCE,
            mvt.DESTINATION,
            mvt.REMARQUE,
            mvt.DUREE,
            mvt.TYPEMVT,
            mvt.etat,
            mvt.CARGAISON,
            mvt.HEURE_DEPART,
            mvt.DATE_DEPART,
            tm.VAL as valmvt,
            tm.desce as descemvt,
            car.VAL as valcargaison,
            car.desce as descecargaison,
            pro.QUAI as quaiprovenance,
            pro.INTERNE as interneprovenance,
            q.PAYS as paysprovenance,
            q.val as valquaisprovenance,
            q.DESCE as descequaisprovenance,
            q.TYPEQUAIS as typequaisprovenance,
            q.TIRANT as tirantprovenance,
            q.LONGUEUR as longueurprovenance,
            q.PROFONDEUR as profondeurprovenance,
            p.VAL as valpaysprovenance,
            p.DESCE as descepaysprovenance,
            des.QUAI as quaisdestination,
            des.INTERNE as internedestination,
            q1.PAYS as paysdestination,
            q1.VAL as valquaisdestination,
            q1.DESCE as descequaisdestination,
            q1.TYPEQUAIS as typequaisdestianantion,
            q1.TIRANT as tirantdestination,
            q1.LONGUEUR as longueurdestination,
            q1.PROFONDEUR as profondeurdestination,
            p1.VAL as valpaysdestination,
            p1.DESCE as descepaysdestination,
            na.REFERENCE as referencenavire,
            na.NOM as nomnavire,
            na.PAVILLON as pavillonnavire,
            na.JNT as jntnavire,
            na.JBT as jbtnavire,
            na.PLT as pltnavire,
            na.LHT as lhtnavire,
            na.LM as lmnavire,
            na.TE as tenavire,
            na.VOLUME as volumenavire,
            na.REMARQUE as remarquenavire,
            na.ETAT as etatnavire,
            cons.NOMCLT as valconsignataire,
            cons.ADRCLT as desceconsignataire
        from MOUVEMENT mvt
        JOIN NAVIRE na on na.ID=MVT.NAVIRE
        left join CONSIGNATAIREMAT cons on cons.CDCLT=mvt.CONSIGNATAIRE
        left join POSTEDESTINATAIRE pro on pro.id=mvt.PROVENANCE
        left join POSTEDESTINATAIRE des on des.id=mvt.DESTINATION
        left join TYPEMVT tm on  tm.id=mvt.TYPEMVT
        left join CARGAISON car on car.id=mvt.CARGAISON
        left join quais q on q.id=pro.QUAI
        left join pays p on p.id=q.PAYS
        left join  quais q1 on q1.id=des.QUAI
        left join pays p1 on p1.id=q1.PAYS;
        
drop view postedestinataireexterne;
create or replace view postedestinataireexterne as
select * from postedestinatairelibcomplet where interne='International';

drop view postedestinataireinterne;
create or replace view postedestinataireinterne as
select * from postedestinatairelibcomplet where interne='National';


create or replace view navirelibValide as
select * from navirelib where etat!=0;

create or replace view mouvementLibComplet as
    select
            mvt.ID,
            mvt.daty,
            mvt.ESCALE,
            mvt.NAVIRE,
            mvt.CONSIGNATAIRE,
            mvt.DATEARRIVEE,
            mvt.heure,
            mvt.PROVENANCE,
            mvt.DESTINATION,
            mvt.REMARQUE,
            mvt.DUREE,
            mvt.TYPEMVT,
            mvt.etat,
            mvt.CARGAISON,
            mvt.HEURE_DEPART,
            mvt.DATE_DEPART,
            tm.VAL as valmvt,
            tm.desce as descemvt,
            car.VAL as valcargaison,
            car.desce as descecargaison,
            pro.QUAI as quaiprovenance,
            pro.INTERNE as interneprovenance,
            q.PAYS as paysprovenance,
            q.val as valquaisprovenance,
            q.DESCE as descequaisprovenance,
            q.TYPEQUAIS as typequaisprovenance,
            q.TIRANT as tirantprovenance,
            q.LONGUEUR as longueurprovenance,
            q.PROFONDEUR as profondeurprovenance,
            p.VAL as valpaysprovenance,
            p.DESCE as descepaysprovenance,
            des.QUAI as quaisdestination,
            des.INTERNE as internedestination,
            q1.PAYS as paysdestination,
            q1.VAL as valquaisdestination,
            q1.DESCE as descequaisdestination,
            q1.TYPEQUAIS as typequaisdestianantion,
            q1.TIRANT as tirantdestination,
            q1.LONGUEUR as longueurdestination,
            q1.PROFONDEUR as profondeurdestination,
            p1.VAL as valpaysdestination,
            p1.DESCE as descepaysdestination,
            na.REFERENCE as referencenavire,
            na.NOM as nomnavire,
            na.PAVILLON as pavillonnavire,
            na.JNT as jntnavire,
            na.JBT as jbtnavire,
            na.PLT as pltnavire,
            na.LHT as lhtnavire,
            na.LM as lmnavire,
            na.TE as tenavire,
            na.VOLUME as volumenavire,
            na.REMARQUE as remarquenavire,
            na.ETAT as etatnavire,
            cons.NOMCLT as valconsignataire,
            cons.ADRCLT as desceconsignataire,
            t.VAL as valtypequaisprovenance,
            t.DESCE as descetypequaisprovenance,
            t2.val as valtypequaisdestination,
            t2.DESCE as descetypequaisdestination
        from MOUVEMENT mvt
        left join  NAVIRE na on na.ID=MVT.NAVIRE
        left join CONSIGNATAIREMAT cons on cons.CDCLT=mvt.CONSIGNATAIRE
        left join POSTEDESTINATAIRE pro on pro.id=mvt.PROVENANCE
        left join POSTEDESTINATAIRE des on des.id=mvt.DESTINATION
        left join TYPEMVT tm on  tm.id=mvt.TYPEMVT
        left join CARGAISON car on car.id=mvt.CARGAISON
        left join quais q on q.id=pro.QUAI
        left join pays p on p.id=q.PAYS
        left join  quais q1 on q1.id=des.QUAI
        left join pays p1 on p1.id=q1.PAYS
        left JOIN TYPEQUAIS T on q.TYPEQUAIS = T.ID
        left JOIN TYPEQUAIS T2 ON T2.ID=Q1.TYPEQUAIS;

create OR REPLACE view previsionLibComplet as
    select
            pre.ID,
            pre.date_rade,
            pre.provenance,
            pre.navire,
            pre.consignataire,
            pre.cargaison,
            pre.pilote,
            pre.date_arrivee,
            pre.heure_arrivee,
            pre.date_depart,
            pre.heure_depart,
            pre.destination,
            pre.etat,
            pro.QUAI as QUAIPROVENANCE,
            pro.INTERNE AS INTERNEPOVENANCE,
            q.LONGUEUR as longueurprovenance,
            q.PAYS as paysprovenance,
            q.TIRANT as tirantprovenance,
            q.PROFONDEUR as profondeurprovenance,
            na.REFERENCE as referencenavire,
            na.NOM as nomnavire,
            na.PAVILLON as pavillonnavire,
            na.JNT as jntnavire,
            na.JBT as jbtnavire,
            na.PLT as pltnavire,
            na.LHT as lhtnavire,
            na.LM as lmnavire,
            na.TE as tenavire,
            na.VOLUME as volumenavire,
            na.REMARQUE as remarquenavire,
            na.ETAT as etatnavire,
            con.NOMCLT as valconsignataire,
            con.ADRCLT as desceconsignataire,
            car.VAL as valcargaison,
            car.DESCE as descecargaison,
            pi.VAL as valpilote,
            pi.DESCE as descepilote,
            pr.QUAI as QUAIDESTINATION,
            pr.INTERNE AS INTERNEDESTINATION,
            q1.LONGUEUR as longueurdestination,
            q1.PAYS as paysdestination,
            q1.TIRANT as tirantdestination,
            q1.PROFONDEUR as profondeurdestination,
            pa.VAL as valpaysprovenance,
            pa.DESCE as desceprovenance,
            pa1.VAL as valpaysdestination,
            pa1.DESCE as descedestination,
            t.VAL as valtypequaisprovenance,
            t.DESCE as descetypequaisprovenance,
            t2.val as valtypequaisdestination,
            t2.DESCE as descetypequaisdestination

        from prevision pre
        join POSTEDESTINATAIRE pro on pro.id=pre.PROVENANCE
        join NAVIRE na on na.id=pre.NAVIRE
        left join CONSIGNATAIREMAT con on con.CDCLT=pre.CONSIGNATAIRE
        join CARGAISON car on car.id=pre.CARGAISON
        join pilote pi on pi.ID=pre.PILOTE
        join POSTEDESTINATAIRE PR ON PR.ID=PRE.DESTINATION
        left join QUAIS q on q.id=pro.QUAI
        left join QUAIS q1 on q.id=pr.QUAI
        left join PAYS pa on pa.id=q.PAYS
        left join PAYS pa1 on pa1.id=q1.PAYS
        left JOIN TYPEQUAIS T on q.TYPEQUAIS = T.ID
        left JOIN TYPEQUAIS T2 ON T2.ID=Q1.TYPEQUAIS;

CREATE OR REPLACE VIEW MOUVEMENTLIBCOMPLETDEPART AS
    SELECT
            MVT.*
        FROM MOUVEMENTLIBCOMPLET MVT WHERE MVT.TYPEMVT='TPMM00003';
CREATE OR REPLACE VIEW MOUVEMENTLIBCOMPLETARRIVE AS
    SELECT
            MVT.*
        FROM MOUVEMENTLIBCOMPLET MVT WHERE MVT.TYPEMVT='TPMM00001';

CREATE OR REPLACE VIEW MOUVEMENTLIBCOMPLETMVT AS
    SELECT
            MVT.*
        FROM MOUVEMENTLIBCOMPLET MVT WHERE MVT.TYPEMVT='TPMM00002';


create or replace view recap_quais as
select 
    prev.QUAIDESTINATION as idQuai , prev.descequaisdestination as nomQuai, prev.typequaisdestination as idTypeQuais, 
    prev.valtypequaisdestination as typequaidestination,
    '' as numeroEscale_prev, prev.nomnavire as nomnavire_prev , prev.valconsignataire as valconsignataire_prev, 
    prev.valcargaison as cargval_prev, prev.date_arrivee as date_arrivee_prev, prev.date_depart as date_depart_prev,
    '-' as numeroEscale_occup, '-' as nomnavire_occup , '-' as valconsignataire_occup, 
    '-' as cargval_occup, null as date_arrivee_occup, null as date_depart_occup
from PREVISIONLIBCOMPLET prev 
union
select
    mvt.quaisdestination as idQuai, mvt.valquaisdestination as nomQuai, mvt.typequaisdestianantion as idTypeQuais, 
    mvt.valtypequaisdestination as typequaidestination,
    '-' as numeroEscale_prev, '-' as nomnavire_prev , '-' as valconsignataire_prev, 
    '-' as cargval_prev, null as date_arrivee_prev, null as date_depart_prev,
    mvt.escale as numeroEscale_occup, mvt.nomnavire as nomnavire_occup, mvt.valconsignataire as valconsignataire_occup,
    mvt.valcargaison as cargval_occup, mvt.datearrivee as date_arrivee_occup, mvt.date_depart as date_depart_occup
from mouvementLibComplet mvt;

CREATE OR REPLACE FORCE VIEW PREVMATERIELNAVALLIBCOMPLET as
select
        prev."ID",prev."DATY",prev."IDMATERIEL_NAVAL",prev."IDCOMMANDANT",prev."IDNATUREOPERATION",prev."IDNAVIRE",prev."IDCLIENT",prev."DUREE",prev."OBSERVATION",prev."ETAT",prev."DATE_DEPART",prev."HEURE_DEPART",prev."DATE_ARRIVEE",prev."HEURE_ARRIVEE",
        mat.denomination, mat.DATE_AQUISITION, mat.IDMARQUE, mat.PUISSANCE, mat.DETENTEUR, mat.MAINTENANCE,
        mat.IDTYPE_MATERIEL, mat.IMMATRICULATION, mat.etat as etatmaterielnaval, mat.valmarque, mat.descemarque, mat.valtypemateriel, mat.descetypemateriel,
        comm.val as valcommandant, comm.DESCE as descecommandant,
        nat.val as valnatureoperation, nat.DESCE as descenatureoperation,
        nav.reference, nav.nom as nomnavire, nav.pavillon as pavillonnavire, nav.jnt, nav.JBT, nav.PLT, nav.LHT, nav.lm, nav.te,
        nav.volume, nav.remarque, nav.valpavillon, nav.descepavillon,
        cli."CDCLT",cli."CDCAT",cli."NOMCLT",cli."ADRCLT",cli."NMSTTCLT",cli."TELCLT",cli."FAXCLT",cli."NMCIN",cli."NIF",cli."RC"
    from PREVISIONMATERIELNAVAL prev
        left join MATERIELNAVALLIBCOMPLET mat on mat.ID = prev.IDMATERIEL_NAVAL
        left join COMMANDANT comm on comm.id = prev.IDCOMMANDANT
        left join NATUREOPERATION nat on nat.id = prev.IDNATUREOPERATION
        left join NAVIRELIBCOMPLET nav on nav.ID = prev.IDNAVIRE
        left join CLIENTMAT cli on cli.CDCLT = prev.IDCLIENT;

create or replace view recap_materiel_naval as
select 
    om.idmateriel_naval as idmateriel_naval_occup, om.denomination as denomination_occup, om.position as position_occup, om.daty as daty_occup, om.datefin as daty_fin_occup, om.heuredebut as heuredebut_occup, om.heurefin as heurefin_occup, om.observation as observation_occup,
    null as daty_prev, null as daty_fin_prev, '' as heuredebut_prev, '' as heurefin_prev, '-' as observation_prev, om.valnatureoperation as nature_occup,  '-' as nature_prev
from OCCUPMATERIELNAVALLIBCOMPLET om
union
select 
    pm.idmateriel_naval as idmateriel_naval_occup, pm.denomination as denomination_occup, '-' as position_occup, null as daty_occup, null as daty_fin_occup, '-' as heuredebut_occup, '-' as heurefin_occup, '-' as observation_occup,
    pm.date_arrivee as date_prev, pm.date_depart as daty_fin, pm.heure_arrivee as heuredebut_prev, pm.heure_depart as heurefin_prev, pm.observation as observation_prev,  '-' as nature_occup,  pm.valnatureoperation as nature_prev
from PREVMATERIELNAVALLIBCOMPLET pm;