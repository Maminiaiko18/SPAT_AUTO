--------------------------------------------------------
--  Fichier créé - mercredi-février-12-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table FORM_ABSENCE
--------------------------------------------------------

  CREATE TABLE "FORM_ABSENCE" 
   (	"ID" VARCHAR2(50 BYTE), 
	"ID_FORMATION" VARCHAR2(200 BYTE), 
	"LOG_PERSONNEL" VARCHAR2(200 BYTE), 
	"DATE_ABSENCE" DATE, 
	"MOTIF" VARCHAR2(200 BYTE), 
	"REMARQUE" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_CAT_REJET_FORMATION
--------------------------------------------------------

  CREATE TABLE "FORM_CAT_REJET_FORMATION" 
   (	"ID" VARCHAR2(50 BYTE), 
	"VAL" VARCHAR2(200 BYTE), 
	"DESCE" VARCHAR2(200 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table FORM_CATEGORIE
--------------------------------------------------------

  CREATE TABLE "FORM_CATEGORIE" 
   (	"ID" VARCHAR2(50 BYTE), 
	"VAL" VARCHAR2(200 BYTE), 
	"DESCE" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_DEMANDE
--------------------------------------------------------

  CREATE TABLE "FORM_DEMANDE" 
   (	"ID" VARCHAR2(50 BYTE), 
	"ID_ETABLISSEMENT" VARCHAR2(50 BYTE), 
	"FORM_DOMAINE" VARCHAR2(50 BYTE), 
	"LOG_SERVICE" VARCHAR2(200 BYTE), 
	"ID_CATEGORIE" VARCHAR2(50 BYTE), 
	"ID_TYPE" VARCHAR2(50 BYTE), 
	"ID_PERSONNEL" VARCHAR2(50 BYTE), 
	"DATE_DEBUT" DATE, 
	"DATE_FIN" DATE, 
	"LIEU" VARCHAR2(200 BYTE), 
	"OBJETT" NUMBER, 
	"NIVEAU_REQUIS" NUMBER(20,0), 
	"ID_TYPE_COUT" VARCHAR2(200 BYTE), 
	"COUT_OFFRE" NUMBER(20,2), 
	"IDMATIERE" VARCHAR2(50 BYTE), 
	"EXERCICE" NUMBER, 
	"IDUSER" VARCHAR2(50 BYTE), 
	"HEURE_DEBUT" VARCHAR2(200 BYTE), 
	"HEURE_FIN" VARCHAR2(200 BYTE), 
	"DUREE_HDEBUT" NUMBER(10,2), 
	"DUREE_HFIN" NUMBER(10,2), 
	"ETAT" NUMBER(*,0), 
	"EFFECTIF" NUMBER, 
	"TYPE_DEMANDEUR" VARCHAR2(250 BYTE), 
	"CATEGORIE_PRO" VARCHAR2(250 BYTE), 
	"STATUT_PRO" VARCHAR2(250 BYTE), 
	"ID_DIRECTION" VARCHAR2(50 BYTE), 
	"FONCTION" VARCHAR2(50 BYTE), 
	"ANNEE_SCOLAIRE" VARCHAR2(50 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_EMPLOI_TEMP
--------------------------------------------------------

  CREATE TABLE "FORM_EMPLOI_TEMP" 
   (	"ID" VARCHAR2(50 BYTE), 
	"ID_FORMATION" VARCHAR2(200 BYTE), 
	"ID_PERSONNEL" VARCHAR2(200 BYTE), 
	"DATE_FORMATION" DATE, 
	"HEURE_DEBUT" VARCHAR2(200 BYTE), 
	"HEURE_FIN" VARCHAR2(200 BYTE), 
	"MATIERE" VARCHAR2(200 BYTE), 
	"DUREE_TRAJET" VARCHAR2(200 BYTE), 
	"IDUSER" VARCHAR2(200 BYTE), 
	"DUREE_HDEB" NUMBER(10,2), 
	"DUREE_HFIN" NUMBER(10,2), 
	"REMARQUE" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_ETABLISSEMENT
--------------------------------------------------------

  CREATE TABLE "FORM_ETABLISSEMENT" 
   (	"ID" VARCHAR2(50 BYTE), 
	"NOM" VARCHAR2(200 BYTE), 
	"SPECIALISATION" VARCHAR2(200 BYTE), 
	"DATE_ANCIENNETE" DATE, 
	"ADRESSE" VARCHAR2(200 BYTE), 
	"PAYS" VARCHAR2(200 BYTE), 
	"VALEUR" NUMBER, 
	"CONTACT" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_ETABLISSEMENT_DOMAINE
--------------------------------------------------------

  CREATE TABLE "FORM_ETABLISSEMENT_DOMAINE" 
   (	"ID" VARCHAR2(50 BYTE), 
	"ID1" VARCHAR2(50 BYTE), 
	"ID2" VARCHAR2(50 BYTE), 
	"MONTANTMERE" NUMBER(20,2), 
	"ETAT" NUMBER(*,0), 
	"REMARQUE" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_EXTRA_RECUP
--------------------------------------------------------

  CREATE TABLE "FORM_EXTRA_RECUP" 
   (	"ID" VARCHAR2(50 BYTE), 
	"IDEXTRA" VARCHAR2(50 BYTE), 
	"IDRECUP" VARCHAR2(50 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_FORMATEUR
--------------------------------------------------------

  CREATE TABLE "FORM_FORMATEUR" 
   (	"ID" VARCHAR2(50 BYTE), 
	"NOM" VARCHAR2(200 BYTE), 
	"NIVEAU" NUMBER, 
	"EXPERIENCE" NUMBER, 
	"DESCE" VARCHAR2(200 BYTE), 
	"REMARQUE" VARCHAR2(200 BYTE), 
	"ID_ETABLISSEMENT" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_FORMATEUR_PJ
--------------------------------------------------------

  CREATE TABLE "FORM_FORMATEUR_PJ" 
   (	"ID" VARCHAR2(50 BYTE), 
	"CHEMIN" VARCHAR2(100 BYTE), 
	"LIBELLE" VARCHAR2(200 BYTE), 
	"MERE" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_FORMATION
--------------------------------------------------------

  CREATE TABLE "FORM_FORMATION" 
   (	"ID" VARCHAR2(50 BYTE), 
	"FORM_DOMAINE" VARCHAR2(50 BYTE), 
	"LOG_SERVICE" VARCHAR2(200 BYTE), 
	"FORM_FORMATEUR" VARCHAR2(50 BYTE), 
	"ID_CATEGORIE" VARCHAR2(50 BYTE), 
	"ID_TYPE" VARCHAR2(50 BYTE), 
	"ID_OF" VARCHAR2(50 BYTE), 
	"DATE_DEBUT" DATE, 
	"DATE_FIN" DATE, 
	"LIEU" VARCHAR2(200 BYTE), 
	"OBJETT" NUMBER, 
	"NIVEAU_REQUIS" NUMBER(20,0), 
	"ID_TYPE_COUT" VARCHAR2(200 BYTE), 
	"COUT_OFFRE" NUMBER(20,2), 
	"ETABLISSEMENT" VARCHAR2(200 BYTE), 
	"EXERCICE" NUMBER, 
	"IDUSER" VARCHAR2(50 BYTE), 
	"HEURE_DEBUT" VARCHAR2(50 BYTE), 
	"HEURE_FIN" VARCHAR2(50 BYTE), 
	"DUREE_HDEBUT" NUMBER(10,2), 
	"DUREE_HFIN" NUMBER(10,2), 
	"ETAT" NUMBER(*,0), 
	"INTITULE" VARCHAR2(100 BYTE), 
	"EFFECTIF" NUMBER, 
	"TYPE_DEMANDEUR" VARCHAR2(250 BYTE), 
	"CATEGORIE_PRO" VARCHAR2(250 BYTE), 
	"STATUT_PRO" VARCHAR2(250 BYTE), 
	"ID_DIRECTION" VARCHAR2(50 BYTE), 
	"FONCTION" VARCHAR2(50 BYTE), 
	"ANNEE_SCOLAIRE" VARCHAR2(50 BYTE), 
	"IDMATIERE" VARCHAR2(100 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_FORMATION_AUTORISATION
--------------------------------------------------------

  CREATE TABLE "FORM_FORMATION_AUTORISATION" 
   (	"ID" VARCHAR2(50 BYTE), 
	"ID1" VARCHAR2(50 BYTE), 
	"ID2" VARCHAR2(50 BYTE), 
	"REMARQUE" VARCHAR2(100 BYTE), 
	"MONTANTMERE" NUMBER, 
	"ETAT" NUMBER
   );
--------------------------------------------------------
--  DDL for Table FORM_FORMATION_DEMANDE
--------------------------------------------------------

  CREATE TABLE "FORM_FORMATION_DEMANDE" 
   (	"ID" VARCHAR2(50 BYTE), 
	"ID1" VARCHAR2(50 BYTE), 
	"ID2" VARCHAR2(50 BYTE), 
	"MONTANTMERE" NUMBER(20,2), 
	"ETAT" NUMBER(*,0), 
	"REMARQUE" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_FORMATION_PJ
--------------------------------------------------------

  CREATE TABLE "FORM_FORMATION_PJ" 
   (	"ID" VARCHAR2(50 BYTE), 
	"CHEMIN" VARCHAR2(50 BYTE), 
	"LIBELLE" VARCHAR2(50 BYTE), 
	"MERE" VARCHAR2(50 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_MATIERE
--------------------------------------------------------

  CREATE TABLE "FORM_MATIERE" 
   (	"ID" VARCHAR2(50 BYTE), 
	"VAL" VARCHAR2(200 BYTE), 
	"DESCE" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_NIVEAU
--------------------------------------------------------

  CREATE TABLE "FORM_NIVEAU" 
   (	"ID" VARCHAR2(250 BYTE), 
	"VAL" VARCHAR2(250 BYTE), 
	"DESCE" VARCHAR2(250 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_OFFRE_FORMATION
--------------------------------------------------------

  CREATE TABLE "FORM_OFFRE_FORMATION" 
   (	"ID" VARCHAR2(50 BYTE), 
	"ID_TYPE" VARCHAR2(50 BYTE), 
	"ID_FORMATEUR" VARCHAR2(50 BYTE), 
	"FORM_CATEGORIE" VARCHAR2(50 BYTE), 
	"LOG_SERVICE" VARCHAR2(200 BYTE), 
	"DATE_DEBUT" DATE, 
	"DATE_FIN" DATE, 
	"LIEU" VARCHAR2(200 BYTE), 
	"REMARQUE" VARCHAR2(200 BYTE), 
	"NIVEAU_REQUIS" NUMBER(30,0), 
	"ID_TYPE_COUT" VARCHAR2(200 BYTE), 
	"COUT_OFFRE" NUMBER, 
	"ETABLISSEMENT" VARCHAR2(200 BYTE), 
	"IDUSER" VARCHAR2(50 BYTE), 
	"ETAT" NUMBER DEFAULT 1
   );
--------------------------------------------------------
--  DDL for Table FORM_PARTICIPANT
--------------------------------------------------------

  CREATE TABLE "FORM_PARTICIPANT" 
   (	"ID" VARCHAR2(50 BYTE), 
	"ID_FORMATION" VARCHAR2(50 BYTE), 
	"LOG_PERSONNEL" VARCHAR2(50 BYTE), 
	"REMARQUE" VARCHAR2(200 BYTE), 
	"NOTE" NUMBER, 
	"COUT" NUMBER(20,2), 
	"ABSENCE" NUMBER, 
	"INDEMNITE" NUMBER(20,2)
   );
--------------------------------------------------------
--  DDL for Table FORM_PARTICIPANT_DEMANDE
--------------------------------------------------------

  CREATE TABLE "FORM_PARTICIPANT_DEMANDE" 
   (	"ID" VARCHAR2(50 BYTE), 
	"ID_FORMATION" VARCHAR2(50 BYTE), 
	"LOG_PERSONNEL" VARCHAR2(50 BYTE), 
	"REMARQUE" VARCHAR2(200 BYTE), 
	"NOTE" NUMBER, 
	"COUT" NUMBER(20,2), 
	"ABSENCE" NUMBER, 
	"INDEMNITE" NUMBER(20,2)
   );
--------------------------------------------------------
--  DDL for Table FORM_PARTICIPANT_PJ
--------------------------------------------------------

  CREATE TABLE "FORM_PARTICIPANT_PJ" 
   (	"ID" VARCHAR2(50 BYTE), 
	"CHEMIN" VARCHAR2(100 BYTE), 
	"MERE" VARCHAR2(200 BYTE), 
	"LIBELLE" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_RECCUPERATION
--------------------------------------------------------

  CREATE TABLE "FORM_RECCUPERATION" 
   (	"ID" VARCHAR2(50 BYTE), 
	"ID_FORMATION" VARCHAR2(200 BYTE), 
	"ID_PERSONNEL" VARCHAR2(200 BYTE), 
	"DATE_RECCUP" DATE, 
	"HEURE_DEBUT_AM" VARCHAR2(50 BYTE), 
	"HEURE_FIN_AM" VARCHAR2(50 BYTE), 
	"HEURE_DEBUT_PM" VARCHAR2(200 BYTE), 
	"HEURE_FIN_PM" VARCHAR2(200 BYTE), 
	"REMARQUE" VARCHAR2(200 BYTE), 
	"IDUSER" VARCHAR2(200 BYTE), 
	"HEURE" NUMBER, 
	"ETAT" NUMBER DEFAULT 1
   );
--------------------------------------------------------
--  DDL for Table FORM_REJET_FORMATION
--------------------------------------------------------

  CREATE TABLE "FORM_REJET_FORMATION" 
   (	"ID" VARCHAR2(50 BYTE), 
	"DATY" DATE, 
	"REMARQUE" VARCHAR2(200 BYTE), 
	"MERE" VARCHAR2(200 BYTE), 
	"MOTIF" VARCHAR2(200 BYTE), 
	"CATEGORIEREJET" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_TYPE
--------------------------------------------------------

  CREATE TABLE "FORM_TYPE" 
   (	"ID" VARCHAR2(50 BYTE), 
	"VAL" VARCHAR2(200 BYTE), 
	"DESCE" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_TYPE_COUT
--------------------------------------------------------

  CREATE TABLE "FORM_TYPE_COUT" 
   (	"ID" VARCHAR2(200 BYTE), 
	"VAL" VARCHAR2(200 BYTE), 
	"DESCE" VARCHAR2(200 BYTE)
   );
--------------------------------------------------------
--  DDL for Table FORM_TYPE_DEMANDEUR
--------------------------------------------------------

  CREATE TABLE "FORM_TYPE_DEMANDEUR" 
   (	"ID" VARCHAR2(250 BYTE), 
	"VAL" VARCHAR2(250 BYTE), 
	"DESCE" VARCHAR2(250 BYTE)
   );
--------------------------------------------------------
--  DDL for Table PAIE_DOMAINE
--------------------------------------------------------

  CREATE TABLE "PAIE_DOMAINE" 
   (	"ID" VARCHAR2(50 BYTE), 
	"VAL" VARCHAR2(255 BYTE), 
	"DESCE" VARCHAR2(255 BYTE)
   );
--------------------------------------------------------
--  DDL for Table PAIE_FONCTION
--------------------------------------------------------

  CREATE TABLE "PAIE_FONCTION" 
   (	"ID" VARCHAR2(50 BYTE), 
	"VAL" VARCHAR2(50 BYTE), 
	"DESCE" VARCHAR2(255 BYTE), 
	"IDGROUPEFONCTION" VARCHAR2(50 BYTE), 
	"GRATIFICATION" VARCHAR2(5 BYTE), 
	"TYPE_FONCTION" VARCHAR2(50 BYTE)
   );
--------------------------------------------------------
--  DDL for Table PAIE_GROUPEFONCTION
--------------------------------------------------------

  CREATE TABLE "PAIE_GROUPEFONCTION" 
   (	"ID" VARCHAR2(50 BYTE), 
	"VAL" VARCHAR2(50 BYTE), 
	"DESCE" VARCHAR2(100 BYTE)
   );

--Table "SIG_DR"
CREATE TABLE "SIG_DR" 
   (	"ID" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"VAL" VARCHAR2(150 BYTE), 
	"DESCE" VARCHAR2(200 BYTE), 
	"DR_ABREVIATION" VARCHAR2(50 BYTE), 
	"NUMERO_FIXE" VARCHAR2(50 BYTE), 
	"NUMERO_MOBILE" VARCHAR2(50 BYTE), 
	"DR_SIGLE" VARCHAR2(100 BYTE), 
	 PRIMARY KEY ("ID"));
   
--PAIE_STATUT
CREATE TABLE "PAIE_STATUT" 
   (	"ID" VARCHAR2(50 BYTE), 
	"VAL" VARCHAR2(100 BYTE), 
	"DESCE" VARCHAR2(100 BYTE), 
	 CONSTRAINT "PK_ID_PAIE_STATUT" PRIMARY KEY ("ID"));

--PAIE_CATEGORIE
CREATE TABLE "PAIE_CATEGORIE" 
   (	"ID" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"VAL" VARCHAR2(50 BYTE), 
	"DESCE" VARCHAR2(255 BYTE), 
	"TAUX" VARCHAR2(50 BYTE), 
	 PRIMARY KEY ("ID"));
   
--TRS_BANQUES_AGENCES
CREATE TABLE "TRS_BANQUES_AGENCES" 
   (	"ID" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"VAL" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"DESCE" VARCHAR2(200 BYTE), 
	 PRIMARY KEY ("ID"));
--SERVEUR PDF pour convocation
CREATE TABLE "SERVEUR_PDF_CNAPS" 
   (	"ID" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"NOM_OBJET" VARCHAR2(250 BYTE), 
	"IDOBJET" VARCHAR2(50 BYTE), 
	"ETAT" NUMBER(2,0), 
	"REMARQUE" VARCHAR2(250 BYTE), 
	 PRIMARY KEY ("ID"));
   
Insert into SERVEUR_PDF_CNAPS (ID,NOM_OBJET,IDOBJET,ETAT,REMARQUE) values ('PEX000369','convocation','convocation','20','1');   
--------------------------------------------------------
--  Constraints for Table FORM_ABSENCE
--------------------------------------------------------

  ALTER TABLE "FORM_ABSENCE" ADD CONSTRAINT "FORM_ABSENCE_PK" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_ABSENCE" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_ABSENCE" MODIFY ("ID_FORMATION" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_ABSENCE" MODIFY ("LOG_PERSONNEL" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_CAT_REJET_FORMATION
--------------------------------------------------------

  ALTER TABLE "FORM_CAT_REJET_FORMATION" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_CAT_REJET_FORMATION" MODIFY ("VAL" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_CAT_REJET_FORMATION" ADD PRIMARY KEY ("ID");
--------------------------------------------------------
--  Constraints for Table FORM_CATEGORIE
--------------------------------------------------------

  ALTER TABLE "FORM_CATEGORIE" ADD CONSTRAINT "PK_FORM_CATEGORIE" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_CATEGORIE" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_CATEGORIE" MODIFY ("VAL" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_DEMANDE
--------------------------------------------------------

  ALTER TABLE "FORM_DEMANDE" ADD CONSTRAINT "FORM_DEMANDE_PK" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_DEMANDE" MODIFY ("ID" NOT NULL DISABLE);
 
  ALTER TABLE "FORM_DEMANDE" MODIFY ("FORM_DOMAINE" NOT NULL DISABLE);
 
  ALTER TABLE "FORM_DEMANDE" MODIFY ("LOG_SERVICE" NOT NULL DISABLE);
 
  ALTER TABLE "FORM_DEMANDE" MODIFY ("ID_TYPE" NOT NULL DISABLE);
 
  ALTER TABLE "FORM_DEMANDE" MODIFY ("ETAT" NOT NULL DISABLE);
--------------------------------------------------------
--  Constraints for Table FORM_EMPLOI_TEMP
--------------------------------------------------------

  ALTER TABLE "FORM_EMPLOI_TEMP" ADD CONSTRAINT "FORM_EMPLOI_TEMP_PK" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_EMPLOI_TEMP" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_ETABLISSEMENT
--------------------------------------------------------

  ALTER TABLE "FORM_ETABLISSEMENT" ADD CONSTRAINT "PK_FORM_ETABLISSEMENT" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_ETABLISSEMENT" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_ETABLISSEMENT_DOMAINE
--------------------------------------------------------

  ALTER TABLE "FORM_ETABLISSEMENT_DOMAINE" ADD CONSTRAINT "PK_FORM_ETABLISSEMENT_DOMAINE" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_ETABLISSEMENT_DOMAINE" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_FORMATEUR
--------------------------------------------------------

  ALTER TABLE "FORM_FORMATEUR" ADD CONSTRAINT "PK_FORM_FORMATEUR" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_FORMATEUR" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_FORMATEUR" MODIFY ("NOM" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_FORMATEUR" MODIFY ("NIVEAU" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_FORMATEUR" MODIFY ("EXPERIENCE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_FORMATEUR_PJ
--------------------------------------------------------

  ALTER TABLE "FORM_FORMATEUR_PJ" ADD CONSTRAINT "PK_FORM_FORMATEUR_PJ" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_FORMATEUR_PJ" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_FORMATEUR_PJ" MODIFY ("CHEMIN" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_FORMATEUR_PJ" MODIFY ("LIBELLE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_FORMATION
--------------------------------------------------------

  ALTER TABLE "FORM_FORMATION" ADD CONSTRAINT "FORM_FORMATION_PK" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_FORMATION" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_FORMATION_DEMANDE
--------------------------------------------------------

  ALTER TABLE "FORM_FORMATION_DEMANDE" ADD CONSTRAINT "PK_FORM_FORMATION_DEMANDE" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_FORMATION_DEMANDE" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_FORMATION_PJ
--------------------------------------------------------

  ALTER TABLE "FORM_FORMATION_PJ" ADD CONSTRAINT "FK_FORM_FORMATION_PJ1" CHECK ("ID" IS NOT NULL) ENABLE NOVALIDATE;
 
  ALTER TABLE "FORM_FORMATION_PJ" ADD CONSTRAINT "FK_FORM_FORMATION_PJ2" CHECK ("CHEMIN" IS NOT NULL) ENABLE NOVALIDATE;
 
  ALTER TABLE "FORM_FORMATION_PJ" ADD CONSTRAINT "FK_FORM_FORMATION_PJ3" CHECK ("LIBELLE" IS NOT NULL) ENABLE NOVALIDATE;
 
  ALTER TABLE "FORM_FORMATION_PJ" ADD CONSTRAINT "FK_FORM_FORMATION_PJ4" CHECK ("MERE" IS NOT NULL) ENABLE NOVALIDATE;
 
  ALTER TABLE "FORM_FORMATION_PJ" ADD CONSTRAINT "PK_FORM_FORMATION_PJ" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_FORMATION_PJ" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_FORMATION_PJ" MODIFY ("CHEMIN" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_FORMATION_PJ" MODIFY ("LIBELLE" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_FORMATION_PJ" MODIFY ("MERE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_MATIERE
--------------------------------------------------------

  ALTER TABLE "FORM_MATIERE" ADD CONSTRAINT "FORM_MATIERE_PK" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_MATIERE" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_MATIERE" MODIFY ("VAL" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_NIVEAU
--------------------------------------------------------

  ALTER TABLE "FORM_NIVEAU" ADD PRIMARY KEY ("ID");
--------------------------------------------------------
--  Constraints for Table FORM_OFFRE_FORMATION
--------------------------------------------------------

  ALTER TABLE "FORM_OFFRE_FORMATION" ADD CONSTRAINT "PK_FORM_OFFRE_FORMATION" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_OFFRE_FORMATION" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_OFFRE_FORMATION" MODIFY ("ID_TYPE" NOT NULL DISABLE);
 
  ALTER TABLE "FORM_OFFRE_FORMATION" MODIFY ("FORM_CATEGORIE" NOT NULL DISABLE);
 
  ALTER TABLE "FORM_OFFRE_FORMATION" MODIFY ("LOG_SERVICE" NOT NULL DISABLE);
--------------------------------------------------------
--  Constraints for Table FORM_PARTICIPANT
--------------------------------------------------------

  ALTER TABLE "FORM_PARTICIPANT" ADD CONSTRAINT "PK_FORM_PARTICIPANT" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_PARTICIPANT" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_PARTICIPANT_DEMANDE
--------------------------------------------------------

  ALTER TABLE "FORM_PARTICIPANT_DEMANDE" ADD CONSTRAINT "PK_FORM_PARTICIPANT_DEMANDE" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_PARTICIPANT_DEMANDE" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_PARTICIPANT_PJ
--------------------------------------------------------

  ALTER TABLE "FORM_PARTICIPANT_PJ" ADD CONSTRAINT "PK_FORM_PARTICIPANT_PJ" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_PARTICIPANT_PJ" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_PARTICIPANT_PJ" MODIFY ("CHEMIN" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_PARTICIPANT_PJ" MODIFY ("MERE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_RECCUPERATION
--------------------------------------------------------

  ALTER TABLE "FORM_RECCUPERATION" ADD CONSTRAINT "FORM_RECCUPERATION_PK" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_RECCUPERATION" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_RECCUPERATION" MODIFY ("ID_FORMATION" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_RECCUPERATION" MODIFY ("ID_PERSONNEL" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_RECCUPERATION" MODIFY ("DATE_RECCUP" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_REJET_FORMATION
--------------------------------------------------------

  ALTER TABLE "FORM_REJET_FORMATION" ADD CONSTRAINT "FORM_REJET_FORMATION_PK" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_REJET_FORMATION" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_REJET_FORMATION" MODIFY ("DATY" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_REJET_FORMATION" MODIFY ("MERE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_TYPE
--------------------------------------------------------

  ALTER TABLE "FORM_TYPE" ADD CONSTRAINT "PK_FORM_TYPE" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_TYPE" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FORM_TYPE" MODIFY ("VAL" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_TYPE_COUT
--------------------------------------------------------

  ALTER TABLE "FORM_TYPE_COUT" ADD CONSTRAINT "FORM_TYPE_COUT_PK" PRIMARY KEY ("ID");
 
  ALTER TABLE "FORM_TYPE_COUT" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FORM_TYPE_DEMANDEUR
--------------------------------------------------------

  ALTER TABLE "FORM_TYPE_DEMANDEUR" ADD PRIMARY KEY ("ID");
--------------------------------------------------------
--  Ref Constraints for Table FORM_DEMANDE
--------------------------------------------------------

  ALTER TABLE "FORM_DEMANDE" ADD FOREIGN KEY ("TYPE_DEMANDEUR")
	  REFERENCES "FORM_TYPE_DEMANDEUR" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table FORM_FORMATION
--------------------------------------------------------

  ALTER TABLE "FORM_FORMATION" ADD FOREIGN KEY ("TYPE_DEMANDEUR")
	  REFERENCES "FORM_TYPE_DEMANDEUR" ("ID") ENABLE;
	  
--------------------------------------------------------
--  Constraints for Table PAIE_DOMAINE
--------------------------------------------------------

  ALTER TABLE "PAIE_DOMAINE" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "PAIE_DOMAINE" ADD PRIMARY KEY ("ID");
--------------------------------------------------------
--  Constraints for Table PAIE_FONCTION
--------------------------------------------------------

  ALTER TABLE "PAIE_FONCTION" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "PAIE_FONCTION" ADD PRIMARY KEY ("ID");
--------------------------------------------------------
--  Constraints for Table PAIE_GROUPEFONCTION
--------------------------------------------------------

  ALTER TABLE "PAIE_GROUPEFONCTION" ADD CONSTRAINT "PK_ID_PAIE_GROUPEFONCTION" PRIMARY KEY ("ID");
--------------------------------------------------------
--  Ref Constraints for Table PAIE_FONCTION
--------------------------------------------------------

  ALTER TABLE "PAIE_FONCTION" ADD CONSTRAINT "FK_GROUPEFONCTION_ID" FOREIGN KEY ("IDGROUPEFONCTION")
	  REFERENCES "PAIE_GROUPEFONCTION" ("ID") ENABLE NOVALIDATE;
