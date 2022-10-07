
        Create view paiementfacturelib as
select
pf.*,
fc.code
FROM  paiementfacture pf 
left join factureclient fc on fc.id=pf.idfact;
