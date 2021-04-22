create or replace view LIAISONBORDEREAU_LIBCOMPLET as
select
       li."ID",li."IDBORDEREAU",li."IDOP",
       op.REMARQUE,
       op.DED_ID as idfacture,
       b2.designation as idbordereaulib,
       op.MONTANT
from liaisonbordereau li
    join bordereau b2 on li.idBordereau = b2.id
    join ORDONNERPAYEMENT op on op.id=li.idOP
/

CREATE SEQUENCE seq_codeetabliss
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_codeetabliss
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_codeetabliss.nextval INTO retour FROM dual;
    return retour;
END;

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
group by op.id, lt.ID1, ff.DESIGNATION, ff.MONTANT, cast(1 as number(10, 2)), ff.MONTANTTVA, ff.MONTANTTTC, ti.NOM,
         NUMEROOP, ff.NUMFACT, ff.DATY,ti1.NOM
/

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
       ti1.NOM                 as prestataire,
       ff.CODE_ETABLISSEMENT,
       PROJET
from LIAISONINTRATABLE lt
         join ORDONNERPAYEMENT op
              on op.id = lt.id2
         join ETATFACTUREMONTANTDATY ff on ff.id = lt.ID1
         left join FOURNISSEUR_UNION_PERSONNEL ti on ti.id = ff.IDFOURNISSEUR
         left join FOURNISSEUR_UNION_PERSONNEL ti1 on ti1.id = op.tiers
group by op.id, lt.ID1, ff.DESIGNATION, ff.MONTANT, cast(1 as number(10, 2)), ff.MONTANTTVA, ff.MONTANTTTC, ti.NOM,
         NUMEROOP, ff.NUMFACT, ff.DATY,ti1.NOM,ff.CODE_ETABLISSEMENT,PROJET
/
