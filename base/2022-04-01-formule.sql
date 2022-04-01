--LAMANAGE
--AMAR. ET DESAMAR. PETRO FERIÉ C 
update detformufact set condition='[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170530';
insert into detformufact values('DFF0000000023170530X',1,1,'1.211','UA048','AMAR. ET DESAMAR. PETRO NUIT C ','RB0000000021170447','[estNational]==''National''&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''','[volumeArrondi]','70681');

--AMAR. ET DESAMAR. PETRO FERIE PFI LC --A VOIR HOE 2.527 za 2.528
update detformufact set condition='[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170531';
insert into detformufact values('DFF0000000023170531X',1,1,'2.527','UA048','AMAR. ET DESAMAR. PETRO NUIT PFI LC','RB0000000021170447','[estNational]==''International''&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''','[volumeArrondi]','70681');

--AMAR. ET DESAMAR. CARGO FERIÉ LC 
update detformufact set condition='[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170523';
insert into detformufact values('DFF0000000023170523X',1,1,'1.532','UA048','AMAR. ET DESAMAR. CARGO NUIT LC','RB0000000021170447','[estNational]==''International''&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]!=''CGM00001''','[volumeArrondi]','70681');

--AMAR. ET DESAMAR. PETRO FERIÉ LC 
update detformufact set condition='[estNational]==''International''&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170527';
insert into detformufact values('DFF0000000023170527X',1,1,'2.298','UA048','AMAR. ET DESAMAR. PETRO NUIT LC','RB0000000021170447','[estNational]==''International''&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''','[volumeArrondi]','70681');



--PILOTAGE
--PILOTAGE MANOEUVRE E/S FERIÉ C 
update detformufact set condition='[estNational]==''National''&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170458';
insert into detformufact values('DFF0000000023170458X',1,1,'0.806','UA048','PILOTAGE MANOEUVRE E/S NUIT C','RB0000000021170445','[estNational]==''National''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''','[volumeArrondi]','70682');

--PILOTAGE MANOEUVRE E/S FERIÉ LC 
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''' where id='DFF0000000023170459';
insert into detformufact values('DFF0000000023170459X',1,1,'2.298','UA048','PILOTAGE MANOEUVRE E/S NUIT LC','RB0000000021170445','[estNational]==''International''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[manoeuvre]!=''MDB_0004''&&[cargaison]!=''CGM00001''','[volumeArrondi]','70682');

--PILOTAGE MANOEUVRE E/S FERIÉ C 
update detformufact set condition='[estNational]==''National''&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170462';
insert into detformufact values('DFF0000000023170462X',1,1,'0.806','UA048','PILOTAGE MANOEUVRE E/S NUIT C','RB0000000021170445','[estNational]==''National''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[manoeuvre]==''MDB_0004''','[volumeArrondi]','70682');

--PILOTAGE A L'INT. DU PORT FERIÉ LC 
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[manoeuvre]==''MDB_0004''' where id='DFF0000000023170463';
insert into detformufact values('DFF0000000023170463X',1,1,'1.349','UA048','PILOTAGE A L''INT. DU PORT NUIT LC','RB0000000021170445','[estNational]==''International''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[manoeuvre]==''MDB_0004''','[volumeArrondi]','70682');

--PILOTAGE MANOEUVRE E/S FERIÉ C 
update detformufact set condition='[estNational]==''National''&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[estPetrolier]==''TRUE''&&[cargaison]==''-''' where id='DFF0000000023170466';
insert into detformufact values('DFF0000000023170466X',1,1,'0.806','UA048','PILOTAGE MANOEUVRE E/S NUIT C','RB0000000021170445','[estNational]==''National''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[estPetrolier]==''TRUE''&&[cargaison]==''-''','[volumeArrondi]','70682');

--PILOTAGE MANOEUVRE E/S FERIÉ C
update detformufact set condition='[estNational]==''National''&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[estPetrolier]==''TRUE''&&[cargaison]==''CGM00001''' where id='DFF0000000023170470';
insert into detformufact values('DFF0000000023170470X',1,1,'0.806','UA048','PILOTAGE MANOEUVRE E/S NUIT C','RB0000000021170445','[estNational]==''National''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[estPetrolier]==''TRUE''&&[cargaison]==''CGM00001''','[volumeArrondi]','70682');

