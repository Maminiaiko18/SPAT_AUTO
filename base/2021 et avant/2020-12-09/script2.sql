

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
mvt.DUREE || ' (en j)' AS DUREE ,
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
left join NAVIRE na on na.ID=MVT.NAVIRE
left join CONSIGNATAIRETAB cons on cons.ID =mvt.CONSIGNATAIRE
left join POSTEDESTINATAIRE pro on pro.id=mvt.PROVENANCE
left join POSTEDESTINATAIRE des on des.id=mvt.DESTINATION
left join TYPEMVT tm on tm.id=mvt.TYPEMVT
left join CARGAISON car on car.id=mvt.CARGAISON
left join quais q on q.id=pro.QUAI
left join pays p on p.id=q.PAYS
left join quais q1 on q1.id=des.QUAI
left join pays p1 on p1.id=q1.PAYS
left JOIN TYPEQUAIS T on q.TYPEQUAIS = T.ID
left JOIN TYPEQUAIS T2 ON T2.ID=Q1.TYPEQUAIS;