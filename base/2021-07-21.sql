
create or replace view PREVISIONFICHE_II as
select id
     , nomnavire
     , valconsignataire
     , valcargaison
     , valpilote
     , valquaisprovenance
     , valpaysprovenance
     , valquaisdestination
     , valpaysdestination
     , date_arrivee
     , heure_arrivee
     , date_depart
     , heure_depart
     , etat
     , typenavirelib as type
     , ESCALE
     , NOVOYAGE
     , NAVIRE        as idnavire
     , Lhtnavire
     , Lmnavire
     , Jntnavire
     , jbtnavire
     , TENAVIRE
     , PAVILLONNAVIRE
from previsionLibComplet;

create or replace view ACTIVITESFACTUREES as
select *
from ACTIVITELIBCOMPLET_V ac
where id in (select idactivite from facture_client_fille_vm WHERE ac.id = IDACTIVITE);	


create or replace view ACTIVITEVISEENONFACTUREE as
select*
from ACTIVITESNONFACTUREES
where etat >= 11;


create or replace view PREVISIONFICHE_II as
select previsionLibComplet.id
     , nomnavire
     , valconsignataire
     , valcargaison
     , valpilote
     , valquaisprovenance
     , valpaysprovenance
     , valquaisdestination
     , valpaysdestination
     , date_arrivee
     , heure_arrivee
     , date_depart
     , heure_depart
     , etat
     , typenavirelib as type
     , ESCALE
     , NOVOYAGE
     , NAVIRE        as idnavire
     , Lhtnavire
     , Lmnavire
     , Jntnavire
     , jbtnavire
     , TENAVIRE
     , pays.VAL as PAVILLONNAVIRE
from previsionLibComplet
    left join pays  on pays.ID=PAVILLONNAVIRE;
	
alter table facture_client_fille add  mois number(10);
alter table facture_client_fille add  annee number(10);
alter table facture_client_fille add  heureDebut varchar2(100);
alter table facture_client_fille add  heureFin varchar2(100);

alter table facture_prof_mere add idprevision varchar2 (100)
    constraint fc_fk_prevision references PREVISION;
	
alter table facture_prof_fille add idactivite varchar2(100) constraint fc_fk_activite references ACTIVITE;
alter table facture_prof_fille add datefact date;
alter table facture_prof_fille add rubrique varchar2(100) constraint fc_fk_rubrique references RUBRIQUE_ACTIVITE;
alter table facture_prof_fille add mois number(10);
alter table facture_prof_fille add annee number(10);
alter table facture_prof_fille add heureDebut varchar2(100);
alter table facture_prof_fille add heureFin varchar2(100);

create or replace view FACTURECLIENPROFTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC,ESCALE) as
select fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(nvl(grp.montanttaux, 0) as number(30, 2))          as montant,
       cast(nvl((grp.montantTva), 0) as number(30, 2))   as montanttva,
       nvl(grp.montantavoiravectaux, 0)                        as montantavoir,
       cast(nvl((grp.montantTva)  + grp.montanttaux, 0) -
            nvl(grp.montantavoiravectaux, 0) as number(30, 2)) AS MONTANTTTC,
        pre.ESCALE

from facture_prof_mere fc
         left join FACTURE_CLIENT_PROFGRP grp on grp.idmere = fc.id
         left join PREVISION pre on pre.id=fc.IDPREVISION;
		 
		
		
		
CREATE OR REPLACE VIEW FACTURE_CLIENT_PROFMERE_FILLE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT,idactivite,datefact,rubrique,mois,annee,heureDebut,heurefin 
)
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
       fc.daty,
       fc.tiers,
       fc.designation                       as designationmere,
       fc.type,
       decode(fi.tva, null, fc.tva, fi.tva) as tva,
       fc.remarque,
       fc.iduser,
       fc.date_echeance,
       fc.etat,
       fi.idactivite,
       fi.datefact,
       fi.rubrique,
       fi.mois,
       fi.annee,
       fi.heureDebut,
	   fi.heurefin 

from facture_prof_fille fi
         left join facture_prof_mere fc on fi.IDMERE = fc.id;

