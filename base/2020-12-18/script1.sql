create or replace view as_bondelivraison_montant as
select mere.* ,
    sum(fille.quantite*bcfille.pu) as montant,
    bcmere.tva

from as_bondelivraison mere 
join as_bondelivraison_fille fille on mere.id=fille.numbl
join as_bondecommande_fille bcfille on fille.idbondecommande=bcfille.id
join as_bondecommande bcmere on bcmere.id=bcfille.idbc
where bcmere.etat>=11  
group by mere.id, mere.remarque, mere.idbc, mere.daty, mere.etat, mere.point, mere.id_bc,bcmere.tva
;

create or replace view as_bondelivraison_montantttc as
select
    mtt.*,
    (mtt.tva * mtt.montant)/100 as montantTVA,
    mtt.montant+(mtt.tva * mtt.montant)/100 as montantttc
from as_bondelivraison_montant mtt ;

create or replace view as_bondelivraison_mttpaye as
select
    bl.id,
    sum(op.montant) as montantpaye
from as_bondelivraison bl
join facturefournisseur ff on ff.remarque=bl.id
join ORDONNERPAYEMENTGROUPEFACT op on op.ded_id=ff.id
group by  bl.id;

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
    sum(dff.qte*dff.pu) as montant
from facturefournisseur ff
join detailsfacturefournisseur dff on dff.idmere=ff.id 
group by ff.id,
    ff.idfournisseur,
    ff.idtva,
    ff.dateemission,
    ff.datyecheance,
    ff.exercice,
    ff.type,ff.remarque ;

create or replace view as_bondelivraison_factPay as
select
    mtttc.*,
    pay.montantpaye,
    fact.montant as montantfact,
    (fact.montant*fact.idtva)/100 as montanttvafact,
    fact.montant+(fact.montant*fact.idtva)/100 as montantfactttc
from as_bondelivraison_montantttc mtttc
join as_bondelivraison_mttpaye pay on pay.id=mtttc.id 
join facturefournisseur_SumMtt fact on fact.remarque=mtttc.id;

create or replace view as_bondelivraison_MttCpl as
select
    fp.*,
    fp.montantfactttc-fp.montantpaye as rap,
    fp.montantttc-fp.montantfactttc as reste_a_facturer
from as_bondelivraison_factPay fp;

