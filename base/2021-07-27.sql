CREATE OR REPLACE  VIEW SITUATIONLCDEPENSE
            (ID, DESIGNATION, COMPTE, ANNEE, MONTANT, ETAT, FACTURE, PAYE) AS
SELECT l.id          AS                                id,
       l.DESIGNATION AS                                designation,
       l.COMPTE      AS                                compte,
       l.ANNEE       AS                                annee,
       l.MONTANT     AS                                montant,
       l.etat,
       CAST(NVL(SUM(nvl(pu, 0) * l.QUANTITE * tva), 0) AS NUMBER(30, 3))
                     AS                                facture,
       CAST(NVL(SUM(montantpaye), 0) AS NUMBER(30, 2)) paye
FROM LIGNECREDITDEPENSE l
         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf
                   ON SUBSTR(mf.COMPTE, 0, LENGTH(l.COMPTE)) LIKE l.COMPTE
                       AND EXTRACT(YEAR FROM daty) = l.ANNEE
GROUP BY l.id,
         l.DESIGNATION,
         l.COMPTE,
         l.ANNEE,
         l.MONTANT, l.etat;


create or replace view FACTURE_CLIENT_FILLE_LIB_RESTE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, TVA, IDACTIVITE, ACTIVITELIB, MOIS,
             ANNEE, HEUREDEBUT, HEUREFIN, MOISLIB,tauxEuro,montantHTEuro,montantTVAEuro)
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
       mois.VAL as moislib,
       cast(0 as NUMBER(32,2)) as tauxEuro,
       cast(0 as NUMBER(32,2)) as montantHTEuro ,
       cast(0 as NUMBER(32,2)) as montantTVAEuro
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         left join ACTIVITE ra on ra.id = fc.IDACTIVITE
        left join mois on mois.id=fc.mois;
		
create view coursdevise_max_pardaty as
select *
from COURSDEVISE c
where DATY >= (select max(daty) from COURSDEVISE cd where c.IDDEVISe = cd.IDDEVISE);

create view courseuro_ariary as
select IDDEVISE,
       MONTANT,
       case when c.IDDEVISE='Ar' then
           (select round(1/montant,5) from COURSDEVISE_MAX_PARDATY d where d.IDDEVISE='Eur')
       else (select montant from COURSDEVISE_MAX_PARDATY d where d.IDDEVISE='Eur') end as montantEuro
from COURSDEVISE_MAX_PARDATY c;

create view FACTURE_CLIENT_MF_EURO as
select mf.*,
       case
           when DEVISE = 'Eur' then cast(nvl(cd.MONTANT, 0) as NUMBER(32, 2))
           else
               nvl((select nvl(c.MONTANT, 0) from COURSDEVISE c where c.IDDEVISE = 'Eur' and c.DATY >= mf.DATY), 0) end
           as tauxEuro
from FACTURE_CLIENT_MERE_FILLE mf
         left join COURSDEVISE cd on cd.IDDEVISE = mf.DEVISE and cd.DATY >= mf.DATY;
		 
CREATE TABLE CATEGORIEFC
(
    ID         VARCHAR2(100)
        CONSTRAINT PK_CATEGORIEFC PRIMARY KEY,
    VAL        VARCHAR2(150),
    DESCE VARCHAR2(150)
);

INSERT INTO CATEGORIEFC
VALUES ('CATFCO1', 'proforma', 'proforma');
INSERT INTO CATEGORIEFC
VALUES ('CATFCO2', 'provision', 'provision');
INSERT INTO CATEGORIEFC
VALUES ('CATFCO3', 'definitive', 'definitive');


ALTER TABLE FACTURECLIENT  ADD idcategorie VARCHAR2(100) CONSTRAINT FK_CATEGORIEFC REFERENCES CATEGORIEFC;
ALTER TABLE FACTURECLIENT ADD idprovision VARCHAR2(100) CONSTRAINT FK_PROVISION REFERENCES FACTURECLIENT;


