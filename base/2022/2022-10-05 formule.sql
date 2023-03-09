
--Veille de sécurité
update detformufact set mere='RB0000000021170449' where id in ('DFF0000000023170518','DFF0000000023170519');

update detformufact set condition='[estNational]==''National''&&[cargaison]==''CGM00001''&&[estdernierstat]==''TRUE''', formuleqte='[nbheure]' where id='DFF0000000023170518';

update detformufact set condition='[estNational]==''International''&&[cargaison]==''CGM00001''&&[estdernierstat]==''TRUE''', formuleqte='[nbheure]' where id='DFF0000000023170519';