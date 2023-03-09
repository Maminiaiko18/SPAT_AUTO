create table bordereau
(
    id varchar2(100) constraint bordereau_pk primary key ,
        daty date,
        numero varchar2(100),
        designation varchar2(4000),
        etat number(10)
);

create table liaisonbordereau
(
    id varchar2(100) constraint  liaisonbordereau_pk primary key ,
        idBordereau varchar2(100) constraint bordereau_lie_fk references bordereau,
        idOP varchar2(100) constraint op_bordereau_fk references ORDONNERPAYEMENT
);

alter table ordonnerpayement add numerobed varchar(100);