--PILOTAGE MANOEUVRE E/S FERIE PFI LC 
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&([estPetrolier]==''TRUE''|| [cargaison]==''CGM00001'')&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170471';
insert into detformufact values('DFF0000000023170471X',1,1,'2.527','UA048','PILOTAGE MANOEUVRE E/S NUIT PFI LC','RB0000000021170445','[estNational]==''International''&&[volume]>=11500&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''','[volumeArrondi]','70682');


--REMORQUAGE
--REMORQ. HYDRO V<20.000 M3 FERIÉ C
update detformufact set condition='[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170486';
insert into detformufact values('DFF0000000023170486X',1,1,'3.281','UA041','REMORQ. HYDRO V<20.000 M3 NUIT C','RB0000000021170446','[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''','[volumeArrondi]','70683');

--REMORQUAGE V<5000 M3 FERIÉ C 
update detformufact set condition='[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170478';
insert into detformufact values('DFF0000000023170478X',1,1,'3.281','UA048','REMORQUAGE V<5000 M3 NUIT C','RB0000000021170446','[estNational]==''National''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]!=''CGM00001''','[volumeArrondi]','70683');

--REMORQUAGE V<5000 M3 FERIÉ LC 
update detformufact set condition='[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170479';
insert into detformufact values('DFF0000000023170479X',1,1,'6.231','UA048','REMORQUAGE V<5000 M3 NUIT LC','RB0000000021170446','[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]!=''CGM00001''','[volumeArrondi]','70683');

--REMORQUAGE V>=5000 M3 FERIÉ C 
update detformufact set condition='[estNational]==''National''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170482';
insert into detformufact values('DFF0000000023170482X',1,1,'4.236','UA048','REMORQUAGE V>=5000 M3 NUIT C','RB0000000021170446','[estNational]==''National''&&[volume]>=5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]!=''CGM00001''','[volumeArrondi]','70683');

--REMORQUAGE V>=5000 M3 FERIÉ LC 
update detformufact set condition='[estNational]==''International''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170483';
insert into detformufact values('DFF0000000023170483X',1,1,'8.045','UA048','REMORQUAGE V>=5000 M3 NUIT LC','RB0000000021170446','[estNational]==''International''&&[volume]>=5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]!=''CGM00001''','[volumeArrondi]','70683');

--MAJ./QUART D'HEURE V<5000 M3 FERIÉ LC 
update detformufact set condition='[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF0000000023170538';
insert into detformufact values('DFF0000000023170538X',1,1,'187.163','UA043','MAJ./QUART D''HEURE V<5000 M3 NUIT LC','RB0000000021170446','[estNational]==''International''&&[volume]>=3000&&[volume]<5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0','[nbQuartHeure]','70683');

--MAJ./QUART D'HEURE V<5000 M3 FERIÉ C 
update detformufact set condition='[estNational]==''National''&&[volume]>=5000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0' where id='DFF0000000023170541';
insert into detformufact values('DFF0000000023170541X',1,1,'98.505','UA043','MAJ./QUART D''HEURE V<5000 M3 NUIT C','RB0000000021170446','[estNational]==''National''&&[volume]>=5000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]!=''CGM00001''&&[nbQuartHeure]>0','[nbQuartHeure]','70683');

--REMORQ. HYDRO 50.000<=V<100.000 M3 FERIÉ C
update detformufact set condition='[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170512';
insert into detformufact values('DFF0000000023170512X',1,1,'9.324','UA041','REMORQ. HYDRO 50.000<=V<100.000 M3 NUIT C','RB0000000021170446','[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''','[volumeArrondi]','70683');

--REMORQ. HYDRO 50.000<=V<100.000 M3 FERIE PFI LC 
update detformufact set condition='[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170513';
insert into detformufact values('DFF0000000023170513X',1,1,'19.485','UA041','REMORQ. HYDRO 50.000<=V<100.000 M3 NUIT PFI LC','RB0000000021170446','[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''','[volumeArrondi]','70683');

--REMORQ. HYDRO V>=100.000M3 FERIÉ C 
update detformufact set condition='[estNational]==''National''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170516';
insert into detformufact values('DFF0000000023170516X',1,1,'12.021','UA041','REMORQ. HYDRO V>=100.000M3 NUIT C','RB0000000021170446','[estNational]==''National''&&[volume]>=100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''','[volumeArrondi]','70683');

