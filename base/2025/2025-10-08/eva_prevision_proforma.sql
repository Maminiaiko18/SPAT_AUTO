---------------------bdd facture proforma et prevision -------------------------------

CREATE TABLE "DERNIER_STATIONNEMENT_PROF" 
   (	"ID" VARCHAR2(100), 
	"IDACTIVITE" VARCHAR2(100), 
	"ESCALE" VARCHAR2(100), 
	 CONSTRAINT "DERNIER_STATIONNEMENT_PROF_PK" PRIMARY KEY ("ID"),
     CONSTRAINT "DERN_STAT_PROF_FK_ACT" FOREIGN KEY ("IDACTIVITE")
	  REFERENCES "ACTIVITE_PROF" ("ID") ENABLE, 
	 CONSTRAINT "DERN_STAT_PROF_FK_ESC" FOREIGN KEY ("ESCALE")
	  REFERENCES "PREVISION_PROF" ("ID") ENABLE
   ) ;
  

ALTER TABLE PREVISION_PROF DROP CONSTRAINT SYS_C0081983; -- FK navire

ALTER TABLE PREVISION_PROF
ADD CONSTRAINT FK_NAVIRE_PREV
FOREIGN KEY (NAVIRE) REFERENCES NAVIRE(id);


ALTER TABLE MOUVEMENT_PROF DROP CONSTRAINT SYS_C0081985;   -- FK navire
 
ALTER TABLE MOUVEMENT_PROF
ADD CONSTRAINT FK_NAVIRE_MVT FOREIGN KEY (NAVIRE)
REFERENCES NAVIRE(id);

ALTER TABLE MOUVEMENT_PROF  DISABLE CONSTRAINT SYS_C0081942; -- desactiver foreign key consignataire


