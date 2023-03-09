CREATE OR REPLACE VIEW "FORM_FORMATION_LIBELLE5" ("ID", "FORM_DOMAINE", "LOG_SERVICE", "FORM_FORMATEUR", "ID_CATEGORIE", "ID_TYPE", "ID_OF", "DATE_DEBUT", "DATE_FIN", "LIEU", "OBJETT", "NIVEAU_REQUIS", "ID_TYPE_COUT", "COUT_OFFRE", "ETABLISSEMENT", "EXERCICE", "IDUSER", "HEURE_DEBUT", "HEURE_FIN", "DUREE_HDEBUT", "DUREE_HFIN", "ETAT", "INTITULE", "EFFECTIF", "TYPE_DEMANDEUR", "CATEGORIE_PRO", "STATUT_PRO", "ID_DIRECTION", "FONCTION") AS 
  SELECT FD.ID,
       PD.DESCE   AS "FORM_DOMAINE",
       GETSTRINGSPLITTEDVALUE(FD.LOG_SERVICE, ';') AS "LOG_SERVICE",
       FF.NOM     AS "FORM_FORMATEUR",
       FC.VAL     AS "ID_CATEGORIE",
       FT.VAL     AS "ID_TYPE",
       FD."ID_OF",
       FD."DATE_DEBUT",
       FD."DATE_FIN",
       FD.LIEU,
       FD.OBJETT,
       FD."NIVEAU_REQUIS",
       FTC.VAL    AS "ID_TYPE_COUT",
       FD."COUT_OFFRE",
       FE.NOM     AS ETABLISSEMENT,
       FD.EXERCICE,
       FD.IDUSER,
       FD."HEURE_DEBUT",
       FD."HEURE_FIN",
       FD."DUREE_HDEBUT",
       FD."DUREE_HFIN",
       FD.ETAT,
       FD.INTITULE,
       FD.EFFECTIF,
       FTD.VAL    AS "TYPE_DEMANDEUR",
       PC."Intitule"     AS "CATEGORIE_PRO",
       FD."STATUT_PRO",
       LD.DESCE   AS "ID_DIRECTION",
       pf.DESCE   AS FONCTION
  FROM "FORM_FORMATION"      FD,
       "PAIE_DOMAINE"        PD,
       "FORM_FORMATEUR"      FF,
       "FORM_CATEGORIE"      FC,
       "FORM_TYPE"           FT,
       "FORM_TYPE_COUT"      FTC,
       "FORM_ETABLISSEMENT"  FE,
       "FORM_TYPE_DEMANDEUR" FTD,
       spat_rh."T_CATEGORIE" PC,
       "LOG_DIRECTION"       LD,
       "PAIE_FONCTION"       PF
 WHERE     fd.FORM_DOMAINE = pd.ID(+)
       AND fd.FORM_FORMATEUR = ff.ID(+)
       AND fd.ID_CATEGORIE = fc.ID(+)
       AND fd.ID_TYPE = ft.ID(+)
       AND fd.ID_TYPE_COUT = ftc.ID(+)
       AND fd.ETABLISSEMENT = fe.ID(+)
       AND fd.TYPE_DEMANDEUR = ftd.ID(+)
       AND fd.CATEGORIE_PRO = pc."Code"(+)
       AND fd.ID_DIRECTION = ld.ID(+)
       AND fd.FONCTION = pf.ID(+); 
       

  CREATE OR REPLACE VIEW "FORM_DEMANDE_LIBELLE7" ("ID", "ID_ETABLISSEMENT", "FORM_DOMAINE", "LOG_SERVICE", "ID_CATEGORIE", "ID_TYPE", "ID_PERSONNEL", "DATE_DEBUT", "DATE_FIN", "LIEU", "OBJETT", "NIVEAU_REQUIS", "ID_TYPE_COUT", "COUT_OFFRE", "IDMATIERE", "EXERCICE", "IDUSER", "HEURE_DEBUT", "HEURE_FIN", "DUREE_HDEBUT", "DUREE_HFIN", "ETAT", "EFFECTIF", "TYPE_DEMANDEUR", "CATEGORIE_PRO", "STATUT_PRO", "ID_DIRECTION", "FONCTION") AS 
  SELECT fd.ID,
       fe.NOM                     AS ID_ETABLISSEMENT,
       pd.DESCE                   AS FORM_DOMAINE,
       ls.LIBELLE                 AS LOG_SERVICE,
       fc.VAL                     AS ID_CATEGORIE,
       ft.VAL                     AS ID_TYPE,
       lp.NOM || ' ' || lp.PRENOM AS ID_PERSONNEL,
       fd.DATE_DEBUT,
       fd.DATE_FIN,
       fd.LIEU,
       fd.OBJETT,
       fd.NIVEAU_REQUIS,
       ftc.VAL                    AS ID_TYPE_COUT,
       fd.COUT_OFFRE,
       fm.VAL                     AS IDMATIERE,
       fd.EXERCICE,
       fd.IDUSER,
       fd.HEURE_DEBUT,
       fd.HEURE_FIN,
       fd.DUREE_HDEBUT,
       fd.DUREE_HFIN,
       fd.ETAT,
       fd.EFFECTIF,
       ftd.VAL                    AS TYPE_DEMANDEUR,
       pc."Intitule"                     AS CATEGORIE_PRO,
       fd.STATUT_PRO,
       ld.DESCE                   AS ID_DIRECTION,
       pf.DESCE                   AS FONCTION
  FROM FORM_DEMANDE        fd,
       FORM_ETABLISSEMENT  fe,
       PAIE_DOMAINE        pd,
       LOG_SERVICE         ls,
       FORM_CATEGORIE      fc,
       FORM_TYPE           ft,
       PERSONNELSAGEINFOPERS       lp,
       FORM_TYPE_COUT      ftc,
       FORM_MATIERE        fm,
       FORM_TYPE_DEMANDEUR ftd,
       spat_rh."T_CATEGORIE"      pc,
       LOG_DIRECTION       ld,
       PAIE_FONCTION       pf
 WHERE     fd.ID_ETABLISSEMENT = fe.ID(+)
       AND fd.FORM_DOMAINE = pd.ID(+)
       AND fd.LOG_SERVICE = ls.ID(+)
       AND fd.ID_CATEGORIE = fc.ID(+)
       AND fd.ID_TYPE = ft.ID(+)
       AND fd.ID_PERSONNEL = lp.ID(+)
       AND fd.ID_TYPE_COUT = ftc.ID(+)
       AND fd.IDMATIERE = fm.ID(+)
       AND fd.TYPE_DEMANDEUR = ftd.ID(+)
       AND fd.CATEGORIE_PRO = pc."Code"(+)
       AND fd.ID_DIRECTION = ld.ID(+)
       AND fd.FONCTION = pf.ID (+); 

