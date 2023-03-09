create or replace view FOURNISSEUR_UNION_PERSONNEL as
select
  tp.ID,
  tp.NOM,
  tp.DESCRIPTION,
  tp.NIF,
  tp.STAT,
  tp.CONTACT,
  tp.RESPONSABLE,
  tp.ADRESSE,
  tp.TYPE,
  tp.ETAT
from TIERS_PRESTATAIRE tp
UNION
select
  an.SA_COMPTEURNUMERO as ID,
  an.NOM ||' '||an.PRENOM as nom,
  '' as DESCRIPTION,
  '' as NIF,
  '' as STAT,
  an.TELEPHONE as CONTACT,
  '' as RESPONSABLE,
  an.RUE1 as ADRESSE,
  an.TYPE,
  11 as etat
from ANALYSEPERSONNELUNION an
/

create or replace view ORDONNERPAYEMENT_PDF as
select op.*,
       fup.NOM as beneficiaire,
       fup.adresse,
       nvl(ff.IDDEVISE,'Ar')                       as devise,
       ff.NUMFACT

from ordonnerpayement_lib op
         left join etatfacturemontantdaty ff on ff.id = op.DED_ID
         left join fournisseur_union_personnel fup on fup.id = ff.IDFOURNISSEUR
where op.ETAT>=11
/