CREATE TABLE "FACTURECLIENT_PROF" 
   (	"ID" VARCHAR2(500), 
	"DATY" DATE, 
	"TIERS" VARCHAR2(500), 
	"DESIGNATION" VARCHAR2(4000), 
	"TYPE" VARCHAR2(500), 
	"TVA" NUMBER(10,2), 
	"REMARQUE" VARCHAR2(500), 
	"IDUSER" VARCHAR2(500), 
	"DATE_ECHEANCE" DATE, 
	"ETAT" NUMBER(10,0), 
	"IDPREVISION" VARCHAR2(100), 
	"IDCATEGORIE" VARCHAR2(100), 
	"IDPROVISION" VARCHAR2(100), 
	"DEVISEMERE" VARCHAR2(100) DEFAULT 'Ar', 
	"ESTDDPMICTSL" VARCHAR2(200), 
	"CODEPRESTATION" VARCHAR2(100), 
	"CODE" VARCHAR2(500), 
	"ESTMICTSL" VARCHAR2(500), 
	"EXERCICE" NUMBER(10,0), 
	"IDAVOIR" VARCHAR2(100), 
	"ESTAUTO" NUMBER(*,0), 
	"TYPEENGAGEMENT" VARCHAR2(500) DEFAULT 'normal', 
	"POURCOMPTE" VARCHAR2(100), 
	"ESTANCIENNE" NUMBER(*,0) DEFAULT 0, 
	"ARMATEUR" VARCHAR2(100), 
	"PAIEMENT" VARCHAR2(100), 
	"LHT" NUMBER(10,2), 
	"LM" NUMBER(10,2), 
	"TE" NUMBER(10,2), 
	"JNT" NUMBER(10,2), 
	"DATEDEPART" DATE, 
	"HEUREDEPART" VARCHAR2(500), 
	"DATEARRIVEE" DATE, 
	"HEUREARRIVEE" VARCHAR2(500), 
	"BATEAU" VARCHAR2(100), 
	"PROVENANCE" VARCHAR2(500), 
	"DESTINATION" VARCHAR2(500), 
	"ESCALE" VARCHAR2(500), 
	"VOLUME" NUMBER(20,3), 
	"VOLUME100" NUMBER(20,3), 
	"NOMCLT" VARCHAR2(100), 
	"ADRCLT" VARCHAR2(300), 
	"NMSTTCLT" VARCHAR2(100), 
	"TELCLT" VARCHAR2(100), 
	"NIF" VARCHAR2(100), 
	"RC" VARCHAR2(100), 
	"DTTP" DATE, 
	"TP" VARCHAR2(100), 
	"DTQUIT" DATE, 
	"QUIT" VARCHAR2(100), 
	"IDPLACEMENT" VARCHAR2(100), 
	"ESTPROFORMAESCALE" NUMBER(*,0), 
	"CONNEXE" VARCHAR2(100), 
	"EST_SUP_2021" NUMBER(*,0) DEFAULT 1, 
	 CONSTRAINT "FACTURECLIENT_PROF_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 2097152 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "FACTURECLIENT_PROF_ARM_ID_FK" FOREIGN KEY ("ARMATEUR")
	  REFERENCES "ARMATEUR_TBD" ("ID") ENABLE, 
	 CONSTRAINT "FK_PROVISION_PROF" FOREIGN KEY ("IDPROVISION")
	  REFERENCES "FACTURECLIENT_PROF" ("ID") ENABLE, 
	 CONSTRAINT "FACT_PROF_NAVIRE_ID_FK_PROF" FOREIGN KEY ("BATEAU")
	  REFERENCES "NAVIRE" ("ID") ENABLE, 
	 FOREIGN KEY ("DEVISEMERE")
	  REFERENCES "DEVISE" ("ID") ENABLE, 
	 CONSTRAINT "FACT_PROF_DEVISE_ID_FK_PROF" FOREIGN KEY ("PAIEMENT")
	  REFERENCES "DEVISE" ("ID") ENABLE, 
	 CONSTRAINT "FACT_CONN_FK_PROF" FOREIGN KEY ("CONNEXE")
	  REFERENCES "CONNEXE" ("ID") ENABLE, 
	 CONSTRAINT "FACT_PROF_AVOIR_FKR_PROF" FOREIGN KEY ("IDAVOIR")
	  REFERENCES "AVOIRFC" ("ID") ENABLE, 
	 CONSTRAINT "FACT_PROF_POSTEDEST_ID_FK_PROF" FOREIGN KEY ("PROVENANCE")
	  REFERENCES "POSTEDESTINATAIRE" ("ID") ENABLE, 
	 CONSTRAINT "FACT_PROF_PSTEDEST2_ID_fK" FOREIGN KEY ("DESTINATION")
	  REFERENCES "POSTEDESTINATAIRE" ("ID") ENABLE, 
	 CONSTRAINT "FACT_PLAC_FK_PROF" FOREIGN KEY ("IDPLACEMENT")
	  REFERENCES "PLACEMENT" ("ID") ENABLE, 
	 CONSTRAINT "F_TYPEFC_PROF" FOREIGN KEY ("TYPE")
	  REFERENCES "TYPEFC" ("ID") ENABLE, 
	 CONSTRAINT "FK_IDPREVISION_PROF" FOREIGN KEY ("IDPREVISION")
	  REFERENCES "PREVISION_PROF" ("ID") ENABLE, 
	 CONSTRAINT "FK_FC_CODE_PRESTATION_PROF" FOREIGN KEY ("CODEPRESTATION")
	  REFERENCES "CODE_PRESTATION" ("ID") ENABLE, 
	 CONSTRAINT "FK_CATEGORIEFC_PROF" FOREIGN KEY ("IDCATEGORIE")
	  REFERENCES "CATEGORIEFC" ("ID") ENABLE
   ) ;
  
  
  CREATE TABLE "FACTURE_CLIENT_FILLE_PROF" 
   (	"ID" VARCHAR2(500), 
	"IDMERE" VARCHAR2(500), 
	"DESIGNATION" VARCHAR2(4000), 
	"QUANTITE" NUMBER(20,3), 
	"PU" NUMBER(30,3), 
	"COMPTE" VARCHAR2(500), 
	"IDPRODUIT" VARCHAR2(500), 
	"DEVISE" VARCHAR2(500), 
	"TAUX" NUMBER(10,2), 
	"IDACTIVITE" VARCHAR2(100), 
	"TVA" NUMBER(20,2), 
	"DATEFACT" DATE, 
	"RUBRIQUE" VARCHAR2(100), 
	"MOIS" NUMBER(10,0), 
	"ANNEE" NUMBER(10,0), 
	"HEUREDEBUT" VARCHAR2(100), 
	"HEUREFIN" VARCHAR2(100), 
	"REDUCTION" NUMBER(20,2), 
	"MAJORATION" NUMBER(20,2), 
	"TEST" NUMBER(10,2), 
	"RANG" NUMBER(*,0), 
	"DUREE" NUMBER(10,2), 
	"DATY" DATE, 
	"ESTPROFORMAESCALE" NUMBER(*,0), 
	 CONSTRAINT "FACTURE_CLIENT_FILLE_PROF_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 3145728 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "MERE_FILLE_FK_PROF" FOREIGN KEY ("IDMERE")
	  REFERENCES "FACTURECLIENT_PROF" ("ID") ENABLE, 
	 CONSTRAINT "DEVISE_FC_FK_PROF" FOREIGN KEY ("DEVISE")
	  REFERENCES "DEVISE" ("ID") ENABLE, 
	 CONSTRAINT "FACTURE_CLIENT_PRODUIT_FK_PROF" FOREIGN KEY ("IDPRODUIT")
	  REFERENCES "AS_PRODUITS" ("ID") ENABLE, 
	 CONSTRAINT "IACTIVITE_FC_FK_PROF" FOREIGN KEY ("IDACTIVITE")
	  REFERENCES "ACTIVITE_PROF" ("ID") ENABLE
   ) ;
   
   
   
   
   CREATE OR REPLACE  VIEW "ACTIVITELIBCOMPLETPROF_V" ("ID", "DESIGNATION", "CLIENT", "RUBRIQUE", "QTE", "MOIS", "MOISLIB", "ANNEE", "DATY", "BATEAU", "ETAT", "RUBRIQUELIB", "NAVIRE", "BATEAULIB", "POIDS", "LONGUEUR", "LARGEUR", "AUTRES", "PU", "DEVISE", "COMPTE", "UNITE", "DIRECTION", "CONDITION", "TVA", "OBJET", "REDEVANCE", "CLIENTLIB", "REDEVANCELIB", "DIRECTIONLIB", "ETATLIB", "CATEGORIE", "CATEGORIELIB", "REFOBJET", "TYPESOURCE", "DATEFACT", "POSTE", "POSTELIB", "DATEDEBUT", "HEUREDEBUT", "DATEFIN", "HEUREFIN", "VOLUME", "VOLUMEARRONDI", "CARGAISON", "IDPRESTATION", "ESTNATIONAL", "ESTJOUR", "ESTFERIE", "MANOEUVRE", "ESTWEEKEND", "NATUREOPERATION", "NBQUARTHEURE", "NBHEURE", "NBJOUR", "TYPEQUAIS", "SURFACE", "NB5JOURS", "QUAI", "FLOTTE", "CATEGORIE_FLOTTE", "UNITELIB", "ESTPETROLIER", "VOLUMERUBRIQUE", "TAUX") AS 
  SELECT "ID","DESIGNATION","CLIENT","RUBRIQUE","QTE","MOIS","MOISLIB","ANNEE","DATY","BATEAU","ETAT","RUBRIQUELIB","NAVIRE","BATEAULIB","POIDS","LONGUEUR","LARGEUR","AUTRES","PU","DEVISE","COMPTE","UNITE","DIRECTION","CONDITION","TVA","OBJET","REDEVANCE","CLIENTLIB","REDEVANCELIB","DIRECTIONLIB","ETATLIB","CATEGORIE","CATEGORIELIB","REFOBJET","TYPESOURCE","DATEFACT","POSTE","POSTELIB","DATEDEBUT","HEUREDEBUT","DATEFIN","HEUREFIN","VOLUME","VOLUMEARRONDI","CARGAISON","IDPRESTATION","ESTNATIONAL","ESTJOUR","ESTFERIE","MANOEUVRE","ESTWEEKEND","NATUREOPERATION","NBQUARTHEURE","NBHEURE","NBJOUR","TYPEQUAIS","SURFACE","NB5JOURS","QUAI","FLOTTE","CATEGORIE_FLOTTE","UNITELIB","ESTPETROLIER","VOLUMERUBRIQUE","TAUX"
