
CREATE TABLE configplacement
(
	id varchar(100) CONSTRAINT configplacement_pk PRIMARY KEY , 
	nature varchar(100) CONSTRAINT configplacement_entite_id_fk REFERENCES entite(id) , 
	banque  CONSTRAINT banque_caisse_id_fk REFERENCES caisse(id) , 
	compte varchar(500) 
) ; 

 
CREATE SEQUENCE   SEQ_configplacement
 	INCREMENT  BY  1 
    MINVALUE 1 
    MAXVALUE 999999999999999
    START  WITH  1  
    CACHE 20  ;

CREATE OR REPLACE FUNCTION SPAT_CAPITAINERIE.getSEQ_configplacement
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT SEQ_configplacement.nextval INTO retour FROM dual;
  return retour;
END;
       
       
create view remboursementplacementV as
select * from remboursementplacementlib where etat>11;

create view factureclientfille_libcompteCA as
select cpt.LIBELLE   libelleCompte,
       ca.mois,
       ca.annee,
       ca.MONTANT as montantht,
       ca.montanttva,
       ca.montantttc
from CAFCFILLECOMPLET ca,
     compteCA cpt
where cpt.val = ca.compte;

  CREATE OR REPLACE  VIEW FACTURECLIENTFILLE_LIBCOMPTECA (LIBELLECOMPTE, MOIS, ANNEE, MONTANTHT,
      MONTANTTVA, MONTANTTTC,moislib) AS
  select cpt.LIBELLE   libelleCompte,
       ca.mois,
       ca.annee,
       ca.MONTANT as montantht,
       ca.montanttva,
       ca.montantttc,
       m.VAL as moislib
from CAFCFILLECOMPLET ca,
     compteCA cpt,
     mois m
where cpt.val = ca.compte and m.ID=ca.mois;


insert into configplacement (id,nature,banque,compte) values ('CONFG0002','ENTT00001','CAISS004','76810');
insert into configplacement (id,nature,banque,compte) values ('CONFG0003','ENTT00001','CAIS000003','76810');
insert into configplacement (id,nature,banque,compte) values ('CONFG0004','ENTT00001','CAIS000005','76810');
insert into configplacement (id,nature,banque,compte) values ('CONFG0005','ENTT00001','CAI000005','76810');
insert into configplacement (id,nature,banque,compte) values ('CONFG0006','ENTT00001','CAISS002','76810');



INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MEN0006813', 'Détails', 'fa fa-money', '#', 12, 3, 'MEN00068');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MEN00068131', 'Liste', 'fa fa-list',
        '/spat/pages/globalnegoce.jsp?but=facture/facture-client-fille-liste.jsp', 1, 4, 'MEN0006813');
INSERT INTO MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MEN00068132', 'Analyse ', 'fa fa-table',
        '/spat/pages/globalnegoce.jsp?but=facture/facture-client-fille-analyse-croisee.jsp', 2, 4, 'MEN0006813')