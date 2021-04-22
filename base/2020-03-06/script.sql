create view occupantpatrimoinelib as
    select
        occPat.id,
        pat.LIBELLE as idpatrimoine,
        vPer.nom||' '||vPer.PRENOM as idoccupant,
        occPat.DEBUTCONTRAT,
        occPat.FINCONTRAT,
        occPat.MONTANT,
        dev.VAL as iddevise,
        occPat.DATECHANGE,
        occPat.COURSCHANGE
    from OCCUPANTPATRIMOINE occPat
    join PATRIMOINE pat on pat.id=occPat.IDPATRIMOINE
    join V_UNION_PERSONNEL vPer on vPer.id=occPat.IDOCCUPANT
    join devisedemat dev on dev.id=occPat.IDDEVISE;