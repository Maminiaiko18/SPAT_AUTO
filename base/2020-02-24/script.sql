------------------------ SPAT_CAPITAINERIE ------------------------

create or replace view MOUVEMENTLIB as
    select m.id,
           daty,
           m.ESCALE,
           n1.NOM                   as navire,
           consignataire,
           datearrivee,
           heure,
           pp1.val || ' ' || q1.VAL as provenance,
           pp2.val || ' ' || q2.VAL as destination,
           m.remarque,
           duree,
           typemvt,
           m.etat,
           DATE_DEPART,
           HEURE_DEPART,
           carg.val as CARGAISON
    from MOUVEMENT m
             join NAVIRE n1 on m.NAVIRE = n1.ID
             join POSTEDESTINATAIRE p1 on p1.id = m.PROVENANCE
             join pays pp1 on pp1.id = p1.PAYS
             join QUAIS q1 on q1.id = p1.QUAI
             join POSTEDESTINATAIRE p2 on p2.id = m.destination
             join pays pp2 on pp2.id = p2.PAYS
             join QUAIS q2 on q2.id = p2.QUAI
             join CARGAISON carg on carg.id = m.CARGAISON;
			 
drop function GETSEQMARQUE_MATERIEL;

create FUNCTION "GETSEQMARQUEMATERIEL"
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT SEQMARQUE_MATERIEL.nextval INTO retour FROM dual;
  return retour;
END;