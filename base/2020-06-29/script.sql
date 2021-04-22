create  view MVTLIBCOMPLETANALYSEUNION1 as
    select a.*,cast(1 as number(10,2)) as depart,
       cast(0 as number(10,2)) as arrivee
from mouvementLibComplet a
union
select b.*,
       cast(0 as number(10,2)) as depart,
       cast(1 as number(10,2)) as arrivee
from mouvementLibComplet b
/

create view MOUVEMENTLIBCOMPLETANALYSE1 as
select
        M.*
    from MVTLIBCOMPLETANALYSEUNION1 M
/

insert into table MENUDYNAMIQUE values ('MENU002', 'Cargaison', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=cargaison', 7, 4, 'MEN0046');