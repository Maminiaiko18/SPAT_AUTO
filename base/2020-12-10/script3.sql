CREATE OR REPLACE FORCE VIEW SPAT_CAPITAINERIE.CHANTIERLIBELLE
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
          MONTANT,
          NVL ( (  SELECT MAX (pourcentage)
                     FROM POURCENTAGEPROJET p
                    WHERE p.IDCHANTIER = cc.id and p.etat>=11
                 GROUP BY IDCHANTIER),
               0)
             AVANCEMENT,
          NOMTIERS AS idtiers,
          ETAT
     FROM CHANTIERLIBCOMPLET cc;