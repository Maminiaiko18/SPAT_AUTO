update menudynamique set ID_PERE = 'MEN00153', NIVEAU = 4 where id in ('MEN00147', 'MEN0045', 'MEN0022', 'MEN0031');

update MENUDYNAMIQUE set rang = 3 where id = 'MEN00147';
update MENUDYNAMIQUE set rang = 4 where id = 'MEN0045';
update MENUDYNAMIQUE set rang = 5 where id = 'MEN0022';
update MENUDYNAMIQUE set rang = 6 where id = 'MEN0031';

update menudynamique set NIVEAU = 5 where id_pere in ('MEN00147', 'MEN0045', 'MEN0022', 'MEN0031');