CREATE OR REPLACE VIEW "FORM_FORMATION_ETAT_CREE"  AS
SELECT "ID",
       "FORM_DOMAINE",
       "LOG_SERVICE",
       "FORM_FORMATEUR",
       "ID_CATEGORIE",
       "ID_TYPE",
       "ID_OF",
       "DATE_DEBUT",
       "DATE_FIN",
       "LIEU",
       "OBJETT",
       "NIVEAU_REQUIS",
       "ID_TYPE_COUT",
       "COUT_OFFRE",
       "ETABLISSEMENT",
       "EXERCICE",
       "IDUSER",
       "HEURE_DEBUT",
       "HEURE_FIN",
       "DUREE_HDEBUT",
       "DUREE_HFIN",
       "ETAT",
       "INTITULE",
       "EFFECTIF",
       "TYPE_DEMANDEUR",
       "CATEGORIE_PRO",
       "STATUT_PRO",
       "ID_DIRECTION",
       "FONCTION"
FROM FORM_FORMATION_LIBELLE5
WHERE ETAT=1;


CREATE OR REPLACE VIEW "FORM_FORMATION_ETAT_ANNULE" AS
SELECT "ID",
       "FORM_DOMAINE",
       "LOG_SERVICE",
       "FORM_FORMATEUR",
       "ID_CATEGORIE",
       "ID_TYPE",
       "ID_OF",
       "DATE_DEBUT",
       "DATE_FIN",
       "LIEU",
       "OBJETT",
       "NIVEAU_REQUIS",
       "ID_TYPE_COUT",
       "COUT_OFFRE",
       "ETABLISSEMENT",
       "EXERCICE",
       "IDUSER",
       "HEURE_DEBUT",
       "HEURE_FIN",
       "DUREE_HDEBUT",
       "DUREE_HFIN",
       "ETAT",
       "INTITULE",
       "EFFECTIF",
       "TYPE_DEMANDEUR",
       "CATEGORIE_PRO",
       "STATUT_PRO",
       "ID_DIRECTION",
       "FONCTION"
FROM FORM_FORMATION_LIBELLE5
WHERE ETAT=0;


CREATE OR REPLACE VIEW "FORM_FORMATION_ETAT_VISE" AS
SELECT "ID",
       "FORM_DOMAINE",
       "LOG_SERVICE",
       "FORM_FORMATEUR",
       "ID_CATEGORIE",
       "ID_TYPE",
       "ID_OF",
       "DATE_DEBUT",
       "DATE_FIN",
       "LIEU",
       "OBJETT",
       "NIVEAU_REQUIS",
       "ID_TYPE_COUT",
       "COUT_OFFRE",
       "ETABLISSEMENT",
       "EXERCICE",
       "IDUSER",
       "HEURE_DEBUT",
       "HEURE_FIN",
       "DUREE_HDEBUT",
       "DUREE_HFIN",
       "ETAT",
       "INTITULE",
       "EFFECTIF",
       "TYPE_DEMANDEUR",
       "CATEGORIE_PRO",
       "STATUT_PRO",
       "ID_DIRECTION",
       "FONCTION"
FROM FORM_FORMATION_LIBELLE5
WHERE ETAT=11;


CREATE OR REPLACE VIEW "FORM_FORMATION_REALISE" ("ID", "FORM_DOMAINE", "LOG_SERVICE", "FORM_FORMATEUR", "ID_CATEGORIE", "ID_TYPE", "ID_OF", "DATE_DEBUT", "DATE_FIN", "LIEU", "OBJETT", "NIVEAU_REQUIS", "ID_TYPE_COUT", "COUT_OFFRE", "ETABLISSEMENT", "EXERCICE", "IDUSER", "HEURE_DEBUT", "HEURE_FIN", "DUREE_HDEBUT", "DUREE_HFIN", "ETAT", "INTITULE", "EFFECTIF", "TYPE_DEMANDEUR", "CATEGORIE_PRO", "STATUT_PRO", "ID_DIRECTION", "FONCTION") AS 
  SELECT FD.ID,
       PD.DESCE   AS "FORM_DOMAINE",
       LS.LIBELLE AS "LOG_SERVICE",
       FF.NOM     AS "FORM_FORMATEUR",
       FC.VAL     AS "ID_CATEGORIE",
       FT.VAL     AS "ID_TYPE",
       FD."ID_OF",
       FD."DATE_DEBUT",
       FD."DATE_FIN",
       FD.LIEU,
       FD.OBJETT,
       FD."NIVEAU_REQUIS",
       FTC.VAL    AS "ID_TYPE_COUT",
       FD."COUT_OFFRE",
       FE.NOM     AS ETABLISSEMENT,
       FD.EXERCICE,
       FD.IDUSER,
       FD."HEURE_DEBUT",
       FD."HEURE_FIN",
       FD."DUREE_HDEBUT",
       FD."DUREE_HFIN",
       FD.ETAT,
       FD.INTITULE,
       FD.EFFECTIF,
       FTD.VAL    AS "TYPE_DEMANDEUR",
       PC."Intitule"     AS "CATEGORIE_PRO",
       FD."STATUT_PRO",
       LD.DESCE   AS "ID_DIRECTION",
       pf.DESCE as FONCTION
  FROM "FORM_FORMATION"      FD,
       "PAIE_DOMAINE"        PD,
       "LOG_SERVICE"         LS,
       "FORM_FORMATEUR"      FF,
       "FORM_CATEGORIE"      FC,
       "FORM_TYPE"           FT,
       "FORM_TYPE_COUT"      FTC,
       "FORM_ETABLISSEMENT"  FE,
       "FORM_TYPE_DEMANDEUR" FTD,
       spat_rh."T_CATEGORIE" PC,
       "LOG_DIRECTION"       LD,
       "PAIE_FONCTION"         PF
 WHERE     fd.FORM_DOMAINE = pd.ID(+)
       AND fd.LOG_SERVICE = ls.ID(+)
       AND fd.FORM_FORMATEUR = ff.ID(+)
       AND fd.ID_CATEGORIE = fc.ID(+)
       AND fd.ID_TYPE = ft.ID(+)
       AND fd.ID_TYPE_COUT = ftc.ID(+)
       AND fd.ETABLISSEMENT = fe.ID(+)
       AND fd.TYPE_DEMANDEUR = ftd.ID(+)
       AND fd.CATEGORIE_PRO = pc."Code"(+)
       AND fd.ID_DIRECTION = ld.ID(+)
       AND fd.FONCTION = pf.ID (+)
       and fd.ETAT=12;
       