--REMORQ. HYDRO V<20.000 M3 FERIÉ LC
update detformufact set condition='[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170487';
insert into detformufact values('DFF0000000023170487X',1,1,'6.231','UA041','REMORQ. HYDRO V<20.000 M3 NUIT LC','RB0000000021170446','[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''','[volumeArrondi]','70683');

--REMORQ. HYDRO 20.000<=V<50.000 M3 FERIÉ C 
update detformufact set condition='[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170490';
insert into detformufact values('DFF0000000023170490X',1,1,'6.873','UA041','REMORQ. HYDRO 20.000<=V<50.000 M3 NUIT C ','RB0000000021170446','[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''','[volumeArrondi]','70683');

--REMORQ. HYDRO 20.000<=V<50.000 M3 FERIÉ LC 
update detformufact set condition='[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170491';
insert into detformufact values('DFF0000000023170491X',1,1,'13.05','UA041','REMORQ. HYDRO 20.000<=V<50.000 M3 NUIT LC','RB0000000021170446','[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''','[volumeArrondi]','70683');

--REMORQ. HYDRO 50.000<=V<100.000 M3 FERIÉ C 
update detformufact set condition='[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170494';
insert into detformufact values('DFF0000000023170494X',1,1,'9.324','UA041','REMORQ. HYDRO 50.000<=V<100.000 M3 NUIT C','RB0000000021170446','[estNational]==''National''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''','[volumeArrondi]','70683');

--REMORQ. HYDRO 50.000<=V<100.000 M3 FERIÉ LC 
update detformufact set condition='[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170495';
insert into detformufact values('DFF0000000023170495X',1,1,'17.71','UA041','REMORQ. HYDRO 50.000<=V<100.000 M3 NUIT LC','RB0000000021170446','[estNational]==''International''&&[volume]>=50000&&[volume]<100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''','[volumeArrondi]','70683');

--REMORQ. HYDRO V>=100.000M3 FERIÉ C 
update detformufact set condition='[estNational]==''National''&&[volume]>=100000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170498';
insert into detformufact values('DFF0000000023170498X',1,1,'12.021','UA041','REMORQ. HYDRO V>=100.000M3 NUIT C','RB0000000021170446','[estNational]==''National''&&[volume]>=100000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''','[volumeArrondi]','70683');

--REMORQ. HYDRO V<20.000 M3 FERIÉ C 
update detformufact set condition='[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170504';
insert into detformufact values('DFF0000000023170504X',1,1,'3.281','UA041','REMORQ. HYDRO V<20.000 M3 NUIT C','RB0000000021170446','[estNational]==''National''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''','[volumeArrondi]','70683');

--REMORQ. HYDRO V<20.000 M3 FERIE PFI LC 
update detformufact set condition='[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170505';
insert into detformufact values('DFF0000000023170505X',1,1,'6.854','UA041','REMORQ. HYDRO V<20.000 M3 NUIT PFI LC','RB0000000021170446','[estNational]==''International''&&[volume]>=3000&&[volume]<20000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''','[volumeArrondi]','70683');

--REMORQ. HYDRO 20.000<=V<50.000 M3 FERIÉ C 
update detformufact set condition='[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170508';
insert into detformufact values('DFF0000000023170508X',1,1,'6.873','UA041','REMORQ. HYDRO 20.000<=V<50.000 M3 NUIT C ','RB0000000021170446','[estNational]==''National''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''','[volumeArrondi]','70683');

--REMORQ. HYDRO 20.000<=V<50.000 M3 FERIE PFI LC 
update detformufact set condition='[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170509';
insert into detformufact values('DFF0000000023170509X',1,1,'14.362','UA041','REMORQ. HYDRO 20.000<=V<50.000 M3 NUIT PFI LC','RB0000000021170446','[estNational]==''International''&&[volume]>=20000&&[volume]<50000&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''','[volumeArrondi]','70683');



--rectif pilotage
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170469';
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0003''' where id='DFF0000000023170471';

-- rectif pilotage PILOTAGE MANOEUVRE E/S JOUR LC
update detformufact set condition='[estNational]==''International''&&[volume]>=11500&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''&&[cargaison]==''CGM00001''&&[manoeuvre]==''MDB_0005''' where id='DFF0000000023170465';



