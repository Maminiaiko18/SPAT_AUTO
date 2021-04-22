********************* spat_capitainerie *********************

create or replace view V_UNION_PERSONNEL as
select
	cast(ts."SA_CompteurNumero" as varchar2(10)) as id,
	cast(ts."MatriculeSalarie" as varchar2(100)) as matriculeSalarie,
	cast(ts."Nom" as varchar2(100)) as nom,
	cast(ts."Prenom" as varchar2(100)) as prenom,
	CASE ts."Civilite" WHEN 0 THEN 'Feminin' else 'Masculin' end as civilite,
	ts."DateNaissance" as dateNaissance,
	cast(ts."Telephone" as varchar2(20)) as telephone,
	cast(ts."EMail" as varchar2(20)) as email
from spat_rh.t_sal ts
	union all
select
		id as id,
		numero_matricule as matriculeSalarie,
		nom,
		prenom,
		CASE genre WHEN 'F' THEN 'Feminin' else 'Masculin' end as civilite,
		datenaissance,
		telephone,
		mail as email
from infopersonnelglobal;

