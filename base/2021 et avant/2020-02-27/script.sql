------------------------ SPAT_CAPITAINERIE ------------------------

drop materialized view  COMPTA_COMPTE_3CHIFFRE;

create materialized view COMPTA_COMPTE_3CHIFFRE
    refresh force on demand
as
select * from spat_compta.compta_compte_3chiffre;