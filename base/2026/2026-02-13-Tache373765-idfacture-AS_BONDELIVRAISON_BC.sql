CREATE OR REPLACE VIEW AS_BONDELIVRAISON_BC  AS 
  select bl.ID,
       bl.REMARQUE,
       bl.IDBC,
       bl.DATY,
       bl.ETAT,
       bl.POINT,
       bl.ID_BC,
       bc.NUMBC,
       bl.idfacture,
       cast(nvl(montant, 0) as NUMBER(30,3)) as montant,
       cast(nvl(montanttva, 0) as NUMBER(30,3)) as montanttva,
       cast(nvl(montanttc, 0) as NUMBER(30,3)) as montantttc,
       bc.IDENGAGEMENT 
from AS_BONDELIVRAISON bl
         left join AS_BONDECOMMANDE bc on bl.ID_BC = bc.ID
         left join AS_BONDELIVRAISON_BCMERE bcm on bcm.numbl = bl.id

;