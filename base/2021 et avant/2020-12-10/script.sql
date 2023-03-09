create OR REPLACE view POURCENTAGEPROJETLIBCOMPLET as
select pp."ID",
       pp."IDCHANTIER",
       pp."DATY",
       pp."POURCENTAGE",
       pp."OBSERVATION",
       pp."IDUTILISATEUR",
       pp."ETAT",
       ch.idtravaux,
       nom,
       datydebut,
       datyfin,
       montant,
       avancement,
       idtiers,
       ch.etat as etatchantier,
       nomtiers,
       desctiers,
       nif,
       stat,
       contact,
       responsable,
       adresse,
       type,
       etattiers,
       nomtravaux,
       datedebuttravaux,
       datefintravaux,
       montanttravaux,
       avancementtravaux,
       desctravaux,
       etattravaux,
       idtypetravaux,
       valtypetravaux,
       descetypetravaux,
       u.REFUSER,
       LOGINUSER,
       PWDUSER,
       NOMUSER,
       ADRUSER,
       TELUSER,
       IDROLE
from pourcentageprojet pp
         join chantierlibcomplet ch on ch.id = pp.idchantier
         LEFT join utilisateur u on to_char(u.refuser) = pp.idutilisateur;
        
        CREATE OR REPLACE FORCE VIEW POURCENTAGEPROJETLIBCREE  AS
select *
from pourcentageprojetlib
where etat = 1;

CREATE OR REPLACE  VIEW CHANTIERLIBELLE
(
ID,
IDTRAVAUX,
NOM,
DATYDEBUT,
DATYFIN,
MONTANT,
AVANCEMENT,
IDTIERS,
ETAT
)
AS
SELECT id,
NOMTRAVAUX AS idtravaux,
nom,
DATYDEBUT,
DATYFIN,
CAST (MONTANT AS NUMBER (30, 2)) AS montant,
NVL ( ( SELECT MAX (pourcentage)
FROM POURCENTAGEPROJET p
WHERE p.IDCHANTIER = cc.id and p.etat>=11
GROUP BY IDCHANTIER),
0),
CAST(AVANCEMENT AS NUMBER(10,2)) as AVANCEMENT,
NOMTIERS AS idtiers,
ETAT
FROM CHANTIERLIBCOMPLET cc;

CREATE OR REPLACE VIEW PREVISION_MAT_NAVAL_LIBcomplet AS
SELECT
	p.ID,
	p.DATY,
	p.IDMATERIEL_NAVAL,
	mn.DENOMINATION ,
	p.IDCOMMANDANT,
	c.VAL AS VALCOMMANDANT,
	p.IDNATUREOPERATION,
	n.VAL AS VALNATUREOPERATION,
	p.IDNAVIRE,
	p.IDCLIENT,
	p.DUREE,
	p.OBSERVATION,
	p.ETAT,
	p.DATE_DEPART,
	p.HEURE_DEPART,
	p.DATE_ARRIVEE,
	p.HEURE_ARRIVEE,
	p.IDARRIVEE,
	m.ESCALE || '-' || m.NAVIRELIB AS IDARRIVEELIB
FROM
	PREVISIONMATERIELNAVAL p
JOIN MATERIEL_NAVAL mn ON
	p.IDMATERIEL_NAVAL = mn.ID
JOIN COMMANDANT c ON
	p.IDCOMMANDANT = c.ID
JOIN NATUREOPERATION n ON
	p.IDNATUREOPERATION = n.ID
LEFT JOIN MOUVEMENT_LIBCOMPLET m ON
	p.IDARRIVEE = m.ID ;



CREATE OR REPLACE VIEW PREVISIONMATERIELNAVALLIB3 AS 
SELECT 
	ID,
	DENOMINATION AS IDMATERIEL_NAVAL,
	IDCOMMANDANT ,
	IDNATUREOPERATION ,
	IDNAVIRE ,
	DATY ,
	IDCLIENT ,
	DUREE ,
	OBSERVATION ,
	ETAT ,
	DATE_DEPART ,
	DATE_ARRIVEE ,
	HEURE_DEPART ,
	HEURE_ARRIVEE ,
	IDARRIVEE ,
	IDARRIVEELIB 
FROM PREVISION_MAT_NAVAL_LIBcomplet;