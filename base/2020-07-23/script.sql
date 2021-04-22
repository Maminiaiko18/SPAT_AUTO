create or replace view sommeReguleBP as 
select idbonprovisoire, sum(montant) as regule from regulBonProvisoire where montant > 0 GROUP BY idbonprovisoire;

create or replace view sommeRetourBP as 
select idbonprovisoire, sum(montant) as retour from regulBonProvisoire where montant < 0 GROUP BY idbonprovisoire;

create or replace view BON_PROVISOIRE_REGULE_RETOUR as 
select bp.*, sregul.regule, sretour.retour from BON_PROVISOIRE_LIB bp left join sommeReguleBP sregul on bp.id = sregul.idbonprovisoire left join sommeRetourBP sretour on bp.id = sretour.idbonprovisoire;