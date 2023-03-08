--Mise à jour placement
	--DAT/SBM
delete from detailsplacement where idmere='PLC0000000468105352';
delete from placement where id='PLC0000000468105352';

--Misy données diso ao amin'ny BFV/DEVISE en euro
delete from paiementfacturef where idmvt in (select id from journalcaisse where caisse='CAIS000011');
delete from journalcaisse where caisse='CAIS000011';