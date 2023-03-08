--MINIMUM DE PERCEPTION PILOTAGE C 
update detformufact set condition='[estNational]==''National''&&[volume]<15000&&[cargaison]==''CGM00001''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''' where id='DFF0000000023170452M';

--PILOTAGE MANOEUVRE E/S FERIÉ C (pétrolier)
update detformufact set condition='[estNational]==''National''&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170470';

--nandeha en double
delete from detformufact where id='DFF0000000023170470X';

--nandeha en double
delete from detformufact where id='DFF0000000023170466';
