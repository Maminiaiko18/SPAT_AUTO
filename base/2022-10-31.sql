-------script spat 31-10-2022


INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENO300', 'Clients', 'fa fa-cog', '#', 17, 3, 'MEN00505');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENO302', 'Liste', 'fa fa-list ', '/spat/pages/globalnegoce.jsp?but=facture/client-tp-liste.jsp', 1, 5, 'MENO301');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENO303', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=facture/client-tp-saisie.jsp', 2, 5, 'MENO301');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENO301', 'TP', 'fa fa-table', '#', 3, 4, 'MENO300');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENO304', 'Client', 'fa fa-user', '#', 1, 4, 'MENO300');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENO306', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=facture/client-liste.jsp', 1, 5, 'MENO304');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENO307', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=facture/client-saisie.jsp', 2, 5, 'MENO304');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENO305', 'Quittance', 'fa fa-money', '#', 2, 4, 'MENO300');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENO308', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=facture/client-quit-liste.jsp', 1, 5, 'MENO305');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENO309', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=facture/client-quit-saisie.jsp', 2, 5, 'MENO305');


----creer table from client avy amin'ny base userspat

CREATE TABLE clientuserspat AS SELECT * FROM client@USERSPAT_LINK.MICROSOFT.COM;

--creer table from client avy @ base db_spat
CREATE TABLE client AS SELECT * FROM client@DBSPAT_LINK.MICROSOFT.COM;

-----client tp from dbspat

CREATE TABLE client_tp AS SELECT * FROM client_tp@DBSPAT_LINK.MICROSOFT.COM;

-----client_quit from dbspat
CREATE TABLE client_quit AS SELECT * FROM client_quit@DBSPAT_LINK.MICROSOFT.COM;


---create table client_specifique & client_categorie

CREATE TABLE client_specifique AS SELECT * FROM client_specifique@LINK_SPAT_ANCIEN_FINANCE_LOCAL;
create table  client_categorie as SELECT * FROM client_categorie@LINK_SPAT_ANCIEN_FINANCE_LOCAL;



	 
	 


create sequence seq_client
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
      

CREATE OR REPLACE FUNCTION GET_seq_client RETURN NUMBER IS retour NUMBER;
BEGIN 
SELECT seq_client.nextval INTO retour FROM dual;
return retour;
END;


create sequence seq_client_tp
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
      

CREATE OR REPLACE FUNCTION GET_seq_client_tp RETURN NUMBER IS retour NUMBER;
BEGIN 
SELECT seq_client_tp.nextval INTO retour FROM dual;
return retour;
END;


create sequence seq_client_quit
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
	  

CREATE OR REPLACE FUNCTION GET_seq_client_quit RETURN NUMBER IS retour NUMBER;
BEGIN 
SELECT seq_client_quit.nextval INTO retour FROM dual;
return retour;
END;


create sequence seq_clientmat
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
	  

CREATE OR REPLACE FUNCTION GET_seq_clientmat RETURN NUMBER IS retour NUMBER;
BEGIN 
SELECT seq_clientmat.nextval INTO retour FROM dual;
return retour;
END;


ALTER TABLE client 
ADD constraint client_pk PRIMARY key(cdclt);


ALTER TABLE client_tp 
ADD constraint client_tp_pk PRIMARY key(cdclt);



ALTER TABLE client_quit
ADD constraint client_quit_pk PRIMARY key(cdclt);



ALTER TABLE clientmat
ADD constraint clientmat_pk PRIMARY key(cdclt);


create view client_quitlib as
select 
cq.* ,
c.nomclt
from client_quit cq
left join client c on c.cdclt=cq.cdclt;


	create view client_tplib 
as
select 
cq.* ,
c.nomclt
from client_tp cq
left join client c on c.cdclt=cq.cdclt;





CREATE OR REPLACE  VIEW V_CLIENT  AS 
  SELECT db.cdclt,
          db.cdcat,
          db.nomclt,
          db.adrclt,
          db.nmsttclt,
          db.telclt,
          CASE
             WHEN db.cdclt = '0120093' OR db.cdclt = '0120047'
             THEN
                'Concessionnaire'
             ELSE
                ' '
          END
             AS faxclt,
          db.nmcin,
          db.nif,
          db.rc
     FROM client db
   UNION ALL
   SELECT u.idclient AS cdclt,
          u.idregime AS cdcat,
          u.nom AS nomclt,
          u.adresse AS adrclt,
          u.numstat AS nmsttclt,
          u.telephone AS telclt,
          'Concessionnaire' AS faxclt,
          '' AS nmcin,
          u.nif,
          cast('' as varchar2(100)) as rc
     FROM clientuserspat u;
	 
	 

    DROP MATERIALIZED VIEW V_CLIENT_CATEGORIE;
	

    CREATE OR REPLACE  VIEW V_CLIENT_CATEGORIE  AS 
  select 
    c.*,
	nvl(ct.val,'Autres') as categorie,
    cltp.DTTP,
    cltp.TP,
    clqi.DTQUIT,
    clqi.QUIT
from
    v_client c
    left join client_specifique s on c.cdclt = s.val
    left join client_categorie ct on s.desce = ct.id
    LEFT JOIN CLIENT_TP cltp ON cltp.CDCLT = c.CDCLT
    LEFT JOIN CLIENT_QUIT clqi ON clqi.CDCLT = c.CDCLT;
	
	
	ALTER TABLE client MODIFY cdclt varchar(200);
ALTER TABLE client_tp MODIFY cdclt varchar(200);
ALTER TABLE client_quit MODIFY cdclt varchar(200);

	
	
     
    
