Insert into CONFIGURATION
   (ID, VALMIN, VALMAX, DESCE, TYPECONFIG)
 Values
   ('CONFEVP', '16', '16', 'Prix EVP', 'Fact');
COMMIT;

CREATE OR REPLACE FORCE VIEW FACTURE_CLIENT_MERE_FILLE
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   DATY,
   TIERS,
   DESIGNATIONMERE,
   TYPE,
   TVA,
   REMARQUE,
   IDUSER,
   DATE_ECHEANCE,
   ETAT
)
AS
   SELECT fi."ID",
          fi."IDMERE",
          fi."DESIGNATION",
          fi."QUANTITE",
          fi."PU",
          fi."COMPTE",
          fi."IDPRODUIT",
          fi."DEVISE",
          fi."TAUX",
          fc.daty,
          fc.tiers,
          fc.designation AS designationmere,
          fc.TYPE,
          decode (fi.tva,null,fc.tva, fi.tva),
          fc.remarque,
          fc.iduser,
          fc.date_echeance,
          fc.etat
     FROM facture_client_fille fi
          LEFT JOIN FACTURECLIENT fc ON fi.idmere = fc.id;
		  
CREATE OR REPLACE FORCE VIEW FACTURE_CLIENT_FILLE_LIB_RESTE
(
   ID,
   IDMERE,
   DESIGNATION,
   QUANTITE,
   PU,
   COMPTE,
   IDPRODUIT,
   DEVISE,
   TAUX,
   QTELIVREE,
   RESTEALIVRER,
   MONTANTTAUX,
   MONTANT,
   MONTANTAVOIRSANSTAUX,
   MONTANTAVOIRAVECTAUX,
   TVA
)
AS
   SELECT fc.ID,
          fc.IDMERE,
          fc.DESIGNATION,
          fc.QUANTITE,
          fc.PU,
          fc.COMPTE,
          pr.NOM AS IDPRODUIT,
          fc.DEVISE,
          fc.TAUX,
          CAST (NVL (gr.QUANTITE, 0) AS NUMBER (10, 2)) AS qteLivree,
          CAST (fc.QUANTITE - NVL (gr.QUANTITE, 0) AS NUMBER (10, 2))
             AS resteAlivrer,
          CAST (fcm.MONTANTTAUX AS NUMBER (32, 2)),
          CAST (fcm.MONTANT AS NUMBER (32, 5)),
          CAST (fcm.MONTANTAVOIRSANSTAUX AS NUMBER (32, 2)),
          CAST (fcm.MONTANTAVOIRAVECTAUX AS NUMBER (32, 2)),
          CAST (fcm.tva AS NUMBER (20, 2))
     FROM facture_client_fille fc
          LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
          LEFT JOIN as_bondelivraison_cl_grp gr
             ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
          LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id;

CREATE OR REPLACE FORCE VIEW ANALYSEGLOBALEFACTURE_VAOVAO
(
   NMFACT,
   DATY,
   CATEGORIE_FACTURE,
   SOUS_CATEGORIE_FACTURE,
   CLIENT,
   CATEGORIE_CLIENT,
   DESIGNATION,
   MTTC,
   MTHT,
   TAXE,
   DEVFACT,
   MTDEVISE,
   MTAVOIR,
   PAYE,
   RESTE,
   NUMCOMPTE,
   VALCAT
)
AS
   SELECT fc.id,
          fc.daty,
          cat.ID,
          '-',
          fc.tiers,
          cl.categorie,
          fc.designation,
          fc.montantttc,
          fc.montant,
          fc.montanttva,
          '-',
          fc.montantttc,
          fc.montantavoir,
          0,
          0,
          '-',
          cat.val
     FROM factureclientmsum_lib fc
          LEFT JOIN FACTURE_CLIENT_FILLE ff ON fc.id = FF.IDMERE
          LEFT JOIN ACTIVITE act ON ff.IDACTIVITE = act.ID
          LEFT JOIN RUBRIQUE_ACTIVITE rub ON act.RUBRIQUE = rub.ID
          LEFT JOIN CATEGORIEFACTURATION cat ON rub.CATEGORIE = cat.ID
          LEFT JOIN V_client_categorie cl ON fc.tiers = CL.CDCLT;
		  


INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN00741003', 'Analyse', 'fa fa-area-chart', '/spat/pages/globalnegoce.jsp?but=exploitants/activites-analyse.jsp', 3, 3, 'MEN0074100');




Insert into DETFORMUFACT
   (ID, MIN, MAX, FORMULE, MERE, 
    FORMULEQTE)
 Values
   ('d1', 0, 2, '[pu]', 'rub1', 
    'Math.min([qte],2)');
Insert into DETFORMUFACT
   (ID, MIN, MAX, FORMULE, MERE, 
    FORMULEQTE)
 Values
   ('d2', 2, 4, '[pu]*1.05', 'rub1', 
    'Math.max(Math.min([qte]-2,4),0)');
