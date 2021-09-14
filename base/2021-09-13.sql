CREATE OR REPLACE VIEW ETAT_PROVISIONLIB
            (ID, IDFACTURE, IDNAVIRE, IDMODE, IDBANQUE, NUMPIECE, NUMPROVISION, OPERATION, TIERS, TIERSLIB, IDNAVIRELIB,
             IDMODELIB, IDBANQUELIB,IDFACTURELIB)
AS
select e.ID,
       e.IDFACTURE,
       e.IDNAVIRE,
       e.IDMODE,
       e.IDBANQUE,
       e.NUMPIECE,
       e.NUMPROVISION,
       e.OPERATION,
       f.TIERS,
       f.TIERSlib,
       n.NOM as idnavirelib,
       m.VAL as idmodelib,
       b.VAL as idbanquelib,
       fc.DESIGNATION as IDFACTURELIB
from ETAT_PROVISION e
         left join BANQUE B on e.IDBANQUE = B.ID
         left join MODEPAIEMENT m on e.IDMODE = m.ID
         left join FACTURECLIENT_LIBCOMPLET f on e.IDFACTURE = f.ID
         left join navire n on e.IDNAVIRE = n.ID
         left join FACTURECLIENT fc on fc.id=e.IDFACTURE;
		 
CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE (ID, IDMERE, DESIGNATION, QUANTITE, PU,
      COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, PRODUIT_LIB, ACTIVITELIB, DATEFACT, RUBRIQUE,
      RUBRIQUELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, MAJORATION, REDUCTION,RANG,DATY) AS
  SELECT fi.ID,
          fi.IDMERE,
          fi.DESIGNATION,
          fi.QUANTITE,
          fi.PU,
          fi.COMPTE,
          fi.IDPRODUIT,
          fi.DEVISE,
          fi.TAUX,
          fi.IDACTIVITE,
          fi.TVA,
          pr.nom AS produit_lib,
          ac.DESIGNATION AS activitelib,
          TO_DATE (fi.DATEFACT, 'dd/MM/YY') AS DATEFACT,
          fi.RUBRIQUE,
          ra.DESIGNATION AS rubriquelib,
          fi.MOIS,
          fi.ANNEE,
          fi.HEUREDEBUT,
          fi.HEUREFIN,
       nvl(fi.MAJORATION,0) as MAJORATION,
       nvl(fi.REDUCTION,0) as REDUCTION,
         case when fi.IDACTIVITE is not null then ra.RANG end as rang,
         case when fi.IDACTIVITE is not null then ac.DATY end as daty
     FROM FACTURE_CLIENT_FILLE fi
          LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
          LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = ac.RUBRIQUE;
		  

CREATE OR REPLACE VIEW FACT_CLT_FILL_LIB_REST_TAXE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB, TAUXEURO, MONTANTHTEURO, MONTANTTVAEURO, MONTANTTAXE, MAJORATION,
             REDUCTION, DATEFACT, RUBRIQUE,rang,daty)
AS
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                               AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))           AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                            AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3))               as MONTANTTAUX,
       CAST(fcm.MONTANT AS NUMBER(32, 5))                   as MONTANT,
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3))      as MONTANTAVOIRSANSTAUX,
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3))      as MONTANTAVOIRAVECTAUX,
       CAST(fcm.tva AS NUMBER(20, 3))                       as tva,
       fc.idactivite,
       ra.DESIGNATION                                       AS activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL                                             AS moislib,
       CAST(0 AS NUMBER(32, 2))                             AS tauxEuro,
       CAST(0 AS NUMBER(32, 2))                             AS montantHTEuro,
       CAST(0 AS NUMBER(32, 2))                             AS montantTVAEuro,
       CAST((fc.pu * fc.QUANTITE * fc.TVA) / 100 AS NUMBER(20, 3))
                                                            AS montanttaxe,
       nvl(fc.majoration, 0)                                as majoration,
       nvl(fc.reduction, 0)                                 as reduction,
       fc.DATEFACT,
       fc.RUBRIQUE,
       case when fc.IDACTIVITE is not null then r.RANG end as rang,
       case when fc.IDACTIVITE is not null then ra.DATY end as daty
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         LEFT JOIN ACTIVITE ra ON ra.id = fc.IDACTIVITE
         LEFT JOIN mois ON mois.id = fc.mois
         LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE;
		 
--base = SPAT_CAPITAINERIE

--update Finance/factue client/provision/etat-provision manala lien
UPDATE SPAT_CAPITAINERIE.MENUDYNAMIQUE
SET LIBELLE='Etat de provision', ICONE='fa fa-table', HREF='', RANG=2, NIVEAU=4, ID_PERE='MDO000001'
WHERE ID='MDO000003';

--create Finance/factue client/provision/etat-provision(saisie/liste/recap)
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MDO000050', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=facture/etatprovision-saisie.jsp', 1, 5, 'MDO000003');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MDO000051', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=facture/etatprovision-liste.jsp', 2, 5, 'MDO000003');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MDO000052', 'Récap', 'fa fa-list-alt', '/spat/pages/globalnegoce.jsp?but=facture/etat-provision.jsp', 3, 5, 'MDO000003');

