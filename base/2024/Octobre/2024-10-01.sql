script SPAT:
--------2024-09-24
--------Tiavina
-- creer view  AVISCREDITPACT  from JOURNALCAISSELIBCOMPLET where idcaisse =’CAI0000000009173634’ -

CREATE VIEW AVISCREDITPACT
AS 
SELECT 
j.*
FROM JOURNALCAISSELIBCOMPLET j 
WHERE j.IDCAISSE='CAI0000000009173634' ;



--creer menu avis de credit PACT
--
--idpere : MEN00400
--
--lien : treso/aviscredit-pact.jsp
--
--Ajouter ce menu pour le role : ROL0000001331195343

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENT0095624', 'avis de credit PACT', 'fa fa-money', '/spat/pages/globalnegoce.jsp?but=treso/aviscredit-pact.jsp', 3, 3, 'MEN00400');

INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('MENAT00095724', NULL, 'MENT0095624', 'ROL0000001331195343', NULL, NULL, 0);


--creer table avenantbudget
--
--String id,idlignecredit,source
--
--double montant

create table avenantbudget (
    id varchar(100) constraint avenantbudget_pk primary key,
    idlignecredit varchar(200) constraint avenantbudget_lcdep_fk references LIGNECREDITDEPENSE(id),
    source varchar(50),
    montant NUMBER(30,2) 
);


create sequence seqavenantbudget
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
      
      

CREATE OR REPLACE FUNCTION getseqavenantbudget
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqavenantbudget.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 


--table
--
--creer table reamenagement
--
--id
--
--idlignedepart
--
--idlignearrive
--
--monant
--
--etat
--
--view :  reamenagementlib,reamenagementlibcreer,reamenagementlibvise
--

create table reamenagement (
    id varchar(100) constraint reamenagement_pk primary key,
    idlignedepart varchar(200) CONSTRAINT depart_lcdep_fk references LIGNECREDITDEPENSE(id) ,
    idlignearrive varchar(200) CONSTRAINT arrive_lcdep_fk references LIGNECREDITDEPENSE(id),
    montant NUMBER(30,2) ,
    etat int
);


create sequence seqreamenagement
      minvalue 1
      maxvalue 999999999999
      start with 1
      increment by 1
      cache 20;
      
      

CREATE OR REPLACE FUNCTION getseqreamenagement
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqreamenagement.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END; 

CREATE VIEW reamenagementlib
AS 
SELECT 
r.*,
l.DESIGNATION AS idlignedepartlib,
l2.DESIGNATION AS idlignearrivelib,
CASE 
	WHEN r.etat = 1 
	THEN 'CREE'
	WHEN r.etat = 11 
	THEN 'VISEE'
END AS etatlib
FROM reamenagement r
LEFT JOIN LIGNECREDITDEPENSE l ON l.id = r.idlignedepart
LEFT JOIN LIGNECREDITDEPENSE l2 ON l2.id = r.idlignearrive ;

CREATE VIEW reamenagementlibcreer
AS 
SELECT 
r.*
FROM reamenagementlib r
WHERE r.etat = 1 ;


CREATE VIEW reamenagementlibvise
AS 
SELECT 
r.*
FROM reamenagementlib r
WHERE r.etat = 11 ;


--menu
--
--idpere : MENBDG00021
--
--nom : Réaménagement
--
--asina fille
--
--saisie : ligneCredit/reamenagement-saisie.jsp
--
--liste :  ligneCredit/reamenagement-liste.jsp


INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENDYT00101724', 'Réaménagement', 'fa fa-money', '#', 5, 4, 'MENBDG00021');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENDYT00101725', 'Saisie', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=ligneCredit/reamenagement-saisie.jsp', 1, 5, 'MENDYT00101724');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MENDYT00101726', 'Liste', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=ligneCredit/reamenagement-liste.jsp', 2, 5, 'MENDYT00101724');


