--Ajustement Compte de résultat
delete from rubrique where id in ('RBS003');
update compte_rubrique set reference='R3' where reference='AC3';
update compte_rubrique set reference='R1' where reference='AC1';
update compte_rubrique set reference='RX' where reference='AC10';
update compte_rubrique set reference='R2' where reference='AC2';
update compte_rubrique set reference='R8' where reference='AC8';
update compte_rubrique set reference='R7' where reference='AC7';
update compte_rubrique set reference='R9' where reference='AC9';
