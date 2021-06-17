alter table FACTURE_CLIENT_FILLE add datefact date;
CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, PRODUIT_LIB,
             ACTIVITELIB, DATEFACT)
AS
select fi.ID,
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
       pr.nom         as produit_lib,
       ac.DESIGNATION as activitelib,
       cast(to_date(fi.DATEFACT, 'DD/MM/YY') as VARCHAR2(100)) AS DATEFACT
from FACTURE_CLIENT_FILLE fi
         left join AS_PRODUITS pr on pr.id = fi.IDPRODUIT
         left join activite ac on ac.id = fi.IDACTIVITE;
		 
CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET
            (ID, DESIGNATION, CLIENT, RUBRIQUE, QTE, MOIS, MOISLIB, ANNEE, DATY, BATEAU, ETAT,
             RUBRIQUELIB, navire,BATEAULIB, POIDS, LONGUEUR, LARGEUR, AUTRES, PU, DEVISE, COMPTE,
             UNITE, DIRECTION, CONDITION, TVA, OBJET, REDEVANCE, CLIENTLIB, REDEVANCELIB,
             DIRECTIONLIB, ETATLIB, CATEGORIE, CATEGORIELIB, REFOBJET, TYPESOURCE, DATEFACT)
AS
SELECT ac.ID,
       ac.DESIGNATION,
       ac.CLIENT,
       ac.RUBRIQUE,
       ac.QTE,
       ac.MOIS,
       MOIS.VAL                   AS MOISLIB,
       ac.ANNEE,
       ac.DATY,
       ac.BATEAU,
       ac.ETAT,
       ra.DESIGNATION             AS rubriquelib,
       nv.id                      as navire,
       nv.NOM                     AS bateaulib,
       nv.PLT                     AS poids,
       nv.LHT                     AS longueur,
       nv.LM                      AS largeur,
       CAST('-' AS VARCHAR2(100)) AS autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                    AS clientlib,
       re.VAL                     AS redevancelib,
       di.LIBELLEDIR              AS directionlib,
       CASE
           WHEN ac.etat = 1 THEN 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)'
           END
                                  AS ETATLIB,

       ra.CATEGORIE,
       cf.val                     as categorieLib,
       ac.REFOBJET,
       ac.TYPESOURCE,
       pre.DATE_DEPART            as DATEFACT
FROM ACTIVITE ac
         LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.id = ac.RUBRIQUE

         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.id = ac.CLIENT
         LEFT JOIN REDEVANCE re ON re.id = ra.REDEVANCE
         LEFT JOIN direction di ON (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         LEFT JOIN CategorieFacturation cf on ra.categorie = cf.id
         left join PREVISION pre on pre.id = ac.BATEAU
         LEFT JOIN NAVIRE nv ON nv.ID = pre.NAVIRE;
		 
create or replace view ACTIVITELIBCOMPLET_A as
SELECT *
     FROM ACTIVITELIBCOMPLET
    WHERE ETAT = 0;

create or replace view ACTIVITELIBCOMPLET_C as
SELECT *
     FROM ACTIVITELIBCOMPLET
    WHERE ETAT = 1;

create or replace view ACTIVITELIBCOMPLET_V as
SELECT *
     FROM ACTIVITELIBCOMPLET
    WHERE ETAT = 11;

create or replace view ACTIVITESFACTUREES as
select *from ACTIVITELIBCOMPLET ac
where id in (select idactivite from facture_client_fille_vm WHERE ac.id = IDACTIVITE);

  alter table commandant add iduser number(10) constraint fk_utilisateur_commandant references  UTILISATEUR;

  
create OR REPLACE view FACTURE_CLIENT_FILLE_LIBELLE as
select fi.ID,
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
       pr.nom         as produit_lib,
       ac.DESIGNATION as activitelib,
       to_date(fi.DATEFACT, 'dd/MM/YY') AS DATEFACT
from FACTURE_CLIENT_FILLE fi
         left join AS_PRODUITS pr on pr.id = fi.IDPRODUIT
         left join activite ac on ac.id = fi.IDACTIVITE;
		 
create table jour_ferie
(
    id          varchar2(100)
        constraint jour_ferie_pk primary key,
    daty        date,
    designation varchar2(500)
);

CREATE SEQUENCE seqjour_ferie
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqjour_ferie
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqjour_ferie.nextval INTO retour FROM dual;
  return retour;
END;

CREATE OR REPLACE VIEW OCCUPATIONMATERIELNAVALLIBCPL
            (ID, DATY, IDMATERIEL_NAVAL, IDPILOTE, IDCOMMANDANT, IDNATUREOPERATION, IDMANOEUVREBORD, HEUREDEBUT,
             HEUREFIN, IDNAVIRE, IDCLIENT, DUREE, POSITION, OBSERVATION, ETAT, DATEFIN, IDPREVISION,
             IDCLIENTLIB, CARGAISON, CARGAISONlib, pavillon, pavillonlib)
AS
select oc.ID,
       oc.DATY,
       oc.IDMATERIEL_NAVAL,
       oc.IDPILOTE,
       oc.IDCOMMANDANT,
       oc.IDNATUREOPERATION,
       oc.IDMANOEUVREBORD,
       oc.HEUREDEBUT,
       oc.HEUREFIN,
       oc.IDNAVIRE,
       pr.CONSIGNATAIRE  as IDCLIENT,
       oc.DUREE,
       oc.POSITION,
       oc.OBSERVATION,
       oc.ETAT,
       oc.DATEFIN,
       oc.IDPREVISION,
       c.VAL             as idclientlib,
       pr.CARGAISON,
       pr.VALCARGAISON   as CARGAISONlib,
       pr.PAVILLONNAVIRE as pavillon,
       pa.VAL            as pavillonlib
from OCCUPATIONMATERIELNAVALLIB oc
         left join PREVISIONLIBCOMPLET pr on pr.id = oc.IDPREVISION
         left join CONSIGNATAIRE c on c.id = pr.CONSIGNATAIRE
         left join pays pa on pa.id = pr.PAVILLONNAVIRE;