----------Nouta
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEND0000821', 'Saisie N', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=treso/journalcaisse-saisie-vaovao.jsp', 12, 5, 'MEN0031');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEND0000820', 'Saisie N', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=facture/factureclient-saisie-vaovao.jsp', 5, 3, 'MEN00068');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEND0000819', 'Saisie N', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=depense/demande-achat-saisie-vaovao.jsp', 3, 4, 'MEN00022');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEND0000818', 'Saisie N', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=facture/facture-fournisseur-saisie-vaovao2.jsp', 8, 4, 'MEN00500');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEND0000817', 'Saisie N', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=stock/bc/bondecommande-multiple-vaovao.jsp', 4, 4, 'MEN00212');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEND0000816', 'Saisie N', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=depense/engagement-saisie-vaovao.jsp', 10, 3, 'MEN00211');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00812', 'Saisie N', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=travaux/travaux-saisie-vaovao.jsp', 3, 2, 'MEN0005');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00813', 'Saisie N', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=travaux/chantier-saisie-vaovao.jsp', 3, 3, 'MEN00184');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES ('MEND0000815', 'Saisie N', 'fa fa-plus', '/spat/pages/globalnegoce.jsp?but=travaux/contrat-saisie-vaovao.jsp', 3, 3, 'MEND0000104');



--AVISCREDITPACT_CREE, AVISCREDITPACT_VISE 
CREATE VIEW AVISCREDITPACT_CREE 
AS 
SELECT 
a.*
FROM AVISCREDITPACT a 
WHERE a.ETAT = 1 ;


CREATE VIEW AVISCREDITPACT_VISE 
AS 
SELECT 
a.*
FROM AVISCREDITPACT a 
WHERE a.ETAT = 11 ;


ALTER TABLE AVENANTBUDGET ADD daty DATE ;

CREATE OR REPLACE  VIEW REAMENAGEMENTLIB (ID, IDLIGNEDEPART, IDLIGNEARRIVE, MONTANT, ETAT, IDLIGNEDEPARTLIB, IDLIGNEARRIVELIB, ETATLIB) AS 
  SELECT 
r.ID,r.IDLIGNEDEPART,r.IDLIGNEARRIVE,r.MONTANT,r.ETAT,
l.DESIGNATION||'	('||l.COMPTE||')' AS idlignedepartlib,
l2.DESIGNATION||'	('||l2.COMPTE||')' AS idlignearrivelib,
CASE 
	WHEN r.etat = 1 
	THEN 'CREE'
	WHEN r.etat = 11 
	THEN 'VISEE'
END AS etatlib
FROM reamenagement r
LEFT JOIN LIGNECREDITDEPENSE l ON l.id = r.idlignedepart
LEFT JOIN LIGNECREDITDEPENSE l2 ON l2.id = r.idlignearrive ;


CREATE OR REPLACE VIEW reamenagementlibcreer
AS 
SELECT 
r.*
FROM reamenagementlib r
WHERE r.etat = 1 ;


CREATE OR REPLACE VIEW reamenagementlibvise
AS 
SELECT 
r.*
FROM reamenagementlib r
WHERE r.etat = 11 ;



alter TABLE ENGAGEMENT ADD montantbudget number(30,2);
CREATE TABLE SITUATION_TEMP_table AS SELECT * FROM SITUATIONLCDEPENSEGRP_TEMP;

UPDATE
	ENGAGEMENT e
SET
	montantbudget = (
	SELECT
		d.montant		
	FROM
		SITUATION_TEMP_table d
		WHERE EXISTS (
    SELECT 1
    FROM LIGNECREDITDEPENSE l
    WHERE l.id = e.idlc
      AND d.annee = l.annee
      AND d.idcodeetablissement = l.CODEETABLISSEMENT
      AND d.idprojet = l.PROJET
)			)
WHERE annee>=2023				
;



-- SPAT_DEVELOP.ENGAGEMENTLIB_PDF source