CREATE OR REPLACE VIEW "FORM_FORMATION_SAISIE" ("ID", "INTITULE", "FORM_DEMANDE", "ID_OF", "TYPE_DEMANDEUR", "ID_TYPE", "ETABLISSEMENT", "FORM_FORMATEUR", "FORM_DOMAINE", "IDMATIERE", "DATE_DEBUT", "DATE_FIN", "HEURE_DEBUT", "HEURE_FIN", "DUREE_HDEBUT", "DUREE_HFIN", "ANNEE_SCOLAIRE", "LIEU", "NIVEAU_REQUIS", "LOG_SERVICE", "ID_DIRECTION", "CATEGORIE_PRO", "STATUT_PRO", "FONCTION", "EFFECTIF", "ID_TYPE_COUT", "COUT_OFFRE", "EXERCICE", "ID_CATEGORIE", "ETAT", "IDUSER", "OBJETT") AS 
  SELECT
	ff.ID,
	ff.INTITULE,
	'' AS FORM_DEMANDE,
	ff.ID_OF,
	ff.TYPE_DEMANDEUR,
	ff.ID_TYPE,
	ff.ETABLISSEMENT,
	ff.FORM_FORMATEUR,
	ff.FORM_DOMAINE,
	ff.IDMATIERE,
	ff.DATE_DEBUT,
	ff.DATE_FIN,
	ff.HEURE_DEBUT,
	ff.HEURE_FIN,
	ff.DUREE_HDEBUT,
	ff.DUREE_HFIN,
	ff.ANNEE_SCOLAIRE,
	ff.LIEU,
	ff.NIVEAU_REQUIS,
	ff.LOG_SERVICE,
	ff.ID_DIRECTION,
	ff.CATEGORIE_PRO,
	ff.STATUT_PRO,
	ff.FONCTION,
	ff.EFFECTIF,
	ff.ID_TYPE_COUT,
	ff.COUT_OFFRE,
	ff.EXERCICE,
	ff.ID_CATEGORIE,
	ff.ETAT,
	ff.IDUSER,
	ff.OBJETT
FROM FORM_FORMATION ff;      

CREATE OR REPLACE VIEW "ANALYSE_DEMANDE_FORMATION" ("ID", "ETABLISSEMENT", "DOMAINE", "SERVICE", "CATEGORIE", "FORMATION_TYPE", "DATE_DEBUT", "DATE_FIN", "LIEU", "OBJETT", "NIVEAU_REQUIS", "COUT_OFFRE", "EXERCICE", "IDUSER") AS 
  select 
dem.id,
etab.nom as etablissement,
dom.val as domaine,
serv.libelle as service,
cat.val as categorie,
tp.val as formation_type,
dem.date_debut,
dem.date_fin,
dem.lieu,
dem.objett,
dem.niveau_requis,
dem.cout_offre,
dem.exercice,
dem.iduser
from form_demande dem
join form_etablissement etab on dem.id_etablissement = etab.id
join form_type tp on dem.id_type = tp.id
join log_service serv on dem.log_service = serv.id
join form_categorie cat on dem.id_categorie = cat.id
join paie_domaine dom on dem.form_domaine = dom.id
join form_matiere mat on dem.idmatiere = mat.id;

CREATE OR REPLACE VIEW "FORM_PARTICIPANT_INFOCOMPLET" ("ID", "ID_FORMATION", "LIEU_FORMATION", "IDPERSONNEL", "NOM", "PRENOM", "REMARQUE", "NOTE", "COUT", "ABSENCE") AS 
  SELECT 
  form_participant.ID, 
  form_formation.ID as id_formation,
  form_formation.lieu as lieu_formation,
  PERSONNELSAGEINFOPERS.id as idpersonnel,
  PERSONNELSAGEINFOPERS.NOM , PERSONNELSAGEINFOPERS.PRENOM ,
 form_participant.remarque, form_participant.note,
 form_participant.cout,  form_participant.absence
  FROM form_participant, form_formation, PERSONNELSAGEINFOPERS
 WHERE ( 
(form_formation.ID = form_participant.id_formation)
AND (PERSONNELSAGEINFOPERS.ID = form_participant.log_personnel)
);

CREATE OR REPLACE VIEW "LOG_SERVICE_LIBELLE" ("ID", "LIBELLE", "CODE_DR", "DR_RATTACHE", "CODE_SERVICE") AS 
  SELECT ls.ID, ls.libelle, sd.val as code_dr,
       ls.dr_rattache, ls.code_service
  FROM log_service ls 
  LEFT JOIN  sig_dr sd ON ls.code_dr = sd.ID;
  
CREATE OR REPLACE VIEW "FORM_ETABLISSEMENT_LIBELLE" ("ID", "NOM", "SPECIALISATION", "DATE_ANCIENNETE", "ADRESSE", "PAYS", "VALEUR", "CONTACT") AS 
  SELECT form_etablissement.ID, form_etablissement.nom,
       form_etablissement.specialisation, form_etablissement.date_anciennete,
       form_etablissement.adresse, pays.val as pays, form_etablissement.valeur,
       form_etablissement.contact
  FROM form_etablissement, pays
 WHERE ((pays.ID = form_etablissement.pays));  
 
 CREATE OR REPLACE VIEW "FORM_OFFRE_FORMATION_LIBELLE" ("ID", "ID_TYPE", "ID_FORMATEUR", "FORM_CATEGORIE", "LOG_SERVICE", "DATE_DEBUT", "DATE_FIN", "LIEU", "REMARQUE", "NIVEAU_REQUIS", "COUT_OFFRE", "ETABLISSEMENT", "IDUSER", "ETAT") AS 
  SELECT form_offre_formation.ID, form_type.val as id_type,
   ('-') as id_formateur,
       form_categorie.val as form_categorie, log_service.libelle as log_service,
       form_offre_formation.date_debut, form_offre_formation.date_fin,
       form_offre_formation.lieu, form_offre_formation.remarque,
       form_offre_formation.niveau_requis, form_offre_formation.cout_offre,
       ets.nom as etablissement,
       form_offre_formation.iduser, FORM_OFFRE_FORMATION.ETAT
  FROM form_offre_formation,
       form_type,
   
       form_categorie,
       log_service,
       form_etablissement ets
    
 WHERE (    (form_type.ID = form_offre_formation.id_type)
     
        AND (form_categorie.ID = form_offre_formation.form_categorie)
        AND (log_service.ID = form_offre_formation.log_service)
        AND (form_offre_formation.etablissement = ets.ID)
       );
       
CREATE OR REPLACE VIEW "PAIE_FONCTIONLIBELLE"  AS
SELECT p.ID,
       p.VAL,
       p.DESCE,
       pg.DESCE AS IDGROUPEFONCTION,
       p.TYPE_FONCTION
FROM PAIE_FONCTION p
LEFT JOIN PAIE_GROUPEFONCTION pg on(p.IDGROUPEFONCTION = pg.ID);   

CREATE OR REPLACE VIEW "FORM_DEMANDE_LIB_TOUS" AS 
  SELECT
	fd.ID,
	ftd.DESCE AS TYPE_DEMANDEUR,
	ft.DESCE AS ID_TYPE,
	fet.NOM AS ID_ETABLISSEMENT,
	pd.DESCE AS FORM_DOMAINE,
	fm.VAL AS IDMATIERE,
	fd.DATE_DEBUT,
	fd.DATE_FIN,
	fd.HEURE_DEBUT,
	fd.HEURE_FIN,
	fd.DUREE_HDEBUT,
	fd.DUREE_HFIN,
	fd.ANNEE_SCOLAIRE,
	fd.LIEU,
	fd.NIVEAU_REQUIS,
	fd.LOG_SERVICE AS LOG_SERVICE,
	fd.ID_DIRECTION AS ID_DIRECTION,
	pc."Intitule" AS CATEGORIE_PRO,
	fd.STATUT_PRO,
	pf.DESCE AS FONCTION,
	fd.EFFECTIF,
	ftc.DESCE AS ID_TYPE_COUT,
	fd.COUT_OFFRE,
	fd.EXERCICE,
	fd.ID_CATEGORIE,
	fd.ETAT,
	fd.IDUSER,
	fd.ID_PERSONNEL,
	fd.OBJETT