CREATE OR REPLACE VIEW FACTURE_CLIENT_PROFMONTANT
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX,
             MONTANTAVOIRAVECTAUX,idactivite,datefact,rubrique,mois,annee,heureDebut,heurefin )
AS
select fm.ID,
       fm.IDMERE,
       fm.DESIGNATION,
       fm.QUANTITE,
       fm.PU,
       fm.COMPTE,
       fm.IDPRODUIT,
       fm.DEVISE,
       fm.TAUX,
       fm.DATY,
       fm.TIERS,
       fm.DESIGNATIONMERE,
       fm.TYPE,
       fm.TVA,
       fm.REMARQUE,
       fm.IDUSER,
       fm.DATE_ECHEANCE,
       fm.ETAT,
       cast(fm.pu * fm.quantite as number(30, 2))             as Montant,
       cast((fm.pu * fm.quantite) * fm.taux as NUMBER(30, 2)) as montanttaux,
       cast(0 as NUMBER(30, 2))                               as montantavoirsanstaux,
       cast(0 as number(30, 2))                               as montantavoiravectaux,
       idactivite,
       datefact,
       rubrique,
       mois,
       annee,
       heureDebut,
	   fm.heurefin 

from FACTURE_CLIENT_PROFMERE_FILLE fm;

 CREATE OR REPLACE VIEW FACTUREPROFMSUM_LIB
     (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER,
         DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR,
         MONTANTTTC, TIERSLIB, ADRESSE, CONTACT,escale) AS
  select m.ID,
       m.DATY,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       m.REMARQUE,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.MONTANT,
       M.MONTANTTVA,
       M.MONTANTAVOIR,
       M.MONTANTTTC,
       fup.NOM as tierslib,
       fup.ADRESSE,
       fup.CONTACT,
        m.ESCALE
from FACTURECLIENPROFTMSUM m
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = m.TIERS;
		 
		  CREATE OR REPLACE VIEW FACTUREPROFMSUM_LIBA  AS
  SELECT *
FROM factureprofMSum_lib WHERE ETAT=0;

create or replace view FACTUREPROFMSUM_LIBC as
SELECT *
FROM factureprofMSum_lib WHERE ETAT=1;

create or replace view FACTUREPROFMSUM_LIBV as
SELECT *FROM factureprofMSum_lib WHERE ETAT=11;

create or replace view FACTURECLIENPROFTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE,
    IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC,ESCALE,IDPREVISION) as
select fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(nvl(grp.montanttaux, 0) as number(30, 2))          as montant,
       cast(nvl((grp.montantTva), 0) as number(30, 2))   as montanttva,
       nvl(grp.montantavoiravectaux, 0)                        as montantavoir,
       cast(nvl((grp.montantTva)  + grp.montanttaux, 0) -
            nvl(grp.montantavoiravectaux, 0) as number(30, 2)) AS MONTANTTTC,
        pre.ESCALE,
       fc.IDPREVISION

from facture_prof_mere fc
         left join FACTURE_CLIENT_PROFGRP grp on grp.idmere = fc.id
         left join PREVISION pre on pre.id=fc.IDPREVISION;
		 


CREATE OR REPLACE VIEW FACTUREPROFMSUM_LIB
     (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER,
         DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR,
         MONTANTTTC, TIERSLIB, ADRESSE, CONTACT,escale,IDPREVISION) AS
  select m.ID,
       m.DATY,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       m.REMARQUE,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.MONTANT,
       M.MONTANTTVA,
       M.MONTANTAVOIR,
       M.MONTANTTTC,
       fup.NOM as tierslib,
       fup.ADRESSE,
       fup.CONTACT,
        m.ESCALE,
         m.IDPREVISION
from FACTURECLIENPROFTMSUM m
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = m.TIERS;
		 
  CREATE OR REPLACE VIEW FACTUREPROFMSUM_LIBA  AS
  SELECT *
FROM factureprofMSum_lib WHERE ETAT=0;

