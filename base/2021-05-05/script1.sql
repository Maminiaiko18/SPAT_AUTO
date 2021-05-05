CREATE OR REPLACE VIEW LIAISONBORDEREAUFF_LIBCOMPLET (ID, IDBORDEREAU, IDOP, REMARQUE, IDFACTURE, IDBORDEREAULIB, MONTANT) AS
select li.ID,
       li.IDBORDEREAU,
       li.IDOP,
       op.DESIGNATION,
       op.id          as idfacture,
       b2.designation as idbordereaulib,
       op.MONTANTTTC  as montant
from liaisonbordereauff li
         left join bordereauFF_libcomplet b2 on li.idBordereau = b2.id
         left join ETATFACTUREMONTANTDATY op on op.id = li.idOP;
