
CREATE SEQUENCE  "SEQ_PAIE_DOMAINE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;

create or replace FUNCTION GETSEQPAIEDOMAINE RETURN NUMBER IS 
retour NUMBER;
BEGIN 
  SELECT seq_paie_domaine.nextval INTO retour FROM dual ;
return retour ;
END;

CREATE SEQUENCE  "SEQ_SERVEUR_PDF_CNAPS"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 2 NOCACHE  NOORDER  NOCYCLE ;

create or replace FUNCTION getSeqServeurPdfCnaps
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_SERVEUR_PDF_CNAPS.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;
--------------------
CREATE SEQUENCE  "SEQ_FORM_PARTICIPANT_DEMANDE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;

create or replace FUNCTION        "GETSEQFORMPARTICIPANTDEMANDE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_PARTICIPANT_DEMANDE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 
-----------------------
CREATE SEQUENCE  "SEQ_FORM_ABSENCE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
create or replace FUNCTION        "GETSEQFORMABSENCE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_ABSENCE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

--SEQ/FONCTION FORMATION
CREATE SEQUENCE  "SEQ_FORM_FORMATION"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;

create or replace FUNCTION        "GETSEQFORMFORMATION" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_FORMATION.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

--seq_paiecategorie

CREATE SEQUENCE  "SEQ_PAIECATEGORIE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 
START WITH 1 NOCACHE  NOORDER  NOCYCLE ;

create or replace FUNCTION        "GETSEQPAIECATEGORIE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seq_paiecategorie.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

--GETSEQFORMETABLISSEMENT
CREATE SEQUENCE "SEQ_FORM_ETABLISSEMENT"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;

create or replace FUNCTION        "GETSEQFORMETABLISSEMENT" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_ETABLISSEMENT.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

--SEQ_FORM_FORMATEUR
CREATE SEQUENCE  "SEQ_FORM_FORMATEUR"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;

create or replace FUNCTION        "GETSEQFORMFORMATEUR" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_FORMATEUR.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 
--GETSEQFORMOFFREFORMATION

CREATE SEQUENCE  "SEQ_FORM_OFFRE_FORMATION"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
 
create or replace FUNCTION        "GETSEQFORMOFFREFORMATION" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_OFFRE_FORMATION.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

--SEQ_PAIE_FONCTION
CREATE SEQUENCE  "SEQ_PAIE_FONCTION"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
 
create or replace FUNCTION "GETSEQPAIEFONCTION" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_PAIE_FONCTION.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 
--SEQ_FORM_DEMANDE
CREATE SEQUENCE  "SEQ_FORM_DEMANDE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
 
create or replace FUNCTION        "GETSEQFORMDEMANDE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_DEMANDE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

--FONCTION
create or replace FUNCTION getStringSplittedValue(str varchar2 , spl char)
   RETURN varchar2
IS
    indicePointVirgule number;
    countPointVirgule number ; 
   retour   varchar2(1000);
   nandalo number:= 0;
   co number :=1 ; 
   sousServiceLib varchar2(200);
    sousServiceId varchar2(200);
  indiceTaloha number:=0;
  suivant  number ;
BEGIN
  indicePointVirgule := instr(str,spl,1,co);

  if indicePointVirgule=0 and str is not null then
    begin
      select libelle into retour from log_service s where s.id =str ; 
    exception
      when no_data_found then retour:='INCONNUE'  ; 
    end;
  else 
    while indicePointVirgule >0  
    loop
        sousServiceId := substr(str,indiceTaloha+1,length(str)-indiceTaloha-(length(str)-indicePointVirgule)-1); 

        if sousServiceId is not null then
           begin 
              select libelle into sousServiceLib from log_service where id =sousServiceId ; 
              retour:= retour ||sousServiceLib || spl; 
          exception 
            when no_data_found then 
            sousServiceLib:= 'INCONNUE';
            retour:=retour || sousServiceLib  ||spl ; 
            suivant:= instr(str,spl,1,co+1);
          end;
        end if;
        indiceTaloha:=indicePointVirgule ; 
        co:=co+1;
       indicePointVirgule := instr(str,spl,1,co);
    end loop;
    if indiceTaloha != length (str) then 
      sousServiceId := substr(str,indiceTaloha+1,length(str)); 
        if sousServiceId is not null then
           begin 
              select libelle into sousServiceLib from log_service where id =sousServiceId ; 
              retour:= retour ||sousServiceLib ;
          exception 
            when no_data_found then 
            sousServiceLib:= 'INCONNUE';
            retour:=retour || sousServiceLib ; 
          end;
        end if;
    end if;  
  end if;
   RETURN retour;
