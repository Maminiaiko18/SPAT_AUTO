CREATE OR REPLACE VIEW "PLACEMENTLIBCOMPLET"
            ("ID", "ENTITE", "DATE_PLACEMENT", "DATE_ECHEANCE", "DUREE", "MONTANT", "TAUX", "ETAT", "NUMERO", "BANQUE",
             "IDDEVISE", "MONTANTDEVISE", "IDDETAILS", "IDMEREDETAILS", "MOIS", "MONTANT_TERME", "INTERET_RECEVOIR",
             "INTERET_NET", "IDENTITE", "IDBANQUE", "VALENTITE", "DESCEENTITE", "VALBANQUE", "DESCEBANQUE",
             "IDDEVISELIB", "ANCIENPLACEMENT", "IRCM", "DESCECAISSE")
AS
select plt.ID,
       plt.ENTITE,
       plt.DATE_PLACEMENT,
       plt.DATE_ECHEANCE,
       plt.DUREE,
       plt.MONTANT,
       plt.TAUX,
       plt.ETAT,
       plt.NUMERO,
       plt.BANQUE,
       plt.IDDEVISE,
       plt.MONTANTDEVISE,
       det.ID                                                          as iddetails,
       IDMERE                                                          as idmeredetails,
       MOIS,
       MONTANT_TERME,
       INTERET_RECEVOIR,
       INTERET_NET,
       lp.id                                                           as IDENTITE,
       b.id                                                            as IDBANQUE,
       lp.val                                                          as VALENTITE,
       lp.desce                                                        as DESCEENTITE,
       b.val                                                           as VALBANQUE,
       b.desce                                                         as DESCEBANQUE,
       dev.VAL                                                         as iddeviselib,
       plt.ancienPlacement,
       CAST((det.interet_recevoir - det.interet_net) AS number(30, 2)) as IRCM,
       c.val                                                           AS descecaisse
from placement plt
    join DETAILSPLACEMENT det
        on plt.ID = det.IDMERE join ENTITE lp on lp.id = plt.ENTITE 
    join BANQUE b on b.id = plt.banque 
    left join devise dev on dev.id = plt.iddevise 
    LEFT JOIN PLACEMENT_BANQUE_CAISSE pbc ON pbc.VAL=plt.BANQUE 
    LEFT JOIN caisse c ON c.id=pbc.desce;

CREATE OR REPLACE VIEW "PLACEMENTLIBCOMPLET"
            ("ID", "ENTITE", "DATE_PLACEMENT", "DATE_ECHEANCE", "DUREE", "MONTANT", "TAUX", "ETAT", "NUMERO", "BANQUE",
             "IDDEVISE", "MONTANTDEVISE", "IDDETAILS", "IDMEREDETAILS", "MOIS", "MONTANT_TERME", "INTERET_RECEVOIR",
             "INTERET_NET", "IDENTITE", "IDBANQUE", "VALENTITE", "DESCEENTITE", "VALBANQUE", "DESCEBANQUE",
             "IDDEVISELIB", "ANCIENPLACEMENT", "IRCM", "IDCAISSE", "DESCECAISSE")
AS
select plt.ID,
       plt.ENTITE,
       plt.DATE_PLACEMENT,
       plt.DATE_ECHEANCE,
       plt.DUREE,
       plt.MONTANT,
       plt.TAUX,
       plt.ETAT,
       plt.NUMERO,
       plt.BANQUE,
       plt.IDDEVISE,
       plt.MONTANTDEVISE,
       det.ID                                                          as iddetails,
       IDMERE                                                          as idmeredetails,
       MOIS,
       MONTANT_TERME,
       INTERET_RECEVOIR,
       INTERET_NET,
       lp.id                                                           as IDENTITE,
       b.id                                                            as IDBANQUE,
       lp.val                                                          as VALENTITE,
       lp.desce                                                        as DESCEENTITE,
       b.val                                                           as VALBANQUE,
       b.desce                                                         as DESCEBANQUE,
       dev.VAL                                                         as iddeviselib,
       plt.ancienPlacement,
       CAST((det.interet_recevoir - det.interet_net) AS number(30, 2)) as IRCM,
       c.id                                                            AS idcaisse,
       c.val                                                           AS descecaisse
from placement plt
    join DETAILSPLACEMENT det
        on plt.ID = det.IDMERE join ENTITE lp on lp.id = plt.ENTITE
    join BANQUE b on b.id = plt.banque 
    left join devise dev on dev.id = plt.iddevise 
    LEFT JOIN PLACEMENT_BANQUE_CAISSE pbc ON pbc.VAL=plt.BANQUE 
    LEFT JOIN caisse c ON c.id=pbc.desce;

