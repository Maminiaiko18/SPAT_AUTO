ALTER TABLE FactureClient MODIFY adrclt varchar(300);



CREATE OR REPLACE  VIEW FACTURE_CLIENT_UNIONV  AS 
  select ID,DATY,TIERS,DESIGNATION,TYPE,TVA,REMARQUE,IDUSER,DATE_ECHEANCE,ETAT,
  CAST(MONTANT AS NUMBER(35,3)) AS MONTANT,
  CAST(MONTANTTVA AS NUMBER(35,3)) AS MONTANTTVA,
  CAST(MONTANTAVOIR AS NUMBER(35,3)) AS MONTANTAVOIR,
  CAST(MONTANTTTC AS NUMBER(35,3)) AS MONTANTTTC,
  CAST(MONTANTPAYE AS NUMBER(35,3)) AS MONTANTPAYE,
  CAST(MONTANTRESTE AS NUMBER(35,3)) AS MONTANTRESTE,
  TIERSLIB,CONTACT,ADRESSE,IDPREVISION,ESCALE,ETATLIB,TYPELIB,IDCATEGORIE,CATEGORIELIB,IDPROVISION,IDPROVISIONLIB,DEVISEMERE,CODEPRESTATION,CODEPRESTATIONLIB,CODE,ESTMICTSL,CODEPROVISION,
  CAST(MONTANTTTCVRAI AS NUMBER(35,3)) AS MONTANTTTCVRAI,
  ARMATEURLIB,
       EXERCICE ,
  facture_client_union.code as codeFiltre,
  IDAVOIR,
  POURCOMPTE,
  POURCOMPTELIB,
  ARMATEUR,
  PAIEMENT,
  PAIEMENTLIB,
  LHT,
  LM ,
  TE,
  JNT,
  DATEDEPART,
  HEUREDEPART,
  DATEARRIVEE,
  HEUREARRIVEE,
  BATEAU,
  BATEAULIB,
  PROVENANCE,
  PROVENANCELIB,
  DESTINATION,
  DESTINATIONLIB,
  PAVILLON,
  PAVILLONLIB,
  NOMCLT,
  ADRCLT,
  NMSTTCLT,
  TELCLT,
  NIF,
  rc,
  DTTP,
  tp,
  DTQUIT,
  QUIT 
from facture_client_union
where etat >= 11;





ALTER TABLE client_tp ADD id varchar(100);


ALTER TABLE client_quit ADD id varchar(100);


UPDATE client_tp SET CDCLT=replace(CDCLT,' ','');

UPDATE client_quit SET CDCLT=replace(CDCLT,' ','');

update client_tp set id='CT0001' where cdclt='120004';
update client_tp set id='CT0002' where cdclt='120008'; 
update client_tp set id='CT0003' where cdclt='120016'; 
update client_tp set id='CT0004' where cdclt='120017' ;
update client_tp set id='CT0005' where cdclt='100019'; 
update client_tp set id='CT0006' where cdclt='100024'; 
update client_tp set id='CT0007' where cdclt='100025' ;
update client_tp set id='CT0008' where cdclt='100026' ;
update client_tp set id='CT0009' where cdclt='100031' ;
update client_tp set id='CT0010' where cdclt='120040' ;
update client_tp set id='CT0011' where cdclt='100042' ;
update client_tp set id='CT0012' where cdclt='260042' ;
update client_tp set id='CT0013' where cdclt='260052' ;
update client_tp set id='CT0014' where cdclt='260065' ;
update client_tp set id='CT0015' where cdclt='260031' ;
update client_tp set id='CT0016' where cdclt='120088' ;
update client_tp set id='CT0017' where cdclt='120098' ;
update client_tp set id='CT0018' where cdclt='120203' ;
update client_tp set id='CT0019' where cdclt='120067' ;
update client_tp set id='CT0020' where cdclt='260317' ;
update client_tp set id='CT0021' where cdclt='120265' ;
update client_tp set id='CT0022' where cdclt='100268' ;
update client_tp set id='CT0023' where cdclt='100054' ;
update client_tp set id='CT0024' where cdclt='100230' ;
update client_tp set id='CT0025' where cdclt='100325' ;
update client_tp set id='CT0026' where cdclt='120327' ;
update client_tp set id='CT0027' where cdclt='100345' ;
update client_tp set id='CT0028' where cdclt='120352' ;
update client_tp set id='CT0029' where cdclt='260435' ;
update client_tp set id='CT0030' where cdclt='120366' ;
update client_tp set id='CT0031' where cdclt='260029' ;
update client_tp set id='CT0032' where cdclt='100373' ;
update client_tp set id='CT0033' where cdclt='100375' ;
update client_tp set id='CT0034' where cdclt='100376' ;
update client_tp set id='CT0035' where cdclt='260388' ;
update client_tp set id='CT0036' where cdclt='150321' ;
update client_tp set id='CT0037' where cdclt='120037' ;
update client_tp set id='CT0038' where cdclt='100398' ;
update client_tp set id='CT0039' where cdclt='CTP0000000007180549' ;
update client_tp set id='CT0040' where cdclt='CTP0000000008181452' ;

update client_quit set id='CQ0003' where cdclt='120017' ;
update client_quit set id='CQ0004' where cdclt='100019' ;
update client_quit set id='CQ0005' where cdclt='100024' ;
update client_quit set id='CQ0006' where cdclt='100025' ;
update client_quit set id='CQ0007' where cdclt='100026' ;
update client_quit set id='CQ0008' where cdclt='100031' ;
update client_quit set id='CQ0009' where cdclt='120040' ;
update client_quit set id='CQ0010' where cdclt='100042' ;
update client_quit set id='CQ0011' where cdclt='260042' ;
update client_quit set id='CQ0012' where cdclt='260065' ;
update client_quit set id='CQ0013' where cdclt='120088' ;
update client_quit set id='CQ0014' where cdclt='100268' ;
update client_quit set id='CQ0015' where cdclt='CQ0000000001090149' ;



DELETE FROM CLIENT_TP
WHERE ID='CT0021';
DELETE FROM CLIENT_TP
WHERE ID='CT0012';
DELETE FROM CLIENT_QUIT
WHERE ID='CQ0015';




ALTER TABLE client_quit ADD CONSTRAINT client_quit_pk  PRIMARY KEY (id);

ALTER TABLE client_tp ADD CONSTRAINT client_tp_pk  PRIMARY KEY (id);

ALTER TABLE client_tp ADD CONSTRAINT client_client_tp_fk FOREIGN KEY(cdclt) REFERENCES client(cdclt);

ALTER TABLE client_quit ADD CONSTRAINT client_client_quit_fk FOREIGN KEY(cdclt) REFERENCES client(cdclt);


CREATE OR REPLACE  VIEW CLIENT_QUITLIB (id,CDCLT, DTQUIT, QUIT, VALIDE, NOMCLT) AS 
  select 
cq.id,
cq.CDCLT,cq.DTQUIT,cq.QUIT,cq.VALIDE ,
c.nomclt
from client_quit cq
left join client c on c.cdclt=cq.cdclt;


CREATE OR REPLACE  VIEW CLIENT_TPLIB (id,CDCLT, DTTP, TP, VALIDE, NOMCLT) AS 
  select 
cq.ID,
  cq.CDCLT,cq.DTTP,cq.TP,cq.VALIDE ,
c.nomclt
from client_tp cq
left join client c on c.cdclt=cq.cdclt;