FROM ACTIVITELIBCOMPLETPROF
WHERE ETAT >= 11;




CREATE OR REPLACE  VIEW "PREVISIONTYPEBORNAGEPROF" ("ID", "DATE_RADE", "PROVENANCE", "NAVIRE", "CONSIGNATAIRE", "CARGAISON", "PILOTE", "DATE_ARRIVEE", "HEURE_ARRIVEE", "DATE_DEPART", "HEURE_DEPART", "DESTINATION", "ETAT", "ESCALE", "NOVOYAGE", "ARMATEUR", "TYPE") AS 
  SELECT
    p.ID,
    p.DATE_RADE,
    p.PROVENANCE,
    p.NAVIRE,
    p.CONSIGNATAIRE,
    p.CARGAISON,
    p.PILOTE,
    p.DATE_ARRIVEE,
    p.HEURE_ARRIVEE,
    p.DATE_DEPART,
    p.HEURE_DEPART,
    p.DESTINATION,
    p.ETAT,
    p.ESCALE,
    p.NOVOYAGE,
    p.ARMATEUR,
    n.TYPE
FROM
    prevision_prof p
    JOIN navire n ON p.navire = n.id;


CREATE OR REPLACE  VIEW "FACTURE_CLIENT_FILLEHT_PROF" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "MONTANTHTSIMPLE", "DUREE") AS 
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
from facture_client_fille_prof ff;


