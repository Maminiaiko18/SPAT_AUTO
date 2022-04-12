update detformufact set condition='[estNational]==''National''&&[volume]<11500&&[cargaison]!=''CGM00001''' where id='DFF0000000023170452';
update detformufact set condition='[estNational]==''National''&&[volume]<15000&&[cargaison]==''CGM00001''&&[estFerie]==''NONFERIE''&&[estJour]==''JOUR''&&[estWeekend]==''normal''' where id='DFF0000000023170452M';
--OK
update detformufact set rem='AMAR. ET DESAMAR. CARGO FERIE C',condition='[estNational]==''National''&&([estFerie]==''FERIE''||[estWeekend]==''weekend'')&&[cargaison]!=''CGM00001''' where id='DFF0000000023170522';
insert into detformufact values('DFF0000000023170522X',1,1,'0.806','UA048','AMAR. ET DESAMAR. CARGO NUIT C','RB0000000021170447','[estNational]==''National''&&([estFerie]==''NONFERIE''&&[estJour]==''NUIT'')&&[cargaison]!=''CGM00001''','[volumeArrondi]','70681');

--suppression facture BARGE EXPRESS
delete FROM facture_client_fille WHERE idmere IN (SELECT id FROM factureclient WHERE idprevision='PREV0000001276162722');
delete FROM factureclient WHERE idprevision='PREV0000001276162722';
DELETE FROM activite WHERE id IN (SELECT id FROM activite WHERE bateau='PREV0000001276162722' AND id NOT IN ('ACT0000007922151844','ACT0000007923152535','ACT0000007928153312'));

--update prevision
update prevision set cargaison='CGM00004' where id='PREV0000001276162722';