CREATE  VIEW JOURNALCAISSE_BANQUE
            (ID, DATESAISIE, DATEEFFET, FOLIO, CAISSE, NUMPIECE, LIBELLE, DEBIT, CREDIT, REMARQUE, ETAT, TIERS,
             IDTYPECHEQUE, IDPLACEMENT, IDORDRE, IDMODE, NUMCHEQUE,VALIDMODE)
AS
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
       IDORDRE,
       IDMODE,
       NUMCHEQUE,
       MP.VAL AS VALIDMODE
from journalcaisselibcomplet lib
         left join TIERS ti on ti.ID = lib.TIERS
         LEFT JOIN MODEPAIEMENT MP ON MP.ID=LIB.IDMODE;