create or replace view FACTUREPROFMSUM_LIBC as
SELECT *
FROM factureprofMSum_lib WHERE ETAT=1;
create or replace view FACTUREPROFMSUM_LIBV as
SELECT *FROM factureprofMSum_lib WHERE ETAT=11;

create or replace
    view FACTURE_CLIENT_UNIONV as
select*
from facture_client_union
where etat = 11;

create or replace view FACTURE_CLIENT_UNIONC as
select *
from facture_client_union
where etat = 1;
 		 

		 
CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIB_RESTE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA,
                IDACTIVITE, ACTIVITELIB,mois,annee,heureDebut,heureFin)
AS
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANT AS NUMBER(32, 5)),
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3)),
       CAST(fcm.tva AS NUMBER(20, 3)),
       idactivite,
       ra.DESIGNATION                             as activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         left join ACTIVITE ra on ra.id = fc.IDACTIVITE;


create or replace view FACTURE_CLIENT_FILLE_LIB_RESTE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEE, HEUREDEBUT, HEUREFIN,moislib)
as
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANT AS NUMBER(32, 5)),
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3)),
       CAST(fcm.tva AS NUMBER(20, 3)),
       idactivite,
       ra.DESIGNATION                             as activitelib,
       fc.mois,
       fc.annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL as moislib
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         left join ACTIVITE ra on ra.id = fc.IDACTIVITE
        left join mois on mois.id=fc.mois;

		
CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIBELLE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, PRODUIT_LIB, ACTIVITELIB, DATEFACT, RUBRIQUE, RUBRIQUELIB, MOIS, ANNEE, HEUREDEBUT, HEUREFIN) AS 
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
          fi.HEUREFIN
     FROM FACTURE_CLIENT_FILLE fi
          LEFT JOIN AS_PRODUITS pr ON pr.id = fi.IDPRODUIT
          LEFT JOIN activite ac ON ac.id = fi.IDACTIVITE
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = fi.RUBRIQUE;
		  

create or replace view FACTURE_CLIENT_FILLE_LIB_PDF
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEE, HEUREDEBUT, HEUREFIN,moislib)
as
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANT AS NUMBER(32, 5)),
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3)),
       CAST(fcm.tva AS NUMBER(20, 3)),
       idactivite,
       ra.DESIGNATION                             as activitelib,
       fc.mois,
       cast(fc.annee as VARCHAR2(100)) as annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL as moislib
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         left join ACTIVITE ra on ra.id = fc.IDACTIVITE
        left join mois on mois.id=fc.mois;
		

create or replace view FACTURE_CLIENT_FILLE_LIB_PDF
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEElib, HEUREDEBUT, HEUREFIN,moislib)
as
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANT AS NUMBER(32, 5)),
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 3)),
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 3)),
       CAST(fcm.tva AS NUMBER(20, 3)),
       idactivite,
       ra.DESIGNATION                             as activitelib,
       fc.mois,
       cast(fc.annee as VARCHAR2(100)) as annee,
       fc.heureDebut,
       fc.heureFin,
       mois.VAL as moislib
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         left join ACTIVITE ra on ra.id = fc.IDACTIVITE
        left join mois on mois.id=fc.mois;
		
CREATE OR REPLACE  VIEW FACTURE_CLIENT_FILLE_PLUS AS 
  SELECT facture_client_fille.ID,
          facture_client_fille.IDMERE,
          facture_client_fille.DESIGNATION,
          facture_client_fille.QUANTITE,
          facture_client_fille.PU,
          facture_client_fille.COMPTE,
          facture_client_fille.IDPRODUIT,
          facture_client_fille.DEVISE,
          facture_client_fille.TAUX,
          CAST (0.0 AS NUMBER (30, 3)) AS montant,
          facture_client_fille.tva,
          facture_client_fille.IDACTIVITE,
          FACTURE_CLIENT_FILLE.DATEFACT,
          facture_client_fille.RUBRIQUE,
          facture_client_fille.MOIS,
          facture_client_fille.ANNEE,
          facture_client_fille.HEUREDEBUT,
          facture_client_fille.HEUREFIN 
     FROM facture_client_fille
    WHERE 1 > 2;
    
   
   CREATE OR REPLACE VIEW FACTURE_PROF_FILLE_0 AS 
  select fp.ID,
       fp.IDMERE,
       fp.DESIGNATION,
       fp.QUANTITE,
       fp.PU,
       fp.COMPTE,
       fp.IDPRODUIT,
       fp.DEVISE,
       fp.TAUX,
       fp.TVA,
       cast(0 as NUMBER(30, 2)) as montant,
       fp.IDACTIVITE,
       fp.DATEFACT,
       fp.RUBRIQUE,
       fp.MOIS,
       fp.ANNEE ,
       fp.HEUREDEBUT ,
       fp.HEUREFIN 
