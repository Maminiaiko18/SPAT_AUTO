	drop sequence SEQCONSIGNATAIRE;
    CREATE SEQUENCE  SEQCONSIGNATAIRE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 100 NOCACHE  NOORDER  NOCYCLE ;
   
    drop function GETSEQSEQConsignataire;
    create or replace FUNCTION GETSEQConsignataire
	  RETURN NUMBER IS
	  retour NUMBER;
	BEGIN
	  SELECT SEQConsignataire.nextval INTO retour FROM dual;
	  return retour;
	END;
	   

	drop sequence SEQTYPE_MATERIEL;
    CREATE SEQUENCE  SEQTYPEMATERIEL  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 100 NOCACHE  NOORDER  NOCYCLE ;
   
    drop function GETSEQtype_materiel;
    create or replace FUNCTION GETSEQtypemateriel
	  RETURN NUMBER IS
	  retour NUMBER;
	BEGIN
	  SELECT SEQConsignataire.nextval INTO retour FROM dual;
	  return retour;
	END;
	   
	 drop view   STAT_ACTIVITE_LIBCOMPLET;
	 /*CREATE OR REPLACE FORCE VIEW STAT_ACTIVITE_LIBCOMPLET ("ID", "IDCLIENT", "RUBRIQUE", "DATY", "CUMUL", "CDCLT", "CDCAT", "NOMCLT", "ADRCLT", "NMSTTCLT", "TELCLT", "FAXCLT", "NMCIN", "NIF", "RC", "CATEGORIE", "IDPREVISION", "RUBRIQUEPREVISION", "DATYPREVISION", "CUMULPREVISION") AS 
          select stat."ID",stat."IDCLIENT",stat."RUBRIQUE",stat."DATY",stat."CUMUL",        clt."CDCLT",clt."CDCAT",clt."NOMCLT",clt."ADRCLT",clt."NMSTTCLT",clt."TELCLT",clt."FAXCLT",clt."NMCIN",clt."NIF",clt."RC",clt."CATEGORIE",        prev.ID as idprevision, prev.RUBRIQUE as rubriqueprevision, prev.DATY as datyprevision, prev.CUMUL as cumulprevision    from STATISTIQUE_ACTIVITE stat        join SPAT_CAPITAINERIE.V_CLIENT_CATEGORIE clt on clt.CDCLT = stat.IDCLIENT        join PREVISION_STATISTIQUE_ACTIVITE prev on prev.IDCLIENT = stat.IDCLIENT;*/
		  
    CREATE OR REPLACE FORCE VIEW STAT_ACTIVITE_LIBCOMPLET AS 
          select stat."ID",stat."IDCLIENT",stat."RUBRIQUE",stat."DATY",stat."CUMUL",        clt."CDCLT",clt."CDCAT",clt."NOMCLT",clt."ADRCLT",clt."NMSTTCLT",clt."TELCLT",clt."FAXCLT",clt."NMCIN",clt."NIF",clt."RC",clt."CATEGORIE",        prev.ID as idprevision, prev.RUBRIQUE as rubriqueprevision, prev.DATY as datyprevision, prev.CUMUL as cumulprevision    from STATISTIQUE_ACTIVITE stat        join SPAT_CAPITAINERIE.V_CLIENT_CATEGORIE clt on clt.CDCLT = stat.IDCLIENT        join PREVISION_STATISTIQUE_ACTIVITE prev on prev.IDCLIENT = stat.IDCLIENT;