Insert into DETFORMUFACT
   (ID, MIN, MAX, FORMULE, MERE, 
    FORMULEQTE)
 Values
   ('d3', 4, -1, '[pu]*1.1', 'rub1', 
    'Math.max([qte]-6,0)');
COMMIT;

alter table  tiers add compteAuxFournisseur varchar2(500);
alter table  tiers add compteAuxClient varchar2(500);


CREATE OR REPLACE VIEW UNION_TIERS_TBD_CEMEDI
            (ID, NOM, DESCRIPTION, NIF, STAT, CONTACT, RESPONSABLE, ADRESSE, TYPE, ETAT,COMPTEAUXCLIENT,COMPTEAUXFOURNISSEUR) AS
select ID,
       NOM,
       DESCRIPTION,
       NIF,
       STAT,
       CONTACT,
       RESPONSABLE,
       ADRESSE,
       TYPE,
       ETAT,
       COMPTEAUXCLIENT,
       COMPTEAUXFOURNISSEUR
from tiers
union
select id,
       raisonsocial as nom,
       ''           as description,
       nif,
       stat,
       ''           as contact,
       ''           as responsable,
       adresse,
       typetiers    as type,
       etat,
       cast('-' as VARCHAR2(100)) as COMPTEAUXCLIENT,
       cast('-' as VARCHAR2(100)) as COMPTEAUXFOURNISSEUR
from tiers_cemedi ;


  CREATE OR REPLACE VIEW FACTURECLIENTMSUM_LIB
      (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, montantpaye ,montantreste,TIERSLIB, CONTACT, ADRESSE) AS
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
         cast(m.MONTANT as NUMBER(32,2)),
         cast(M.MONTANTTVA as NUMBER(32,2)),
         cast(M.MONTANTAVOIR as NUMBER(32,2)),
         cast(M.MONTANTTTC as number(32,2)),
         cast(nvl(jc.DEBIT, 0) as number(32,2)) as montantpaye,
         cast(M.MONTANTTTC - nvl(jc.DEBIT, 0) as NUMBER(32,2))as montantreste ,
       fup.NOM as tierslib,
       fup.CONTACT,
       fup.ADRESSE
from factureclientMSum m
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = m.tiers
         left join JOURNALCAISSELIB_VISE jc on jc.IDPLACEMENT=m.id;
		 

create or replace view TIERS_PRESTATAIRE as
select *
from tiers
where TYPE like 'prestataire'
/


create or replace view FOURNISSEUR_UNION_PERSONNEL as
SELECT tp.ID,
       tp.NOM,
       tp.DESCRIPTION,
       tp.NIF,
       tp.STAT,
       tp.CONTACT,
       tp.RESPONSABLE,
       tp.ADRESSE,
       tp.TYPE,
       tp.ETAT,
       tp.COMPTEAUXFOURNISSEUR,
       tp.COMPTEAUXCLIENT
FROM TIERS_PRESTATAIRE tp
UNION
SELECT an.SA_COMPTEURNUMERO       AS ID,
       an.NOM || ' ' || an.PRENOM AS nom,
       ''                         AS DESCRIPTION,
       ''                         AS NIF,
       ''                         AS STAT,
       an.TELEPHONE               AS CONTACT,
       ''                         AS RESPONSABLE,
       an.RUE1                    AS ADRESSE,
       an.TYPE,
       11                         AS etat,
       '' as COMPTEAUXFOURNISSEUR,
       '' as COMPTEAUXCLIENT
FROM ANALYSEPERSONNELUNION an
union
select cl.cdclt    as ID,
       cl.nomclt   as nom,
       ''          AS DESCRIPTION,
       cl.nif      AS NIF,
       cl.nmsttclt AS STAT,
       cl.telclt   AS CONTACT,
       ''          AS RESPONSABLE,
       cl.adrclt   AS ADRESSE,
       cl.cdcat    as TYPE,
       11          AS etat,
       '' as COMPTEAUXFOURNISSEUR,
       '' as COMPTEAUXCLIENT
from V_CLIENT_CATEGORIE cl
/

create view union_client_fournisseur
as select *from UNION_TIERS_TBD_CEMEDI
union
select *from fournisseur_union_personnel;

create table transitionPaiementVide
(
    id varchar2(500)constraint transitionPaiementVide_pk primary key ,
    caisse varchar2(500)constraint caisse_transitionpaiement_fk references CAISSE,
    modepaiement varchar2(500)constraint mode_transitionpaiement_fk references  modepaiement,
    numcheque varchar2(500) ,
    typeCheque varchar2(500) constraint fk_deroulante_type references TYPECHEQUE,
    iddevise varchar2(500) constraint fk_devise_transition references DEVISE
);


CREATE SEQUENCE seqtransitionPaiementVide
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

create or replace FUNCTION get_seqtransitionPaiementVide
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqtransitionPaiementVide.nextval INTO retour FROM dual;
  return retour;
END;
>>>>>>> Stashed changes
