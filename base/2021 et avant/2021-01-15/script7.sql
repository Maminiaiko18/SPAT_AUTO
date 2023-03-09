create or replace view bed_pdf as
select op.id,

       lt.ID1                   as idfacture,
       ff.DESIGNATION,
       ff.MONTANT               as puht,
       cast(1 as number(10, 2)) as quantite,
       ff.MONTANTTVA,
       ff.MONTANTTTC
from LIAISONINTRATABLE lt
         join ORDONNERPAYEMENT op
              on op.id = lt.id2
         join ETATFACTUREMONTANTDATY ff on ff.id = lt.ID1
where op.ETAT < 11
group by op.id, lt.ID1, ff.DESIGNATION, ff.MONTANT, cast(1 as number(10, 2)), ff.MONTANTTVA, ff.MONTANTTTC;

create or replace view QUANTITELIVRE as
select b.id_bc, sum(bl.QUANTITE) as qtelivre
from AS_BONDELIVRAISON b
         join quantite_bl bl on bl.NUMBL = b.ID
where b.ETAT>=11
group by ID_BC
/


alter table Caisse add type varchar2(100) ;

 UPDATE CAISSE t SET t.TYPE = 'sous-caisse' WHERE t.ID LIKE 'CAIS_00014' ;
 UPDATE CAISSE t SET t.TYPE = 'sous-caisse' WHERE t.ID LIKE 'CAIS_00017' ;
 UPDATE CAISSE t SET t.TYPE = 'sous-caisse' WHERE t.ID LIKE 'CAIS_00016' ;
 UPDATE CAISSE t SET t.TYPE = 'sous-caisse' WHERE t.ID LIKE 'CAIS_00015' ;

 create or replace view AS_BONDECOMMANDE_FILLE_FINAL as
select bcf.IDBC,

       sum(bcf.QUANTITE)                            as quantitecommande,
       sum(nvl(bl.qtelivre, 0))                     as quantitelivre,
       sum(nvl(ff.qte, 0))                          as quantitefacture,
       sum(bcf.QUANTITE) - sum(nvl(bl.qtelivre, 0)) as restelivre,
       sum(bcf.QUANTITE) - sum(nvl(ff.qte, 0))      as restefacture,
       ETAT
from bondecommande_sumqte bcf
         left join quantitelivre bl on bl.ID_BC = bcf.IDBC
         left join DETAILSFF_groupe ff on ff.IDINGREDIENT = bcf.IDBC
where ETAT>=11
group by bcf.IDBC, ETAT
/

create or replace view DETAILSFF_GROUPE as
SELECT nvl(sum(QTE), 0) as qte, bl.ID_BC as IDINGREDIENT
FROM DETAILSFACTUREFOURNISSEUR dff
         join FACTUREFOURNISSEUR ff on ff.ID = dff.IDMERE
         right join AS_BONDELIVRAISON bl on bl.id = ff.REMARQUE
where ff.ETAT>=11
group by ID_BC
/
