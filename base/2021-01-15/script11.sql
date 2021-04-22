alter  table ordonnerpayement add tiers varchar2(100);

alter table journalcaisse drop constraint FK_PLACEMENT_JOURNAL;

create or replace view BED_PDF as
select op.id,

       lt.ID1                   as idfacture,
       ff.DESIGNATION,
       ff.MONTANT               as puht,
       cast(1 as number(10, 2)) as quantite,
       ff.MONTANTTVA,
       ff.MONTANTTTC,
       ti.NOM as  TIERS
from LIAISONINTRATABLE lt
         join ORDONNERPAYEMENT op
              on op.id = lt.id2
         join ETATFACTUREMONTANTDATY ff on ff.id = lt.ID1
        left join TIERS ti on ti.id=op.tiers
where op.ETAT < 11
group by op.id, lt.ID1, ff.DESIGNATION, ff.MONTANT, cast(1 as number(10, 2)), ff.MONTANTTVA, ff.MONTANTTTC,ti.NOM
/


create or replace view BED_PDF as
select op.id,

       lt.ID1                   as idfacture,
       ff.DESIGNATION,
       ff.MONTANT               as puht,
       cast(1 as number(10, 2)) as quantite,
       ff.MONTANTTVA,
       ff.MONTANTTTC,
       ti.NOM as  TIERS
from LIAISONINTRATABLE lt
         join ORDONNERPAYEMENT op
              on op.id = lt.id2
         join ETATFACTUREMONTANTDATY ff on ff.id = lt.ID1
        left join FOURNISSEUR_UNION_PERSONNEL ti on ti.id=op.tiers
where op.ETAT < 11
group by op.id, lt.ID1, ff.DESIGNATION, ff.MONTANT, cast(1 as number(10, 2)), ff.MONTANTTVA, ff.MONTANTTTC,ti.NOM
/

create or replace view INVENTAIREDETAILSLIB2 as
select
            i.ID,
            i.IDMERE as IDMERE,
            ar.DESIGNATION as IDINGREDIENT,
            i.IDUSER,
            i.QUANTITER,
            i.EXPLICATION,
            i.ETAT,
            ga.VAL as IDCATEGORIEINGREDIENT,
            i.DATY,
            i.QTETHEORIQUE
        from inventairedetails i
        join st_inventaire sti on sti.ID=i.IDMERE
        join ST_ARTICLE ar on ar.id=i.IDINGREDIENT
        left join ST_GROUPE_ARTICLE ga on ga.id=i.IDCATEGORIEINGREDIENT
/

create or replace view INVENTAIREDETAILSLIB2 as
select
            i.ID,
            i.IDMERE as IDMERE,
            ar.DESIGNATION as IDINGREDIENT,
            i.IDUSER,
            i.QUANTITER,
            i.EXPLICATION,
            i.ETAT,
            ga.VAL as IDCATEGORIEINGREDIENT,
            i.DATY,
            i.QTETHEORIQUE,
            un.VAL as UNITE
        from inventairedetails i
        join st_inventaire sti on sti.ID=i.IDMERE
        join ST_ARTICLE ar on ar.id=i.IDINGREDIENT
        left join ST_GROUPE_ARTICLE ga on ga.id=i.IDCATEGORIEINGREDIENT
        left join ST_UNITE un on un.id=ar.UNITE;

create table mvtintracaisse
(
    id varchar2(100) constraint mvtintracaisse_pk primary key ,
        daty date,
        caissedepart varchar2(100) constraint fk_caisse references CAISSE,
        caissearrivee varchar2(100) constraint fk_caisseII references CAISSE,
        montant number(10,2),
        modepaiement varchar2(100) constraint modepaiement_fk references MODEPAIEMENT,
        remarque varchar2(4000),
        etat number(10)
);



CREATE SEQUENCE seq_mvtintracaisse
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_mvtintracaisse
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_mvtintracaisse.nextval INTO retour FROM dual;
    return retour;
