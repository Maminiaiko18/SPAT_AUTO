--delete typemvt--
truncate table mvtcaisse;
truncate table mouvement;
delete from typemvt where id = 'TPMM00002';
delete from typemvt where id = 'TPMM00001';
delete from typemvt where id = 'TPMM00004';
insert into typemvt values ('TPMM00001', 'Arrivee', 'Arrivee');
