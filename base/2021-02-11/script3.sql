alter table tarifRubriqueFactureClient add compte varchar2(500);


create or replace view tarifRubriqueFactureClient_lib as
select trfc.id,
       trfc.borne_inf,
       trfc.borne_sup,
       trfc.prixUnitaire,
       dev.VAL as iddevise,
       nat.VAL as idNature,
       trfc.unite,
       trfc.etat,
       trfc.compte
from tarifRubriqueFactureClient trfc
         join DEVISE dev on dev.ID = trfc.iddevise
         join NATUREOPERATION nat on nat.ID = trfc.idNature;

create or replace view tarifRubriqueFactureClientcree
as
select *
from tarifRubriqueFactureClient_lib
where etat = 1;

create or replace view tarifRubriqueFactureClientvise
as
select *
from tarifRubriqueFactureClient_lib
where etat = 11;
