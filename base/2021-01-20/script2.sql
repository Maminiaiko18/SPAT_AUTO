create view ordonnerpayement_n_paye as
select op.*
from ORDONNERPAYEMENT_LIBETAT op
where op.id not  in( select jc.IDORDRE from journalcaisse jc where jc.IDORDRE = op.id)
    and  op.ETAT>=11;