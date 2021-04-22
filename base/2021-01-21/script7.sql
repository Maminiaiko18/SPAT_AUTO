
CREATE OR REPLACE VIEW ORDONNERPAYEMENT_BORDEREAU AS
(
	SELECT 
	op.*,
	bord.ID AS idBordereau
	FROM ORDONNERPAYEMENT op
	JOIN LIAISONBORDEREAU liaison ON op.ID  = LIAISON.IDOP
	JOIN BORDEREAU bord ON bord.ID = LIAISON.IDBORDEREAU 
);

create or replace view BED_PDF as
select op.id,

       lt.ID1                   as idfacture,
       ff.DESIGNATION,
       ff.MONTANT               as puht,
       cast(1 as number(10, 2)) as quantite,
       ff.MONTANTTVA,
       ff.MONTANTTTC,
       ti.NOM                   as TIERS,
       op.NUMEROOP,
       ff.DATY
from LIAISONINTRATABLE lt
         join ORDONNERPAYEMENT op
              on op.id = lt.id2
         join ETATFACTUREMONTANTDATY ff on ff.id = lt.ID1
         left join FOURNISSEUR_UNION_PERSONNEL ti on ti.id = op.tiers
where op.ETAT < 11
group by op.id, lt.ID1, ff.DESIGNATION, ff.MONTANT, cast(1 as number(10, 2)), ff.MONTANTTVA, ff.MONTANTTTC, ti.NOM,
         NUMEROOP, ff.DATY
/

CREATE OR REPLACE VIEW ORDONNERPAYEMENT_BORDEREAU AS
(
	SELECT 
	op.*,
	bord.ID AS idBordereau
	FROM ORDONNERPAYEMENT op
	JOIN LIAISONBORDEREAU liaison ON op.ID  = LIAISON.IDOP
	JOIN BORDEREAU bord ON bord.ID = LIAISON.IDBORDEREAU 
);