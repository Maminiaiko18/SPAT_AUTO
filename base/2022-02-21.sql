


CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLEHT
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE,DUREE)
AS
select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       cast(ff.quantite * ff.pu * nvl(ff.duree, 1) as number(30, 3)) as montantHTSimple,
       ff.DUREE
from facture_client_fille ff;



CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLEMR
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE,DUREE, MONTANTMAJ,
             MONTANTRED)
AS
select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.DUREE,
       cast((montantHTSimple * majoration) / 100 as number(30, 3)) as montantMaj,
       cast((montantHTSimple * reduction) / 100 as number(30, 3))  as montantRed
from facture_client_filleHT ff;

CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLENET
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE, MONTANTMAJ,
             MONTANTRED, MONTANTNET,DUREE)
AS
select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.MONTANTMAJ,
       ff.MONTANTRED,
       cast(montantHTSimple + montantMaj - montantRed as number(30, 3)) as montantNET,
       ff.DUREE
from facture_client_filleMR ff;		


create or replace view FACTURE_CLIENT_FILLEWITHTVA as
select ff."ID",
       ff."IDMERE",
       ff."DESIGNATION",
       ff."QUANTITE",
       ff."PU",
       ff."COMPTE",
       ff."IDPRODUIT",
       ff."DEVISE",
       ff."TAUX",
       ff."IDACTIVITE",
       ff."TVA",
       ff."DATEFACT",
       ff."RUBRIQUE",
       ff."MOIS",
       ff."ANNEE",
       ff."HEUREDEBUT",
       ff."HEUREFIN",
       ff."REDUCTION",
       ff."MAJORATION",
       ff."TEST",
       ff."MONTANTHTSIMPLE",
       ff."MONTANTMAJ",
       ff."MONTANTRED",
       ff."MONTANTNET",
       ff.DUREE,
       cast((montantNET * tva) / 100 as number(30, 3)) as montantTVA
from facture_client_filleNet ff;



CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLETTC
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, IDACTIVITE, TVA, DATEFACT,
             RUBRIQUE, MOIS, ANNEE, HEUREDEBUT, HEUREFIN, REDUCTION, MAJORATION, TEST, MONTANTHTSIMPLE, MONTANTMAJ,
             MONTANTRED, MONTANTNET, MONTANTTVA, MONTANTTTC,DUREE)
AS
select ff.ID,
       ff.IDMERE,
       ff.DESIGNATION,
       ff.QUANTITE,
       ff.PU,
       ff.COMPTE,
       ff.IDPRODUIT,
       ff.DEVISE,
       ff.TAUX,
       ff.IDACTIVITE,
       ff.TVA,
       ff.DATEFACT,
       ff.RUBRIQUE,
       ff.MOIS,
       ff.ANNEE,
       ff.HEUREDEBUT,
       ff.HEUREFIN,
       ff.REDUCTION,
       ff.MAJORATION,
       ff.TEST,
       ff.MONTANTHTSIMPLE,
       ff.MONTANTMAJ,
       ff.MONTANTRED,
       ff.MONTANTNET,
       ff.MONTANTTVA,
       cast(montantNET + montantTVA as number(30, 3)) as montantTTC,
       ff.DUREE
from facture_client_filleWithTVA ff;

