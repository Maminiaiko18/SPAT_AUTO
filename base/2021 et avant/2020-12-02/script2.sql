create view Mouvement_arrivee as select * from mouvementlibcomplet where typemvt = 'TPMM00004';
create view Mouvement_depart as select * from mouvementlibcomplet where typemvt = 'TPMM00003';