create or replace view BON_PROVISOIRE_LIB_cree as
select * from bon_provisoire_libcomplet where etat=1;

create or replace view BON_PROVISOIRE_LIB_valide as
select * from bon_provisoire_libcomplet where etat=11;

create or replace view BON_PROVISOIRE_LIB_regularise as
select * from bon_provisoire_libcomplet where etat=12;