FROM FORM_DEMANDE fd
LEFT JOIN FORM_TYPE_DEMANDEUR ftd ON ftd.ID = fd.TYPE_DEMANDEUR
LEFT JOIN FORM_TYPE ft ON ft.ID = fd.ID_TYPE
LEFT JOIN FORM_ETABLISSEMENT fet ON fet.ID = fd.ID_ETABLISSEMENT
LEFT JOIN PAIE_DOMAINE pd ON pd.ID = fd.FORM_DOMAINE
LEFT JOIN FORM_MATIERE fm ON fm.ID = fd.IDMATIERE
--LEFT JOIN LOG_SERVICE ls ON ls.ID = fd.LOG_SERVICE
--LEFT JOIN LOG_DIRECTION ld ON ld.ID = fd.ID_DIRECTION
LEFT JOIN spat_rh.T_CATEGORIE pc ON pc."Code" = fd.CATEGORIE_PRO
LEFT JOIN PAIE_FONCTION pf ON pf.ID = fd.FONCTION
LEFT JOIN FORM_TYPE_COUT ftc ON ftc.ID = fd.ID_TYPE_COUT;

CREATE OR REPLACE VIEW "FORM_DEMANDE_LIB_CREE" AS
SELECT "ID",
       "TYPE_DEMANDEUR",
       "ID_TYPE",
       "ID_ETABLISSEMENT",
       "FORM_DOMAINE",
       "IDMATIERE",
       "DATE_DEBUT",
       "DATE_FIN",
       "HEURE_DEBUT",
       "HEURE_FIN",
       "DUREE_HDEBUT",
       "DUREE_HFIN",
       "ANNEE_SCOLAIRE",
       "LIEU",
       "NIVEAU_REQUIS",
       "LOG_SERVICE",
       "ID_DIRECTION",
       "CATEGORIE_PRO",
       "STATUT_PRO",
       "FONCTION",
       "EFFECTIF",
       "ID_TYPE_COUT",
       "COUT_OFFRE",
       "EXERCICE",
       "ID_CATEGORIE",
       "ETAT",
       "IDUSER",
       "ID_PERSONNEL",
       "OBJETT"
FROM FORM_DEMANDE_LIB_TOUS fd
WHERE fd.ETAT = 1;

--PAIE_INFO_PERSONNEL a revoir.
CREATE OR REPLACE VIEW "FORM_PART_INFO_COMPLET" ("ID", "FORM_FORMATION", "ID_PERSONNEL", "LOG_PERSONNEL", "LOG_SERVICE", "PAIE_FONCTION", "MATRICULE", "NOTE", "ABSENCE") AS 
  SELECT
fp.ID as ID,
fp.ID_FORMATION as FORM_FORMATION,
fp.LOG_PERSONNEL as ID_PERSONNEL,
pip.NOM||' '||pip.PRENOM as LOG_PERSONNEL,
pip.categorie as LOG_SERVICE,
pip.POSTE as PAIE_FONCTION,
pip.NUMEROMATRICULE as MATRICULE,
fp.NOTE,
fp.ABSENCE
FROM
FORM_PARTICIPANT fp,
PERSONNELSAGEINFOPERS pip
WHERE fp.LOG_PERSONNEL = pip.ID
;
--FORM_DEMANDE_LIBELLE7
CREATE OR REPLACE VIEW "FORM_DEMANDE_LIBELLE7" ("ID", "ID_ETABLISSEMENT", "FORM_DOMAINE", "LOG_SERVICE", "ID_CATEGORIE", "ID_TYPE", "ID_PERSONNEL", "DATE_DEBUT", "DATE_FIN", "LIEU", "OBJETT", "NIVEAU_REQUIS", "ID_TYPE_COUT", "COUT_OFFRE", "IDMATIERE", "EXERCICE", "IDUSER", "HEURE_DEBUT", "HEURE_FIN", "DUREE_HDEBUT", "DUREE_HFIN", "ETAT", "EFFECTIF", "TYPE_DEMANDEUR", "CATEGORIE_PRO", "STATUT_PRO", "ID_DIRECTION", "FONCTION") AS 
  SELECT fd.ID,
       fe.NOM                     AS ID_ETABLISSEMENT,
       pd.DESCE                   AS FORM_DOMAINE,
       ls.LIBELLE                 AS LOG_SERVICE,
       fc.VAL                     AS ID_CATEGORIE,
       ft.VAL                     AS ID_TYPE,
       lp.NOM || ' ' || lp.PRENOM AS ID_PERSONNEL,
       fd.DATE_DEBUT,
       fd.DATE_FIN,
       fd.LIEU,
       fd.OBJETT,
       fd.NIVEAU_REQUIS,
       ftc.VAL                    AS ID_TYPE_COUT,
       fd.COUT_OFFRE,
       fm.VAL                     AS IDMATIERE,
       fd.EXERCICE,
       fd.IDUSER,
       fd.HEURE_DEBUT,
       fd.HEURE_FIN,
       fd.DUREE_HDEBUT,
       fd.DUREE_HFIN,
       fd.ETAT,
       fd.EFFECTIF,
       ftd.VAL                    AS TYPE_DEMANDEUR,
       pc."Intitule"                     AS CATEGORIE_PRO,
       fd.STATUT_PRO,
       ld.DESCE                   AS ID_DIRECTION,
       pf.DESCE                   AS FONCTION
  FROM FORM_DEMANDE        fd,
       FORM_ETABLISSEMENT  fe,
       PAIE_DOMAINE        pd,
       LOG_SERVICE         ls,
       FORM_CATEGORIE      fc,
       FORM_TYPE           ft,
       PERSONNELSAGEINFOPERS       lp,
       FORM_TYPE_COUT      ftc,
       FORM_MATIERE        fm,
       FORM_TYPE_DEMANDEUR ftd,
       "SPAT_RH".T_CATEGORIE pc,
       LOG_DIRECTION       ld,
       PAIE_FONCTION       pf
 WHERE     fd.ID_ETABLISSEMENT = fe.ID(+)
       AND fd.FORM_DOMAINE = pd.ID(+)
       AND fd.LOG_SERVICE = ls.ID(+)
       AND fd.ID_CATEGORIE = fc.ID(+)
       AND fd.ID_TYPE = ft.ID(+)
       AND fd.ID_PERSONNEL = lp.ID(+)
       AND fd.ID_TYPE_COUT = ftc.ID(+)
       AND fd.IDMATIERE = fm.ID(+)
       AND fd.TYPE_DEMANDEUR = ftd.ID(+)
       AND fd.CATEGORIE_PRO = pc."Code"(+)
       AND fd.ID_DIRECTION = ld.ID(+)
       AND fd.FONCTION = pf.ID (+);
       
