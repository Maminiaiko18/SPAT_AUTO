create table typenavire
(
    id varchar2(100) constraint typenavire_pk primary key ,
    val varchar2(500),
    desce varchar2(500)
);

CREATE SEQUENCE seq_typenavire
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seq_typenavire
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_typenavire.nextval INTO retour FROM dual;
  return retour;
END;

 INSERT INTO TYPENAVIRE (ID, VAL, DESCE) VALUES ('TYPN0001', 'Long coursp', 'Long coursp');
 INSERT INTO TYPENAVIRE (ID, VAL, DESCE) VALUES ('TYPN0002', 'Tanker', 'Tanker');
 INSERT INTO TYPENAVIRE (ID, VAL, DESCE) VALUES ('TYPN0003', 'Cabotage', 'Cabotage');

   alter table NAVIRE add type varchar2(100) constraint navire_type_fk references typenavire ;

   create or replace view NAVIRELIBCOMPLET as
select nav.*,
       p.val   as valpavillon,
       p.DESCE as descepavillon,
       tn.val as typenavirelib
from navire nav
         join PAYS p on p.id = nav.PAVILLON
         left join typenavire tn on tn.id=nav.type
/

create or replace view NAVIRELIB as
select id,
       reference,
       nom,
       valpavillon   as pavillon,
       JNT,
       JBT,
       PLT,
       LHT,
       LM,
       TE,
       VOLUME,
       REMARQUE,
       etat,
       typenavirelib as type
from navirelibcomplet
/

 INSERT INTO MANOEUVREBORD (ID, VAL, DESCE) VALUES ('MDB_0003', 'entrée', 'entrée');
 INSERT INTO MANOEUVREBORD (ID, VAL, DESCE) VALUES ('MDB_0004', 'mouvement', 'mouvement');
 INSERT INTO MANOEUVREBORD (ID, VAL, DESCE) VALUES ('MDB_0005', 'sortie', 'sortie');

ALTER TABLE as_bondecommande ADD delaipaiement NUMBER(10);
ALTER TABLE AS_BONDECOMMANDE_FILLE ADD TVA NUMBER(10,2);

alter table placement add iddevise varchar2(100) constraint devise_placement_fk references DEVISE;
alter table placement add montantdevise number(10,2);

create or replace view PLACEMENTLIBCOMPLET as
select plt.*,
       det.ID   as iddetails,
       IDMERE   as idmeredetails,
       MOIS,
       MONTANT_TERME,
       INTERET_RECEVOIR,
       INTERET_NET,
       lp.id    as IDENTITE,
       b.id     as IDBANQUE,
       lp.val   as VALENTITE,
       lp.desce as DESCEENTITE,
       b.val    as VALBANQUE,
       b.desce  as DESCEBANQUE,
       dev.VAL  as iddeviselib
from placement plt
         join DETAILSPLACEMENT det on plt.ID = det.IDMERE
         join ENTITE lp on lp.id = plt.ENTITE
         join BANQUE b on b.id = plt.banque
         left join devise dev on dev.id = plt.iddevise
/

create or replace view PLACEMENTLIB as
select id,
       valentite as entite,
       date_placement,
       date_echeance,
       duree,
       montant,
       taux,
       numero,
       VALBANQUE as BANQUE,
       etat,
       iddeviselib as iddevise,
       MONTANTDEVISE
from PLACEMENTLIBCOMPLET
/

CREATE OR REPLACE
FORCE VIEW POSTEDESTINATAIRELIB AS
SELECT
	ID,
	QUAI,
	valquais,
	INTERNE,
	paysquais AS PAYS,
	LONGUEUR,
	PROFONDEUR,
	TIRANT
FROM
	POSTEDESTINATAIRELIBCOMPLET p ;

create or replace view POSTEDESTINATAIRELIBCOMPLET as
select
		   p.id,
		   p.quai,
		   case when interne = 1 then 'Interne' else 'Externe' end as interne,
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
			 left join pays p1 on p1.id = q.PAYS
			 left join TYPEQUAIS tq on tq.ID=q.TYPEQUAIS
/


create or replace view OCCUPMATERIELNAVALLIBCOMPLET as
select occup.*,
       mat.denomination,
       mat.DATE_AQUISITION,
       mat.IDMARQUE,
       mat.PUISSANCE,
       mat.DETENTEUR,
       mat.MAINTENANCE,
       mat.IDTYPE_MATERIEL,
       mat.IMMATRICULATION,
       mat.etat                         as etatmaterielnaval,
       mat.valmarque,
       mat.descemarque,
       mat.valtypemateriel,
       mat.descetypemateriel,
       p.VAL                            as valpilote,
       p.DESCE                          as descepilote,
       comm.val                         as valcommandant,
       comm.DESCE                       as descecommandant,
       nat.val                          as valnatureoperation,
       nat.DESCE                        as descenatureoperation,
       manb.val                         as valmanoeuvrebord,
       manb.DESCE                       as descemanoeuvrebord,
       nav.reference,
       nav.nom                          as nomnavire,
       nav.pavillon                     as pavillonnavire,
       nav.jnt,
       nav.JBT,
       nav.PLT,
       nav.LHT,
       nav.lm,
       nav.te,
       nav.volume,
       nav.remarque,
       nav.valpavillon,
       nav.descepavillon,
       ML.ESCALE || '-' || ML.NAVIRELIB AS IDARRIVEELIB,
       case
           when POSITION = '1' then 'Tribord'
           when POSITION = '2' then 'bâbord '
           else '-' end                 as positionlib
from OCCUPATIONMATERIELNAVAL occup
         join MATERIELNAVALLIBCOMPLET mat on mat.ID = occup.IDMATERIEL_NAVAL
         LEFT join pilote p on p.ID = occup.IDPILOTE
         join COMMANDANT comm on comm.id = occup.IDCOMMANDANT
         join NATUREOPERATION nat on nat.id = occup.IDNATUREOPERATION
         join MANOEUVREBORD manb on manb.id = occup.IDMANOEUVREBORD
         LEFT join NAVIRELIBCOMPLET nav on nav.ID = occup.IDNAVIRE
         LEFT JOIN MOUVEMENT_LIBCOMPLET ML ON ML.ID = occup.IDARRIVEE
/

create or replace view OCCUPMATERIELNAVALLIB as
select id,
       daty,
       denomination       as idmateriel_naval,
       valpilote          as idpilote,
       valcommandant      as idcommandant,
       valnatureoperation as idnatureoperation,
       valmanoeuvrebord   as idmanoeuvrebord,
       heuredebut,
       heurefin,
       nomnavire          as idnavire,
       duree,
       position,
       observation,
       etat,
       datefin,
       IDARRIVEE,
       IDARRIVEELIB,
     positionlib

from OCCUPMATERIELNAVALLIBCOMPLET
order by DATY desc
/