from facture_prof_fille fp;

REATE OR REPLACE VIEW FACTURE_PROF_FILLE_libelle AS 
SELECT 
	f.ID,
	f.IDMERE,
	f.DESIGNATION,
	f.QUANTITE,
	f.PU,
	f.COMPTE,
	pr.nom AS produit_lib,
	f.IDPRODUIT,
	f.DEVISE,
	f.TAUX,
	f.TVA,
	f.RUBRIQUE,
	ra.DESIGNATION AS rubriquelib,
	f.DATEFACT,
	ac.DESIGNATION AS activitelib,
	f.IDACTIVITE,
	f.MOIS,
	f.ANNEE,
	f.HEUREDEBUT,
	f.HEUREFIN
FROM FACTURE_PROF_FILLE f
			LEFT JOIN AS_PRODUITS pr ON pr.id = f.IDPRODUIT
          LEFT JOIN activite ac ON ac.id = f.IDACTIVITE
          LEFT JOIN RUBRIQUE_ACTIVITE ra ON ra.ID = f.RUBRIQUE;
		
		 
CREATE or replace VIEW situationLC_vide AS
SELECT
	'ID' AS id,
	'DESIGNATION' AS DESIGNATION,
	'COMPTE' AS COMPTE,
	0 AS ANNEE,
	0 AS MONTANT,
	0 AS ETAT,
	0 AS FACTURE,
	0 AS PAYE,
	CURRENT_DATE AS daty
FROM
	dual ;
	
	
	create or replace view FACTURE_CLIENT_MEREFILLE as
select fcf.*,

       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA as tvamere,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       fc.IDPREVISION
from facture_client_fille fcf
         join factureclient fc on fcf.IDMERE = fc.ID;
		 
	
  CREATE OR REPLACE VIEW FACTURE_CLIENT_PROFMONTANT (ID, IDMERE, DESIGNATION, QUANTITE, PU,
      COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE, TVA, REMARQUE, IDUSER,
      DATE_ECHEANCE, ETAT, MONTANT, MONTANTTAUX, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX,
      IDACTIVITE, DATEFACT, RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN,moislib,anneelib) AS
  select fm.ID,
       fm.IDMERE,
       fm.DESIGNATION,
       fm.QUANTITE,
       fm.PU,
       fm.COMPTE,
       fm.IDPRODUIT,
       fm.DEVISE,
       fm.TAUX,
       fm.DATY,
       fm.TIERS,
       fm.DESIGNATIONMERE,
       fm.TYPE,
       fm.TVA,
       fm.REMARQUE,
       fm.IDUSER,
       fm.DATE_ECHEANCE,
       fm.ETAT,
       cast(fm.pu * fm.quantite as number(30, 2))             as Montant,
       cast((fm.pu * fm.quantite) * fm.taux as NUMBER(30, 2)) as montanttaux,
       cast(0 as NUMBER(30, 2))                               as montantavoirsanstaux,
       cast(0 as number(30, 2))                               as montantavoiravectaux,
       idactivite,
       datefact,
       rubrique,
       mois,
       annee,
       heureDebut,
	   fm.heurefin,
        m.VAL as moislib,
         cast(annee as varchar2(100)) as anneelib

from FACTURE_CLIENT_PROFMERE_FILLE fm
    left join mois m on m.ID=fm.MOIS;