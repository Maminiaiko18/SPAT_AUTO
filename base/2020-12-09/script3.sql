
create view MOUVEMENT_LIBCOMPLET AS
select mv.*,
       N.NOM                    AS NAVIRELIB,
       C2.DESCE                 AS CONSIGNATAIRELIB,
       pP1.val || ' ' || q1.VAL as provenanceLIB,
       pp2.val || ' ' || q2.VAL as destinationLIB,
       CARG.VAL                 AS CARGAISONLIB,
       TM.VAL                   AS TYPEMVTLIB
from MOUVEMENT mv
         JOIN NAVIRE N on mv.NAVIRE = N.ID
         LEFT JOIN CONSIGNATAIRETAB C2 on mv.CONSIGNATAIRE = C2.ID
         LEFT join POSTEDESTINATAIRE p1 on p1.id = mV.PROVENANCE
         join QUAIS q1 on q1.id = p1.QUAI
         LEFT join pays pp1 on pp1.id = p1.PAYS
         join POSTEDESTINATAIRE p2 on p2.id = mV.destination
         LEFT join pays pp2 on pp2.id = p2.PAYS
         LEFT join QUAIS q2 on q2.id = p2.QUAI
         join CARGAISON carg on carg.id = mV.CARGAISON
         LEFT JOIN TYPEMVT TM ON TM.ID = MV.TYPEMVT;

create OR REPLACE view OCCUPMATERIELNAVALLIBCOMPLET as
select occup.*,
       mat.denomination,
       mat.DATE_AQUISITION,
       mat.IDMARQUE,
       mat.PUISSANCE,
       mat.DETENTEUR,
       mat.MAINTENANCE,
       mat.IDTYPE_MATERIEL,
       mat.IMMATRICULATION,
       mat.etat     as etatmaterielnaval,
       mat.valmarque,
       mat.descemarque,
       mat.valtypemateriel,
       mat.descetypemateriel,
       p.VAL        as valpilote,
       p.DESCE      as descepilote,
       comm.val     as valcommandant,
       comm.DESCE   as descecommandant,
       nat.val      as valnatureoperation,
       nat.DESCE    as descenatureoperation,
       manb.val     as valmanoeuvrebord,
       manb.DESCE   as descemanoeuvrebord,
       nav.reference,
       nav.nom      as nomnavire,
       nav.pavillon as pavillonnavire,
       nav.jnt,
       nav.JBT,
       nav.PLT,
       nav.LHT,
       nav.lm,
       nav.te,
       nav.volume,
       nav.remarque,
       nav.valpavillon,
       nav.descepavillon,
       ML.ESCALE||'-'||ML.NAVIRELIB AS IDARRIVEELIB
from OCCUPATIONMATERIELNAVAL occup
         join MATERIELNAVALLIBCOMPLET mat on mat.ID = occup.IDMATERIEL_NAVAL
         LEFT join pilote p on p.ID = occup.IDPILOTE
         join COMMANDANT comm on comm.id = occup.IDCOMMANDANT
         join NATUREOPERATION nat on nat.id = occup.IDNATUREOPERATION
         join MANOEUVREBORD manb on manb.id = occup.IDMANOEUVREBORD
         LEFT join NAVIRELIBCOMPLET nav on nav.ID = occup.IDNAVIRE
         LEFT JOIN MOUVEMENT_LIBCOMPLET ML ON ML.ID = occup.IDARRIVEE;

