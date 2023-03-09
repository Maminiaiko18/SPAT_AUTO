****** SPAT_RH ******

CREATE MATERIALIZED VIEW HISTO_EVO_CARRIERE
	REFRESH WITH ROWID
   	AS SELECT * FROM HISTO_EVO_CARRIERE@db_link_spat_rh;

****** SPAT_CAPITAINERIE ******

create view analyse_personnel_permanent as
    select * from spat_rh.analyse_personnel_permanent;
	
insert into TYPE_MATERIEL values ('TYPE000001','remorqueur','remorqueur');

truncate table quais;
insert into quais (id,val,desce,typequais) values ('QUA000001','MOLE C1','MOLE C1','TQ001');
insert into quais (id,val,desce,typequais) values ('QUA000002','MOLE C2','MOLE C2','TQ001');
insert into quais (id,val,desce,typequais) values ('QUA000003','MOLE C3','MOLE C3','TQ001');
insert into quais (id,val,desce,typequais) values ('QUA000004','QUAI SHERRIT Ouest','QUAI SHERRIT Ouest','TQ001');
insert into quais (id,val,desce,typequais) values ('QUA000005','QUAI SHERRIT Est','QUAI SHERRIT Est','TQ001');
insert into quais (id,val,desce,typequais) values ('QUA000006','JETEE PETROLIERE','JETEE PETROLIERE','TQ001');
insert into quais (id,val,desce,typequais) values ('QUA000007','MOLE A Ouest','MOLE A Ouest','TQ002');
insert into quais (id,val,desce,typequais) values ('QUA000008','MOLE A Est','MOLE A Est','TQ002');
insert into quais (id,val,desce,typequais) values ('QUA000009','MOLE B','MOLE B','TQ002');
insert into quais (id,val,desce,typequais) values ('QUA000010','QUAI N° 1B','QUAI N° 1B','TQ003');
insert into quais (id,val,desce,typequais) values ('QUA000011','QUAI N° 2B','QUAI N° 2B','TQ003');
insert into quais (id,val,desce,typequais) values ('QUA000012','QUAI N° 3B','QUAI N° 3B','TQ003');
insert into quais (id,val,desce,typequais) values ('QUA000013','QUAI N° 4B','QUAI N° 4B','TQ003');
insert into quais (id,val,desce,typequais) values ('QUA000014','QUAI N° 5B','QUAI N° 5B','TQ003');
insert into quais (id,val,desce,typequais) values ('QUA000015','QUAI N° 6B','QUAI N° 6B','TQ003');
insert into quais (id,val,desce,typequais) values ('QUA000016','QUAI N° 7B','QUAI N° 7B','TQ003');
insert into quais (id,val,desce,typequais) values ('QUA000017','QUAI N° 1F','QUAI N° 1F','TQ003');
insert into quais (id,val,desce,typequais) values ('QUA000018','QUAI N° 2F','QUAI N° 2F','TQ003');
insert into quais (id,val,desce,typequais) values ('QUA000019','QUAI N° 3F','QUAI N° 3F','TQ003');
insert into quais (id,val,desce,typequais) values ('QUA000020','QUAI N° 4F','QUAI N° 4F','TQ003');