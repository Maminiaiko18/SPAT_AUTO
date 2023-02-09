------------script spat Mr Tahina------

CREATE OR REPLACE  VIEW PAIEMENTFACTUREPROVISION
(
   ID,
   IDMVT,
   IDFACT,
   MONTANT
)
AS
   SELECT pf."ID",
          pf."IDMVT",
          pf."IDFACT",
          pf."MONTANT"
     FROM paiementfacture pf JOIN factureclient fc ON fc.id = pf.idfact
    WHERE fc.etat >= 11 AND fc.idcategorie = 'CATFCO2';
    

CREATE OR REPLACE  VIEW PAIEMENTFACTHORSPROVAVECPROV
AS
   SELECT pf."ID",
          pf."IDMVT",
          pf."IDFACT",
          pf."MONTANT",
          PP.IDFACT as provision
     FROM paiementfacture pf JOIN factureclient fc ON fc.id = pf.idfact
     LEFT JOIN PAIEMENTFACTUREPROVISION pp on PF.IDMVT=PP.IDMVT
    WHERE fc.etat >= 11 AND fc.idcategorie != 'CATFCO2';
	

CREATE OR REPLACE VIEW PAIEMENTFACTHORSPROVAVECPROV
AS
   SELECT pf."ID",
          pf."IDMVT",
          pf."IDFACT",
          pf."MONTANT",
          PP.IDFACT as idprovision
     FROM paiementfacture pf JOIN factureclient fc ON fc.id = pf.idfact
     LEFT JOIN PAIEMENTFACTUREPROVISION pp on PF.IDMVT=PP.IDMVT
    WHERE fc.etat >= 11 AND fc.idcategorie != 'CATFCO2';
	
	
	
CREATE OR REPLACE VIEW PMENTFACTHORSPROVAVPROVCPLT AS 
SELECT prov.*, fcu.daty, fcu.TIERS, fcu.TIERSLIB, fcu.DESIGNATION , fcu."TYPE", fcu.REMARQUE, fcu.DATE_ECHEANCE,
fcu.ETATLIB, fcu.ETAT, fcu.CONTACT, fcu.ADRESSE, fcu.DEVISEMERE, fcu.MONTANTTVA, fcu.MONTANTAVOIR, fcu.MONTANTPAYE,
fcu.MONTANTRESTE, fcu.CATEGORIELIB
FROM PAIEMENTFACTHORSPROVAVECPROV prov LEFT join FACTURE_CLIENT_UNION2 fcu on prov.idfact = fcu.ID;
