CREATE OR replace VIEW facture_client_fille_plus AS 
  select facture_client_fille.*,
       cast(0.0 as NUMBER(30,2)) as montant
from facture_client_fille;