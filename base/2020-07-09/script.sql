create or replace view reportlib as
select r.id, daty, montant,c.val as caisse,devise,c.id as idcaisse
from report r
join caisse c on
r.caisse=c.id;