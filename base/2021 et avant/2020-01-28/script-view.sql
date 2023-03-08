create view PLACEMENTLIBETATCOMPLET as (

	select
		plt."ID",plt."ENTITE",plt."DATE_PLACEMENT",plt."DATE_ECHEANCE",plt."DUREE",plt."MONTANT",plt."TAUX",
		case plt."ETAT"
			when 1 then 'EN COURS'
			when 12 then 'ECHU'
			end as ETAT,
		plt."NUMERO",
		det.ID as iddetails, IDMERE as idmeredetails, MOIS, MONTANT_TERME, INTERET_RECEVOIR, INTERET_NET,
		lp.IDENTITE, lp.IDBANQUE, lp.VALENTITE, lp.DESCEENTITE, lp.VALBANQUE, lp.DESCEBANQUE
	from placement plt
		join DETAILSPLACEMENT det on plt.ID = det.IDMERE
		join LIAISONPLACEMENTLIBCOMPLET lp on lp.id = plt.ENTITE
);	
	

create view caisse_lib as (
    select * from caisse where upper(desce) = 'CAISSE'
);