create or replace view ordonnerpayement_pdf as
select op.*,
       fup.adresse,
       ff.IDDEVISE as devise
from ordonnerpayement op
        left  join etatfacturemontantdaty ff on ff.id=op.DED_ID
        left join fournisseur_union_personnel fup on fup.id=ff.IDFOURNISSEUR;

CREATE OR REPLACE
FORCE VIEW ADDITIFLIB AS
SELECT
	ad.ID,
	ad.DATY,
	ff.DESIGNATION AS IDFACTURE,
	ad.MONTANT,
CASE
		WHEN ad.TYPE = '1' THEN 'HT'
		WHEN ad.TYPE = '2' THEN 'TTC'
	END AS TYPE ,
	ad.ETAT
FROM
	additif ad
LEFT JOIN FACTUREFOURNISSEUR ff ON
	ff.id = ad.IDFACTURE;

CREATE OR REPLACE
FORCE VIEW AVOIR_LIB AS
SELECT
	av.id,
	av.daty,
	fc.DESIGNATION AS idfacture,
	AV.montant,
CASE
		WHEN AV.TYPE = '1' THEN 'HT'
		WHEN AV.TYPE = '2' THEN 'TTC'
	END AS TYPE ,
	AV.etat
FROM
	avoir av
LEFT JOIN FACTUREFOURNISSEUR fc ON
	fc.id = av.idfacture;

