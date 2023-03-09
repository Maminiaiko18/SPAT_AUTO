create view listeBordereauFFchoixlib
as
select ff.id,
        b.DESIGNATION as idbourdereau,
       f.DESIGNATION as idop
from LIAISONBORDEREAUFF ff
    left join BORDEREAUFF B on B.ID = ff.IDBORDEREAU
    left join FACTUREFOURNISSEUR f on ff.IDOP = f.ID ;