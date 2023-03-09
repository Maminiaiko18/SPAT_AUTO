CREATE VIEW FACTFOURN_MSUM_LIB_MODIF_ORDRE AS
  SELECT m.ID,
       m.DATY,
	   m.DATEREGUL,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       '--' || m.remarque AS remarque,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.idprevision,
       CAST(m.MONTANT AS NUMBER(32, 2)) as MONTANT ,
       CAST(M.MONTANTTVA AS NUMBER(32, 2)) as MONTANTTVA,
       CAST(M.MONTANTAVOIR AS NUMBER(32, 2))as MONTANTAVOIR,
       CAST(M.MONTANTTTC AS NUMBER(32, 2))as MONTANTTTC,
       CAST(NVL(pf.montant, 0) AS NUMBER(32, 2)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(pf.montant, 0) AS NUMBER(32, 2)) AS montantreste,
       fup.NOM  AS tierslib,
       fup.CONTACT,
       fup.ADRESSE,
       M.ESCALE,
       TYPELIB,
       m.IDCATEGORIE,
       m.CATEGORIELIB,
       m.IDPROVISION,
       m.IDPROVISIONLIB,
       m.ESTDDPMICTSL,
       m.devisemere,
       m.codePrestation,
       m.codePrestationlib,
       m.CODE,
       m.ESTMICTSL,
       codeprovision,
       case
           when m.etat = 1 then 'CREE'
           when m.etat >= 11 then 'VISE'
           else '' end                           as etatlib,
       cast(MONTANTTTCVRAI as number(32,2)) as MONTANTTTCVRAI,
       m.IDBL,
       m.CODE_ETABLISSEMENT,
       m.CODE_ETABLISSEMENTLIB,
       m.NUMEROOP,
       m.PROJET,
       m.PROJETLIB,
       m.NUMFACT,
       m.NATURE,
       m.naturelib,
       m.IDBC,
       m.exercice,
       IDENGAGEMENT,
       idengagementlib ,
       cast(m.MONTANTHTSANSREMISE AS NUMBER(30,2)) AS MONTANTHTSANSREMISE
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id;
		 
		 INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN000001211', 'Etat recette', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=treso/journalcaisserecette-liste.jsp', 6, 5, 'MEN0031');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN000001212', 'Etat dépense', 'fa fa-list', '/spat/pages/globalnegoce.jsp?but=treso/journalcaissedepense-liste.jsp.jsp', 7, 5, 'MEN0031');