CREATE OR REPLACE  VIEW "FACTURE_CLIENT_FILLEMR_PROF" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "MONTANTHTSIMPLE", "DUREE", "MONTANTMAJ", "MONTANTRED") AS 
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
from facture_client_filleHT_PROF ff;


CREATE OR REPLACE  VIEW "FACTURE_CLIENT_FILLENET_PROF" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "MONTANTHTSIMPLE", "MONTANTMAJ", "MONTANTRED", "MONTANTNET", "DUREE") AS 
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
from facture_client_filleMR_PROF ff;



CREATE OR REPLACE  VIEW "FACTURE_CLIENT_FILLETVA_PROF" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "MONTANTHTSIMPLE", "MONTANTMAJ", "MONTANTRED", "MONTANTNET", "DUREE", "MONTANTTVA") AS 
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
from facture_client_filleNet_PROF ff;
	

CREATE OR REPLACE  VIEW  "FACTURE_CLIENT_FILLETTC_PROF" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "MONTANTHTSIMPLE", "MONTANTMAJ", "MONTANTRED", "MONTANTNET", "MONTANTTVA", "MONTANTTTC", "DUREE") AS 
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
from FACTURE_CLIENT_FILLETVA_PROF ff;


CREATE OR REPLACE  VIEW "FCFILLECOMPLETPROF2" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "RANG", "DUREE", "MONTANTAV", "RUBRIQUECPL", "DATY", "TIERS", "IDCATEGORIE", "TYPE", "DEVISEMERE", "EXERCICE", "IDAVOIR", "ETAT", "MTAVOIR", "MONTANTREDUCTION", "MONTANTMAJORATION", "MONTANT", "MONTANTTVA", "MONTANTTTC", "MOISLIB", "MONTANTHTSIMPLE", "CLIENT", "MONTANTAVOIRAVECTSAUX", "MONTANTAVTTCAVECTAUX", "MONTANTAVTVAAVECTAUX", "CODE", "DATEFACTUREFILLE") AS 
  SELECT
    fcf.ID,
    fcf.IDMERE,
    fcf.DESIGNATION,
    fcf.QUANTITE,
    fcf.PU,
    fcf.COMPTE,
    fcf.IDPRODUIT,
    fcf.DEVISE,
    fcf.TAUX,
    fcf.IDACTIVITE,
    fcf.TVA,
    fcf.DATEFACT,
    fcf.RUBRIQUE,
    EXTRACT(
        MONTH
        FROM
            fc.DATY
    ) AS mois,
    EXTRACT(
        YEAR
        FROM
            fc.DATY
    ) AS annee,
    fcf.HEUREDEBUT,
    fcf.HEUREFIN,
    fcf.REDUCTION,
    fcf.MAJORATION,
    fcf.TEST,
    fcf.RANG,
    fcf.DUREE,
    fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) AS montantAV,
    DECODE(fcf.rubrique, NULL, a.rubrique, fcf.rubrique) AS rubriquecpl,
    fc.daty,
    fc.tiers,
    fc.idcategorie,
    fc.TYPE,
    fc.devisemere,
    fc.exercice,
    FC.IDAVOIr,
    fc.etat,
    NVL(AV.montantsanstaux, 0) AS mtavoir,
    fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.REDUCTION, 0) / 100 AS montantReduction,
    fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.MAJORATION, 0) / 100 AS montantMajoration,
    fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) + (
        fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.MAJORATION, 0)
    ) / 100 - (
        fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.REDUCTION, 0)
    ) / 100 AS montant,
    (
        fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) + (
            fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.MAJORATION, 0)
        ) / 100 - (
            fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.REDUCTION, 0)
        ) / 100
    ) * NVL(fcf.tva / 100, 0) AS montanttva,
    (
        fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) + (
            fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.MAJORATION, 0)
        ) / 100 - (
            fcf.pu * fcf.quantite * fcf.taux * NVL(fcf.duree, 1) * NVL(FCF.REDUCTION, 0)
        ) / 100
    ) * (1 + NVL(fcf.tva / 100, 0)) AS montantttc,
    m.VAL AS moislib,
    f.MONTANTHTSIMPLE,
    t.nomclt,
    CAST(nvl(av.montantavectsaux, 0) AS NUMBER (30, 3)) AS montantavoiravectsaux,
    CAST(nvl(av.MONTANTTTC, 0) AS NUMBER (30, 3)) as montantavTTCavecTaux,
    CAST(nvl(av.MONTANTTVA, 0) AS NUMBER (30, 3)) as montantavTVAavecTaux,
    fc.code,
    fcf.daty AS datefacturefille
