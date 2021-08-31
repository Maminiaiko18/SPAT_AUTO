
create or replace view provisionEcart as
select tp.*,
       cast(montantTTC - montantPaye as number(30,3)) as ecart
from tousProvision tp;