create or replace view facturefournisseur_SumMtt as
select
    ff.id,
    ff.idfournisseur,
    ff.idtva,
    ff.dateemission,
    ff.datyecheance,
    ff.exercice,
    ff.type,
    ff.remarque,
    sum(dff.qte*dff.pu) as montant,
	ff.etat
from facturefournisseur ff
join detailsfacturefournisseur dff on dff.idmere=ff.id 
group by ff.id,
    ff.idfournisseur,
    ff.idtva,
    ff.dateemission,
    ff.datyecheance,
    ff.exercice,
    ff.type,ff.remarque,ff.etat ;
	
create or replace view contrat_chantier_mttpaye as
select
    ch.id,
    sum(op.montant) as montantpaye
from contrat_chantier ch 
join facturefournisseur fact on fact.remarque=ch.id
join ORDONNERPAYEMENTGROUPEFACT op on op.ded_id=fact.id
group by ch.id;
	
	
create or replace view contrat_chantier_Sum as
select 
    ch.*,
   nvl(fact.montant,0) as montantfact,
   ch.montant-nvl(fact.montant,0) as resteAfacturer,
    nvl(pay.montantpaye,0) as montant_paye,
    nvl(fact.montant-nvl(pay.montantpaye,0),0) as reste_a_payer
from contrat_chantier ch
left join facturefournisseur_SumMtt fact on fact.remarque=ch.id
left join contrat_chantier_mttpaye pay on pay.id=ch.id
;