FROM
    facture_client_fille_prof fcf
    JOIN factureclient_prof fc ON fcf.idmere = fc.id
    LEFT JOIN activite_prof a ON a.id = fcf.idactivite
    LEFT JOIN AVOIRFCAVECTAUX_GRP av ON AV.IDDETAILFACTURE = fcf.id
    LEFT JOIN mois m ON m.ID = EXTRACT(
        MONTH
        FROM
            fc.DATY
    )
    LEFT JOIN facture_client_filleTTC_prof f ON f.ID = fcf.ID
    left join client_union t on fc.TIERS = t.cdclt;
	
	
	
	
CREATE OR REPLACE  VIEW "CAFCFILLECOMPLET_GRPPROF2" ("IDMERE", "MONTANTAV", "MTAVOIR", "MONTANTREDUCTION", "MONTANTMAJORATION", "MONTANT", "MONTANTTVA", "MONTANTTTC", "MONTANTHTSIMPLE", "MONTANTAVOIRAVECTSAUX", "MONTANTAVTTCAVECTAUX") AS 
  select
    idmere,
    sum(nvl(montantav, 0)) as montantav,
    sum(nvl(mtavoir, 0)) as mtavoir,
    sum(nvl(montantreduction, 0)) as montantreduction,
    sum(nvl(montantmajoration, 0)) as montantmajoration,
    sum(nvl(montant, 0)) as montant,
    sum(nvl(montanttva, 0)) as montanttva,
    sum(nvl(montantttc, 0)) as montantttc,
    sum(nvl(montanthtsimple, 0)) as montanthtsimple,
    sum(nvl(MONTANTAVOIRAVECTSAUX, 0)) as MONTANTAVOIRAVECTSAUX,
    sum(nvl(montantavTTCavecTaux, 0)) as montantavTTCavecTaux
from
    FCFILLECOMPLETprof2
group by
    idmere;
	
	
	
	
