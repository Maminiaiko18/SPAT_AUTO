Update rubrique_activite set tva=0 where id IN ('RBR0117' ,'RBR0118', 'RBR0119','RBR0120','RBR0121','RBR0122');
CREATE OR REPLACE  VIEW AS_BONDELIVRAISON_FILLEQTE_RES (ID, PRODUIT, NUMBL, QUANTITE, QUANTITEPARPACK, IDDETAILSFACTUREFOURNISSEUR, IDBONDECOMMANDE, FACTURE, QUANTITERESTE, PU, NOMTIERS, IDTIERS, TVA, MONTANTHT, MONTANTTVA, PROJET, PROJETLIB, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB, IDBONDECOMMANDEMERE,remise) AS 
  SELECT blf.ID,
       blf.PRODUIT,
       blf.NUMBL,
       blf.QUANTITE,
       blf.QUANTITEPARPACK,
       blf.IDDETAILSFACTUREFOURNISSEUR,
       blf.IDBONDECOMMANDE,
       NVL(qff.quantite, 0)                                                AS facture,
       blf.QUANTITE - NVL(qff.quantite, 0)                                 AS quantitereste,
       bcf.PU,
       tiers.nom                                                      AS nomTiers,
       tiers.id                                                       as idtiers,
       bcf.TVA,
       cast((blf.QUANTITE * bcf.PU) as number(34, 2))                 as montantht,
       cast((blf.QUANTITE * bcf.PU * bcf.TVA) / 100 as number(34, 2)) as montanttva,
       bc.PROJET,
       pr.DESIGNATION                                                 as projetlib,
       bc.CODE_ETAB                                                   as code_etablissement,
       ce.VAL                                                         as code_etablissementlib
      ,bcf.IDBC as IDBONDECOMMANDEMERE,
       bcf.remise
FROM AS_BONDELIVRAISON_FILLE blf
         LEFT JOIN union_bcf_spat_cemedi bcf
                   ON bcf.id = blf.IDBONDECOMMANDE
         LEFT JOIN union_bc_spat_cemedi bc ON bc.id = bcf.idbc
         LEFT JOIN tiers ON tiers.id = bc.fournisseur
         LEFT JOIN FACTURE_FOURNISSEUR_QTE qff
                   ON qff.IDBLF = blf.id
         left join PROJET pr on pr.id = bc.PROJET
         left join CODEETABLISSEMENT ce on ce.id = CODE_ETAB;
		 
		 
CREATE OR REPLACE VIEW FACTFOURN_MSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB, NUMEROOP, PROJET, PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, DATEREGUL,montantHTSansRemise) AS 
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
       CAST(NVL(grp.montanttaux, 0) AS NUMBER(30, 2))                          AS montant,
       CAST(NVL(grp.MONTANTTVA, 0) AS NUMBER(30, 2))                           AS montanttva,
       NVL(grp.montantavoiravectaux, 0)                                        AS montantavoir,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0)
                   - NVL(grp.montantavoiravectaux, 0) AS NUMBER(30, 2))
                                                                               AS MONTANTTTC,
       pr.ESCALE,
       tfc.VAL                                                                 AS typelib,
       fc.IDCATEGORIE,
       catfc.VAL                                                               AS CATEGORIELIB,
       fc.IDPROVISION,
       fcf.DESIGNATION                                                         AS IDPROVISIONlib,
       fc.ESTDDPMICTSL,
       fc.DEVISEMERE,
       fc.codePrestation,
       cp.VAL                                                                  as codePrestationlib,
       fc.code,
       fc.ESTMICTSL,
       fcf.CODE                                                                as codeprovision,
       CAST(NVL(NVL(grp.MONTANTTVA, 0) + grp.montanttaux, 0) AS NUMBER(30, 2)) as MONTANTTTCVRAI,
       fc.IDBL,
       fc.CODE_ETABLISSEMENT,
       cod.VAL                                                                 as CODE_ETABLISSEMENTlib,
       fc.NUMEROOP,
       fc.PROJET,
       p.DESIGNATION                                                           as projetlib,
       fc.NUMFACT,
       fc.NATURE,
       n.VAL                                                                   as naturelib,
       bl.ID_BC,
       fc.EXERCICE,
       fc.IDENGAGEMENT,
       en.DESIGNATION                                                        as idengagementlib ,
       fc.DATEREGUL,
       cast(Nvl(grp.montant,0) AS number(30,2))                               as montantHTSansRemise
       FROM FACTURE_FOURNISSEUR_MERE fc
         LEFT JOIN FACTFOURN_GRP grp ON grp.idmere = fc.id
         LEFT JOIN PREVISION pr ON pr.id = fc.IDPREVISION
         LEFT JOIN TYPEFf tfc ON tfc.ID = fc.TYPE
         LEFT JOIN CATEGORIEFF catfc ON catfc.ID = fc.IDCATEGORIE
         LEFT JOIN FACTURE_FOURNISSEUR_MERE fcf ON fcf.id = fc.IDPROVISION
         left join CODE_PRESTATION cp on fc.codePrestation = cp.id
         left join CODEETABLISSEMENT cod on fc.CODE_ETABLISSEMENT = cod.ID
         left join projet p on fc.PROJET = p.ID
         LEFT JOIN nature n on fc.NATURE = n.ID
         left join AS_BONDELIVRAISON bl on bl.ID = nvl(fc.IDBL, fc.REMARQUE)
         left join engagement en on en.ID = fc.IDENGAGEMENT;


