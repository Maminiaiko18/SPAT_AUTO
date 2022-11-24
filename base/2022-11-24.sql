ALTER TABLE ENGAGEMENT 
DROP CONSTRAINT ENGAGEMET_TIERSFK;


CREATE VIEW   etatjournalcaisselibrecette AS
select * from journalcaisselibrecette where idcaisse in ('CAI0000000010174129', 'CAIS000014', 'CAIS000015');


CREATE VIEW etatjournalcaisselibdepense as
select * from journalcaisselibdepense where idcaisse in ('CAIS000016', 'CAI0000000015200311');

UPDATE MENUDYNAMIQUE SET href='/spat/pages/globalnegoce.jsp?but=treso/journalcaissedepense-liste.jsp' WHERE id='MEN000001212';

CREATE OR REPLACE VIEW SEQJOURNALVAOVAODEP (DATEEFFET, NUMPIECE, MOIS, ANNEE, TYPE, MODEPAIEMENT, MAXIDPARMOISANE) AS 
  SELECT 
    dateeffet, 
    numpiece,
    CAST(extract(MONTH from dateeffet) AS int) AS mois, 
    CAST(extract(YEAR from dateeffet)AS int) AS annee, 
    IDTYPECHEQUE AS type, 
    IDMODE AS modepaiement,
    CAST(substr(NUMPIECE, length(NUMPIECE) - 5, 6) AS int) as maxidparmoisane
FROM journalcaisse WHERE etat>=11 AND numpiece IS NOT NULL AND debit>0;


CREATE OR REPLACE  VIEW FACTURECLIENTAPAYER  AS 
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
       CAST(fc.MONTANT AS NUMBER(35, 3))        AS MONTANT,
       CAST(fc.MONTANTTVA AS NUMBER(35, 3))     AS MONTANTTVA,
       CAST(fc.MONTANTAVOIR AS NUMBER(35, 3))   AS MONTANTAVOIR,
       CAST(fc.MONTANTTTC AS NUMBER(35, 3))     AS MONTANTTTC,
       CAST(fc.MONTANTPAYE AS NUMBER(35, 3))    AS MONTANTPAYE,
       CAST(fc.MONTANTRESTE AS NUMBER(35, 3))   AS MONTANTRESTE,
       fc.TIERSLIB,
       fc.CONTACT,
       fc.ADRESSE,
       fc.IDPREVISION,
       fc.ESCALE,
       fc.ETATLIB,
       fc.TYPELIB,
       fc.IDCATEGORIE,
       fc.CATEGORIELIB,
       fc.IDPROVISION,
       fc.IDPROVISIONLIB,
       fc.DEVISEMERE,
       fc.CODEPRESTATION,
       fc.CODEPRESTATIONLIB,
       fc.CODE,
       fc.ESTMICTSL,
       fc.CODEPROVISION,
       CAST(fc.MONTANTTTCVRAI AS NUMBER(35, 3)) AS MONTANTTTCVRAI,
       fc.ARMATEURLIB,
       fc.EXERCICE ,
       fc.code as codeFiltre,
       CASE
		   WHEN p.code IS NOT null THEN p.code||';' 
		   ELSE NULL
	   END AS numpiece
from facture_client_union fc
LEFT JOIN PAIEMENTFACTURELIB p on p.idfact = fc.id
where MONTANTRESTE > 0 AND  fc.etat >= 11
;