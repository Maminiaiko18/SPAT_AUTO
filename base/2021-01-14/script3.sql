create or replace view JOURNALCAISSELIBCOMPLET as
select j.*,
       c.ID     as idcaisse,
       c.val    as valcaisse,
       c.desce  as descecaisse,
       tc.val   as valtypecheque,
       tc.desce as descetypecheque
from Journalcaisse j
         join CAISSE C on j.CAISSE = C.ID
         left join TYPECHEQUE tc on tc.id = j.idtypecheque
/


create or replace view JOURNALCAISSE_LIB as
select lib.id,
       datesaisie,
       dateeffet,
       folio,
       valcaisse              as caisse,
       numpiece,
       libelle,
       debit,
       credit,
       remarque,
       lib.etat,
       nvl(ti.NOM, lib.tiers) as tiers,
       valtypecheque          as idtypecheque,
       IDPLACEMENT,
       IDORDRE
from journalcaisselibcomplet lib
         left join TIERS ti on ti.ID = lib.TIERS
/