CREATE OR REPLACE VIEW FACTFOURN_MSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, IDPREVISION, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, MONTANTPAYE, MONTANTRESTE, TIERSLIB, CONTACT, ADRESSE, ESCALE, TYPELIB, IDCATEGORIE, CATEGORIELIB, IDPROVISION, IDPROVISIONLIB, ESTDDPMICTSL, DEVISEMERE, CODEPRESTATION, CODEPRESTATIONLIB, CODE, ESTMICTSL, CODEPROVISION, ETATLIB, MONTANTTTCVRAI, IDBL, CODE_ETABLISSEMENT, CODE_ETABLISSEMENTLIB, NUMEROOP, PROJET, PROJETLIB, NUMFACT, NATURE, NATURELIB, IDBC, EXERCICE, IDENGAGEMENT, IDENGAGEMENTLIB, DATEREGUL,MONTANTHTSANSREMISE) AS 
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
       CAST(NVL(pf.montant, 0) AS NUMBER(32, 2)) AS montantpaye,
       CAST(M.MONTANTTTC - NVL(pf.montant, 0) AS NUMBER(32, 2))
                                                 AS montantreste,
       fup.NOM                                   AS tierslib,
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
       cast(MONTANTTTCVRAI as number(32,2)),
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
       m.DATEREGUL,
       cast(m.MONTANTHTSANSREMISE AS NUMBER(30,2)) AS MONTANTHTSANSREMISE
FROM FACTFOURN_MSUM m
         LEFT JOIN FOURNISSEUR_UNION_PERSONNEL fup ON fup.ID = m.tiers
         LEFT JOIN paiementfacturefsum pf ON pf.idfact = m.id;
CREATE TABLE placement_banque_caisse(
id varchar (100) CONSTRAINT placement_banque_caisse_pk PRIMARY KEY,
val varchar (500) CONSTRAINT  placement_bc_banque_id_fk REFERENCES banque(id),
desce varchar(500) CONSTRAINT placement_bc_caisse_id_fk REFERENCES caisse(id)
) ;

	CREATE SEQUENCE seq_placement_banque_caisse
	MINVALUE 1
	MAXVALUE 999999999999999999999999999
	START WITH 1
	INCREMENT BY 1
	CACHE 20;

CREATE OR REPLACE FUNCTION get_seq_placement_bc
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_placement_banque_caisse.nextval INTO retour FROM dual;
  return retour;
END;


ALTER TABLE  remboursementPlacement
add  interetBrut NUMBER;  
ALTER TABLE  remboursementPlacement
add IRCM NUMBER;

CREATE OR REPLACE  VIEW REMBOURSEMENTPLACEMENTLIB (ID, DATY, IDPLACEMENT, MONTANTPLACE, INTERET, CAISSE, ETAT, ENTITE, BANQUE, CAISSELIB,INTERETBRUT,IRCM) AS 
  select r.ID,r.DATY,r.IDPLACEMENT,r.MONTANTPLACE,r.INTERET,r.CAISSE,r.ETAT,
       p.entite,
       p.banque,
       c.val as caisselib,
       CAST(r.INTERETBRUT AS NUMBER (30,2)) AS INTERETBRUT,
       cast(r.IRCM AS NUMBER (30,2)) AS IRCM 
from remboursementPlacement r
    left join placementlib p on r.idplacement=p.ID
    left join caisse c on r.caisse=c.ID;
	
 
   CREATE OR REPLACE VIEW REMBOURSEMENTPLACEMENTV (ID, DATY, IDPLACEMENT, MONTANTPLACE, INTERET, CAISSE, ETAT, ENTITE, BANQUE, CAISSELIB,INTERETBRUT,IRCM) AS 
  select ID,
       DATY,
       IDPLACEMENT,
       MONTANTPLACE,
       INTERET,
       CAISSE,
       ETAT,
       ENTITE,
       BANQUE,
       CAISSELIB,
        CAST(INTERETBRUT AS NUMBER (30,2)) AS INTERETBRUT,
       cast(IRCM AS NUMBER (30,2)) AS IRCM 
from remboursementplacementlib
where etat >= 11;



