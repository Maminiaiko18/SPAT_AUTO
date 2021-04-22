CREATE OR REPLACE FORCE VIEW VIEW_FACTURECLIENT_2 AS 
select
	f.id,
	f.daty,
	V_CLIENT_CATEGORIE.NOMCLT AS tiers,
	f.designation,
	f.montant,
	f.TYPEE,
	f.tva,
	f.montanttva,
	f.etat,
	f.devise,
	f.compte,
	f.remarque,
	f.coursdevise,
	f.ANTENNE,
	'' as service
	from facture_client f
	join V_CLIENT_CATEGORIE on f.tiers = V_CLIENT_CATEGORIE.CDCLT ;