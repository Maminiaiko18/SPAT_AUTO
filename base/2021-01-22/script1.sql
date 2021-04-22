create view journalcaisselib_cree as
select *
from journalcaisselib
where etat = 1;
create view journalcaisselib_vise as
select *
from journalcaisselib
where etat = 11;
create view journalcaisselib_annule as
select *
from journalcaisselib
where etat = 0;

create or replace view ORDONNERPAYEMENT_LIBETAT as
SELECT op."ID",
       op."DED_ID",
       op."IDLIGNE",
       op."DATY",
       op."MONTANT",
       op."REMARQUE",
       op."ETAT",
       op."NUMEROOP",
       op."DESTINATION",
       op."MODEPAIEMENT",
       op."IDUSER",
       jc.FOLIO,
       jc.NUMCHEQUE ,
       CASE
           WHEN op.etat = 0 THEN 'annule'
           WHEN op.etat = 1 THEN 'cree'
           WHEN op.etat = 11 THEN 'vise'
           END
           AS etatlib
FROM OrdonnerPayement op
left join journalcaisse jc on jc.IDORDRE=op.ID
/

alter table Placement modify montant number (20,2);


create table departement
(
    id    varchar2(100)
        constraint departement_pk primary key,
    val   varchar2(500),
    desce varchar2(500)

);


create table service
(
    id    varchar2(100)
        constraint service_pk primary key,
    val   varchar2(500),
    desce varchar2(500)

);


alter table codeetablissement add Departement varchar2(500) constraint codeetablissement_dep_fk references departement;
alter table codeetablissement add Service varchar2(500) constraint Service_dep_fk references departement;


create or replace view BED_PDF_II as
select op.id,

       lt.ID1                   as idfacture,
       ff.DESIGNATION,
       ff.MONTANT               as puht,
       cast(1 as number(10, 2)) as quantite,
       ff.MONTANTTVA,
       ff.MONTANTTTC,
       ti.NOM                   as TIERS,
       op.NUMEROOP,
       ff.DATY,
       ff.NUMFACT,
       ti1.NOM                 as prestataire
from LIAISONINTRATABLE lt
         join ORDONNERPAYEMENT op
              on op.id = lt.id2
         join ETATFACTUREMONTANTDATY ff on ff.id = lt.ID1
         left join FOURNISSEUR_UNION_PERSONNEL ti on ti.id = ff.IDFOURNISSEUR
         left join FOURNISSEUR_UNION_PERSONNEL ti1 on ti1.id = op.tiers
where op.ETAT < 11
group by op.id, lt.ID1, ff.DESIGNATION, ff.MONTANT, cast(1 as number(10, 2)), ff.MONTANTTVA, ff.MONTANTTTC, ti.NOM,
         NUMEROOP, ff.NUMFACT, ff.DATY,ti1.NOM
/