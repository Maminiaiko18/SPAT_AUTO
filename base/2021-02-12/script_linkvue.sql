CREATE MATERIALIZED VIEW produit_cemedi AS
select * from st_article@link_test_II;
 
ALTER MATERIALIZED VIEW produit_cemedi
 REFRESH COMPLETE START WITH (sysdate)
 NEXT SYSDATE + 30/86400;


CREATE MATERIALIZED VIEW unite_cemedi AS
select * from st_unite@link_test_II;

ALTER MATERIALIZED VIEW unite_cemedi
 REFRESH COMPLETE START WITH (sysdate)
 NEXT SYSDATE + 30/86400;
