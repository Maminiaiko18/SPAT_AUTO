
CREATE OR REPLACE FORCE VIEW OCCUPMATERIELNAVALLIBCOMPLET
AS
   SELECT occup."ID",
          occup."DATY",
          occup."IDMATERIEL_NAVAL",
          occup."IDPILOTE",
          occup."IDCOMMANDANT",
          occup."IDNATUREOPERATION",
          occup."IDMANOEUVREBORD",
          occup."HEUREDEBUT",
          occup."HEUREFIN",
          occup."IDNAVIRE",
          occup."IDCLIENT",
          occup."DUREE",
          occup."POSITION",
          occup."OBSERVATION",
          occup."ETAT",
          occup."DATEFIN",
          occup."IDARRIVEE",
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
             WHEN POSITION = '2' THEN 'bâbord '
             ELSE '-'
          END
             AS positionlib
     FROM OCCUPATIONMATERIELNAVAL occup
          left JOIN MATERIELNAVALLIBCOMPLET mat ON mat.ID = occup.IDMATERIEL_NAVAL
          LEFT JOIN pilote p ON p.ID = occup.IDPILOTE
          left JOIN COMMANDANT comm ON comm.id = occup.IDCOMMANDANT
          left JOIN NATUREOPERATION nat ON nat.id = occup.IDNATUREOPERATION
          left JOIN MANOEUVREBORD manb ON manb.id = occup.IDMANOEUVREBORD
          LEFT JOIN NAVIRELIBCOMPLET nav ON nav.ID = occup.IDNAVIRE
          LEFT JOIN MOUVEMENT_LIBCOMPLET ML ON ML.ID = occup.IDARRIVEE;
		  
		  
		  
insert into menudynamique values('MEN0000202A','Saisir nouveau',' fa fa-plus','/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp'||'&'||'ciblename=consignatairetab','2','4','MEND0000201');
