create or replace view AS_BONDECOMMANDE_FILLE_GROUPER as
SELECT IDBC,
       sum(montantht)  as montantht,
       sum(montanttva) as montanttva,
       sum(montantttc) as montantttc
FROM AS_BONDECOMMANDE_FILLE_MONTANT
--WHERE ETAT >= 11
group by IDBC
/
create or replace view BED_PDF as
select op.id,

       lt.ID1                   as idfacture,
       ff.DESIGNATION,
       ff.MONTANT               as puht,
       cast(1 as number(10, 2)) as quantite,
       ff.MONTANTTVA,
       ff.MONTANTTTC,
       ti.NOM                   as TIERS,
       op.NUMEROOP
from LIAISONINTRATABLE lt
         join ORDONNERPAYEMENT op
              on op.id = lt.id2
         join ETATFACTUREMONTANTDATY ff on ff.id = lt.ID1
         left join FOURNISSEUR_UNION_PERSONNEL ti on ti.id = op.tiers
where op.ETAT < 11
group by op.id, lt.ID1, ff.DESIGNATION, ff.MONTANT, cast(1 as number(10, 2)), ff.MONTANTTVA, ff.MONTANTTTC, ti.NOM,NUMEROOP
/
