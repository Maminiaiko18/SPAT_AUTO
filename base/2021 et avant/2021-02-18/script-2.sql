
CREATE VIEW mvtintracaisse_lib_cree AS
select *
from mvtintracaisse_lib
where ETAT=1;
CREATE VIEW mvtintracaisse_lib_visee AS
select *
from mvtintracaisse_lib
where ETAT=11;