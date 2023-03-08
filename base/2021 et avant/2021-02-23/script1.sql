create table typeActionConteneur (
id varchar2(100) constraint typeActionConteneur_pk primary key,
val varchar2(500),
desce varchar2(500)
);

create table nomsociete  (
id varchar2(100) constraint nomsociete_pk primary key,
val varchar2(500),
desce  varchar2(500)
);

create table typemanipulation   (
id varchar2(100) constraint typemanipulation_pk primary key,
val varchar2(500),
desce  varchar2(500)
);

create table typemarchandise    (
id varchar2(100) constraint typemarchandise_pk primary key,
val varchar2(500),
desce  varchar2(500)
);


create table typemesure     (
id varchar2(100) constraint typemesure_pk primary key,
val varchar2(500),
desce  varchar2(500)
);

create table typeSaisie      (
id varchar2(100) constraint typeSaisie_pk primary key,
val varchar2(500),
desce  varchar2(500)
);


create table statistiqueActivite(
id varchar2(100) constraint statistiqueActivite_pk primary key,
titre varchar2(500),
daty date,
idtypeActionConteneur varchar2(100) constraint actionconteneur_fk references typeActionConteneur,
Plein20Pieds number(10,2),
Vide20Pieds number(10,2),
Plein40Pieds number(10,2),
Vide40Pieds number(10,2),
idnomsociete varchar2(100) constraint nomsociete_fk references nomsociete,
idtypemanipulation varchar2(100) constraint typemanipulation_fk references typemanipulation,
idtypemarchandise  varchar2(100) constraint typemarchandise_fk references typemarchandise,
idtypemesure varchar2(100) constraint typemesure_fk references typemesure,
nombreunite number(10),
poids number(10,2),
typeSaisie varchar2(100),
etat number(10)
);



INSERT INTO TYPEACTIONCONTENEUR (ID,VAL,DESCE)
	VALUES ('TYAC001','chargement','chargement');
INSERT INTO TYPEACTIONCONTENEUR (ID,VAL,DESCE)
	VALUES ('TYAC002','déchargement','déchargement');
INSERT INTO TYPEACTIONCONTENEUR (ID,VAL,DESCE)
	VALUES ('TYAC003','transit chargement','transit chargement');
INSERT INTO TYPEACTIONCONTENEUR (ID,VAL,DESCE)
	VALUES ('TYAC004','transit dechargement','transit dechargement');


INSERT INTO NOMSOCIETE (ID,VAL,DESCE)
	VALUES ('NS001','TP','TP');
INSERT INTO NOMSOCIETE (ID,VAL,DESCE)
	VALUES ('NS002','SMMC','SMMC');
INSERT INTO NOMSOCIETE (ID,VAL,DESCE)
	VALUES ('NS003','HITA','HITA');



INSERT INTO TYPEMANIPULATION (ID,VAL,DESCE)
	VALUES ('TYM001','débarquement','débarquement');
INSERT INTO TYPEMANIPULATION (ID,VAL,DESCE)
	VALUES ('TYM002','embarquement','embarquement');



INSERT INTO TYPEMARCHANDISE (ID,VAL,DESCE)
	VALUES ('TMAR001','pétrole','pétrole');
INSERT INTO TYPEMARCHANDISE (ID,VAL,DESCE)
	VALUES ('TMAR002','gasoil','gasoil');
INSERT INTO TYPEMARCHANDISE (ID,VAL,DESCE)
	VALUES ('TMAR003','essence','essence');
INSERT INTO TYPEMARCHANDISE (ID,VAL,DESCE)
	VALUES ('TMAR004','ble','ble');


INSERT INTO TYPEMESURE (ID,VAL,DESCE)
	VALUES ('TMES001','tonnage','tonnage');
INSERT INTO TYPEMESURE (ID,VAL,DESCE)
	VALUES ('TMES002','volume','volume');
INSERT INTO TYPEMESURE (ID,VAL,DESCE)
	VALUES ('TMES003','nombre','nombre');


INSERT INTO TYPESAISIE (ID,VAL,DESCE)
	VALUES ('TSAI001','conteneur','conteneur');
INSERT INTO TYPESAISIE (ID,VAL,DESCE)
	VALUES ('TSAI001','societe','societe');