create OR REPLACE view FACTURECLIENTMSUM as
SELECT fc.ID,
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 2)) AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 2))  AS montanttva,
       NVL(grp.montantavoiravectaux, 0)               AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 2))
                                                      AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL as typelib,
       fc.IDCATEGORIE,
       catfc.VAL AS CATEGORIELIB
FROM FACTURECLIENT fc
         LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id
         left join PREVISION pr on pr.id = fc.IDPREVISION
         left join TYPEFC tfc on tfc.ID=fc.TYPE
        left join CATEGORIEFC catfc on catfc.ID = fc.IDCATEGORIE
/

create OR REPLACE view FACTURECLIENTMSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB)
as
SELECT m.ID,
       m.DATY,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       '--' || m.remarque                        AS remarque,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.idprevision,
       CAST(m.MONTANT AS NUMBER(32, 2)),
       CAST(M.MONTANTTVA AS NUMBER(32, 2)),
       CAST(M.MONTANTAVOIR AS NUMBER(32, 2)),
       CAST(M.MONTANTTTC AS NUMBER(32, 2)),
       CAST(NVL(jc.montant, 0) AS NUMBER(32, 2)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(jc.montant, 0) AS NUMBER(32, 2))
                                                 AS montantreste,
       fup.NOM                                   AS tierslib,
       fup.CONTACT,
       fup.ADRESSE,
       M.ESCALE,TYPELIB,
       m.IDCATEGORIE,
       m.CATEGORIELIB

FROM factureclientMSum m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN JOURNALCAISSELIB_VISE_SUM jc ON jc.IDPLACEMENT = m.id
/

                                                                    create OR REPLACE view FACTURE_CLIENT_UNION
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB)
as
select ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       cast(TVA as NUMBER(20, 2)) as tva,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       cast(ETAT as NUMBER(10))   as etat,
       cast(MONTANT as NUMBER(32, 2)),
       cast(MONTANTTVA as number(32, 2)),
       cast(MONTANTAVOIR as number(32, 2)),
       cast(MONTANTTTC as NUMBER(32, 2)),
       cast(MONTANTPAYE as NUMBER(32, 2)),
       cast(MONTANTRESTE as NUMBER(32, 2)),
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       CASE WHEN ETAT=1 THEN 'CREE(E)'
            WHEN ETAT=11 THEN  'VISE(E)' END AS ETATLIB,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB
from (
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                cast(TVA as NUMBER(20, 2))          as TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                cast(ETAT as number(10))            as etat,
                cast(MONTANT as NUMBER(32, 2))      as MONTANT,
                cast(MONTANTTVA as NUMBER(32, 2))   as MONTANTTVA,
                cast(MONTANTAVOIR as NUMBER(32, 2)) as MONTANTAVOIR,
                cast(MONTANTTTC as NUMBER(32, 2))   as MONTANTTTC,
                cast(MONTANTPAYE as NUMBER(32, 2))  as MONTANTPAYE,
                cast(MONTANTRESTE as NUMBER(32, 2)) as MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                IDPREVISION,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB
         from FACTURECLIENTMSUM_LIB
         union all
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                cast(TVA as NUMBER(20, 2))          as TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                cast(ETAT as NUMBER(10))            as etat,
                cast(MONTANT as NUMBER(32, 2))      as MONTANT,
                cast(MONTANTTVA as NUMBER(32, 2))   as MONTANTTVA,
                cast(MONTANTAVOIR as NUMBER(32, 2)) as MONTANTAVOIR,
                cast(MONTANTTTC as NUMBER(32, 2))   as MONTANTTTC,
                cast(MONTANTPAYE as NUMBER(32, 2))  as MONTANTPAYE,
                cast(MONTANTRESTE as NUMBER(32, 2)) as MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                '-' as PREVISION,
                '-' as ESCALE,
                TYPE as typelib,
                '-' as IDCATEGORIE,
                '-' as CATEGORIELIB
         from analyseglobaleantsika);
		 
create OR REPLACE view FACTURECLIENTMSUM as
SELECT fc.ID,
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 2)) AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 2))  AS montanttva,
       NVL(grp.montantavoiravectaux, 0)               AS montantavoir,
       CAST(
                   NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 2))
                                                      AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL as typelib,
       fc.IDCATEGORIE,
       catfc.VAL AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION as IDPROVISIONlib
