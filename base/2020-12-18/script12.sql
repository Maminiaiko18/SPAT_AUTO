 CREATE OR REPLACE FORCE VIEW AS_BONDELIVRAISON_MONTANT AS 
  select mere."ID",mere."REMARQUE",mere."IDBC",mere."DATY",mere."ETAT",mere."POINT",mere."ID_BC" ,
    sum(fille.quantite*bcfille.pu) as montant,
    bcmere.tva
from as_bondelivraison mere 
left join as_bondelivraison_fille fille on mere.id=fille.numbl
left join as_bondecommande_fille bcfille on fille.idbondecommande=bcfille.id
left join as_bondecommande bcmere on bcmere.id=bcfille.idbc
where bcmere.etat>=11 
group by mere.id, mere.remarque, mere.idbc, mere.daty, mere.etat, mere.point, mere.id_bc,bcmere.tva;

 
 CREATE OR REPLACE FORCE VIEW AS_BONDELIVRAISON_MONTANTTTC AS 
  select
    mtt."ID",mtt."REMARQUE",mtt."IDBC",mtt."DATY",mtt."ETAT",mtt."POINT",mtt."ID_BC",mtt."MONTANT",mtt."TVA",
    (mtt.tva * mtt.montant)/100 as montantTVA,
    mtt.montant+(mtt.tva * mtt.montant)/100 as montantttc
from as_bondelivraison_montant mtt;

 CREATE OR REPLACE FORCE VIEW AS_BONDELIVRAISON_MTTPAYE AS 
  select
    bl.id,
    nvl(sum(op.montant),0) as montantpaye
from as_bondelivraison bl
left join facturefournisseur ff on ff.remarque=bl.id
left join ORDONNERPAYEMENTGROUPEFACT op on op.ded_id=ff.id
group by  bl.id;

create or replace view facturefournisseur_SumMttGrp as
select 
  fct.idtva,
  sum(fct.montant) as montant,
  fct.remarque
from facturefournisseur_SumMtt fct where fct.etat>=11 group by fct.remarque,fct.idtva;

CREATE OR REPLACE FORCE VIEW AS_BONDELIVRAISON_FACTPAY AS 
  select
    mtttc."ID",mtttc."REMARQUE",mtttc."IDBC",mtttc."DATY",mtttc."ETAT",mtttc."POINT",mtttc."ID_BC",mtttc."MONTANT",mtttc."TVA",mtttc."MONTANTTVA",mtttc."MONTANTTTC",
    nvl(pay.montantpaye,0) as montantpaye,
    nvl(fact.montant,0) as montantfact,
    nvl((fact.montant*fact.idtva)/100,0) as montanttvafact,
    nvl(fact.montant+(fact.montant*fact.idtva)/100,0) as montantfactttc
from as_bondelivraison_montantttc mtttc
left join as_bondelivraison_mttpaye pay on pay.id=mtttc.id 
left join facturefournisseur_SumMttGrp fact on fact.remarque=mtttc.id;


CREATE OR REPLACE FORCE VIEW AS_BONDELIVRAISON_MONTANT AS 
  select mere."ID",mere."REMARQUE",mere."IDBC",mere."DATY",mere."ETAT",mere."POINT",mere."ID_BC" ,
    sum(fille.quantite*bcfille.pu) as montant,
    bcmere.tva
from as_bondelivraison mere 
left join as_bondelivraison_fille fille on mere.id=fille.numbl
left join as_bondecommande_fille bcfille on fille.idbondecommande=bcfille.id
left join as_bondecommande bcmere on bcmere.id=bcfille.idbc
where bcmere.etat>=11  
group by mere.id, mere.remarque, mere.idbc, mere.daty, mere.etat, mere.point, mere.id_bc,bcmere.tva;


CREATE OR REPLACE FORCE VIEW AS_BONDELIVRAISON_MTTCPL AS 
  select
    fp."ID",fp."REMARQUE",fp."IDBC",fp."DATY",fp."ETAT",fp."POINT",fp."ID_BC",fp."MONTANT",fp."TVA",fp."MONTANTTVA",fp."MONTANTTTC",fp."MONTANTPAYE",fp."MONTANTFACT",fp."MONTANTTVAFACT",fp."MONTANTFACTTTC",
    fp.montantfactttc-fp.montantpaye as rap,
    fp.montantttc-fp.montantfactttc as reste_a_facturer
from as_bondelivraison_factPay fp;