CREATE OR REPLACE  VIEW ENGAGEMENTLIB_PDF (ID, DESIGNATION, CODEETABLISSEMENT, PROJET, MONTANT, DISPOAVANT, DISPOAPRES, ETAT, CODEETABLISSEMENTLIB, PROJETLIB, IDLC, IDLCLIB, DATY, AVECFACTURE, AVECFACTURELIB, MONTANTOP, DISPONIBLE, TIERS, TIERSLIB, NUM, OBSERVATION, ANNEE, DATEIMPRESSION, MONTANTRESTE, MONTANTLIBERER, COMPTE, CHANTIER, OBJET, DUREE, IDAVENANT, IDUSER, IDTYPE, IDTYPELIB, IDCONTRAT, DEVISE, MONTANTDEVISE, TAUX,montantbudget) AS 
  SELECT
    E.ID,
    E.DESIGNATION,
    NVL(E.CODEETABLISSEMENT, LP.CODEETABLISSEMENT)                                       AS CODEETABLISSEMENT,
    NVL(E.PROJET, LP.PROJET)                                                             AS PROJET,
    CAST(LEB.MONTANT AS NUMBER(30, 2)),
 --e.DISPONIBLE,
    CAST(E.DISPOAVANT AS NUMBER(30, 2)),
    CAST(E.DISPOAPRES AS NUMBER(30, 2)),
    E.ETAT,
    NVL(CE.VAL, CE1.VAL)                                                                 AS CODEETABLISSEMENTLIB,
    NVL(P.DESIGNATION, P1.DESIGNATION)                                                   AS PROJETLIB,
    E.IDLC,
    LP.DESIGNATION                                                                       AS IDLCLIB,
    CASE 
    	WHEN ab.DATY IS NOT NULL THEN ab.DATY 
    	WHEN b.DATY IS NOT NULL THEN b.daty
    	WHEN c.DATE_SIGNATURE  IS NOT NULL THEN c.DATE_SIGNATURE 
    	ELSE e.DATY 
    END AS DATY,
    E.AVECFACTURE,
    CASE
      WHEN E.AVECFACTURE = 0 THEN
        'NON'
      WHEN E.AVECFACTURE = 1 THEN
        'OUI'
    END AS         AVECFACTURELIB,
    CAST(NVL(GR.MONTANT, 0) AS NUMBER(30, 2))                                            AS MONTANTOP,
    CAST(E.MONTANT- NVL(ENG.MONTANTTAUX, 0)-NVL(LEB.MONTANTLIBERER, 0) AS NUMBER(30, 2)) AS DISPONIBLE,
    E.TIERS,
    T.NOM                                                                                AS TIERSLIB,
    E.NUM,
    E.OBSERVATION,
    E.ANNEE,
    E.DATY AS DATEIMPRESSION ,
    CAST(LEB.MONTANTRESTE AS NUMBER(30, 2)),
    CAST (NVL(LEB.MONTANTLIBERER, 0) AS NUMBER(30, 2))                                   AS MONTANTLIBERER,
    LC.COMPTE,
    E.CHANTIER,
    E.OBJET,
    E.DUREE,
    e.idavenant,
    	CASE 
	WHEN u.LOGINUSER IS NOT NULL THEN (u.LOGINUSER ||' - '||u.NOMUSER) 
	ELSE null
	END AS IDUSER ,
    e.idtype,
    typeen.val as idtypelib,
    e.IDCONTRAT ,
	de.val as devise,
	e.montantdevise,
	e.taux,
	e.montantbudget
  FROM
    ENGAGEMENT                  E
    JOIN LIAISONENGAGEMENT_RESTE LEB
    ON LEB.IDENGAGEMENT =E.ID LEFT JOIN CODEETABLISSEMENT CE
    ON CE.ID = E.CODEETABLISSEMENT
    LEFT JOIN PROJET P
    ON P.ID = E.PROJET
    LEFT JOIN LIGNECREDITDEPENSE LP
    ON E.IDLC = LP.ID
    LEFT JOIN CODEETABLISSEMENT CE1
    ON CE1.ID = LP.CODEETABLISSEMENT
    LEFT JOIN PROJET P1
    ON P1.ID = LP.PROJET
    LEFT JOIN ENGAGEMENTOPMONTANT GR
    ON GR.IDENGAGEMENT = E.ID
    LEFT JOIN FACTFOURN_ENGAGEMENT ENG
    ON ENG.IDENGAGEMENT = E.ID
 --LEFT JOIN LIBERER_MONTANT lib ON
 --	lib.IDENGAGEMENT = e.ID
    LEFT JOIN FOURNISSEUR_UNION_PERSONNEL T
    ON T.ID = E.TIERS
    LEFT JOIN LIGNECREDITDEPENSE LC
    ON E.IDLC = LC.ID
LEFT JOIN UTILISATEUR u ON u.REFUSER = e.IDUSER 
left join typeengagement typeen on e.idtype=typeen.id
LEFT JOIN BORDEREAUFF b ON b.IDENGAGEMENT = E.ID 
LEFT JOIN AS_BONDECOMMANDE ab ON ab.IDENGAGEMENT = E.id 
LEFT JOIN CONTRAT c ON c.ID = e.IDCONTRAT  
left join devise de on de.id=e.devise
;

-- SPAT_DEVELOP.ENGAGEMENTLIB source

