CREATE OR REPLACE FORCE VIEW POURCENTAGEPROJET_LIB_ETAT
(
   ID,
   CHANTIER,
   DATY,
   POURCENTAGE,
   OBSERVATION,
   IDUTILISATEUR,
   ETAT,
   IDCHANTIER,
     ETATLIB
)
AS
   SELECT p.id,
          c.nom as chantier,
          p.daty,
          p.pourcentage,
          p.observation,
          p.idutilisateur,
          p.etat,
          c.id as IDCHANTIER,
          CASE WHEN p.etat = 1 THEN 'CREE' ELSE 'VALIDE' END AS etatlib
     FROM pourcentageprojet p JOIN CHANTIER c on p.idchantier = c.id;
create or replace view CHANTIERLIBELLE as
select id,
       NOMTRAVAUX as idtravaux,
       nom,
       DATYDEBUT,
       DATYFIN,
       MONTANT,
       nvl((select max(pourcentage) from POURCENTAGEPROJET p where p.IDCHANTIER = cc.id group by IDCHANTIER),
           0)        AVANCEMENT,
       NOMTIERS   as idtiers,
       ETAT
from CHANTIERLIBCOMPLET cc;

create view pourcentageprojet_lib_etat
            (ID, CHANTIER, DATY, POURCENTAGE, OBSERVATION, IDUTILISATEUR, ETAT, ETATLIB)
AS
select id,
       idchantier,
       daty,
       pourcentage,
       observation,
       idutilisateur,
       etat,
       CASE  WHEN etat = 1
           then 'CREE' ELSE 'VALIDE' END as etatlib
FROM pourcentageprojetlib;

CREATE OR REPLACE
VIEW DETAILSFFBONLIVRAISONLIB AS
SELECT
	dl.id,
	dl.QTE,
	dl.pu,
	dl.IDMERE,
	dl.COMPTE,
	dl.IDINGREDIENT,
	dl.livre,
	dl.reste
FROM
	Detailsffbonlivraison dl;