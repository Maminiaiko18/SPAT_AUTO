
create or replace view provisionEcart as
select tp.*,
       cast(montantTTC - montantPaye as number(30,3)) as ecart
from tousProvision tp;

create view paiementfacturesum as
select sum(montant) as montant,idfact from paiementfacture group by idfact;

CREATE OR REPLACE FORCE VIEW FACTURECLIENTMSUM_LIB
(
   ID,
   DATY,
   TIERS,
   DESIGNATION,
   TYPE,
   TVA,
   REMARQUE,
   IDUSER,
   DATE_ECHEANCE,
   ETAT,
   IDPREVISION,
   MONTANT,
   MONTANTTVA,
   MONTANTAVOIR,
   MONTANTTTC,
   MONTANTPAYE,
   MONTANTRESTE,
   TIERSLIB,
   CONTACT,
   ADRESSE,
   ESCALE,
   TYPELIB,
   IDCATEGORIE,
   CATEGORIELIB,
   IDPROVISION,
   IDPROVISIONLIB,
   ESTDDPMICTSL,
   DEVISEMERE,
   CODEPRESTATION,
   CODEPRESTATIONLIB,
   CODE,
   ESTMICTSL,
   CODEPROVISION
)
AS
   SELECT m.ID,
          m.DATY,
          m.TIERS,
          m.DESIGNATION,
          m.TYPE,
          m.TVA,
          '--' || m.remarque AS remarque,
          m.IDUSER,
          m.DATE_ECHEANCE,
          m.ETAT,
          m.idprevision,
          CAST (m.MONTANT AS NUMBER (32, 3)),
          CAST (M.MONTANTTVA AS NUMBER (32, 3)),
          CAST (M.MONTANTAVOIR AS NUMBER (32, 3)),
          CAST (M.MONTANTTTC AS NUMBER (32, 3)),
          CAST (NVL (pf.montant, 0) AS NUMBER (32, 3)) AS montantpaye,
          CAST (M.MONTANTTTC - NVL (pf.montant, 0) AS NUMBER (32, 3))
             AS montantreste,
          fup.NOM AS tierslib,
          fup.CONTACT,
          fup.ADRESSE,
          M.ESCALE,
          TYPELIB,
          m.IDCATEGORIE,
          m.CATEGORIELIB,
          IDPROVISION,
          IDPROVISIONLIB,
          m.ESTDDPMICTSL,
          m.devisemere,
          m.codePrestation,
          m.codePrestationlib,
          m.CODE,
          m.ESTMICTSL,
          codeprovision
     FROM factureclientMSum m
          LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
          LEFT JOIN paiementfacturesum pf ON pf.idfact = m.id;
	
	
CREATE OR REPLACE FORCE VIEW NUMEROAVOIRFC
(
   ID,
   VAL,
   DESCE
)
AS
   SELECT CAST ('-' AS VARCHAR2 (100)) AS id,
          CAST (
             NVL (CAST (MAX (maxidparmoisane) + 1 AS NUMBER (10)), 1) AS VARCHAR2 (500))
             AS val,
          CAST ('-' AS VARCHAR2 (10)) AS desce
     FROM AVOIRFC_SEQUENCE;		
CREATE OR REPLACE FORCE VIEW AVOIRFC_SEQUENCE
(
   ID,
   DATY,
   DESIGNATION,
   ETAT,
   CODE,
   DATEMOISSEQ,
   DATEMOIS,
   MAXIDPARMOISANE
)
AS
   SELECT fc.ID,
          DATY,
          DESIGNATION,
          ETAT,
          CODE,
             SUBSTR ( (CODE), 2, 2)
          || '/'
          || SUBSTR ( (CODE), 4, 2)
          || '/01/'
          || SUBSTR ( (CODE), LENGTH ( (CODE)) - 5, 6)
             AS datemoisseq,
          CAST (
             '01/' || SUBSTR ( (CODE), 4, 2) || '/' || SUBSTR ( (CODE), 2, 2) AS VARCHAR2 (100))
             AS datemois,
          SUBSTR ( (CODE), LENGTH ( (CODE)) - 2, 6) AS maxidparmoisane
     FROM AVOIRFC fc;	 