create view BORDEREAUFF_LIB_MONTANTC as
    select * from BORDEREAUFF_LIB_MONTANT where etat=1;
create view BORDEREAUFF_LIB_MONTANTV as
    select * from BORDEREAUFF_LIB_MONTANT where etat>=11;
