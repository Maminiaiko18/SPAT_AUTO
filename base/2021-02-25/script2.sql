    CREATE OR REPLACE  VIEW PRESTATIONS_ESCALE 
    (ID, DATY, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, HEUREDEBUT, 
    HEUREFIN, IDNAVIRE, IDCLIENT, DUREE, POSITION, OBSERVATION, ETAT, DATEFIN, IDARRIVEE, IDPREVISION, ESCALE,ETATLIB) AS 
  select occ.ID,
        occ.DATY,
        occ.IDMATERIEL_NAVAL,
        p.val as IDPILOTE,
        comm.val as IDCOMMANDANT,
        nat.val as IDNATUREOPERATION,
        manb.val as IDMANOEUVREBORD,
        occ.HEUREDEBUT,
        occ.HEUREFIN,
        occ.IDNAVIRE,
        occ.IDCLIENT,
        occ.DUREE,
        occ.POSITION,
        occ.OBSERVATION,
        occ.ETAT,
        occ.DATEFIN,
        occ.IDARRIVEE,
        prev.id as idprevision, 
        prev.escale ,
        case when occ.etat=1 then 'CREE(E)'
		when occ.etat=11 then 'VISE(E)' END AS ETATLIB
        
    from occupationmaterielnaval occ
  left join mouvement mvt on mvt.id=occ.idarrivee 
  left join prevision prev on prev.id=mvt.escale
  left JOIN pilote p ON p.ID = occ.IDPILOTE
  left JOIN COMMANDANT comm ON comm.id = occ.IDCOMMANDANT
  left JOIN NATUREOPERATION nat ON nat.id = occ.IDNATUREOPERATION
  left JOIN MANOEUVREBORD manb ON manb.id = occ.IDMANOEUVREBORD
;