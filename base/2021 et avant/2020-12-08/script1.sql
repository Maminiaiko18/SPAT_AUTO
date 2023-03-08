alter table PREVISIONMATERIELNAVAL drop constraint sys_c0031295;
create OR REPLACE view PREVISIONMATERIELNAVALLIB2
            (ID, IDMATERIEL_NAVAL, IDCOMMANDANT, IDNATUREOPERATION, IDNAVIRE, DATY, IDCLIENT, DUREE, OBSERVATION, ETAT,
             DATE_DEPART, DATE_ARRIVEE, HEURE_DEPART, HEURE_ARRIVEE)
AS
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
         left join mouvement mv on mv.ID=p.IDARRIVEE
        left  join NAVIRE nav on mv.ID = nav.ID
ORDER BY DATY DESC;

create or replace view OCCUPATIONMATERIELNAVALLIB as
select
  OCCUPATIONMATERIELNAVAL.ID,
  OCCUPATIONMATERIELNAVAL.DATY,
	IDMATERIEL_NAVAL,
	pilote.val||' '|| pilote.desce as IDPILOTE,
	Commandant.val as IDCOMMANDANT,
	NATUREOPERATION.val as IDNATUREOPERATION,
	MANOEUVREBORD.val as IDMANOEUVREBORD,
	OCCUPATIONMATERIELNAVAL.HEUREDEBUT,
	OCCUPATIONMATERIELNAVAL.HEUREFIN,
	navire.nom as IDNAVIRE,
	IDCLIENT,
	OCCUPATIONMATERIELNAVAL.DUREE,
	OCCUPATIONMATERIELNAVAL.POSITION,
	OCCUPATIONMATERIELNAVAL.OBSERVATION,
	OCCUPATIONMATERIELNAVAL.ETAT,
	OCCUPATIONMATERIELNAVAL.DATEFIN
  from OCCUPATIONMATERIELNAVAL
 -- left join MATERIEL_NAVAL on MATERIEL_NAVAL.id=OCCUPATIONMATERIELNAVAL.IDMATERIEL_NAVAL
  left join PILOTE on PILOTE.ID=OCCUPATIONMATERIELNAVAL.IDPILOTE
  left join COMMANDANT on COMMANDANT.id=OCCUPATIONMATERIELNAVAL.IDCOMMANDANT
  left join NATUREOPERATION on NATUREOPERATION.id=OCCUPATIONMATERIELNAVAL.IDNATUREOPERATION
  left join MANOEUVREBORD on MANOEUVREBORD.id=OCCUPATIONMATERIELNAVAL.IDMANOEUVREBORD
    left join MOUVEMENT mv on mv.id=OCCUPATIONMATERIELNAVAL.IDARRIVEE
 left join navire on navire.id=mv.id;
create or replace view mvtcaisse_ordonnerpayement_F(id, nomfournisseur, montantttc, idordre,idfournisseur) as
SELECT e.id,
       e.nomfournisseur,
       e.montantttc,
       m.idordre,
       e.idfournisseur
FROM mvtcaisse m
         JOIN ordonnerpayement o ON m.idordre = o.id
         JOIN etatfacturemontantdaty e ON o.ded_id = e.id;
CREATE OR REPLACE FORCE VIEW FACTUREFOURNISSEURLIBELLE
(
   ID,
   DATY,
   IDFOURNISSEUR,
   FOURNISSEUR,
   IDTVA,
   MONTANTTTC,
   IDCHANTIER,
   REMARQUE,
   DATEEMISSION,
   DESIGNATION,
   IDDEVISE,
   NUMFACT,
   RESP,
   DATYECHEANCE,
   ETAT,
   IDFACTUREFOURNISSEUR,
   BUDGET,
   MONTANTDEVISE,
   EXERCICE,
   TYPE
)
AS
   SELECT ff.id,
          daty,
          idfournisseur,
          t.NOM AS fournisseur,
          idtva,
          montantttc,
          remarque AS idchantier,
          ch.nom AS remarque,
          dateemission,
          designation,
          iddevise,
          numfact,
          resp,
          datyecheance,
          ff.etat,
          ff.idfacturefournisseur,
          budget,
          montantdevise,
          exercice,
          ff.type
     FROM facturefournisseur ff
          JOIN chantier ch ON ch.id = ff.remarque
          LEFT JOIN tiers t ON t.id = ff.idfournisseur;