CREATE OR REPLACE VIEW "FORM_OFFRE_FORMATION_LIBELLE3" ("ID", "ID_TYPE", "ID_FORMATEUR", "FORM_CATEGORIE", "LOG_SERVICE", "DATE_DEBUT", "DATE_FIN", "LIEU", "REMARQUE", "NIVEAU_REQUIS", "ID_TYPE_COUT", "COUT_OFFRE", "ETABLISSEMENT", "IDUSER", "ETAT") AS 
  SELECT
fof.ID,
ft.VAL as ID_TYPE,
ff.NOM as ID_FORMATEUR,
fc.VAL as FORM_CATEGORIE,
ls.LIBELLE as LOG_SERVICE,
fof.DATE_DEBUT,
fof.DATE_FIN,
fof.LIEU,
fof.REMARQUE,
fof.NIVEAU_REQUIS,
ftc.VAL as ID_TYPE_COUT,
fof.COUT_OFFRE,
fe.NOM as ETABLISSEMENT,
fof.IDUSER,
fof.ETAT
FROM 
FORM_OFFRE_FORMATION fof,
FORM_TYPE ft,
FORM_FORMATEUR ff,
FORM_CATEGORIE fc,
LOG_SERVICE ls,
FORM_TYPE_COUT ftc,
FORM_ETABLISSEMENT fe
WHERE
fof.ID_TYPE = ft.ID (+)
AND fof.ID_FORMATEUR = ff.ID (+)
AND fof.FORM_CATEGORIE = fc.ID (+)
AND fof.LOG_SERVICE = ls.ID (+)
AND fof.ID_TYPE_COUT = ftc.ID (+)
AND fof.ETABLISSEMENT = fe.ID (+);       

CREATE OR REPLACE VIEW "FORM_DEMANDE_SAISIE" ("ID", "TYPE_DEMANDEUR", "ID_TYPE", "ID_ETABLISSEMENT", "FORM_DOMAINE", "IDMATIERE", "DATE_DEBUT", "DATE_FIN", "HEURE_DEBUT", "HEURE_FIN", "DUREE_HDEBUT", "DUREE_HFIN", "ANNEE_SCOLAIRE", "LIEU", "NIVEAU_REQUIS", "LOG_SERVICE", "ID_DIRECTION", "CATEGORIE_PRO", "STATUT_PRO", "FONCTION", "EFFECTIF", "ID_TYPE_COUT", "COUT_OFFRE", "EXERCICE", "ID_CATEGORIE", "ETAT", "IDUSER", "ID_PERSONNEL", "OBJETT") AS 
  SELECT
	ID,
	TYPE_DEMANDEUR,
	ID_TYPE,
	ID_ETABLISSEMENT,
	FORM_DOMAINE,
	IDMATIERE,
	DATE_DEBUT,
	DATE_FIN,
	HEURE_DEBUT,
	HEURE_FIN,
	DUREE_HDEBUT,
	DUREE_HFIN,
	ANNEE_SCOLAIRE,
	LIEU,
	NIVEAU_REQUIS,
	LOG_SERVICE,
	ID_DIRECTION,
	CATEGORIE_PRO,
	STATUT_PRO,
	FONCTION,
	EFFECTIF,
	ID_TYPE_COUT,
	COUT_OFFRE,
	EXERCICE,
	ID_CATEGORIE,
	ETAT,
	IDUSER,
	ID_PERSONNEL,
	OBJETT
FROM FORM_DEMANDE;

CREATE OR REPLACE VIEW "LOG_SERVICE_LIBELLEF" ("ID", "LIBELLE", "CODE_DR", "DR_RATTACHE", "CODE_SERVICE") AS 
  SELECT ls.ID, ls.libelle, sd.val as code_dr,
       ls.dr_rattache, di.desce as CODE_SERVICE
  FROM log_service ls 
  LEFT JOIN  sig_dr sd ON ls.code_dr = sd.ID
  LEFT JOIN  log_direction di ON ls.dr_rattache = di.id;
  
  
CREATE OR REPLACE VIEW "FORM_PARTICIPANT_INFOCOMPLET" ("ID", "ID_FORMATION", "LIEU_FORMATION", "IDPERSONNEL", "NOM", "PRENOM", "REMARQUE", "NOTE", "COUT", "ABSENCE") AS 
  SELECT 
  form_participant.ID, 
  form_formation.ID as id_formation,
  form_formation.lieu as lieu_formation,
  PERSONNELSAGEINFOPERS.id as idpersonnel,
  PERSONNELSAGEINFOPERS.NOM , PERSONNELSAGEINFOPERS.PRENOM ,
 form_participant.remarque, form_participant.note,
 form_participant.cout,  form_participant.absence
  FROM form_participant, form_formation, PERSONNELSAGEINFOPERS
 WHERE ( 
 (form_formation.ID = form_participant.id_formation)
  AND (PERSONNELSAGEINFOPERS.ID = form_participant.log_personnel)
);  

CREATE OR REPLACE VIEW "FORM_PARTICIPANT_DEMCOMPLET" ("ID", "ID_FORMATION", "IDPERSONNEL", "MATRICULE", "PERSONNEL", "SERVICE", "DIRECTION", "CATEGORIE", "FONCTION", "SEXE", "REMARQUE", "NOTE", "ABSENCE", "COUT", "INDEMNITE") AS 
  SELECT
	fp.ID,
	fp.ID_FORMATION,
	pip.ID AS IDPERSONNEL,
	pip.NUMEROMATRICULE,
	pip.NOm || ' ' || pip.PRENOM AS PERSONNEL,
	pip.POSTE AS SERVICE,
	pip.CATEGORIE AS DIRECTION,
	pip.categorie AS CATEGORIE,
	pip.poste AS FONCTION,
	pip.GENRE AS SEXE,
	fp.REMARQUE,
	fp.NOTE,
	fp.ABSENCE,
	fp.COUT,
	fp.INDEMNITE
FROM FORM_PARTICIPANT_DEMANDE fp
LEFT JOIN PERSONNELSAGEINFOPERS pip ON pip.ID = fp.LOG_PERSONNEL
--LEFT JOIN LOG_SERVICE ls ON ls.ID = lp.SERVICE
--LEFT JOIN LOG_DIRECTION ld ON ld.ID = lp.DIRECTION
;

CREATE OR REPLACE VIEW "FORM_PART_INFOCOMPLET_VISE" ("ID", "ID_FORMATION", "LIEU_FORMATION", "IDPERSONNEL", "NOM", "PRENOM", "REMARQUE", "NOTE", "COUT", "ABSENCE") AS 
  SELECT form_participant.ID,
          form_formation.ID   AS id_formation,
          form_formation.lieu AS lieu_formation,
          PERSONNELSAGEINFOPERS.ID    AS idpersonnel,
          PERSONNELSAGEINFOPERS.NOM,
          PERSONNELSAGEINFOPERS.PRENOM,
          form_participant.remarque,
          form_participant.note,
          form_participant.cout,
          form_participant.absence
     FROM form_participant, form_formation, PERSONNELSAGEINFOPERS
    WHERE (    (form_formation.ID = form_participant.id_formation)
           AND (PERSONNELSAGEINFOPERS.ID = form_participant.log_personnel))
		   and form_formation.ETAT > 11;

