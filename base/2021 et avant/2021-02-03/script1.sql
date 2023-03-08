create view report_cree as
select *
from reportlib
where ETAT = 1;
create view report_vise as
select *
from reportlib
where ETAT >= 1;