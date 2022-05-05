
CREATE OR REPLACE  VIEW PLACEMENT_ANALYSE (ENTITE, BANQUE, ANNEEPLACEMENT, ANNEEREMBOUSEMENT, MOISPLACEMENT, MOISREMBOUSEMENT, MONTANT, MONTANT_TERME, INTERET_RECEVOIR, INTERETNET , moisPlacementlib , moisRembousementlib) AS 
  SELECT
pl.entite ,
pl.banque,
EXTRACT(year from pl.date_placement) as anneePlacement ,
EXTRACT(year from rp.daty) as anneeRembousement , 
EXTRACT(month from pl.date_placement) as moisPlacement ,
EXTRACT(month from rp.daty) as moisRembousement , 
pl.montant , 
dp.montant_terme , 
dp.interet_recevoir,
nvl(rp.interet,0) as interetnet , 
m.val as moisPlacementlib ,
m2.val as moisRembousementlib 
from placementlib pl
left join detailsplacement dp on dp.idmere=pl.id
left join remboursementplacementv rp ON rp.idplacement=pl.id 
LEFT JOIN mois m ON m.id = EXTRACT(month from pl.date_placement) 
LEFT JOIN mois m2 ON m2.id = EXTRACT(month from rp.daty); 






CREATE OR REPLACE  VIEW PLACEMENT_ANALYSE (ENTITE, BANQUE, ANNEEPLACEMENT, ANNEEREMBOUSEMENT, MOISPLACEMENT, MOISREMBOUSEMENT, MONTANT, MONTANT_TERME, INTERET_RECEVOIR, INTERETNET , moisPlacementlib , moisRembousementlib) AS 
  SELECT
pl.entite ,
pl.banque,
EXTRACT(year from pl.date_placement) as anneePlacement ,
EXTRACT(year from rp.daty) as anneeRembousement , 
EXTRACT(month from pl.date_placement) as moisPlacement ,
EXTRACT(month from rp.daty) as moisRembousement , 
pl.montant , 
dp.montant_terme , 
dp.interet_recevoir,
nvl(rp.interet,0) as interetnet , 
m.val as moisPlacementlib ,
m2.val as moisRembousementlib 
from placementlib pl
left join detailsplacement dp on dp.idmere=pl.id
left join remboursementplacementv rp ON rp.idplacement=pl.id 
LEFT JOIN mois m ON m.id = EXTRACT(month from pl.date_placement) 
LEFT JOIN mois m2 ON m2.id = EXTRACT(month from rp.daty)
WHERE pl.etat>=11 ;                               


CREATE OR REPLACE VIEW PLACEMENT_ANALYSE_NEW  (ENTITE, BANQUE, ANNEEPLACEMENT, ANNEEREMBOUSEMENT, MOISPLACEMENT, MOISREMBOUSEMENT, MONTANT, MONTANT_TERME, INTERET_RECEVOIR, INTERETNET , moisPlacementlib , moisRembousementlib) 
AS SELECT
pl.entite ,
pl.banque,
EXTRACT(year from pl.date_placement) as anneePlacement ,
EXTRACT(year from rp.daty) as anneeRembousement , 
EXTRACT(month from pl.date_placement) as moisPlacement ,
EXTRACT(month from rp.daty) as moisRembousement , 
pl.montant , 
dp.montant_terme , 
dp.interet_recevoir,
nvl(rp.interet,0) as interetnet , 
m.val as moisPlacementlib ,
m2.val as moisRembousementlib 
from placementlib_nouveau   pl
left join detailsplacement dp on dp.idmere=pl.id
left join remboursementplacementv rp ON rp.idplacement=pl.id 
LEFT JOIN mois m ON m.id = EXTRACT(month from pl.date_placement) 
LEFT JOIN mois m2 ON m2.id = EXTRACT(month from rp.daty)
WHERE pl.etat>=11 ;                    




CREATE OR REPLACE  VIEW PLACEMENT_ANALYSE_RENOUVELLE (ENTITE, BANQUE, ANNEEPLACEMENT, ANNEEREMBOUSEMENT, MOISPLACEMENT, MOISREMBOUSEMENT, MONTANT, MONTANT_TERME, INTERET_RECEVOIR, INTERETNET , moisPlacementlib , moisRembousementlib) AS 
  SELECT
pl.entite ,
pl.banque,
EXTRACT(year from pl.date_placement) as anneePlacement ,
EXTRACT(year from rp.daty) as anneeRembousement , 
EXTRACT(month from pl.date_placement) as moisPlacement ,
EXTRACT(month from rp.daty) as moisRembousement , 
pl.montant , 
dp.montant_terme , 
dp.interet_recevoir,
nvl(rp.interet,0) as interetnet , 
m.val as moisPlacementlib ,
m2.val as moisRembousementlib 
from placementlib_renouvelle     pl
left join detailsplacement dp on dp.idmere=pl.id
left join remboursementplacementv rp ON rp.idplacement=pl.id 
LEFT JOIN mois m ON m.id = EXTRACT(month from pl.date_placement) 
LEFT JOIN mois m2 ON m2.id = EXTRACT(month from rp.daty)
WHERE pl.etat>=11 ;                                              





INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0000023', 'Analyse', 'fa fa-area-chart', '/spat/pages/globalnegoce.jsp?but=placement/placement-analyse.jsp', 4, 4, 'MEN0000123');
