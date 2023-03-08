create or replace view bc_bl_fille ("ID", "PRODUIT", "IDBC", "QUANTITE", "PU", "REMARQUE", "NUMBL", 
"QTELIVRE") as 
select bcf.id, bcf.produit, idbc, bcf.quantite, pu, remarque, numbl, blf.quantite as qtelivre 
from AS_BONDECOMMANDE_FILLE bcf join AS_BONDELIVRAISON_FILLE blf ON bcf.id = blf.idbondecommande;


create or replace view bc_bl_livre("ID", "IDBCF", "PRODUIT", "IDBC", "PU", "REMARQUE", "NUMBL", "QTELIVRE", "DATY", "ETAT")
as select bl.id,bbf.id as idbcf, bbf.produit, bbf.idbc, bbf.pu, bbf.remarque, bbf.numbl,qtelivre, daty, etat 
from bc_bl_fille bbf join AS_BONDELIVRAISON bl on bbf.numbl = bl.id;