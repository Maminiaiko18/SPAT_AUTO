create view ordonnerpayement_paye_lib  as
select op.*
from ORDONNERPAYEMENT_LIBETAT op
         join journalcaisse jc on jc.IDORDRE = op.id
    where jc.ETAT>=11 and op.ETAT>=11;