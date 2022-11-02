
create view journalcaisselib_provision AS
select jc.* from journalcaisselibrecette jc join PROVISIONFACTURETOUS pr on pr.id=jc.idplacement;


create view journalcaisselib_sansprov AS 
select jc.* from journalcaisselibrecette jc left outer join PROVISIONFACTURETOUS pr on pr.id=jc.idplacement
where pr.id is NULL;