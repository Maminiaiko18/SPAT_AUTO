create table ANNULATIONUTILISATEUR
(
    IDANNULATIONUSER VARCHAR2(20) not null
        primary key,
    REFUSER          NUMBER(4),
    DATY             DATE
);

create table SOURCE
(
    ID    VARCHAR2(50) not null
        constraint SOURCE_PK
            primary key,
    VAL   VARCHAR2(100),
    DESCE VARCHAR2(100)
);