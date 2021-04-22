alter table as_bondelivraison add id_bc varchar2(100) constraint asbl_asbc_fk references AS_BONDECOMMANDE null ;
create OR REPLACE view PREVISIONMATERIELNAVALLIB2 (ID, IDMATERIEL_NAVAL, IDCOMMANDANT, IDNATUREOPERATION, IDNAVIRE, DATY, IDCLIENT, DUREE, OBSERVATION, ETAT, DATE_DEPART, DATE_ARRIVEE, HEURE_DEPART, HEURE_ARRIVEE) AS
     select p.ID,
           DENOMINATION as IDMATERIEL_NAVAL,
           c.VAL        as IDCOMMANDANT,
           n.VAL        as IDNATUREOPERATION,
           nav.NOM      as IDNAVIRE,
           p.DATY,
           p.IDCLIENT,
           p.DUREE,
           p.OBSERVATION,
           p.ETAT,
           p.DATE_DEPART,
           p.DATE_ARRIVEE,
           p.HEURE_DEPART,
           p.HEURE_ARRIVEE
    from PREVISIONMATERIELNAVAL p
         join MATERIEL_NAVAL mn on p.IDMATERIEL_NAVAL = mn.ID
         left join COMMANDANT c on p.IDCOMMANDANT = c.ID
         join NATUREOPERATION N on p.IDNATUREOPERATION = N.ID
         join NAVIRE nav on p.IDNAVIRE = nav.ID
        ORDER BY DATY DESC;

        
CREATE SEQUENCE SEQ_BONDELIVRAISONFILLE
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION GET_SEQBONDELIVRAISONFILLE
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT SEQ_BONDELIVRAISONFILLE.nextval INTO retour FROM dual;
    return retour;
END;

alter table AS_BONDELIVRAISON_FILLE drop constraint PRODUITFILLE_FK;

select
        id,
        daty,
        denomination as idmateriel_naval,
        valpilote as idpilote,
        valcommandant as idcommandant,
        valnatureoperation as idnatureoperation,
        valmanoeuvrebord as idmanoeuvrebord,
        heuredebut, heurefin,
        nomnavire as idnavire,
        duree, position, observation, etat, datefin
    from OCCUPMATERIELNAVALLIBCOMPLET
        order by DATY desc
/