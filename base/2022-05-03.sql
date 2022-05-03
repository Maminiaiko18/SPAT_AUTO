
CREATE VIEW placement_analyse AS SELECT
pl.entite ,
pl.banque,
EXTRACT(year from pl.date_placement) as anneePlacement ,
EXTRACT(year from rp.daty) as anneeRembousement , 
EXTRACT(month from pl.date_placement) as moisPlacement ,
EXTRACT(month from rp.daty) as moisRembousement , 
pl.montant , 
dp.montant_terme , 
dp.interet_recevoir,
nvl(rp.interet,0) as interetnet
from placementlib pl
left join detailsplacement dp on dp.idmere=pl.id
left join remboursementplacementv rp ON rp.idplacement=pl.id ; 


ALTER TABLE PLACEMENT ADD ancienPlacement  varchar(100) CONSTRAINT PLACEMENT_placement REFERENCES placement(id) ; 





CREATE OR REPLACE  VIEW PLACEMENTLIBCOMPLET (ID, ENTITE, DATE_PLACEMENT, DATE_ECHEANCE, DUREE, MONTANT, TAUX, ETAT, NUMERO, BANQUE, IDDEVISE, MONTANTDEVISE, IDDETAILS, IDMEREDETAILS, MOIS, MONTANT_TERME, INTERET_RECEVOIR, INTERET_NET, IDENTITE, IDBANQUE, VALENTITE, DESCEENTITE, VALBANQUE, DESCEBANQUE, IDDEVISELIB , ancienPlacement) AS 
  select plt.ID,plt.ENTITE,plt.DATE_PLACEMENT,plt.DATE_ECHEANCE,plt.DUREE,plt.MONTANT,plt.TAUX,plt.ETAT,plt.NUMERO,plt.BANQUE,plt.IDDEVISE,plt.MONTANTDEVISE,
       det.ID   as iddetails,
       IDMERE   as idmeredetails,
       MOIS,
       MONTANT_TERME,
       INTERET_RECEVOIR,
       INTERET_NET,
       lp.id    as IDENTITE,
       b.id     as IDBANQUE,
       lp.val   as VALENTITE,
       lp.desce as DESCEENTITE,
       b.val    as VALBANQUE,
       b.desce  as DESCEBANQUE,
       dev.VAL  as iddeviselib , 
       plt.ancienPlacement 
from placement plt
         join DETAILSPLACEMENT det on plt.ID = det.IDMERE
         join ENTITE lp on lp.id = plt.ENTITE
         join BANQUE b on b.id = plt.banque
         left join devise dev on dev.id = plt.iddevise;
        
        
        
CREATE OR REPLACE  VIEW PLACEMENTLIB (ID, ENTITE, DATE_PLACEMENT, DATE_ECHEANCE, DUREE, MONTANT, TAUX, NUMERO, BANQUE, ETAT, IDDEVISE, MONTANTDEVISE , ancienPlacement) AS 
  select id,
       valentite as entite,
       date_placement,
       date_echeance,
       duree,
       montant,
       taux,
       numero,
       VALBANQUE as BANQUE,
       etat,
       iddeviselib as iddevise,
       MONTANTDEVISE , 
       ancienPlacement
from PLACEMENTLIBCOMPLET;

CREATE OR REPLACE  VIEW SPAT_PREPROD.PLACEMENTLIB_VISEE (ID, ENTITE, DATE_PLACEMENT, DATE_ECHEANCE, DUREE, MONTANT, TAUX, NUMERO, BANQUE, ETAT, IDDEVISE, MONTANTDEVISE , ancienPlacement) AS 
  select id,
       valentite as entite,
       date_placement,
       date_echeance,
       duree,
       montant,
       taux,
       numero,
       VALBANQUE as BANQUE,
       etat,
       iddeviselib as iddevise,
       MONTANTDEVISE , 
       ancienPlacement
from PLACEMENTLIBCOMPLET
where etat = 11;


CREATE VIEW placementlib_renouvelle
AS select * from placementlib_visee where ancienPlacement is not NULL ; 


CREATE VIEW placementlib_nouveau AS select * from placementlib_visee where ancienPlacement is NULL ; 