FROM FACTURECLIENT fc
         LEFT JOIN facture_client_grp grp ON grp.idmere = fc.id
         left join PREVISION pr on pr.id = fc.IDPREVISION
         left join TYPEFC tfc on tfc.ID=fc.TYPE
        left join CATEGORIEFC catfc on catfc.ID = fc.IDCATEGORIE
        left join factureclient fcf on fcf.IDPROVISION=fc.IDPROVISION;
		


create OR REPLACE view FACTURECLIENTMSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT,
             MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE,
             TYPELIB, IDCATEGORIE, CATEGORIELIB,IDPROVISION,IDPROVISIONLIB)
as
SELECT m.ID,
       m.DATY,
       m.TIERS,
       m.DESIGNATION,
       m.TYPE,
       m.TVA,
       '--' || m.remarque                        AS remarque,
       m.IDUSER,
       m.DATE_ECHEANCE,
       m.ETAT,
       m.idprevision,
       CAST(m.MONTANT AS NUMBER(32, 2)),
       CAST(M.MONTANTTVA AS NUMBER(32, 2)),
       CAST(M.MONTANTAVOIR AS NUMBER(32, 2)),
       CAST(M.MONTANTTTC AS NUMBER(32, 2)),
       CAST(NVL(jc.montant, 0) AS NUMBER(32, 2)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(jc.montant, 0) AS NUMBER(32, 2))
                                                 AS montantreste,
       fup.NOM                                   AS tierslib,
       fup.CONTACT,
       fup.ADRESSE,
       M.ESCALE,TYPELIB,
       m.IDCATEGORIE,
       m.CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB

FROM factureclientMSum m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN JOURNALCAISSELIB_VISE_SUM jc ON jc.IDPLACEMENT = m.id;
		 
create OR REPLACE view FACTURE_CLIENT_UNION
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, IDPREVISION, ESCALE,
             ETATLIB, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION,IDPROVISIONLIB)
as
select ID,
       DATY,
       TIERS,
       DESIGNATION,
       TYPE,
       cast(TVA as NUMBER(20, 2))            as tva,
       REMARQUE,
       IDUSER,
       DATE_ECHEANCE,
       cast(ETAT as NUMBER(10))              as etat,
       cast(MONTANT as NUMBER(32, 2)),
       cast(MONTANTTVA as number(32, 2)),
       cast(MONTANTAVOIR as number(32, 2)),
       cast(MONTANTTTC as NUMBER(32, 2)),
       cast(MONTANTPAYE as NUMBER(32, 2)),
       cast(MONTANTRESTE as NUMBER(32, 2)),
       TIERSLIB,
       CONTACT,
       ADRESSE,
       IDPREVISION,
       ESCALE,
       CASE
           WHEN ETAT = 1 THEN 'CREE(E)'
           WHEN ETAT = 11 THEN 'VISE(E)' END AS ETATLIB,
       TYPELIB,
       IDCATEGORIE,
       CATEGORIELIB,
       IDPROVISION,
       IDPROVISIONLIB
