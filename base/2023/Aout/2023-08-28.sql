create table DETFORMUFACT_BCKP_202308 as select * from DETFORMUFACT;

alter table DETFORMUFACT add REMFORMULE varchar2(4000);
alter table DETFORMUFACT add PU varchar2(500);

update DETFORMUFACT set pu = formule where 1>0;
UPDATE DETFORMUFACT SET rem = REPLACE(rem, CHR(13), ' ');

update DETFORMUFACT set REMFORMULE = '''' ||rem|| '''' where 1>0;

-- Configuration
INSERT INTO CONFIGURATION (ID, VALMIN, VALMAX, DESCE, REMARQUE, DATY, TYPECONFIG, COMPTE_CREDIT) VALUES ('CONF00001', '174.105', '174.105', 'MINIMUM DE PERCEPTION PILOTAGE LC', 'MINIMUM DE PERCEPTION PILOTAGE LC', DATE '2023-08-18', 'activite', null);
INSERT INTO CONFIGURATION (ID, VALMIN, VALMAX, DESCE, REMARQUE, DATY, TYPECONFIG, COMPTE_CREDIT) VALUES ('CONF00002', '91.634', '91.634', 'MINIMUM DE PERCEPTION REMORQUAGE C', 'MINIMUM DE PERCEPTION REMORQUAGE C', DATE '2023-08-18', 'activite', null);
INSERT INTO CONFIGURATION (ID, VALMIN, VALMAX, DESCE, REMARQUE, DATY, TYPECONFIG, COMPTE_CREDIT) VALUES ('CONF00003', '174.105', '174.105', 'MINIMUM DE PERCEPTION REMORQUAGE LC', 'MINIMUM DE PERCEPTION REMORQUAGE LC', DATE '2023-08-18', 'activite', null);
INSERT INTO CONFIGURATION (ID, VALMIN, VALMAX, DESCE, REMARQUE, DATY, TYPECONFIG, COMPTE_CREDIT) VALUES ('CONF00004', '91.634', '91.634', 'MINIMUM DE PERCEPTION PILOTAGE C', 'MINIMUM DE PERCEPTION PILOTAGE C', DATE '2023-08-18', 'activite', null);


---------- PILOTAGE
update DETFORMUFACT set FORMULE = 'if ([Conf::CONF00004]>'|| PU ||'*[volumeArrondi]){ [Conf::CONF00004] } else { '|| PU || ' }' where REM like '% C%' and  MERE = 'RB0000000021170445';
update DETFORMUFACT set FORMULE = 'if ([Conf::CONF00001]>'|| PU ||'*[volumeArrondi]){ [Conf::CONF00001] } else { '|| PU || ' }' where REM like '% LC%' and  MERE = 'RB0000000021170445';

update DETFORMUFACT set FORMULEQTE = 'if ([Conf::CONF00004]>'|| PU ||'*[volumeArrondi]){ 1 } else { '|| FORMULEQTE || ' }' where REM like '% C%' and  MERE = 'RB0000000021170445' AND FORMULEQTE NOT LIKE 'if%';
update DETFORMUFACT set FORMULEQTE = 'if ([Conf::CONF00001]>'|| PU ||'*[volumeArrondi]){ 1 } else { '|| FORMULEQTE || ' }' where REM like '% LC%' and  MERE = 'RB0000000021170445' AND FORMULEQTE NOT LIKE 'if%';

update DETFORMUFACT set REMFORMULE = 'if ([Conf::CONF00004]>'|| PU ||'*[volumeArrondi]){ ''[Conf::CONF00004..desce]'' } else { '''|| REM || ''' }' where REM like '% C%' and  MERE = 'RB0000000021170445';
update DETFORMUFACT set REMFORMULE = 'if ([Conf::CONF00001]>'|| PU ||'*[volumeArrondi]){ ''[Conf::CONF00001..desce]'' } else { '''|| REM || ''' }' where REM like '% LC%' and  MERE = 'RB0000000021170445';


---------- REMORQUAGE
update DETFORMUFACT set FORMULE = 'if ([Conf::CONF00002]>'|| PU ||'*[volumeArrondi]){ [Conf::CONF00002] } else { '|| PU || ' }' where REM like '% C%' and  MERE = 'RB0000000021170446';
update DETFORMUFACT set FORMULE = 'if ([Conf::CONF00003]>'|| PU ||'*[volumeArrondi]){ [Conf::CONF00003] } else { '|| PU || ' }' where REM like '% LC%' and  MERE = 'RB0000000021170446';

update DETFORMUFACT set FORMULEQTE = 'if ([Conf::CONF00002]>'|| PU ||'*[volumeArrondi]){ 1 } else { '|| FORMULEQTE || ' }' where REM like '% C%' and  MERE = 'RB0000000021170446' AND FORMULEQTE NOT LIKE 'if%';
update DETFORMUFACT set FORMULEQTE = 'if ([Conf::CONF00003]>'|| PU ||'*[volumeArrondi]){ 1 } else { '|| FORMULEQTE || ' }' where REM like '% LC%' and  MERE = 'RB0000000021170446' AND FORMULEQTE NOT LIKE 'if%';

update DETFORMUFACT set REMFORMULE = 'if ([Conf::CONF00002]>'|| PU ||'*[volumeArrondi]){ ''[Conf::CONF00002..desce]'' } else { '''|| REM || ''' }' where REM like '% C%' and  MERE = 'RB0000000021170446';
update DETFORMUFACT set REMFORMULE = 'if ([Conf::CONF00003]>'|| PU ||'*[volumeArrondi]){ ''[Conf::CONF00003..desce]'' } else { '''|| REM || ''' }' where REM like '% LC%' and  MERE = 'RB0000000021170446';
