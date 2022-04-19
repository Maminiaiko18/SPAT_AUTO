--MINIMUM DE PERCEPTION PILOTAGE C PETROLIER
update detformufact set condition='[estNational]==''National''&&[volume]<15000&&[cargaison]==''CGM00001''' where id='DFF0000000023170452M';

--PILOTAGE MANOEUVRE E/S JOUR C
delete from detformufact where id='DFF0000000023170464';

-- PILOTAGE MANOEUVRE E/S JOUR C pétrolier - 0,537 (plein ou vide)
update detformufact set condition='[estNational]==''National''&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''' where id='DFF0000000023170468';

--PILOTAGE MANOEUVRE E/S JOUR LC pétrolier sortie
--update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170465';

--PILOTAGE MANOEUVRE E/S JOUR LC non pétrolier
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170457';


--MOUVEMENT A L INTERIEUR DU PORT NUIT
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170463X';


