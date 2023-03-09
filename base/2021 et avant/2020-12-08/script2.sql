CREATE OR REPLACE VIEW OCCUPMATERIELNAVALLIBCOMPLET AS 
  select
    occup."ID",occup."DATY",occup."IDMATERIEL_NAVAL",occup."IDPILOTE",occup."IDCOMMANDANT",occup."IDNATUREOPERATION",occup."IDMANOEUVREBORD",occup."HEUREDEBUT",occup."HEUREFIN",occup."IDNAVIRE",occup."IDCLIENT",occup."DUREE",occup."POSITION",occup."OBSERVATION",occup."ETAT",occup."DATEFIN", occup.IDARRIVEE, 
    mat.denomination, mat.DATE_AQUISITION, mat.IDMARQUE, mat.PUISSANCE, mat.DETENTEUR, mat.MAINTENANCE,
    mat.IDTYPE_MATERIEL, mat.IMMATRICULATION, mat.etat as etatmaterielnaval, mat.valmarque, mat.descemarque, mat.valtypemateriel, mat.descetypemateriel,
    p.VAL as valpilote, p.DESCE as descepilote,
    comm.val as valcommandant, comm.DESCE as descecommandant,
    nat.val as valnatureoperation, nat.DESCE as descenatureoperation,
    manb.val as valmanoeuvrebord, manb.DESCE as descemanoeuvrebord,
    nav.reference, nav.nom as nomnavire, nav.pavillon as pavillonnavire, nav.jnt, nav.JBT, nav.PLT, nav.LHT, nav.lm, nav.te,
    nav.volume, nav.remarque, nav.valpavillon, nav.descepavillon
from OCCUPATIONMATERIELNAVAL occup
    join MATERIELNAVALLIBCOMPLET mat on mat.ID = occup.IDMATERIEL_NAVAL
    join pilote p on p.ID = occup.IDPILOTE
    join COMMANDANT comm on comm.id = occup.IDCOMMANDANT
    join NATUREOPERATION nat on nat.id = occup.IDNATUREOPERATION
    join MANOEUVREBORD manb on manb.id = occup.IDMANOEUVREBORD
    join NAVIRELIBCOMPLET nav on nav.ID = occup.IDNAVIRE;
    
CREATE OR REPLACE VIEW OCCUPMATERIELNAVALLIB AS 
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
        duree, position, observation, etat, datefin,
        idarrivee
    from OCCUPMATERIELNAVALLIBCOMPLET
        order by DATY desc;