CREATE OR REPLACE  VIEW "FACTURECLIENTMSUMPROF" ("ID", "DATY", "TIERS", "DESIGNATION", "TYPE", "TVA", "REMARQUE", "IDUSER", "DATE_ECHEANCE", "ETAT", "IDPREVISION", "MONTANT", "MONTANTTVA", "MONTANTAVOIR", "MONTANTTTC", "ESCALE", "TYPELIB", "IDCATEGORIE", "CATEGORIELIB", "IDPROVISION", "IDPROVISIONLIB", "ESTDDPMICTSL", "DEVISEMERE", "CODEPRESTATION", "CODEPRESTATIONLIB", "CODE", "ESTMICTSL", "CODEPROVISION", "MONTANTTTCVRAI", "NAVIRE", "ARMATEURLIB", "EXERCICE", "IDAVOIR", "POURCOMPTE", "POURCOMPTELIB", "ESTANCIENNE", "ARMATEUR", "PAIEMENT", "LHT", "LM", "TE", "JNT", "DATEDEPART", "HEUREDEPART", "DATEARRIVEE", "HEUREARRIVEE", "BATEAU", "PROVENANCE", "DESTINATION", "PAVILLON", "PAVILLONLIB", "BATEAULIB", "VOLUME", "VOLUME100", "NOMCLT", "ADRCLT", "NMSTTCLT", "TELCLT", "NIF", "RC", "DTTP", "TP", "DTQUIT", "QUIT", "ESTPROFORMAESCALE") AS 
  SELECT
    fc.ID,
    fc.DATY,
    fc.TIERS,
    fc.DESIGNATION,
    fc.TYPE,
    fc.TVA,
    fc.REMARQUE,
    fc.IDUSER,
    fc.DATE_ECHEANCE,
    fc.ETAT,
    fc.idprevision,
    CAST(NVL(grp.montant, 0) AS NUMBER(30, 3)) AS montant,
    --montanttaux
    CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 3)) AS montanttva,
    CAST(
        NVL(grp.montantavTTCavecTaux, 0) AS NUMBER(32, 3)
    ) AS montantavoir,
    CAST(
        NVL(MONTANTTTC, 0) - NVL(grp.montantavTTCavecTaux, 0) AS NUMBER(30, 3)
    ) AS MONTANTTTC,
    nvl(pr.escale, fc.escale) as escale,
    tfc.VAL AS typelib,
    fc.IDCATEGORIE,
    catfc.VAL AS CATEGORIELIB,
    fc.IDPROVISION,
    fcf.DESIGNATION AS IDPROVISIONlib,
    fc.ESTDDPMICTSL,
    fc.DEVISEMERE,
    fc.codePrestation,
    cp.VAL AS codePrestationlib,
    fc.code,
    fc.ESTMICTSL,
    fcf.CODE AS codeprovision,
    CAST(
        NVL(NVL(grp.MONTANTTVA, 0) + grp.MONTANT, 0) AS NUMBER(30, 3)
    ) AS MONTANTTTCVRAI,
    pr.NAVIRE,
    a.val AS armateurlib,
    fc.exercice,
    fc.IDAVOIR,
    fc.pourcompte,
    fup.NOM as pourcomptelib,
    fc.ESTANCIENNE,
    fc.armateur,
    fc.paiement,
    CAST(
        case
            when fc.lht IS NULL
            OR fc.lht = 0 THEN CAST(nvl(nv.lht, nvc.lht) AS NUMBER(10, 2))
            else CAST(fc.lht AS NUMBER(10, 2))
        END AS NUMBER(10, 2)
    ) as lht,
    CAST(
        case
            when fc.lm is null
            OR fc.lm = 0 then CAST(nvl(nv.lm, nvc.lm) AS NUMBER(10, 2))
            else CAST(fc.lm AS NUMBER(10, 2))
        end AS NUMBER(10, 2)
    ) as lm,
    CAST(
        case
            when fc.te is null
            OR fc.te = 0 then CAST(nvl(nv.te, nvc.te) AS NUMBER(10, 2))
            else CAST(fc.te AS NUMBER(10, 2))
        end AS NUMBER(10, 2)
    ) as te,
    CAST(
        case
            when fc.jnt is null
            OR fc.jnt = 0 then CAST(nvl(nv.jnt, nvc.jnt) AS NUMBER(10, 2))
            else CAST(fc.jnt AS NUMBER(10, 2))
        end AS NUMBER(10, 2)
    ) as jnt,
    nvl(pr.date_depart, fc.datedepart) as datedepart,
    nvl(pr.heure_depart, fc.heuredepart) as heuredepart,
    nvl(pr.date_arrivee, fc.datearrivee) as datearrivee,
    nvl(pr.heure_arrivee, fc.heurearrivee) as heurearrivee,
    nvl(pr.navire, fc.bateau) as bateau,
    nvl(pr.provenance, fc.provenance) as provenance,
    nvl(esca.DESTINATION, fc.destination) as destination,
    nvl(nv.pavillon, nvc.pavillon) as pavillon,
    nvl(nv.valpavillon, nvc.valpavillon) as pavillonlib,
    nvl(nv.nom, nvc.nom) as bateaulib,
    fc.volume,
    fc.volume100,
    nvl(fc.nomclt, cu.nomclt),
    nvl(fc.adrclt, cu.adrclt),
    nvl(fc.nmsttclt, cu.nmsttclt),
    nvl(fc.telclt, cu.telclt),
    nvl(fc.nif, cu.nif),
    nvl(fc.rc, cu.rc),
    nvl(fc.dttp, cu.dttp),
    nvl(fc.tp, cu.tp),
    nvl(fc.dtquit, cu.dtquit),
    nvl(fc.quit, cu.quit),
    fc.estProformaEscale