END;

create view mvtintracaisse_lib as
select mv.id,
       daty,
       ca.VAL  as caissedepart,
       ca1.VAL as caissearrivee,
       montant,
       mp.VAL  as modepaiement,
       remarque,
       etat
from mvtintracaisse mv
         left join CAISSE ca on ca.id = mv.caissedepart
         left join CAISSE ca1 on ca1.id = mv.caissedepart
         left join MODEPAIEMENT mp on mp.id = mv.modepaiement;

create view mvtintracaisse_libcomplet as
select mv.*,
       ca.VAL  as caissedepartlib,
       ca1.VAL as caissearriveelib,
       mp.VAL  as modepaiementlib
from mvtintracaisse mv
         left join CAISSE ca on ca.id = mv.caissedepart
         left join CAISSE ca1 on ca1.id = mv.caissedepart
         left join MODEPAIEMENT mp on mp.id = mv.modepaiement;


         create or replace view mvtintracaisse_libcomplet as
select mv.*,
       ca.VAL  as caissedepartlib,
       ca1.VAL as caissearriveelib,
       mp.VAL  as modepaiementlib
from mvtintracaisse mv
         left join CAISSE ca on ca.id = mv.caissedepart
         left join CAISSE ca1 on ca1.id = mv.caissearrivee
         left join MODEPAIEMENT mp on mp.id = mv.modepaiement;

alter table REGULFACTURE drop constraint FF_REGULFACT_FK;

DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000129';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000128';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000132';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000133';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000137';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000136';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000140';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000152';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000143';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000146';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000147';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000148';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000149';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000150';
DELETE FROM JOURNALCAISSE x
	WHERE x.ID='CAS000151';


DELETE FROM REPORT x
	WHERE x.ID='REP000012';
DELETE FROM REPORT x
	WHERE x.ID='REP000013';






UPDATE CAISSE x
	SET x.ID='CAIS000001'
	WHERE x.ID='CAIS_00001';
UPDATE CAISSE x
	SET x.ID='CAIS000002'
	WHERE x.ID='CAIS_00002';
UPDATE CAISSE x
	SET x.ID='CAIS000003'
	WHERE x.ID='CAIS_00003';
UPDATE CAISSE x
	SET x.ID='CAIS000004'
	WHERE x.ID='CAIS_00004';
UPDATE CAISSE x
	SET x.ID='CAIS000005'
	WHERE x.ID='CAIS_00005';
UPDATE CAISSE x
	SET x.ID='CAIS000006'
	WHERE x.ID='CAIS_00006';
UPDATE CAISSE x
	SET x.ID='CAIS000007'
	WHERE x.ID='CAIS_00007';
UPDATE CAISSE x
	SET x.ID='CAIS000008'
	WHERE x.ID='CAIS_00008';
UPDATE CAISSE x
	SET x.ID='CAIS000009'
	WHERE x.ID='CAIS_00009';
UPDATE CAISSE x
	SET x.ID='CAIS000010'
	WHERE x.ID='CAIS_00010';
UPDATE CAISSE x
	SET x.ID='CAIS000011'
	WHERE x.ID='CAIS_00011';
UPDATE CAISSE x
	SET x.ID='CAIS000012'
	WHERE x.ID='CAIS_00012';
UPDATE CAISSE x
	SET x.ID='CAIS000013'
	WHERE x.ID='CAIS_00013';
UPDATE CAISSE x
	SET x.ID='CAIS000014'
	WHERE x.ID='CAIS_00014';
UPDATE CAISSE x
	SET x.ID='CAIS000015'
	WHERE x.ID='CAIS_00015';
UPDATE CAISSE x
	SET x.ID='CAIS000016'
	WHERE x.ID='CAIS_00016';
UPDATE CAISSE x
	SET x.ID='CAIS000017'
	WHERE x.ID='CAIS_00017';

