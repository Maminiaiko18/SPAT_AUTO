create table prevision_stat_activite
(
    ID                    VARCHAR2(100) not null
        constraint prevision_stat_activite_PK
            primary key,
    TITRE                 VARCHAR2(500),
    DATY                  DATE,
    IDTYPEACTIONCONTENEUR VARCHAR2(100)
        constraint ACTIONNTENEUR_FK
            references TYPEACTIONCONTENEUR,
    PLEIN20PIEDS          NUMBER(10, 2),
    VIDE20PIEDS           NUMBER(10, 2),
    PLEIN40PIEDS          NUMBER(10, 2),
    VIDE40PIEDS           NUMBER(10, 2),
    IDNOMSOCIETE          VARCHAR2(100)
        constraint NOM_SOCIETE_FK
            references NOMSOCIETE,
    IDTYPEMANIPULATION    VARCHAR2(100)
        constraint TYPEMANIPULATION_FK_fk
            references TYPEMANIPULATION,
    IDTYPEMARCHANDISE     VARCHAR2(100)
        constraint TYPEMARCHANDISE_FK_fk
            references TYPEMARCHANDISE,
    IDTYPEMESURE          VARCHAR2(100)
        constraint TYPEMESURE_FK_fk
            references TYPEMESURE,
    NOMBREUNITE           NUMBER(10),
    POIDS                 NUMBER(10, 2),
    TYPESAISIE            VARCHAR2(100),
    ETAT                  NUMBER(10),
    NAVIRE                VARCHAR2(400)
        constraint STATISTIQUEANAVIRE_FK
            references NAVIRE
)
/

CREATE SEQUENCE seqprevision_stat_activite
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqprevision_stat_activite
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqprevision_stat_activite.nextval INTO retour FROM dual;
  return retour;
END

CREATE  VIEW previsionSTATACTIVITELIB (ID, TITRE, DATY, IDTYPEACTIONCONTENEUR, PLEIN20PIEDS, VIDE20PIEDS, PLEIN40PIEDS, VIDE40PIEDS, IDNOMSOCIETE, IDTYPEMANIPULATION, IDTYPEMARCHANDISE, IDTYPEMESURE, NOMBREUNITE, POIDS, TYPESAISIE, ETAT, NAVIRE) AS
  SELECT s.ID,
       s.TITRE,
       s.DATY,
       t.VAL  AS IDTYPEACTIONCONTENEUR,
       s.PLEIN20PIEDS,
       s.VIDE20PIEDS,
       s.PLEIN40PIEDS,
       s.VIDE40PIEDS,
       n.VAL  AS IDNOMSOCIETE,
       t2.VAL AS IDTYPEMANIPULATION,
       t3.VAL AS IDTYPEMARCHANDISE,
       t4.VAL AS IDTYPEMESURE,
       s.NOMBREUNITE,
       s.POIDS,
       ts.VAL as TYPESAISIE,
       s.ETAT,
       na.nom||' '||na.TYPENAVIRELIB as NAVIRE
FROM prevision_stat_activite s
         LEFT JOIN TYPEACTIONCONTENEUR t ON s.IDTYPEACTIONCONTENEUR = t.ID
         LEFT JOIN NOMSOCIETE n ON s.IDNOMSOCIETE = n.ID
         LEFT JOIN TYPEMANIPULATION t2 ON s.IDTYPEMANIPULATION = t2.ID
         LEFT JOIN TYPEMARCHANDISE t3 ON s.IDTYPEMARCHANDISE = t3.ID
         LEFT JOIN TYPEMESURE t4 ON s.IDTYPEMESURE = t4.ID
         left join TYPESAISIE ts on ts.ID = s.TYPESAISIE
        left join NAVIRELIBCOMPLET na on na.ID=s.NAVIRE;


create or replace view  previsionSTATACTIVITELIBV as
select *from previsionSTATACTIVITELIB where ETAT>=11;


create or replace view  previsionSTATACTIVITELIBC as
select *from previsionSTATACTIVITELIB where ETAT=1;
