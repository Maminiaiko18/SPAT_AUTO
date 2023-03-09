create view previsionLibCompletC as
    select *
    from previsionLibComplet where ETAT=1;
create view previsionLibCompletV as
    select *
    from previsionLibComplet where ETAT=11;

create view previsionLibCompletA as
    select *
    from previsionLibComplet where ETAT=0;