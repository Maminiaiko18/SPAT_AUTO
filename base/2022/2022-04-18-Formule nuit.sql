--[estWeekend]==''normal''

--RECTIF 
--AMAR. ET DESAMAR. PETRO NUIT C 
update detformufact set condition='[estNational]==''National''&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170530X';

--AMAR. ET DESAMAR. PETRO NUIT PFI LC
update detformufact set condition='[estNational]==''International''&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170531X';

--AMAR. ET DESAMAR. CARGO NUIT LC
update detformufact set condition='[estNational]==''International''&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170523X';

--AMAR. ET DESAMAR. PETRO NUIT LC
update detformufact set condition='[estNational]==''International''&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170527X';

--PILOTAGE MANOEUVRE E/S NUIT C
update detformufact set condition='[estNational]==''National''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170458X';

--PILOTAGE MANOEUVRE E/S NUIT LC
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170459X';

--PILOTAGE MANOEUVRE E/S NUIT C
update detformufact set condition='[estNational]==''National''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170462X';

--PILOTAGE A L'INT. DU PORT NUIT LC
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170463X';

--PILOTAGE MANOEUVRE E/S NUIT C
update detformufact set condition='[estNational]==''National''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''' where id='DFF0000000023170466X';

--PILOTAGE MANOEUVRE E/S NUIT C
update detformufact set condition='[estNational]==''National''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''' where id='DFF0000000023170470X';

--PILOTAGE MANOEUVRE E/S NUIT PFI LC
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170471X';

--REMORQ. HYDRO V<20.000 M3 NUIT C
update detformufact set condition='[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170486X';

--REMORQUAGE V<5000 M3 NUIT C
update detformufact set condition='[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170478X';

--REMORQUAGE V<5000 M3 NUIT LC
update detformufact set condition='[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170479X';

--REMORQUAGE V>=5000 M3 NUIT C	
update detformufact set condition='[estNational]==''National''&&[volume]>=5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170482X';

--REMORQUAGE V>=5000 M3 NUIT LC
update detformufact set condition='[estNational]==''International''&&[volume]>=5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170483X';

--MAJ./QUART D'HEURE V<5000 M3 NUIT LC
update detformufact set condition='[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF0000000023170538X';

--MAJ./QUART D'HEURE V<5000 M3 NUIT C
update detformufact set condition='[estNational]==''National''&&[volume]>=5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF0000000023170541X';

--REMORQ. HYDRO 50.000<=V<100.000 M3 NUIT C
update detformufact set condition='[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170512X';

--REMORQ. HYDRO 50.000<=V<100.000 M3 NUIT PFI LC
update detformufact set condition='[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170513X';

--REMORQ. HYDRO V>=100.000M3 NUIT C
update detformufact set condition='[estNational]==''National''&&[volume]>=100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170516X';

--REMORQ. HYDRO V<20.000 M3 NUIT LC
update detformufact set condition='[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170487X';

--REMORQ. HYDRO 20.000<=V<50.000 M3 NUIT C 
update detformufact set condition='[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170490X';

--REMORQ. HYDRO 20.000<=V<50.000 M3 NUIT LC
update detformufact set condition='[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170491X';

--REMORQ. HYDRO 50.000<=V<100.000 M3 NUIT C
update detformufact set condition='[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170494X';

--REMORQ. HYDRO 50.000<=V<100.000 M3 NUIT LC
update detformufact set condition='[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170495X';

--REMORQ. HYDRO V>=100.000M3 NUIT C
update detformufact set condition='[estNational]==''National''&&[volume]>=100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170498X';

--REMORQ. HYDRO V<20.000 M3 NUIT C
update detformufact set condition='[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170504X';

--REMORQ. HYDRO V<20.000 M3 NUIT PFI LC
update detformufact set condition='[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170505X';

--REMORQ. HYDRO 20.000<=V<50.000 M3 NUIT C 
update detformufact set condition='[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170508X';

--REMORQ. HYDRO 20.000<=V<50.000 M3 NUIT PFI LC
update detformufact set condition='[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT''&&[estWeekend]==''normal'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170509X';






