CREATE OR REPLACE VIEW "PERSONNEL_INFOLIBELLE" ("ID", "SEXE", "PERSONNEL", "DATE_NAISSANCE", "NATIONALITE", "ADRESSE", "NUMERO_CIN", "DATE_CIN", "BANQUE_AGENCE", "BANQUE_NUMERO_COMPTE", "MATRICULE", "DATEEMBAUCHE", "FONCTION", "CATEGORIE", "ECHELON", "CLASSEE", "STATUT", "INDICEGRADE", "INDICE_FONCTIONNEL", "VEHICULEE", "SERVICE", "DIRECTION", "ETAT") AS 
  SELECT 
    pip.ID,
    pip.GENRE as SEXE,
    pip.NOM || ' ' || pip.PRENOM AS PERSONNEL,
    pip.DATENAISSANCE as DATE_NAISSANCE,
    'MALAGASY' AS NATIONALITE,
    pip.ADRESSE,
    lp.NUMERO_CIN as NUMERO_CIN,
    '' as DATE_CIN,
    '' AS BANQUE_AGENCE,
    lp.NUMERO_VIREMENT as BANQUE_NUMERO_COMPTE,
    pip.NUMEROMATRICULE as MATRICULE,
    lp.DATE_EMBAUCHE as DATEEMBAUCHE,
    pip.POSTE AS FONCTION,
    pip.CATEGORIE AS CATEGORIE,
    lp.PALIER as ECHELON,
    pip.QUALIFICATION as CLASSEE,
    lp.SITUATION_MATRIMONIALE as STATUT,
    '' as INDICEGRADE,
    '' as INDICE_FONCTIONNEL,
    '' as VEHICULEE,
    pip.POSTE AS SERVICE,
    pip.DIRECTION AS DIRECTION,
    '' as ETAT
FROM PERSONNELSAGEINFOPERS pip
left join INFOPERSONNELGLOBAL lp on lp.id=pip.id
--LEFT JOIN LOG_SERVICE ls ON ls.ID = lp.SERVICE
--LEFT JOIN LOG_DIRECTION ld ON ld.ID = lp.DIRECTION
--LEFT JOIN PAIE_CATEGORIE pc ON pc.ID = pip.IDCATEGORIE
--LEFT JOIN PAIE_FONCTION pf ON pf.ID = pip.IDFONCTION
--LEFT JOIN PAYS p ON p.ID = lp.NATIONALITE
--LEFT JOIN TRS_BANQUES_AGENCES tba ON TBA.ID = pip.CODE_AGENCE_BANQUE
;

CREATE OR REPLACE VIEW "FORMATION_PARTICIPANTCOMPLET" ("ID", "SEXE", "PERSONNEL", "DATE_NAISSANCE", "NATIONALITE", "ADRESSE", "NUMERO_CIN", "DATE_CIN", "BANQUE_AGENCE", "BANQUE_NUMERO_COMPTE", "MATRICULE", "DATEEMBAUCHE", "FONCTION", "CATEGORIE", "ECHELON", "CLASSEE", "STATUT", "INDICEGRADE", "INDICE_FONCTIONNEL", "VEHICULEE", "SERVICE", "DIRECTION", "ETAT", "ID_FORMATION") AS 
  SELECT
    pi."ID",pi."SEXE",pi."PERSONNEL",pi."DATE_NAISSANCE",pi."NATIONALITE",pi."ADRESSE",
    pi."NUMERO_CIN",pi."DATE_CIN",pi."BANQUE_AGENCE",pi."BANQUE_NUMERO_COMPTE",pi."MATRICULE",
    pi."DATEEMBAUCHE",pi."FONCTION",pi."CATEGORIE",pi."ECHELON",pi."CLASSEE",pi."STATUT",
    pi."INDICEGRADE",pi."INDICE_FONCTIONNEL",pi."VEHICULEE",pi."SERVICE",pi."DIRECTION",pi."ETAT", fp.ID_FORMATION 
FROM FORM_PARTICIPANT fp
LEFT JOIN PERSONNEL_INFOLIBELLE pi on fp.LOG_PERSONNEL = pi.ID;  

CREATE OR REPLACE VIEW "ANALYSE_FORMATION" ("ID", "DOMAINE", "SERVICE", "CATEGORIE", "FORMATION_TYPE", "DATE_DEBUT", "DATE_FIN", "LIEU", "OBJETT", "NIVEAU_REQUIS", "COUT", "ETABLISSMEENT", "EXERCICE", "IDUSER") AS 
  select 
frm.id,
dom.val as domaine,
'' as service,
'' as categorie,
tp.val as formation_type,
frm.date_debut,
frm.date_fin,
frm.lieu,
frm.objett,
frm.niveau_requis,
frm.cout_offre as cout,
etab.nom as etablissmeent,
frm.exercice,
frm.iduser
from form_formation frm 
join paie_domaine dom on frm.form_domaine = dom.id
--join log_service serv on frm.log_service = serv.id
join form_formateur frmtr on frm.form_formateur = frmtr.id
--join form_categorie cat on frm.id_categorie = cat.id
Join Form_Type Tp On Frm.Id_Type = Tp.Id
join form_etablissement etab on frm.etablissement = etab.id;

CREATE OR REPLACE VIEW "FORM_ABSENCE_LIBELLE" 
("ID",
 "ID_FORMATION",
 "LOG_PERSONNEL",
 "DATE_ABSENCE",
 "MOTIF",
 "REMARQUE") AS
SELECT ab.id,
       ab.id_formation,
       pers.nom,
       ab.date_absence,
       ab.motif,
       ab.remarque
FROM form_absence ab
JOIN PERSONNELSAGEINFOPERS pers ON ab.log_personnel = pers.id;

CREATE OR REPLACE VIEW "ANALYSE_OFFRE_FORMATION" ("ID", "SERVICE", "CATEGORIE", "FORMATION_TYPE", "DATE_DEBUT", "DATE_FIN", "LIEU", "NIVEAU_REQUIS", "COUT_OFFRE", "ETABLISSMEENT", "IDUSER") AS 
  select 
ofr.id,
serv.libelle as service,
cat.val as categorie,
tp.val as formation_type,
ofr.date_debut,
ofr.date_fin,
ofr.lieu,
ofr.niveau_requis,
ofr.cout_offre,
etab.nom as etablissmeent,
ofr.iduser
from form_offre_formation ofr
join form_type tp on id_type = tp.id
left join form_formateur frmtr on ofr.id_formateur = frmtr.id
left join form_categorie cat on ofr.form_categorie = cat.id
left join log_service serv on ofr.log_service = serv.id
join form_etablissement etab on ofr.etablissement = etab.id;

CREATE OR REPLACE VIEW "FORM_FORMATEUR_LIBELLE_2" ("ID", "NOM", "NIVEAU", "EXPERIENCE", "DESCE", "REMARQUE", "ID_ETABLISSEMENT") AS 
  SELECT
ff.ID,
ff.NOM,
ff.NIVEAU,
ff.EXPERIENCE,
ff.DESCE,
ff.REMARQUE,
fe.NOM as ID_ETABLISSEMENT
FROM 
FORM_FORMATEUR ff, FORM_ETABLISSEMENT fe
WHERE
ff.ID_ETABLISSEMENT = fe.ID (+);
 