END;
--SEQ_FORM_FORMATION_DEMANDE

CREATE SEQUENCE  "SEQ_FORM_FORMATION_DEMANDE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
 
create or replace FUNCTION        "GETSEQFORMFORMATIONDEMANDE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_FORMATION_DEMANDE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

------------SEQ
--------------------------------------------------------
--  Fichier créé - mardi-février-25-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_ABSENCE
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_ABSENCE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_CATEGORIE
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_CATEGORIE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_DEMANDE
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_DEMANDE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_EMPLOI_TEMP
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_EMPLOI_TEMP"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_ETABLISSEMENT
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_ETABLISSEMENT"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_ETABLISSEMENT_DOMAINE
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_ETABLISSEMENT_DOMAINE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_EXTRA_RECUP
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_EXTRA_RECUP"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_FORMATEUR
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_FORMATEUR"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_FORMATEUR_PJ
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_FORMATEUR_PJ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_FORMATION
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_FORMATION"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_FORMATION_ABSENCE
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_FORMATION_ABSENCE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_FORMATION_DEMANDE
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_FORMATION_DEMANDE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_FORMATION_PJ
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_FORMATION_PJ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_MATIERE
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_MATIERE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_MATIERE_DEMANDE
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_MATIERE_DEMANDE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_NIVEAU
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_NIVEAU"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_OFFRE_FORMATION
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_OFFRE_FORMATION"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_PARTICIPANT
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_PARTICIPANT"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_PARTICIPANT_DEMANDE
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_PARTICIPANT_DEMANDE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_PARTICIPANT_PJ
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_PARTICIPANT_PJ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_RECCUPERATION
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_RECCUPERATION"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_TYPE
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_TYPE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FORM_TYPE_DEMANDEUR
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_FORM_TYPE_DEMANDEUR"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_PAIE_FORMATION
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_PAIE_FORMATION"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;

---------------FONCTION
--------------------------------------------------------
--  Fichier créé - mardi-février-25-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function GETSEQFORMABSENCE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMABSENCE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_ABSENCE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMCATEGORIE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMCATEGORIE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_CATEGORIE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMDEMANDE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMDEMANDE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_DEMANDE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMEMPLOITEMP
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMEMPLOITEMP" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_EMPLOI_TEMP.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMETABLISSEMENT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMETABLISSEMENT" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_ETABLISSEMENT.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMETABLISSEMENTDOMAINE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMETABLISSEMENTDOMAINE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_ETABLISSEMENT_DOMAINE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMFORMATEUR
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMFORMATEUR" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_FORMATEUR.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMFORMATEURPJ
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMFORMATEURPJ" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_FORMATEUR_PJ.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMFORMATION
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMFORMATION" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_FORMATION.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMFORMATIONABSENCE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMFORMATIONABSENCE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_FORMATION_ABSENCE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMFORMATIONDEMANDE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMFORMATIONDEMANDE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_FORMATION_DEMANDE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMFORMATIONPJ
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMFORMATIONPJ" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_FORMATION_PJ.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMMATIERE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMMATIERE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_MATIERE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMMATIEREDEMANDE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMMATIEREDEMANDE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_MATIERE_DEMANDE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMNIEAU
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMNIEAU" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_NIVEAU.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END GETSEQFORMNIEAU; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMNIVEAU
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMNIVEAU" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_NIVEAU.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END GETSEQFORMNIEAU; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMOFFREFORMATION
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMOFFREFORMATION" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_OFFRE_FORMATION.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMPARTICIPANT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMPARTICIPANT" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_PARTICIPANT.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMPARTICIPANTDEMANDE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMPARTICIPANTDEMANDE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_PARTICIPANT_DEMANDE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMPARTICIPANTPJ
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMPARTICIPANTPJ" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_PARTICIPANT_PJ.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMRECCUPERATION
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMRECCUPERATION" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_RECCUPERATION.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMTYPE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMTYPE" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_TYPE.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQFORMTYPEDEMANDEUR
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQFORMTYPEDEMANDEUR" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT SEQ_FORM_TYPE_DEMANDEUR.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
--------------------------------------------------------
--  DDL for Function GETSEQPAIE_FORMATION
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSEQPAIE_FORMATION" 
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seq_paie_formation.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

/
