

----------add column daty
CREATE OR REPLACE  VIEW LIAISONENGAGEMENTBCFF (IDENGAGEMENT, MONTANT, MONTANTBC, MONTANTFF, MONTANTRESTE,daty) AS 
  SELECT
--------view hijerena RESTE ENGAGEMENT (atao moins ze efa niasa tam Bc na ze efa niasa tamnah FF)
e.id AS idengagement,
CAST(e.MONTANT AS NUMBER (30,2)) ,
CAST(nvl(ag.montant,0) AS number(30,2)) AS montantbc,
CAST(nvl(ff.montant,0) AS number(30,2)) AS montantff,
CAST(CASE 
	WHEN (nvl(e.MONTANT,0)-nvl(ag.montant,0)-nvl(ff.montant,0))<0
			THEN CAST(0 AS number(30,2))
	ELSE 
			CAST((nvl(e.MONTANT,0)-nvl(ag.montant,0)-nvl(ff.montant,0)) AS number(30,2))
END AS number(30,2)),
e.DATY 
AS MONTANTreste
FROM ENGAGEMENT e 
LEFT JOIN  bc_engag_montant ag ON ag.idengagement =e.ID  
LEFT JOIN FACTFOURN_engag_nonbc_grp ff ON ff.idengagement =e.ID
;

------------- Tiavina
-------- 2023-06-05

CREATE VIEW liaisonEngagementFF AS 

SELECT 
e.*,
l.ID2 AS idfacturefournisseur
FROM ENGAGEMENTLIB e
JOIN LIAISONENGAGEMENT l  ON  l.ID1 = e.ID 
WHERE l.ETAT =11;

---------- Itokiana

CREATE OR REPLACE VIEW facture_fournisseur_engagement AS SELECT FACTUREFOURNVALIDE_TOUS.id,
FACTUREFOURNVALIDE_TOUS.daty,
FACTUREFOURNVALIDE_TOUS.tierslib,
FACTUREFOURNVALIDE_TOUS. numeroop,
FACTUREFOURNVALIDE_TOUS. code,
FACTUREFOURNVALIDE_TOUS. projetlib,
FACTUREFOURNVALIDE_TOUS. code_etablissementlib,
FACTUREFOURNVALIDE_TOUS. naturelib,
FACTUREFOURNVALIDE_TOUS.designation,
FACTUREFOURNVALIDE_TOUS.exercice,
FACTUREFOURNVALIDE_TOUS.date_echeance,
FACTUREFOURNVALIDE_TOUS. montantTTCvrai,
FACTUREFOURNVALIDE_TOUS. montantAvoir,
FACTUREFOURNVALIDE_TOUS. montantTTC,
FACTUREFOURNVALIDE_TOUS. montantpaye,
FACTUREFOURNVALIDE_TOUS.montantreste,
FACTUREFOURNVALIDE_TOUS.numOP,
FACTUREFOURNVALIDE_TOUS. etatlib,
LIAISONENGAGEMENTFF.id AS idengagement
FROM
FACTUREFOURNVALIDE_TOUS
JOIN LIAISONENGAGEMENTFF ON
FACTUREFOURNVALIDE_TOUS.id = LIAISONENGAGEMENTFF.idfacturefournisseur;