CREATE OR REPLACE VIEW MOUVEMENTLIBCOMPLET
AS
SELECT
            mvt.ID,
            mvt.daty,
            mvt.ESCALE,
            mvt.NAVIRE,
            mvt.CONSIGNATAIRE,
            mvt.DATEARRIVEE,
            mvt.heure,
            mvt.PROVENANCE,
            mvt.DESTINATION,
            mvt.REMARQUE,
            mvt.DUREE  ,
            mvt.TYPEMVT,
            mvt.etat,
            mvt.CARGAISON,
            mvt.HEURE_DEPART,
            mvt.DATE_DEPART,
            tm.VAL as valmvt,
            tm.desce as descemvt,
            car.VAL as valcargaison,
            car.desce as descecargaison,
            pro.QUAI as quaiprovenance,
            pro.INTERNE as interneprovenance,
            q.PAYS as paysprovenance,
            q.val as valquaisprovenance,
            q.DESCE as descequaisprovenance,
            q.TYPEQUAIS as typequaisprovenance,
            q.TIRANT as tirantprovenance,
            q.LONGUEUR as longueurprovenance,
            q.PROFONDEUR as profondeurprovenance,
            p.VAL as valpaysprovenance,
            p.DESCE as descepaysprovenance,
            des.QUAI as quaisdestination,
            des.INTERNE as internedestination,
            q1.PAYS as paysdestination,
            q1.VAL as valquaisdestination,
            q1.DESCE as descequaisdestination,
            q1.TYPEQUAIS as typequaisdestianantion,
            q1.TIRANT as tirantdestination,
            q1.LONGUEUR as longueurdestination,
            q1.PROFONDEUR as profondeurdestination,
            p1.VAL as valpaysdestination,
            p1.DESCE as descepaysdestination,
            na.REFERENCE as referencenavire,
            na.NOM as nomnavire,
            na.PAVILLON as pavillonnavire,
            na.JNT as jntnavire,
            na.JBT as jbtnavire,
            na.PLT as pltnavire,
            na.LHT as lhtnavire,
            na.LM as lmnavire,
            na.TE as tenavire,
            na.VOLUME as volumenavire,
            na.REMARQUE as remarquenavire,
            na.ETAT as etatnavire,
            cons.VAL as valconsignataire,
            cons.DESCE as desceconsignataire,
            t.VAL as valtypequaisprovenance,
            t.DESCE as descetypequaisprovenance,
            t2.val as valtypequaisdestination,
            t2.DESCE as descetypequaisdestination
        from MOUVEMENT mvt
        left join  NAVIRE na on na.ID=MVT.NAVIRE
        left join CONSIGNATAIRETAB cons on cons.ID =mvt.CONSIGNATAIRE
        left join POSTEDESTINATAIRE pro on pro.id=mvt.PROVENANCE
        left join POSTEDESTINATAIRE des on des.id=mvt.DESTINATION
        left join TYPEMVT tm on  tm.id=mvt.TYPEMVT
        left join CARGAISON car on car.id=mvt.CARGAISON
        left join quais q on q.id=pro.QUAI
        left join pays p on p.id=q.PAYS
        left join  quais q1 on q1.id=des.QUAI
        left join pays p1 on p1.id=q1.PAYS
        left JOIN TYPEQUAIS T on q.TYPEQUAIS = T.ID
        left JOIN TYPEQUAIS T2 ON T2.ID=Q1.TYPEQUAIS;

CREATE OR REPLACE FORCE VIEW OCCUPMATERIELNAVALLIBCOMPLET AS 
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
    LEFT join pilote p on p.ID = occup.IDPILOTE
    join COMMANDANT comm on comm.id = occup.IDCOMMANDANT
    join NATUREOPERATION nat on nat.id = occup.IDNATUREOPERATION
    join MANOEUVREBORD manb on manb.id = occup.IDMANOEUVREBORD
    LEFT join NAVIRELIBCOMPLET nav on nav.ID = occup.IDNAVIRE;


    ALTER  TABLE detailsfacturefournisseur MODIFY PU NUMBER(25,2);
    create OR REPLACE view etatfacturemontantdatyretenu
            (id, daty, idfournisseur, nomfournisseur, idtva, montantttc, remarque, dateemission, designation, iddevise,
             numfact, datyecheance, etat, montantpaye, reste, entite, montantttdevise, budget, retenue, montant)
as
SELECT DISTINCT efm.id,
                efm.daty,
                efm.idfournisseur,
                t.nom                  AS nomfournisseur,
                efm.idtva,
                efm.montantttc,
                null                   AS remarque,
                efm.dateemission,
                efm.designation,
                efm.iddevise,
                efm.numfact,
                efm.datyecheance,
                efm.etat,
                COALESCE(mv.debit, 0)  AS montantpaye,
                COALESCE(efm.reste, 0) AS reste,
                ''                     AS entite,
                dff.montantttc         AS montantttdevise,
                ''                     AS budget,
                0                      AS retenue,
                0                      AS montant
FROM etatfacturemontant efm
         JOIN facturefournisseur dff ON dff.id = efm.id
         LEFT JOIN tiers t ON dff.idfournisseur = t.id
    --  LEFT JOIN budget_depense bd ON dff.budget = bd.id
    -- JOIN marcheetat m ON dff.remarque = m.id
         LEFT JOIN ordonnerpayement op ON op.ded_id = dff.id AND OP.ETAT>=11
         LEFT JOIN JOURNALCAISSE mv ON mv.idordre = op.id;