CREATE OR REPLACE  VIEW ENGAGEMENTLIB (ID, DESIGNATION, CODEETABLISSEMENT, PROJET, MONTANT, DISPOAVANT, DISPOAPRES, ETAT, CODEETABLISSEMENTLIB, PROJETLIB, IDLC, IDLCLIB, DATY, AVECFACTURE, AVECFACTURELIB, MONTANTOP, DISPONIBLE, TIERS, TIERSLIB, NUM, OBSERVATION, ANNEE, DATEIMPRESSION, MONTANTRESTE, MONTANTLIBERER, COMPTE, CHANTIER, OBJET, DUREE, IDAVENANT, IDUSER, IDTYPE, IDTYPELIB, IDCONTRAT, DEVISE, TAUX, MONTANTDEVISE,montantbudget) AS 
  SELECT
    E.ID,
    E.DESIGNATION,
    NVL(E.CODEETABLISSEMENT, LP.CODEETABLISSEMENT)                                       AS CODEETABLISSEMENT,
    NVL(E.PROJET, LP.PROJET)                                                             AS PROJET,
    CAST(LEB.MONTANT AS NUMBER(30, 2)),
 --e.DISPONIBLE,
    CAST(E.DISPOAVANT AS NUMBER(30, 2)),
    CAST(E.DISPOAPRES AS NUMBER(30, 2)),
    E.ETAT,
    NVL(CE.VAL, CE1.VAL)                                                                 AS CODEETABLISSEMENTLIB,
    NVL(P.DESIGNATION, P1.DESIGNATION)                                                   AS PROJETLIB,
    E.IDLC,
    LP.DESIGNATION                                                                       AS IDLCLIB,
    E.DATY,
    E.AVECFACTURE,
    CASE
      WHEN E.AVECFACTURE = 0 THEN
        'NON'
      WHEN E.AVECFACTURE = 1 THEN
        'OUI'
    END AS         AVECFACTURELIB,
    CAST(NVL(GR.MONTANT, 0) AS NUMBER(30, 2))                                            AS MONTANTOP,
    CAST(E.MONTANT- NVL(ENG.MONTANTTAUX, 0)-NVL(LEB.MONTANTLIBERER, 0) AS NUMBER(30, 2)) AS DISPONIBLE,
    E.TIERS,
    T.NOM                                                                                AS TIERSLIB,
    E.NUM,
    E.OBSERVATION,
    E.ANNEE,
    E.DATEIMPRESSION,
    CAST(LEB.MONTANTRESTE AS NUMBER(30, 2)),
    CAST (NVL(LEB.MONTANTLIBERER, 0) AS NUMBER(30, 2))                                   AS MONTANTLIBERER,
    LC.COMPTE,
    E.CHANTIER,
    E.OBJET,
    E.DUREE,
    e.idavenant,
    	CASE 
	WHEN u.LOGINUSER IS NOT NULL THEN (u.LOGINUSER ||' - '||u.NOMUSER) 
	ELSE null
	END AS IDUSER ,
    e.idtype,
    typeen.val as idtypelib,
    e.IDCONTRAT ,
    e.devise,
    e.taux,
    e.montantdevise,
    e.montantbudget
  FROM
    ENGAGEMENT                  E
    JOIN LIAISONENGAGEMENT_RESTE LEB
    ON LEB.IDENGAGEMENT =E.ID LEFT JOIN CODEETABLISSEMENT CE
    ON CE.ID = E.CODEETABLISSEMENT
    LEFT JOIN PROJET P
    ON P.ID = E.PROJET
    LEFT JOIN LIGNECREDITDEPENSE LP
    ON E.IDLC = LP.ID
    LEFT JOIN CODEETABLISSEMENT CE1
    ON CE1.ID = LP.CODEETABLISSEMENT
    LEFT JOIN PROJET P1
    ON P1.ID = LP.PROJET
    LEFT JOIN ENGAGEMENTOPMONTANT GR
    ON GR.IDENGAGEMENT = E.ID
    LEFT JOIN FACTFOURN_ENGAGEMENT ENG
    ON ENG.IDENGAGEMENT = E.ID
 --LEFT JOIN LIBERER_MONTANT lib ON
 --	lib.IDENGAGEMENT = e.ID
    LEFT JOIN FOURNISSEUR_UNION_PERSONNEL T
    ON T.ID = E.TIERS
    LEFT JOIN LIGNECREDITDEPENSE LC
    ON E.IDLC = LC.ID
