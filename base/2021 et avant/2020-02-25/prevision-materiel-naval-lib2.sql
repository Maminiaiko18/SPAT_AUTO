
create view PREVISIONMATERIELNAVALLIB2 as (
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
);