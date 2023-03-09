insert into commandant values ('CM001','-','-');

delete from menudynamique where id_pere='MEN0061' or id='MEN0061';

update menudynamique set libelle='Gestion des prestations',href='#' where id='MEN0019';

delete from menudynamique where id='MEN0079';

insert into pilote values ('PL001','-','-');

update menudynamique set libelle='Analyse prestation' where id='MEN0087';

delete from manoeuvrebord where id in ('MANO000002','MAN0001','MANO000001');