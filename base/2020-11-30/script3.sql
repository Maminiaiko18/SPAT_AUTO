UPDATE MENUDYNAMIQUE t SET t.HREF = '/spat/pages/globalnegoce.jsp?but=stock/bc/asBonDeCommande-liste.jsp' WHERE t.ID LIKE 'MEN00213' ;
UPDATE MENUDYNAMIQUE t SET t.HREF = '/spat/pages/globalnegoce.jsp?but=stock/bc/asBonDeCommande-saisie.jsp' WHERE t.ID LIKE 'MEN00214' ;
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00500', 'Facture fournisseur', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=facture/facture-fournisseur-saisie-multiple.jsp&type=TFF0001', 3, 3, 'MEN00211');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES ('MEN00501', 'BED', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=facture/facture-fournisseur-saisie-multiple.jsp&type=TPFF002', 4, 3, 'MEN00211');


UPDATE MENUDYNAMIQUE t SET t.LIBELLE = 'Report' WHERE t.ID LIKE 'MEN00000120' ;

create view TIERS_PRESTATAIRE as
select *
from tiers
where TYPE like 'prestataire';



create or replace view as_bondecommande_DetSumLiv as
select bcf.ID,
       PRODUIT,
       IDBC,
       QUANTITE,
       PU,
       QUANTITEPARPACK,
       MONTANT,
       REMARQUE,
       nvl((select sum(bfl.QUANTITE)from AS_BONDELIVRAISON_FILLE bfl where bfl.IDBONDECOMMANDE=bcf.id group by IDBC),0) as quantitelivre,
       QUANTITE-nvl((select sum(bfl.QUANTITE)from AS_BONDELIVRAISON_FILLE bfl where bfl.IDBONDECOMMANDE=bcf.id group by IDBC),0) as quantitereste
from AS_BONDECOMMANDE_FILLE bcf;
