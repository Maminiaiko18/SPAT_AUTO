CREATE OR REPLACE FORCE VIEW MOUVEMENTLIBCOMPLET
AS
   SELECT DISTINCT mvt.ID,
                   mvt.daty,
                   mvt.ESCALE,
                   mvt.NAVIRE,
                   mvt.CONSIGNATAIRE,
                   mvt.PROVENANCE,
                   mvt.DESTINATION,
                   mvt.REMARQUE,
                   mvt.DUREE,
                   mvt.TYPEMVT,
                   mvt.CARGAISON,
                   na.REFERENCE AS referencenavire,
                   na.NOM AS nomnavire,
                   tm.VAL AS valmvt,
                   tm.desce AS descemvt,
                   car.VAL AS valcargaison,
                   car.desce AS descecargaison,
                   cons.VAL AS valconsignataire,
                   cons.DESCE AS desceconsignataire,
                   pro.QUAI AS quaiprovenance,
                   q.val AS valquaisprovenance,
                   q.PAYS AS paysprovenance,
                   p.VAL AS valpaysprovenance,
                   des.QUAI AS quaisdestination,
                   q1.VAL AS valquaisdestination,
                   q1.PAYS AS paysdestination,
                   p1.VAL AS valpaysdestination,
                   mvt.DATEARRIVEE,
                   mvt.heure,
                   mvt.DATE_DEPART,
                   mvt.HEURE_DEPART,
                   pro.INTERNE AS interneprovenance,
                   q.DESCE AS descequaisprovenance,
                   q.TYPEQUAIS AS typequaisprovenance,
                   q.TIRANT AS tirantprovenance,
                   q.LONGUEUR AS longueurprovenance,
                   q.PROFONDEUR AS profondeurprovenance,
                   p.DESCE AS descepaysprovenance,
                   des.INTERNE AS internedestination,
                   q1.DESCE AS descequaisdestination,
                   q1.TYPEQUAIS AS typequaisdestianantion,
                   q1.TIRANT AS tirantdestination,
                   q1.LONGUEUR AS longueurdestination,
                   q1.PROFONDEUR AS profondeurdestination,
                   p1.DESCE AS descepaysdestination,
                   na.PAVILLON AS pavillonnavire,
                   na.JNT AS jntnavire,
                   na.JBT AS jbtnavire,
                   na.PLT AS pltnavire,
                   na.LHT AS lhtnavire,
                   na.LM AS lmnavire,
                   na.TE AS tenavire,
                   na.VOLUME AS volumenavire,
                   na.REMARQUE AS remarquenavire,
                   na.ETAT AS etatnavire,
                   t.VAL AS valtypequaisprovenance,
                   t.DESCE AS descetypequaisprovenance,
                   t2.val AS valtypequaisdestination,
                   t2.DESCE AS descetypequaisdestination,
                   mvt.etat
     FROM MOUVEMENT mvt
          LEFT JOIN NAVIRE na ON na.ID = MVT.NAVIRE
          LEFT JOIN CONSIGNATAIRETAB cons ON cons.id = mvt.CONSIGNATAIRE
          LEFT JOIN POSTEDESTINATAIRE pro ON pro.id = mvt.PROVENANCE
          LEFT JOIN POSTEDESTINATAIRE des ON des.id = mvt.DESTINATION
          LEFT JOIN TYPEMVT tm ON tm.id = mvt.TYPEMVT
          LEFT JOIN CARGAISON car ON car.id = mvt.CARGAISON
          LEFT JOIN quais q ON q.id = pro.QUAI
          LEFT JOIN pays p ON p.id = q.PAYS
          LEFT JOIN quais q1 ON q1.id = des.QUAI
          LEFT JOIN pays p1 ON p1.id = q1.PAYS
          LEFT JOIN TYPEQUAIS T ON q.TYPEQUAIS = T.ID
          LEFT JOIN TYPEQUAIS T2 ON T2.ID = Q1.TYPEQUAIS;
		  
		  
		  
CREATE OR REPLACE FORCE VIEW ETATFACTUREMONTANTDATY
(
   ID,
   DATY,
   IDFOURNISSEUR,
   NOMFOURNISSEUR,
   IDTVA,
   REMARQUE,
   DATEEMISSION,
   DESIGNATION,
   IDDEVISE,
   NUMFACT,
   DATYECHEANCE,
   ETAT,
   MONTANTPAYE,
   RESTE,
   ENTITE,
   MONTANTTTDEVISE,
   BUDGET,
   RETENUE,
   NUMID,
   TIERSLIB,
   TVA,
   MONTANT,
   MONTANTAVOIR,
   MONTANTADDITIF,
   MONTANTNET,
   MONTANTTVA,
   MONTANTTTC,
   MONTANTTOTALAPAYER,
   TYPE,
   CODE_ETABLISSEMENT,
   PROJET
)
AS
   SELECT et.id,
          et.daty,
          et.idfournisseur,
          et.nomfournisseur,
          et.idtva,
          et.remarque,
          et.dateemission,
          et.designation,
          et.iddevise,
          et.numfact,
          et.datyecheance,
          CASE
             WHEN et.etat = 'VALIDE(E)' THEN '11'
             WHEN et.etat = 'CREE(E)' THEN '1'
             ELSE '0'
          END
             AS etat,
          NVL (et.montantpaye, 0) AS montantpaye,
          cast(RESTE as number(25,2)) AS reste,
          et.entite,
          et.montantttdevise,
          et.budget,
          et.retenue,
          et.NUMID,
          t.NOM AS tierslib,
          et.IDTVA AS tva,
          cast(et.montantht + et.montantadditifht - et.montantavoirht as number(25,2)) AS montant,
          cast(et.montantavoir as number(25,2)),
          cast(et.montantadditif as number(25,2)),
          cast(et.montantnet as number(25,2)),
          cast(et.montanttva + et.montantadditiftva - et.montantavoirtva as number(25,2))
             AS montanttva,
          cast(et.montantttc as number(25,2)),
          cast(reste as number(25,2)) AS montantTotalApayer,
          ff.TYPE,
          co.VAL AS CODE_ETABLISSEMENT,
          pr.DESIGNATION AS PROJET
     FROM etatfacturemontantdatyretenu et
          JOIN facturefournisseur_SumMtt ff ON ff.id = et.id
          LEFT JOIN TIERS t ON t.id = et.idfournisseur
          LEFT JOIN projet pr ON pr.id = et.PROJET
          LEFT JOIN CODEETABLISSEMENT co ON co.id = et.CODE_ETABLISSEMENT;