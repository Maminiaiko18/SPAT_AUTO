--PILOTAGE NAT
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170458';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170460';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170462';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''' where id='DFF0000000023170468';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]!=''MDB_0004''' where id='DFF0000000023170470';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]<11500&&[cargaison]!=''CGM00001''' where id='DFF0000000023170452';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170456';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]<15000&&[cargaison]==''CGM00001''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''' where id='DFF0000000023170452M';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170458X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170462X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''' where id='DFF0000000023170466X';

--PILOTAGE INTERNATIONAL
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170459';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=11500&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170465';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&([cargaison]==''CGM00001'')&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170467';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=11500&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170469';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170471';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]<11500' where id='DFF0000000023170453';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=11500&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170457';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF001';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170459X';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170471X';

--LAMANAGE NATIONAL
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170530';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170520';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170522';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170524';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170526';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170528';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170522X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170530X';

--LAMANAGE INTERNATIONAL
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170531';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170521';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170523';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170525';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170527';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170523X';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170527X';

--REMORQUAGE NATIONAL
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]<3000' where id='DFF0000000023170472';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170476';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170478';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170480';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170482';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF0000000023170535';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF0000000023170537';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF0000000023170539';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF0000000023170541';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170484';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170486';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170512';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170514';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170516';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170492';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170494';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170496';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170498';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170502';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170504';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170506';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170508';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=3000&&[volume]<20000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170486X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=3000&&[volume]<5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170478X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170482X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF0000000023170541X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=50000&&[volume]<100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170512X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170516X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170490X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=50000&&[volume]<100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170494X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170498X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=3000&&[volume]<20000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170504X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170508X';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170510';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170488';
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170490';

--REMORQUAGE INTERNATIONAL
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]<3000' where id='DFF0000000023170473';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170477';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170479';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''' where id='DFF00000000231704781';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170483';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=3000&&[volume]<5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF00000000231704536';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF0000000023170538';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=5000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF00000000231704540';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF0000000023170542';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170485';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170511';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170513';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170515';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170517';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170491';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=50000&&[volume]<100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170493';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170495';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=100000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170497';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend''||([estFerie]==''NONFERIE''&&[estJour]==''NUIT''))&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170499';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=3000&&[volume]<20000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170503';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170505';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170507';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=3000&&[volume]<5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170479X';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170483X';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=3000&&[volume]<5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF0000000023170538X';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=50000&&[volume]<100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170513X';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=3000&&[volume]<20000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170487X';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170491X';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=50000&&[volume]<100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170495X';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=3000&&[volume]<20000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170505X';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170509X';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170509';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170487';
update detformufact set condition='([estNational]==''International''||([estNational]==''National''&&([provenanceMadagascar]==0||[destinationMadagascar]==0)))&&[volume]>=20000&&[volume]<50000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170489';


--PILOTAGE A L"intérieur du port nuit
insert into detformufact values('DFF0000000023170460N','1','1','0.705','UA041','PILOTAGE A L''INT. DU PORT NUIT C ','RB0000000021170445','([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]==''MDB_0004''','[volumeArrondi]','70682');
insert into detformufact values('DFF0000000023170460F','1','1','0.705','UA041','PILOTAGE A L''INT. DU PORT FERIE C ','RB0000000021170445','([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0004''','[volumeArrondi]','70682');


--Added on 26 july
--PILOTAGE MANOEUVRE E/S FERIÉ C 
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''' where id='DFF0000000023170462';

--PILOTAGE MANOEUVRE E/S NUIT C
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]!=''MDB_0004''' where id='DFF0000000023170462X';

--PILOTAGE A L'INT. DU PORT JOUR C
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170460';

