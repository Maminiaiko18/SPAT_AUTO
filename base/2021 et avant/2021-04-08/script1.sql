create view etatfacturemontantDatyetatlib as
select et.*,'PAYE(E)' as etatlib from EtatFactureMontantDatyPAYE et
union
select et.*,'VISE(E)' as etatlib from ETATFACTUREMONTANTDATYVISEII et
union
select et.*,'CREE(E)' as etatlib from ETATFACTUREMONTANTDATYCREE et
union
select et.*,'Attente de paiement' as etatlib from  ETATFACTUREATTENTEPAIEMENT et;