create or replace view AS_BONDELIVRAISON_BC AS
select bl.*,
        bc.NUMBC
from AS_BONDELIVRAISON bl
  left join  AS_BONDECOMMANDE bc on bl.ID_BC=bc.ID;