CREATE OR REPLACE VIEW "FORM_FORMATION_LIBELLE4" ("ID", "FORM_DOMAINE", "LOG_SERVICE", "FORM_FORMATEUR", "ID_CATEGORIE", "ID_TYPE", "ID_OF", "DATE_DEBUT", "DATE_FIN", "LIEU", "OBJETT", "NIVEAU_REQUIS", "ID_TYPE_COUT", "COUT_OFFRE", "ETABLISSEMENT", "EXERCICE", "IDUSER", "HEURE_DEBUT", "HEURE_FIN", "DUREE_HDEBUT", "DUREE_HFIN", "ETAT", "INTITULE", "EFFECTIF", "TYPE_DEMANDEUR", "CATEGORIE_PRO", "STATUT_PRO", "ID_DIRECTION") AS 
  SELECT
FD.ID,
PD.DESCE AS "FORM_DOMAINE",
LS.LIBELLE AS "LOG_SERVICE",
FF.NOM AS "FORM_FORMATEUR",
FC.VAL AS "ID_CATEGORIE",
FT.VAL AS "ID_TYPE",
FD."ID_OF",
FD."DATE_DEBUT",
FD."DATE_FIN",
FD.LIEU,
FD.OBJETT,
FD."NIVEAU_REQUIS",
FTC.VAL AS "ID_TYPE_COUT",
FD."COUT_OFFRE",
FE.NOM AS ETABLISSEMENT,
FD.EXERCICE,
FD.IDUSER,
FD."HEURE_DEBUT",
FD."HEURE_FIN",
FD."DUREE_HDEBUT",
FD."DUREE_HFIN",
FD.ETAT,
FD.INTITULE,
FD.EFFECTIF,
FTD.VAL AS "TYPE_DEMANDEUR",
PC.VAL AS "CATEGORIE_PRO",
FD."STATUT_PRO",
LD.DESCE AS "ID_DIRECTION"
FROM
"FORM_FORMATION" FD,
"PAIE_DOMAINE" PD,
"LOG_SERVICE" LS,
"FORM_FORMATEUR" FF,
"FORM_CATEGORIE" FC,
"FORM_TYPE" FT,
"FORM_TYPE_COUT" FTC,
"FORM_ETABLISSEMENT" FE,
"FORM_TYPE_DEMANDEUR" FTD,
"PAIE_CATEGORIE" PC,
"LOG_DIRECTION" LD
WHERE
fd.FORM_DOMAINE = pd.ID (+)
AND fd.LOG_SERVICE = ls.ID (+)
AND fd.FORM_FORMATEUR = ff.ID (+)
AND fd.ID_CATEGORIE = fc.ID (+)
AND fd.ID_TYPE = ft.ID (+)
AND fd.ID_TYPE_COUT = ftc.ID (+)
AND fd.ETABLISSEMENT = fe.ID (+)
AND fd.TYPE_DEMANDEUR = ftd.ID (+)
AND fd.CATEGORIE_PRO = pc.ID (+)
AND fd.ID_DIRECTION = ld.ID (+);


CREATE OR REPLACE VIEW "PERSONNEL_VALIDE_INFOLIBELLE" ("ID", "SEXE", "PERSONNEL", "DATE_NAISSANCE", "NATIONALITE", "ADRESSE", "NUMERO_CIN", "DATE_CIN", "BANQUE_AGENCE", "BANQUE_NUMERO_COMPTE", "MATRICULE", "DATEEMBAUCHE", "FONCTION", "CATEGORIE", "ECHELON", "CLASSEE", "STATUT", "INDICEGRADE", "INDICE_FONCTIONNEL", "VEHICULEE", "SERVICE", "DIRECTION", "ETAT") AS 
  SELECT 
    lp.ID,
    lp.GENRE,
    lp.NOM || ' ' || lp.PRENOM AS PERSONNEL,
    lp.DATENAISSANCE as DATE_NAISSANCE,
    '' AS NATIONALITE,
    lp.ADRESSE,
    '' as NUMERO_CIN,
    null as DATE_CIN,
    '' AS BANQUE_AGENCE,
    '' as BANQUE_NUMERO_COMPTE,
    lp.NUMEROMATRICULE as MATRICULE,
    null as DATEEMBAUCHE,
    lp.POSTE AS FONCTION,
    lp.CATEGORIE AS CATEGORIE,
    0 as ECHELON,
    '' as CLASSEE,
    '' as STATUT,
    0 as INDICEGRADE,
    0 as INDICE_FONCTIONNEL,
    0 as VEHICULEE,
    '' AS SERVICE,
    '' AS DIRECTION,
    11 as ETAT
FROM PERSONNELSAGEINFOPERS lp
--LEFT JOIN PAIE_INFO_PERSONNEL pip ON pip.ID = lp.ID
--LEFT JOIN LOG_SERVICE ls ON ls.ID = lp.SERVICE
--LEFT JOIN LOG_DIRECTION ld ON ld.ID = lp.DIRECTION
--LEFT JOIN PAIE_CATEGORIE pc ON pc.ID = pip.IDCATEGORIE
--LEFT JOIN PAIE_FONCTION pf ON pf.ID = pip.IDFONCTION
--LEFT JOIN PAYS p ON p.ID = lp.NATIONALITE
--LEFT JOIN TRS_BANQUES_AGENCES tba ON TBA.ID = pip.CODE_AGENCE_BANQUE
--WHERE ETAT = 11
;

CREATE OR REPLACE VIEW "FORM_PARTICIPANT_INFO" ("ID",
                                            "ID_FORMATION",
                                            "NOM",
                                            "PRENOM",
                                            "REMARQUE",
                                            "NOTE",
                                            "COUT",
                                            "ABSENCE",
                                            "INDEMNITE",
                                            "SEXE") AS
SELECT form_participant.ID,
       form_participant.id_formation,
       PERSONNELSAGEINFOPERS.nom,
       PERSONNELSAGEINFOPERS.prenom,
       form_participant.remarque,
       form_participant.note,
       form_participant.cout,
       form_participant.ABSENCE,
       form_participant.indemnite,
       PERSONNELSAGEINFOPERS.GENRE as sexe
FROM form_participant,
     PERSONNELSAGEINFOPERS
WHERE ((PERSONNELSAGEINFOPERS.ID = form_participant.log_personnel));

