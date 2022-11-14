 CREATE OR replace view FACTURECLIENTPAYEES AS
 select ff.*
from FACTURE_CLIENT_UNIONV ff where ff.montantreste=0;


INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MDO000080', 'Solde par client', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=facture/analyse-client.jsp', 14, 3, 'MEN00068');
