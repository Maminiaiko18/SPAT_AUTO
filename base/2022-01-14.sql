create view facture_fournisseur_mereAuto as
select * from facture_fournisseur_mere where estauto=1;



alter table FACTURECLIENT add estAuto integer;



create view factureclientAuto as
select * from factureclient where estauto=1;


create view FACTUREfournisseurAUTO as
select * from facture_fournisseur_mere where estAuto=1;
