

create view AS_BONDECOMMANDE_FILLE_LIBELLE as
select bcf.id, prd.libelle as produit, bcf.idbc, bcf.quantite, bcf.pu, bcf.quantiteparpack, bcf.remarque
from as_bondecommande_fille bcf join ElementChantier prd on bcf.produit = prd.id
/
CREATE VIEW postbureau AS
SELECT *FROM poste WHERE id<>'POST000001';
CREATE VIEW postmembre AS
SELECT *FROM poste WHERE id='POST000001';

CREATE VIEW DETAILCHANTIERELEMENT AS
SELECT d.ID ,MERE ,e.LIBELLE  AS IDELEMENT ,d.QTE ,d.PU ,d.ETAT FROM DETAILCHANTIER d 
	JOIN ELEMENTCHANTIER e ON e.id=d.IDELEMENT ;

insert into quais(id, val, desce, typequais, longueur, profondeur, pays) values('QUAI001', 'Quais Rade', 'Quais Rade', 'TYP001', 0, 0, 'PAYS000010');