FROM
    FACTURECLIENT_PROF fc
    LEFT JOIN CAFCFILLECOMPLET_GRPprof2 grp ON grp.idmere = fc.id
    LEFT JOIN prevision_prof pr ON pr.id = fc.IDPREVISION
    left join MOUVEMENTDEPART_ESCprof esca on esca.ESCALE = pr.id
    LEFT JOIN TYPEFC tfc ON tfc.ID = fc.TYPE
    LEFT JOIN CATEGORIEFC catfc ON catfc.ID = fc.IDCATEGORIE
    LEFT JOIN factureclient_PROF fcf ON fcf.id = fc.IDPROVISION
    LEFT JOIN CODE_PRESTATION cp ON fc.codePrestation = cp.id
    LEFT JOIN NAVIRELIBCOMPLET nv ON pr.NAVIRE = nv.id
    left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = fc.POURCOMPTE
    LEFT JOIN armateur_tbd a ON a.id = fc.armateur
    left join NAVIRELIBCOMPLET nvc on nvc.id = fc.bateau
    left join postedestinataire pd on pd.id = fc.provenance
    left join postedestinataire pd2 on pd2.id = fc.destination
    left join client_union cu on cu.cdclt = fc.tiers;	
	
	
	
	
	
	
CREATE OR REPLACE  VIEW "FC_FILLE_RANG_DET_PROF" ("ID", "IDMERE", "DESIGNATION", "QUANTITE", "PU", "COMPTE", "IDPRODUIT", "DEVISE", "TAUX", "IDACTIVITE", "TVA", "DATEFACT", "RUBRIQUE", "MOIS", "ANNEE", "HEUREDEBUT", "HEUREFIN", "REDUCTION", "MAJORATION", "TEST", "RANG", "DUREE", "RANG_RUBRIQUE", "RANG_MANOEUVRE", "ESTPROFORMAESCALE") AS 
  select
    fc.ID,
    fc.IDMERE,
    fc.DESIGNATION,
    fc.QUANTITE,
    fc.PU,
    fc.COMPTE,
    fc.IDPRODUIT,
    fc.DEVISE,
    fc.TAUX,
    fc.IDACTIVITE,
    fc.TVA,
    fc.DATEFACT,
    fc.RUBRIQUE,
    fc.MOIS,
    fc.ANNEE,
    fc.HEUREDEBUT,
    fc.HEUREFIN,
    fc.REDUCTION,
    fc.MAJORATION,
    fc.TEST,
    fc.RANG,
    fc.DUREE,
    CASE
        WHEN fc.IDACTIVITE IS NOT NULL THEN r.RANG
        else r1.RANG
    END AS rang_rubrique,
    ma.RANG as rang_manoeuvre,
    fc.estProformaEscale
from
    facture_client_fille_prof fc
    LEFT JOIN ACTIVITELIBCOMPLETPROF ra ON ra.id = fc.IDACTIVITE
    LEFT JOIN RUBRIQUE_ACTIVITE r ON r.ID = ra.RUBRIQUE
    LEFT JOIN RUBRIQUE_ACTIVITE r1 ON r1.ID = fc.RUBRIQUE
    left join OCCUPATIONMATERIELNAVAL_PROF oc on oc.id = ra.REFOBJET
    left join MANOEUVREBORD ma on ma.id = oc.IDMANOEUVREBORD;	
	
   
   
 