CREATE OR REPLACE VIEW "FORMATION_ETAT" ("EMPLOYE", "MATRICULE", "FONCTION", "SERVICE", "IDFORMATION", "SEXE", "FORMATION", "LIEU", "DATE_DEBUT", "DATE_FIN", "DUREE_HEURE_DEBUT", "MATERIEL", "OBJET", "DRH") AS 
  SELECT lp.NOM || ' ' || lp.PRENOM AS employe,
       lp.NUMEROMATRICULE              AS matricule,
       lp.POSTE                   AS fonction,
       lp.CATEGORIE                 AS service,
       ff.ID                      AS idformation,
       lp.GENRE                    AS sexe,
       fp.REMARQUE                AS formation,
       ff.LIEU                    AS lieu,
       ff.DATE_DEBUT              AS date_debut,
       ff.DATE_FIN                AS date_fin,
       ff.HEURE_DEBUT            AS duree_heure_debut,
       fp.REMARQUE                AS materiel,
       fp.REMARQUE                AS objet,
       fp.REMARQUE                AS drh
  FROM FORM_PARTICIPANT     fp,
       FORM_FORMATION       ff,
       PERSONNELSAGEINFOPERS lp
       --LOG_PERSONNEL        lp,
       --PAIE_INFO_PERSONNEL  pip,
       --PAIE_FONCTION        pf,
       --LOG_SERVICE          ls--,
       --LOG_PERSONNEL_VALIDE lpv
 WHERE (    (fp.ID_FORMATION = ff.ID(+))
        AND (fp.LOG_PERSONNEL = lp.ID(+)))
        --AND (lp.ID = pip.ID)
        --AND (pip.IDFONCTION = pf.ID(+))
        --AND (ls.ID(+) = lp.SERVICE)
        --AND (lpv.ID(+) = lp.ID))
;


CREATE OR REPLACE
VIEW "FORMDEM_PARTICIPANTCOMPLET" ("ID",
                                                 "SEXE",
                                                 "PERSONNEL",
                                                 "DATE_NAISSANCE",
                                                 "NATIONALITE",
                                                 "ADRESSE",
                                                 "NUMERO_CIN",
                                                 "DATE_CIN",
                                                 "BANQUE_AGENCE",
                                                 "BANQUE_NUMERO_COMPTE",
                                                 "MATRICULE",
                                                 "DATEEMBAUCHE",
                                                 "FONCTION",
                                                 "CATEGORIE",
                                                 "ECHELON",
                                                 "CLASSEE",
                                                 "STATUT",
                                                 "INDICEGRADE",
                                                 "INDICE_FONCTIONNEL",
                                                 "VEHICULEE",
                                                 "SERVICE",
                                                 "DIRECTION",
                                                 "ETAT",
                                                 "ID_FORMATION") AS
SELECT pi."ID",
       pi."SEXE",
       pi."PERSONNEL",
       pi."DATE_NAISSANCE",
       pi."NATIONALITE",
       pi."ADRESSE",
       pi."NUMERO_CIN",
       pi."DATE_CIN",
       pi."BANQUE_AGENCE",
       pi."BANQUE_NUMERO_COMPTE",
       pi."MATRICULE",
       pi."DATEEMBAUCHE",
       pi."FONCTION",
       pi."CATEGORIE",
       pi."ECHELON",
       pi."CLASSEE",
       pi."STATUT",
       pi."INDICEGRADE",
       pi."INDICE_FONCTIONNEL",
       pi."VEHICULEE",
       pi."SERVICE",
       pi."DIRECTION",
       pi."ETAT",
       fp.ID_FORMATION
FROM FORM_PARTICIPANT_DEMANDE fp
LEFT JOIN PERSONNEL_INFOLIBELLE pi ON fp.LOG_PERSONNEL = pi.ID;

CREATE OR REPLACE VIEW "FORMATION_PERSONNEL_VIEW" ("ID",
                                               "ID_FORMATION",
                                               "LOG_PERSONNEL",
                                               "REMARQUE",
                                               "NOTE",
                                               "COUT",
                                               "ABSENCE",
                                               "NOM",
                                               "PRENOM") AS
SELECT form_participant.ID,
       form_participant.id_formation,
       form_participant.log_personnel,
       form_participant.remarque,
       form_participant.note,
       form_participant.cout,
       form_participant.absence,
       PERSONNELSAGEINFOPERS.nom,
       PERSONNELSAGEINFOPERS.prenom
FROM form_participant,
     PERSONNELSAGEINFOPERS
WHERE PERSONNELSAGEINFOPERS.ID = form_participant.log_personnel;


CREATE OR REPLACE VIEW "FORM_OFFRE_FORMATION_CREE" ("ID",
                                                "ID_TYPE",
                                                "ID_FORMATEUR",
                                                "FORM_CATEGORIE",
                                                "LOG_SERVICE",
                                                "DATE_DEBUT",
                                                "DATE_FIN",
                                                "LIEU",
                                                "REMARQUE",
                                                "NIVEAU_REQUIS",
                                                "COUT_OFFRE",
                                                "ETABLISSEMENT",
                                                "IDUSER",
                                                "ETAT") AS
SELECT "ID",
       "ID_TYPE",
       "ID_FORMATEUR",
       "FORM_CATEGORIE",
       "LOG_SERVICE",
       "DATE_DEBUT",
       "DATE_FIN",
       "LIEU",
       "REMARQUE",
       "NIVEAU_REQUIS",
       "COUT_OFFRE",
       "ETABLISSEMENT",
       "IDUSER",
       "ETAT"
FROM FORM_OFFRE_FORMATION_LIBELLE
WHERE ETAT = 1;


CREATE OR REPLACE VIEW "FORM_OFFRE_FORMATION_ANNULE" ("ID",
                                                  "ID_TYPE",
                                                  "ID_FORMATEUR",
                                                  "FORM_CATEGORIE",
                                                  "LOG_SERVICE",
                                                  "DATE_DEBUT",
                                                  "DATE_FIN",
                                                  "LIEU",
                                                  "REMARQUE",
                                                  "NIVEAU_REQUIS",
                                                  "COUT_OFFRE",
                                                  "ETABLISSEMENT",
                                                  "IDUSER",
                                                  "ETAT") AS
SELECT "ID",
       "ID_TYPE",
       "ID_FORMATEUR",
       "FORM_CATEGORIE",
       "LOG_SERVICE",
       "DATE_DEBUT",
       "DATE_FIN",
       "LIEU",
       "REMARQUE",
       "NIVEAU_REQUIS",
       "COUT_OFFRE",
       "ETABLISSEMENT",
       "IDUSER",
       "ETAT"
FROM FORM_OFFRE_FORMATION_LIBELLE
WHERE ETAT = 0;


CREATE OR REPLACE VIEW "FORM_OFFRE_FORMATION_VISE" ("ID",
                                                "ID_TYPE",
                                                "ID_FORMATEUR",
                                                "FORM_CATEGORIE",
                                                "LOG_SERVICE",
                                                "DATE_DEBUT",
                                                "DATE_FIN",
                                                "LIEU",
                                                "REMARQUE",
                                                "NIVEAU_REQUIS",
                                                "COUT_OFFRE",
                                                "ETABLISSEMENT",
                                                "IDUSER",
                                                "ETAT") AS
SELECT "ID",
       "ID_TYPE",
       "ID_FORMATEUR",
       "FORM_CATEGORIE",
       "LOG_SERVICE",
       "DATE_DEBUT",
       "DATE_FIN",
       "LIEU",
       "REMARQUE",
       "NIVEAU_REQUIS",
       "COUT_OFFRE",
       "ETABLISSEMENT",
       "IDUSER",
       "ETAT"
FROM FORM_OFFRE_FORMATION_LIBELLE
WHERE ETAT = 11;