--PILOTAGE MIN PERCEP C (natao <15000 au lieu de inf 11500 dia nampiana condition jour)
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]<15000&&[cargaison]!=''CGM00001''[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''' where id='DFF0000000023170452';

--PILOTAGE A L INT. DU PORT NUIT C 
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170460N';

--PILOTAGE A L INT. DU PORT FERIE C 
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170460F';



--PILOTAGE MANOEUVRE E/S FERIÉ C 
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170458';
--update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''' where id='DFF0000000023170462';

--delete
delete from detformufact where id='DFF0000000023170458';

--------------------------------------------------------------------------------------
--27/07/2022
--PILOTAGE MANOEUVRE E/S JOUR C 
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170456';

--PILOTAGE MANOEUVRE E/S FERIÉ C 
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''' where id='DFF0000000023170462';

--PILOTAGE MANOEUVRE E/S NUIT C
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]!=''MDB_0004''' where id='DFF0000000023170462X';

--PILOTAGE A L'INT. DU PORT JOUR C navadika sup 15000
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=15000&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170460';

--PILOTAGE A L INT. DU PORT NUIT C 
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170460N';

--PILOTAGE A L INT. DU PORT FERIE C 
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170460F';


--PILOTAGE MIN PERCEP C jOUR moins de 15000 si jour
update detformufact set condition='([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]<15000&&[cargaison]!=''CGM00001''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''' where id='DFF0000000023170452';

--PILOTAGE MIN PERCEP C FERIE
insert into detformufact values ('DFF0000000023170452F','1','1','91.634','UA016','MINIMUM DE PERCEPTION PILOTAGE C ','RB0000000021170445','([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]<11500&&[cargaison]!=''CGM00001''&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')','1','70682');

--PILOTAGE MIN PERCEP C NUIT
insert into detformufact values ('DFF0000000023170452N','1','1','91.634','UA016','MINIMUM DE PERCEPTION PILOTAGE C ','RB0000000021170445','([estNational]==''National''&&[provenanceMadagascar]==1&&[destinationMadagascar]==1)&&[volume]<11500&&[cargaison]!=''CGM00001''&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')','1','70682');



CREATE OR REPLACE VIEW "ACTIVITELIBCOMPLET" ("ID", "DESIGNATION", "CLIENT", "RUBRIQUE", "QTE", "MOIS", "MOISLIB", "ANNEE", "DATY", "BATEAU", "ETAT", "RUBRIQUELIB", "NAVIRE", "BATEAULIB", "POIDS", "LONGUEUR", "LARGEUR", "AUTRES", "PU", "DEVISE", "COMPTE", "UNITE", "DIRECTION", "CONDITION", "TVA", "OBJET", "REDEVANCE", "CLIENTLIB", "REDEVANCELIB", "DIRECTIONLIB", "ETATLIB", "CATEGORIE", "CATEGORIELIB", "REFOBJET", "TYPESOURCE", "DATEFACT", "POSTE", "POSTELIB", "DATEDEBUT", "HEUREDEBUT", "DATEFIN", "HEUREFIN", "VOLUME", "VOLUMEARRONDI", "CARGAISON", "IDPRESTATION", "ESTNATIONAL", "ESTJOUR", "ESTFERIE", "MANOEUVRE", "ESTWEEKEND", "NATUREOPERATION", "NBQUARTHEURE", "NBHEURE", "NBJOUR", "TYPEQUAIS", "SURFACE", "NB5JOURS", "QUAI", "FLOTTE", "CATEGORIE_FLOTTE", "UNITELIB", "ESTPETROLIER", "VOLUMERUBRIQUE", "TAUX", "TIRANT", "VOLUMEVIR", "NBHEUREPREV", "DEPART", "ARRIVE", "PROVENANCEPAYS", "DESTINATIONPAYS", "PROVENANCEMADAGASCAR", "DESTINATIONMADAGASCAR") AS 
  SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                                                                                      AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION                                                                                AS rubriquelib,
       nv.id                                                                                         AS navire,
       nv.NOM                                                                                        AS bateaulib,
       nv.PLT                                                                                        AS poids,
       nv.LHT                                                                                        AS longueur,
       nv.LM                                                                                         AS largeur,
       CAST('-' AS VARCHAR2(100))                                                                    AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       case
           when (
           			nv.PAVILLON not in ('PAYS000054', 'PAYS000010', 'PAYS000057')
           			OR 
           			(nv.PAVILLON in ('PAYS000054', 'PAYS000010', 'PAYS000057') AND 
           			(occ.provenancePays not in ('PAYS000054', 'PAYS000010', 'PAYS000057') OR occ.destinationPays not in ('PAYS000054', 'PAYS000010', 'PAYS000057'))
           			)
           		)
               and rubrique in ('RB0000000021170445', 'RB0000000021170446', 'RB0000000021170447')
               then 0
           else ra.tva
           end                                                                                       as tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                                                                       AS clientlib,
       re.VAL                                                                                        AS redevancelib,
       di.LIBELLEDIR                                                                                 AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                                                                                     AS ETATLIB,
       ra.CATEGORIE,
       cf.val                                                                                        AS categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART                                                                               AS DATEFACT,
       ac.POSTE,
       pd.VALQUAIS                                                                                   AS postelib,
       ac.DATEDEBUT,
       ac.HEUREDEBUT,
       ac.DATEFIN,
       ac.HEUREFIN,
       CAST(
               TRUNC(nv.lm, 2) * TRUNC(nv.lht, 2) * TRUNC(nv.te, 2) AS NUMBER(10, 3))
                                                                                                     AS volume,
       cast(round((TRUNC(nv.lm, 2) * TRUNC(nv.lht, 2) * TRUNC(nv.te, 2)) / 100, 1) AS number(10, 0)) AS volumeArrondi,
       NVL(pre.cargaison, '-')                                                                       AS cargaison,
       pre.id                                                                                        AS idprestation,
       CASE
           WHEN nv.pavillon = 'PAYS000054'
               OR nv.pavillon = 'PAYS000010'
               OR nv.pavillon = 'PAYS000057'
               THEN
               'National'
           WHEN nv.pavillon != 'PAYS000054'
               OR nv.pavillon != 'PAYS000010'
               OR nv.pavillon != 'PAYS000057'
               THEN
               'International'
           END
                                                                                                     AS estNational,
       CASE
           WHEN ac.heuredebut BETWEEN '05:00:00' AND '18:59:59' THEN 'JOUR'
           ELSE 'NUIT'
           END
                                                                                                     AS estJour,
       CASE
           WHEN ac.daty IN (SELECT daty FROM jour_ferie) THEN 'FERIE'
           ELSE 'NONFERIE'
           END
                                                                                                     AS estFerie,
       occ.idmanoeuvrebord                                                                           AS manoeuvre,
       CASE
           WHEN TO_CHAR(ac.daty, 'DAY') LIKE '%DIMANCHE%'
               OR TO_CHAR(ac.daty, 'DAY') LIKE '%SAMEDI%'
               THEN
               'weekend'
           ELSE
               'normal'
           END
                                                                                                     AS estWeekend,
       occ.IDNATUREOPERATION                                                                         AS natureoperation,
       CASE
           WHEN ((60
               * 24
               * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                          'dd-mm-yy hh24:mi:ss')
                   - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                             'dd-mm-yy hh24:mi:ss')))
               - 60) < 0
               THEN
               0
           WHEN ((60
               * 24
               * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                          'dd-mm-yy hh24:mi:ss')
                   - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                             'dd-mm-yy hh24:mi:ss')))
               - 60) <= 1
               THEN
               0
           ELSE
               CEIL(
                           ((60
                               * 24
                               * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                          'dd-mm-yy hh24:mi:ss')
                                   - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                             'dd-mm-yy hh24:mi:ss')))
                               - 60)
                           / 15)
           END
                                                                                                     AS nbQuartHeure,
       CASE
           WHEN 24
                    * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                               'dd-mm-yy hh24:mi:ss')
                   - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                             'dd-mm-yy hh24:mi:ss')) < 0
               THEN
               0
           ELSE
               (CEIL(
                           24
                           * (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                     'dd-mm-yy hh24:mi:ss'))))
           END
                                                                                                     AS nbHeure,
       CASE
           WHEN (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                         'dd-mm-yy hh24:mi:ss')
               - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                         'dd-mm-yy hh24:mi:ss')) < 0
               THEN
               0
           WHEN ROUND(
                        (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                 'dd-mm-yy hh24:mi:ss')
                            - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                      'dd-mm-yy hh24:mi:ss'))) = 0 or ROUND(
                                                                              (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                                                                       'dd-mm-yy hh24:mi:ss')
                                                                                  - TO_DATE(
                                                                                       ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                                                                       'dd-mm-yy hh24:mi:ss'))) = 1
               THEN
               1
           ELSE
                   ((TO_DATE(ac.DATEFIN, 'dd-mm-yy')
                       - TO_DATE(ac.DATEDEBUT, 'dd-mm-yy')))
                   + 1
           END
                                                                                                     AS nbJour,
       CASE WHEN TYPESOURCE IS NULL THEN q.typequais ELSE ty.TYPEQUAIS END
                                                                                                     AS typequais,
       --type not postedestinaire
       CAST(nv.LHT * nv.lm AS NUMBER(20, 2))                                                         AS surface,
       CASE
           WHEN (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                         'dd-mm-yy hh24:mi:ss')
               - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                         'dd-mm-yy hh24:mi:ss')) < 0
               THEN
               0
           ELSE
               CASE
                   WHEN ROUND(
                           (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                    'dd-mm-yy hh24:mi:ss')
                               - TO_DATE(ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                         'dd-mm-yy hh24:mi:ss'))) BETWEEN 0
                       AND 5
                       THEN
                       1
                   ELSE
                       (TRUNC(
                                    (TO_DATE(ac.DATEFIN || ' ' || ac.HEUREFIN,
                                             'dd-mm-yy hh24:mi:ss')
                                        - TO_DATE(
                                             ac.DATEDEBUT || ' ' || ac.HEUREDEBUT,
                                             'dd-mm-yy hh24:mi:ss'))
                                    / 5)
                           + 1)
                   END
           END
                                                                                                     AS nb5jours,
       pd2.QUAI,
       occ.IDMATERIEL_NAVAL                                                                          AS flotte,
       cm.IDCATEGORIE                                                                                AS categorie_flotte,
       ua.VAL                                                                                        AS unitelib,
       CASE WHEN nv.TYPE = 'TP0001' THEN 'TRUE' ELSE 'FALSE' END
                                                                                                     AS estPetrolier,
       RA.VOLUME                                                                                     AS volumeRubrique,
       ac.TAUX,
       nv.te                                                                                         AS tirant,
       cast((TRUNC(nv.lm, 2) * TRUNC(nv.lht, 2) * TRUNC(nv.te, 2)) / 100 as number(10, 2))           AS volumeVir,
       CASE
           WHEN pre.DATE_DEPART IS NULL
               OR pre.DATE_ARRIVEE IS NULL
               OR HEURE_DEPART IS NULL
               OR HEURE_ARRIVEE IS NULL
               OR (24
                       * (TO_DATE(
                                  pre.DATE_DEPART || ' ' || pre.HEURE_DEPART,
                                  'dd-mm-yy hh24:mi:ss')
                       - TO_DATE(
                                  pre.DATE_ARRIVEE || ' ' || pre.HEURE_ARRIVEE,
                                  'dd-mm-yy hh24:mi:ss')) < 0)
               THEN
               0
           ELSE
               (CEIL(
                           24
                           * (TO_DATE(pre.DATE_DEPART || ' ' || pre.HEURE_DEPART,
                                      'dd-mm-yy hh24:mi:ss')
                           - TO_DATE(
                                      pre.DATE_ARRIVEE || ' ' || pre.HEURE_ARRIVEE,
                                      'dd-mm-yy hh24:mi:ss'))))
           END
                                                                                                     AS nbHeurePrev,
       CASE
           WHEN pre.DATE_DEPART IS NULL
               OR pre.DATE_ARRIVEE IS NULL
               OR HEURE_DEPART IS NULL
               OR HEURE_ARRIVEE IS NULL
               THEN
               NULL
           ELSE
               TO_DATE(pre.DATE_DEPART || ' ' || pre.HEURE_DEPART,
                       'dd-mm-yy hh24:mi:ss')
           END
                                                                                                     AS depart,
       CASE
           WHEN pre.DATE_DEPART IS NULL
               OR pre.DATE_ARRIVEE IS NULL
               OR HEURE_DEPART IS NULL
               OR HEURE_ARRIVEE IS NULL
               THEN
               NULL
           ELSE
               TO_DATE(pre.DATE_ARRIVEE || ' ' || pre.HEURE_ARRIVEE,
                       'dd-mm-yy hh24:mi:ss')
           END
                                                                                                     AS arrive,
       occ.provenancePays,
       occ.destinationPays,
       CASE
           WHEN occ.provenancePays = 'PAYS000054'
               OR occ.provenancePays = 'PAYS000010'
               OR occ.provenancePays = 'PAYS000057'
               THEN 1
           ELSE 0
       END AS provenanceMadagascar,
       CASE
           WHEN occ.destinationPays = 'PAYS000054'
               OR occ.destinationPays = 'PAYS000010'
               OR occ.destinationPays = 'PAYS000057'
               THEN 1
           ELSE 0
       END
                                                                                         AS destinationMadagascar
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf ON ra.categorie = cf.id
         LEFT JOIN PREVISION pre ON pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET pd ON pd.ID = ac.POSTE
         LEFT JOIN UNITE_ACTIVITE ua ON ua.ID = ra.UNITE
         LEFT JOIN POSTEDESTINATAIRE pd2 ON pd2.ID = pre.destination
         LEFT JOIN quais q ON q.id = pd2.quai
         LEFT JOIN OCCUPATIONMATERIELNAVAL_LIBCPL occ ON occ.id = ac.REFOBJET
         LEFT JOIN MATERIEL_NAVAL cm ON cm.id = occ.IDMATERIEL_NAVAL
         LEFT JOIN POSTEDESTINATAIRELIBCOMPLET ty ON ty.id = ac.TYPESOURCE;