from (
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                cast(TVA as NUMBER(20, 2))          as TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                cast(ETAT as number(10))            as etat,
                cast(MONTANT as NUMBER(32, 2))      as MONTANT,
                cast(MONTANTTVA as NUMBER(32, 2))   as MONTANTTVA,
                cast(MONTANTAVOIR as NUMBER(32, 2)) as MONTANTAVOIR,
                cast(MONTANTTTC as NUMBER(32, 2))   as MONTANTTTC,
                cast(MONTANTPAYE as NUMBER(32, 2))  as MONTANTPAYE,
                cast(MONTANTRESTE as NUMBER(32, 2)) as MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                IDPREVISION,
                ESCALE,
                TYPELIB,
                IDCATEGORIE,
                CATEGORIELIB,
                IDPROVISION,
                IDPROVISIONLIB
         from FACTURECLIENTMSUM_LIB
         union all
         select ID,
                DATY,
                TIERS,
                DESIGNATION,
                TYPE,
                cast(TVA as NUMBER(20, 2))          as TVA,
                REMARQUE,
                IDUSER,
                DATE_ECHEANCE,
                cast(ETAT as NUMBER(10))            as etat,
                cast(MONTANT as NUMBER(32, 2))      as MONTANT,
                cast(MONTANTTVA as NUMBER(32, 2))   as MONTANTTVA,
                cast(MONTANTAVOIR as NUMBER(32, 2)) as MONTANTAVOIR,
                cast(MONTANTTTC as NUMBER(32, 2))   as MONTANTTTC,
                cast(MONTANTPAYE as NUMBER(32, 2))  as MONTANTPAYE,
                cast(MONTANTRESTE as NUMBER(32, 2)) as MONTANTRESTE,
                TIERSLIB,
                CONTACT,
                ADRESSE,
                '-'                                 as PREVISION,
                '-'                                 as ESCALE,
                TYPE                                as typelib,
                '-'                                 as IDCATEGORIE,
                '-'                                 as CATEGORIELIB,
                '-'                                 as  IDPROVISION,

                '-'                                 as IDPROVISIONLIB
         from analyseglobaleantsika);
		 
create view  ProvisionFactureDefinitive as
select *
from facture_client_union
where idcategorie = 'CATFCO2'
  and id in (select idProvision from factureclient where etat >= 11)
  and etat >= 11;
  
  
create view ProvisionNonFacturee as
select *
from facture_client_union
where IDCATEGORIE = 'CATFCO2'
  and id not in (select id from ProvisionFactureDefinitive);

  
create view ProvisionViseeNonFacturee as
select * from ProvisionNonFacturee where etat>=11;


create view factureClientValide as
select * from facture_client_union where id not in (select id from ProvisionFactureDefinitive);

create view etatProvision as
select fac.id,
       fac.MONTANTTTC as montantfacture,
       fu.MONTANTTTC as montantprovision,
       fac.MONTANTTTC-fu.MONTANTTTC as ecart
from FACTURE_CLIENT_UNION fac
    join  FACTURE_CLIENT_UNION fu on fu.id=fac.IDPROVISION;
	
	
	CREATE TABLE EDITIONMICTSLVIDE(
    ID VARCHAR2(100) CONSTRAINT PK_EDITIONMICTSLVIDE PRIMARY KEY ,
    DATY DATE,
    TYPE VARCHAR2(500),
    NOTEEXPLICATIVE VARCHAR2(500),
    MOIS NUMBER(10),
    ANNEE NUMBER(10)
);

CREATE SEQUENCE seq_editionmictslvide
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION GETseq_editionmictslvide
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_editionmictslvide.nextval INTO retour FROM dual;
  return retour;
END;


create or replace view facture_client_montanttc as
select fc.*,
       cast((fc.PU * fc.QUANTITE * fc.TVA) / 100 as NUMBER(20,2)) as montanttva,
       cast((fc.PU * fc.QUANTITE) + (fc.PU * fc.QUANTITE * fc.TVA) / 100 as NUMBER(20,2))as montanttc
from facture_client_montant fc;



create or replace view SITUATIONLCRECETTE as
SELECT l.id AS id,
            l.DESIGNATION AS designation,
            l.COMPTE AS compte,
            l.ANNEE AS annee,
            l.MONTANT AS montant,
            l.etat,
            CAST (SUM (mf.QUANTITE * mf.pu * mf.TAUX) AS NUMBER (30, 3))
               AS facture,
            CAST (SUM (montantpaye) AS NUMBER (30, 3)) paye
       FROM LIGNECREDITRECETTE l
            LEFT JOIN FACTURE_CLIENT_MEREF_paye mf
               ON     SUBSTR (mf.COMPTE, 0, LENGTH (l.COMPTE)) LIKE l.COMPTE
                  AND EXTRACT (YEAR FROM DATY) = l.ANNEE and mf.IDMERE not in
                                                             (select id from  ProvisionFactureDefinitive)
   GROUP BY l.id,
            l.DESIGNATION,
            l.COMPTE,
            l.ANNEE,
            l.MONTANT, l.etat;