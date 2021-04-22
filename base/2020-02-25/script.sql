------------------------- SPAT_CAPITAINERIE -------------------------

alter table ANALYSELIEN modify lien varchar2(500);

create or replace view statistiquelibcomplet as
    select
        stat.id, titre, daty, nombre,
        stat.volume, navire,
        n.reference, nom, pavillon, jnt, jbt, plt, lht, lm, te,
        n.volume as volumenavire, remarque, etat
    from statistique stat
        join navire n on stat.NAVIRE = n.ID;
		
create or replace view statistiquelib as
    select
        id,
        titre,
        daty,
        nombre,
        volume,
        nom as navire
    from statistiquelibcomplet;