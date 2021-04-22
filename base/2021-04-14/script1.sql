create table detailRubriqueVide(
	rubrique varchar(500),
	cpt_rubrique varchar(50),
	ec_montant number(25,2)
);
alter table detailRubriqueVide add libelle_cpt_rubrique varchar(500);

CREATE OR REPLACE FORCE VIEW JOURNALCAISSE_ANALYSE
(
   ID,
   DATESAISIE,
   DATEEFFET,
   FOLIO,
   CAISSE,
   NUMPIECE,
   LIBELLE,
   DEBIT,
   CREDIT,
   REMARQUE,
   ETAT,
   TIERS,
   IDTYPECHEQUE
)
AS
   SELECT ab.ID,
          ab.DATESAISIE,
          ab.DATEEFFET,
          ab.FOLIO,
          ab.valcaisse as CAISSE,
          ab.NUMPIECE,
          ab.LIBELLE,
          ab.DEBIT,
          ab.CREDIT,
          ab.REMARQUE,
          ab.ETAT,
          ab.TIERS,
          ab.IDTYPECHEQUE
     FROM journalcaisselibcomplet ab;
	 
CREATE OR REPLACE FORCE VIEW OCCUPMATERIELNAVALLIBNOMBRE
AS
   SELECT occ.id,
          occ.daty,
          occ.idmateriel_naval,
          occ.idpilote,
          occ.idcommandant,
          occ.idnatureoperation,
          occ.idmanoeuvrebord,
          occ.heuredebut,
          occ.heurefin,
          occ.idnavire,
          occ.duree,
          occ.position,
          occ.observation,
          occ.etat,
          occ.datefin,
          p.escale as escale,
          CAST (1 AS NUMBER (10, 2)) AS nombre
     FROM occupmaterielnavallib occ
     join mouvement m on m.id=occ.idarrivee
     join prevision p on p.id=m.escale;
	 
CREATE OR REPLACE FORCE VIEW OCCUPMATERIELNAVALLIBCOMPLET
(
   ID,
   DATY,
   IDMATERIEL_NAVAL,
   IDPILOTE,
   IDCOMMANDANT,
   IDNATUREOPERATION,
   IDMANOEUVREBORD,
   HEUREDEBUT,
   HEUREFIN,
   IDNAVIRE,
   IDCLIENT,
   DUREE,
   POSITION,
   OBSERVATION,
   ETAT,
   DATEFIN,
   IDARRIVEE,
   DENOMINATION,
   DATE_AQUISITION,
   IDMARQUE,
   PUISSANCE,
   DETENTEUR,
   MAINTENANCE,
   IDTYPE_MATERIEL,
   IMMATRICULATION,
   ETATMATERIELNAVAL,
   VALMARQUE,
   DESCEMARQUE,
   VALTYPEMATERIEL,
   DESCETYPEMATERIEL,
   VALPILOTE,
   DESCEPILOTE,
   VALCOMMANDANT,
   DESCECOMMANDANT,
   VALNATUREOPERATION,
   DESCENATUREOPERATION,
   VALMANOEUVREBORD,
   DESCEMANOEUVREBORD,
   REFERENCE,
   NOMNAVIRE,
   PAVILLONNAVIRE,
   JNT,
   JBT,
   PLT,
   LHT,
   LM,
   TE,
   VOLUME,
   REMARQUE,
   VALPAVILLON,
   DESCEPAVILLON,
   IDARRIVEELIB,
   POSITIONLIB,
   ETATLIB
)
AS
   SELECT occup.ID,
          occup.DATY,
          occup.IDMATERIEL_NAVAL,
          occup.IDPILOTE,
          occup.IDCOMMANDANT,
          occup.IDNATUREOPERATION,
          occup.IDMANOEUVREBORD,
          occup.HEUREDEBUT,
          occup.HEUREFIN,
          occup.IDNAVIRE,
          occup.IDCLIENT,
          occup.DUREE,
          occup.POSITION,
          occup.OBSERVATION,
          occup.ETAT,
          occup.DATEFIN,
          occup.IDARRIVEE,
          mat.denomination,
          mat.DATE_AQUISITION,
          mat.IDMARQUE,
          mat.PUISSANCE,
          mat.DETENTEUR,
          mat.MAINTENANCE,
          mat.IDTYPE_MATERIEL,
          mat.IMMATRICULATION,
          mat.etat AS etatmaterielnaval,
          mat.valmarque,
          mat.descemarque,
          mat.valtypemateriel,
          mat.descetypemateriel,
          p.VAL AS valpilote,
          p.DESCE AS descepilote,
          comm.val AS valcommandant,
          comm.DESCE AS descecommandant,
          nat.val AS valnatureoperation,
          nat.DESCE AS descenatureoperation,
          manb.val AS valmanoeuvrebord,
          manb.DESCE AS descemanoeuvrebord,
          nav.reference,
          nav.nom AS nomnavire,
          nav.pavillon AS pavillonnavire,
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
          ML.ESCALE || '-' || ML.NAVIRELIB AS IDARRIVEELIB,
          CASE
             WHEN POSITION = '1' THEN 'Tribord'
             WHEN POSITION = '2' THEN 'babord '
             ELSE '-'
          END
             AS positionlib,
          CASE
             WHEN occup.etat = 1 THEN 'CREER'
             WHEN occup.etat = 11 THEN 'VISEE'
          END
             AS ETATLIB
     FROM OCCUPATIONMATERIELNAVAL occup
          LEFT JOIN MATERIELNAVALLIBCOMPLET mat
             ON mat.ID = occup.IDMATERIEL_NAVAL
          LEFT JOIN pilote p ON p.ID = occup.IDPILOTE
          LEFT JOIN COMMANDANT comm ON comm.id = occup.IDCOMMANDANT
          LEFT JOIN NATUREOPERATION nat ON nat.id = occup.IDNATUREOPERATION
          LEFT JOIN MANOEUVREBORD manb ON manb.id = occup.IDMANOEUVREBORD
          LEFT JOIN MOUVEMENT_LIBCOMPLET ML ON ML.ID = occup.IDARRIVEE
		  LEFT JOIN NAVIRELIBCOMPLET nav ON nav.ID = ml.NAVIRE
          ;