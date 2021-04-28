CREATE OR REPLACE VIEW ORDONNERPAYEMENT_LIBETAT
            (ID, DED_ID, IDLIGNE, DATY, MONTANT, REMARQUE, ETAT, NUMEROOP, DESTINATION, MODEPAIEMENT, IDUSER, FOLIO,
             NUMCHEQUE, ETATLIB, MODEPAIEMENTLIB,TIERS)
AS
SELECT op.ID,
       op.DED_ID,
       op.IDLIGNE,
       op.DATY,
       op.MONTANT,
       op.REMARQUE,
       op.ETAT,
       op.NUMEROOP,
       op.DESTINATION,
       op.MODEPAIEMENT,
       op.IDUSER,
       jc.FOLIO,
       jc.NUMCHEQUE,
       CASE
           WHEN op.etat = 0 THEN 'annule'
           WHEN op.etat = 1 THEN 'cree'
           WHEN op.etat = 11 THEN 'vise'
           END
              AS etatlib,
       md.VAL AS MODEPAIEMENTLIB,
       fup.NOM as TIERS
FROM OrdonnerPayement op
         left join journalcaisse jc on jc.IDORDRE = op.ID
         LEFT JOIN modepaiement md ON md.ID = op.MODEPAIEMENT
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = op.TIERS;
		 

CREATE OR REPLACE VIEW ORDONNERPAYEMENT_N_PAYE
AS
SELECT *
FROM ORDONNERPAYEMENT_LIBETAT op
WHERE op.id NOT IN (SELECT jc.IDORDRE
                    FROM journalcaisse jc
                    WHERE jc.IDORDRE = op.id)
  AND op.ETAT >= 11;
 
 create or replace view ORDONNERPAYEMENT_PAYE_LIB as
SELECT op.*
FROM ORDONNERPAYEMENT_LIBETAT op
         JOIN journalcaisse jc ON jc.IDORDRE = op.id
WHERE jc.ETAT >= 11
  AND op.ETAT >= 11;

 create view bordereauFF_libcomplet as
    select br.*,
           fup.NOM as tierslib
        from bordereauFF br
        left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id=br.TIERS;
		


create view liaisonbordereauFF_libcomplet as
select
       lb.*,
       b.DESIGNATION as designatiobordereau,
       b.DATY as datybordereau,
       b.tierslib,
       b.TIERS,
       b.ETAT as etatbourdereau,
       ff.DESIGNATION as designationfacture
from liaisonbordereauFF lb
    left join bordereauFF_libcomplet B on B.ID = lb.IDBORDEREAU
    left JOIN FACTUREFOURNISSEUR ff on lb.IDOP = ff.ID;

create or replace view LIAISONBORDEREAUFF_LIBCOMPLET as
select
       li.*,
       op.REMARQUE,
       op.id as idfacture,
       b2.designation as idbordereaulib,
       op.MONTANTTTC as montant
from liaisonbordereauff li
    left join bordereauFF_libcomplet b2 on li.idBordereau = b2.id
    left join ETATFACTUREMONTANTDATY op on op.id=li.idOP;
	
CREATE OR REPLACE VIEW ORDONNERPAYEMENT_CREE AS 
  SELECT *
     FROM ORDONNERPAYEMENT_LIBETAT
    WHERE etat = 1;
    
CREATE OR REPLACE VIEW ORDONNERPAYEMENT_N_PAYE AS 
  SELECT *
     FROM ORDONNERPAYEMENT_LIBETAT op
    WHERE     op.id NOT IN (SELECT jc.IDORDRE
                              FROM journalcaisse jc
                             WHERE jc.IDORDRE = op.id)
          AND op.ETAT >= 11;
          
 CREATE OR REPLACE VIEW ORDONNERPAYEMENT_PAYE_LIB AS 
  SELECT op.*
     FROM ORDONNERPAYEMENT_LIBETAT op
          JOIN journalcaisse jc ON jc.IDORDRE = op.id
    WHERE jc.ETAT >= 11 AND op.ETAT >= 11;
    
CREATE OR REPLACE VIEW ORDONNERPAYEMENT_ANNULE AS 
  SELECT *
     FROM ORDONNERPAYEMENT_LIBETAT
    WHERE etat = 0;