LEFT JOIN UTILISATEUR u ON u.REFUSER = e.IDUSER 
left join typeengagement typeen on e.idtype=typeen.id

;


-- SPAT_DEVELOP.SITUATIONLCDEPENSEGRP_TEMP source

CREATE OR REPLACE  VIEW SITUATIONLCDEPENSEGRP_TEMP (DIRECTION, PROJET, DIRECTIONPROJET, COMPTE, MONTANT, N_MONTANT, NON_MONTANT, NT_MONTANT, GR_MONTANT, BC_MONTANT, BP_MONTANT, ENGAGEER, FACTURE, PAYE, ARECOUVRIR, RESTEBUDGET, POURCENGAGE, POURCPAYE, RESTEAPRESENGMT, IDPROJET, IDCODEETABLISSEMENT, ANNEE) AS 
  SELECT
        L.DIRECTION,
        L.PROJET,
        L.DIRECTIONPROJET,
        L.COMPTEFULL                                                     AS COMPTE,
        CAST(SUM(L.MONTANT )AS NUMBER(30, 3))                            AS MONTANT,
        CAST(NVL(N.MONTANT, 0)AS NUMBER(30, 3))                          AS N_MONTANT,
        CAST(-1 * NVL(NON.MONTANT, 0) AS NUMBER(30, 3))                  AS NON_MONTANT,
        CAST(NVL(NT.MONTANT, 0)AS NUMBER(30, 3))                         AS NT_MONTANT,
        CAST(-1 * NVL(GR.MONTANT, 0) AS NUMBER(30, 3))                   AS GR_MONTANT,
        CAST(NVL(BC.MONTANT, 0)AS NUMBER(30, 3))                         AS BC_MONTANT,
        CAST(NVL(BP.MONTANT, 0)AS NUMBER(30, 3))                         AS BP_MONTANT,
 --cast(nvl(n.montant, 0) +
        CAST(NVL(NT.MONTANT, 0)AS NUMBER(30, 3)) /*- nvl(non.montant, 0)*/
 /*- nvl(gr.MONTANT, 0) + nvl(bc.montant, 0) + nvl(bp.montant, 0) as NUMBER(30, 3)) */ AS ENGAGEER,
        CAST(NVL(FD.FACTURE, 0) AS NUMBER(30, 3))                        AS FACTURE,
        CAST(NVL(FD.PAYE, 0) AS NUMBER(30, 3))                           AS PAYE,
        CAST(NVL(FD.FACTURE, 0) - NVL(FD.PAYE, 0) AS NUMBER(30, 3))      AS ARECOUVRIR,
        CAST(SUM(L.MONTANT) - NVL(FD.FACTURE, 0) AS NUMBER(30, 3))       AS RESTEBUDGET,
        CAST(NVL(FD.FACTURE, 0) / SUM(L.MONTANT) * 100 AS NUMBER(30, 3)) AS POURCENGAGE,
        CAST(NVL(FD.PAYE, 0) / SUM(L.MONTANT) * 100 AS NUMBER(30, 3))    AS POURCPAYE,
 /*cast(sum(l.montant) -
            (nvl(n.montant, 0) - nvl(non.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) + nvl(bc.montant, 0) +
             nvl(bp.montant, 0)) as NUMBER(30, 3))*/
        CAST((SUM(L.MONTANT) - NVL(NT.MONTANT, 0)) AS NUMBER(30, 3))     AS RESTEAPRESENGMT,
        L.IDPROJET,
        L.IDDIRECTION                                                    AS IDCODEETABLISSEMENT,
        L.ANNEE
    FROM
        SITUATIONLCDEPENSE_FULL L
        LEFT JOIN (
            SELECT
                CAST(NVL(SUM(MONTANT), 0) AS NUMBER(30, 3))     AS FACTURE,
                CAST(NVL(SUM(MONTANTPAYE), 0) AS NUMBER(30, 3)) AS PAYE,
                SUBSTR(MF.COMPTE, 1, 6)                         AS COMPTEFULL,
                MF.ANNEE
            FROM
                DETAILSFACTUREFOURNISSEUR_PAYE MF
            WHERE
                1 < 2
 --and (typeengagement != 'ED' or TYPEENGAGEMENT is null)
 --  and mf.daty >= '01/01/2022'
            GROUP BY
                SUBSTR(MF.COMPTE, 1, 6), MF.ANNEE
        ) FD
        ON L.COMPTEFULL = FD.COMPTEFULL
        AND L.ANNEE = FD.ANNEE
        LEFT JOIN (
            SELECT
                SUBSTR(COMPTE, 1, 6) AS COMPTE,
                SUM(MONTANT)         AS MONTANT,
                ANNEE
            FROM
                DETAILSFACTUREFOURNISSEUR_PAYE
            WHERE
                IDENGAGEMENT IS NULL
 --   and daty >= '01/01/2022'
            GROUP BY
                SUBSTR(COMPTE, 1, 6), ANNEE
        ) N
        ON N.COMPTE = L.COMPTEFULL
        AND N.ANNEE = L.ANNEE
        LEFT JOIN (
            SELECT
                SUM(MONTANT)              AS MONTANT,
                PROJET,
                CODEETABLISSEMENT,
                PROJETLIB,
                CODEETABLISSEMENTLIB,
                ANNEE,
                SUM(NVL(MONTANTRESTE, 0)) AS MONTANTRESTE
            FROM
                ENGAGEMENTLIBV EV
            WHERE
                1 < 2
 --    and ev.daty >= '01/01/2022'
            GROUP BY
                PROJET, CODEETABLISSEMENT, PROJETLIB, CODEETABLISSEMENTLIB, ANNEE
        ) NT
        ON NT.PROJET = L.IDPROJET
        AND NT.CODEETABLISSEMENT = L.IDDIRECTION
        AND NT.ANNEE = L.ANNEE
        LEFT JOIN (
            SELECT
                SUBSTR(COMPTE, 1, 6) AS COMPTE,
                SUM(MONTANT)         AS MONTANT,
                ANNEE
            FROM
                DETAILSFACTUREFOURNISSEUR_PAYE
            WHERE
                IDENGAGEMENT IS NOT NULL
 --and daty >= to_date('01/01/2023', 'dd/mm/yyyy')
            GROUP BY
                SUBSTR(COMPTE, 1, 6), ANNEE
        ) NON
        ON NON.COMPTE = L.COMPTEFULL
        AND NON.ANNEE = L.ANNEE
        LEFT JOIN (
            SELECT
 --en.ID,
                SUM(LI.MONTANT)   AS MONTANT
 --, DATY as DATYENGAGEMENT
,
                PROJET,
                CODEETABLISSEMENT,
                ANNEE
            FROM
                LIBERER    LI
                LEFT JOIN ENGAGEMENT EN
                ON EN.ID = LI.IDENGAGEMENT
            WHERE
                LI.ETAT >= 11
 -- and en.daty >= '01/01/2022'
            GROUP BY --en.ID,
 --, DATY
                PROJET, CODEETABLISSEMENT, ANNEE
        ) GR
        ON NT.PROJET = GR.PROJET
        AND NT.CODEETABLISSEMENT = GR.CODEETABLISSEMENT
        AND GR.ANNEE = L.ANNEE
        LEFT JOIN (
            SELECT
                COMPTEBDG,
                SUM(MONTANTNONFACTURE) AS MONTANT,
                ANNEE
            FROM
                SITUATION_BC_SANSENG BC
            WHERE
                1 < 2
 --  and bc.daty >= '01/01/2022'
            GROUP BY
                COMPTEBDG, ANNEE
        ) BC
        ON BC.COMPTEBDG = L.COMPTEFULL
        AND BC.ANNEE = L.ANNEE
        LEFT JOIN (
            SELECT
                SUM(MONTANTRESTE) AS MONTANT,
                COMPTEFULL        AS COMPTE,
                ANNEE
            FROM
                ETATBPVRAI BP
            WHERE
                1 < 2
 --  and bp.daty >= '01/01/2022'
            GROUP BY
                COMPTEFULL, ANNEE
        ) BP
        ON BP.COMPTE = L.COMPTEFULL
        AND BP.ANNEE = L.ANNEE
    WHERE
        1 < 2
    GROUP BY
        L.DIRECTION, L.PROJET, N.MONTANT, NON.MONTANT, NT.MONTANT, GR.MONTANT, FD.FACTURE, FD.PAYE, L.DIRECTION, L.PROJET, L.COMPTEFULL, L.IDPROJET, L.IDDIRECTION, BC.MONTANT, BP.MONTANT, L.IDPROJET, L.IDDIRECTION, L.ANNEE, L.DIRECTIONPROJET, NT.MONTANTRESTE;