commit;

UPDATE RUBRIQUE_ACTIVITE SET Rang ='1' WHERE ID='RB0000000021170444';
UPDATE RUBRIQUE_ACTIVITE SET Rang ='2' WHERE ID='RB0000000021170445';
UPDATE RUBRIQUE_ACTIVITE SET Rang ='3' WHERE ID='RB0000000021170446';
UPDATE RUBRIQUE_ACTIVITE SET Rang ='4' WHERE ID='RB0000000021170447';
UPDATE RUBRIQUE_ACTIVITE SET Rang ='5' WHERE ID='RB0000000021170449';
UPDATE RUBRIQUE_ACTIVITE SET Rang ='6' WHERE ID='RB0000000021170448';
UPDATE RUBRIQUE_ACTIVITE SET Rang ='1' WHERE ID='RB0000000021170493';
UPDATE RUBRIQUE_ACTIVITE SET Rang ='2' WHERE ID='RB0000000021170495';
UPDATE RUBRIQUE_ACTIVITE SET Rang ='3' WHERE ID='RB0000000059112123';
UPDATE RUBRIQUE_ACTIVITE SET Rang ='4' WHERE ID='RB0000000060112257';

commit;



alter table journalcaisse add idbanque varchar2(100) constraint fk_journalcaisse_banque references BANQUE(id);




CREATE OR REPLACE VIEW JOURNALCAISSELIBCOMPLET as
SELECT j.ID,
       j.DATESAISIE,
       j.DATEEFFET,
       j.FOLIO,
       j.CAISSE,
       j.NUMPIECE,
       j.LIBELLE,
       j.DEBIT,
       j.CREDIT,
       j.REMARQUE,
       j.ETAT,
       j.TIERS,
       j.IDTYPECHEQUE,
       j.DESIGNATION,
       j.IDDEVISE,
       j.IDMODE,
       j.NUMCHEQUE,
       j.TYPEMVT,
       j.IDORDRE,
       j.IDPLACEMENT,
       c.ID    AS idcaisse,
       c.val   AS valcaisse,
       c.desce AS descecaisse,
       tc.val  AS valtypecheque,
       m.val   AS descetypecheque,
       ti.NOM  AS tierslib,
       j.IDBANQUE,
       b.val as idbanquelib
FROM Journalcaisse j
         JOIN CAISSE C
              ON j.CAISSE = C.ID
         LEFT JOIN TYPECHEQUE tc ON tc.id = j.idtypecheque
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL ti ON ti.id = j.TIERS
         LEFT JOIN MODEPAIEMENT m on j.idmode = m.id
         LEFT JOIN BANQUE b on j.IDBANQUE = b.ID;


CREATE OR REPLACE VIEW JOURNALCAISSE_LIB as
select lib.id,
       datesaisie,
       dateeffet,
       folio,
       valcaisse              as caisse,
       numpiece,
       libelle,
       debit,
       credit,
       remarque,
       lib.etat,
       nvl(ti.NOM, lib.tiers) as tiers,
       valtypecheque          as idtypecheque,
       IDPLACEMENT,
       IDORDRE,
       lib.IDBANQUE,
       lib.IDBANQUELIB
from journalcaisselibcomplet lib
         left join FOURNISSEUR_UNION_PERSONNEL ti on ti.ID = lib.TIERS;
 




 create table etat_provision
(
    id           varchar2(100)
        constraint pk_etat_provision primary key,
    idFacture    varchar2(500)
        constraint fk_etat_provision_factclient references FACTURECLIENT (id),
    idnavire     varchar2(500)
        constraint fk_etat_provision_navire references navire (id),
    idmode       varchar2(20)
        constraint fk_etat_provision_modepaiement references MODEPAIEMENT (id),
    idbanque     varchar2(100)
        constraint fk_etat_provision_banque references BANQUE (id),
    numpiece     varchar2(500),
    numProvision varchar2(500),
    operation    varchar2(500)
);

CREATE SEQUENCE seq_etat_provision
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

create or replace FUNCTION get_seq_etat_provision
    RETURN NUMBER IS
    retour NUMBER;
BEGIN
    SELECT seq_etat_provision.nextval INTO retour FROM dual;
    return retour;
END;



create view  etat_provisionlib as
select e.*,
       f.TIERS,
       f.TIERSlib,
       n.NOM as idnavirelib,
       m.VAL as idmodelib,
       b.VAL as idbanquelib
from ETAT_PROVISION e
         left join BANQUE B on e.IDBANQUE = B.ID
         left join MODEPAIEMENT m on e.IDMODE = m.ID
         left join FACTURECLIENT_LIBCOMPLET f on e.IDFACTURE = f.ID
         left join navire n on e.IDNAVIRE = n.ID;


alter table rubrique_activite  add rang integer;


