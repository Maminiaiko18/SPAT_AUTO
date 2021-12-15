
create  view avoirfcfille_fm as
select fil.*,
       DATY,
       IDFACTURE,
       ETAT,
       DESIGNATION,
       CODE,
       CATEGORIE,
       MOTIF,
       TYPE
from avoirfcfille fil
         left join avoirfc av on av.ID = fil.IDMERE;

create view avoirfcfille_vm as
select *from avoirfcfille_fm
    where etat=11;


create view facture_client_avoir_vm as
select vm.*from facture_client_fille_vm vm
    join avoirfcfille_fm fm on vm.ID=fm.IDDETAILFACTURE;
