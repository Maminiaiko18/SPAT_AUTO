
CREATE OR REPLACE FORCE VIEW JOURNALCAISSE_LIB as
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
         left join FOURNISSEUR_UNION_PERSONNEL ti on ti.ID = lib.TIERS;