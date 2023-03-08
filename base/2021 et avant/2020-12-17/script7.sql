
CREATE OR REPLACE
VIEW AVOIR_LIB_VAL AS
SELECT
	av.*,
	fc.DESIGNATION ,
	ta.DESCE AS TYPEAVOIR_desce 
FROM
	avoir av
LEFT JOIN FACTUREFOURNISSEUR fc ON
	fc.id = av.idfacture
LEFT JOIN typeavoir ta ON
	ta.id = av.type;