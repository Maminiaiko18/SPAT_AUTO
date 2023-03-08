
update menudynamique set href='/spat/pages/globalnegoce.jsp?but=treso/recette-liste.jsp'||'&'||'type=debit' where id='MEN00175';
update menudynamique set href='/spat/pages/globalnegoce.jsp?but=treso/recette-liste.jsp'||'&'||'type=credit' where id='MEN00172';

-------------------- SPAT_CAPITAINERIE --------------------

create or replace view syndicatcree as
    select * from syndicat where etat=1;

create or replace view syndicatvalide as
    select * from syndicat where etat=11;
