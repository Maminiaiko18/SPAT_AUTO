CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIB (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX, IDPRODUITLIB) AS 
  select fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       fc.IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       cast(nvl(gr.QUANTITE, 0) as number(10,2)) as qteLivree,
           cast(fc.QUANTITE-nvl(gr.QUANTITE, 0) as number(10,2)) as resteAlivrer,
       fcm.MONTANTTAUX,
       fcm.MONTANT,
       fcm.MONTANTAVOIRSANSTAUX,
       fcm.MONTANTAVOIRAVECTAUX,
       pr.nom AS IDPRODUITlib
from facture_client_fille fc
         left join AS_PRODUITS pr on pr.ID = fc.IDPRODUIT
         left join as_bondelivraison_cl_grp gr on gr.IDDETAILSFACTUREFOURNISSEUR=fc.ID
         left join FACTURE_CLIENT_MONTANT fcm on fcm.id=fc.id;
		 
		 
CREATE OR REPLACE VIEW AVOIRFCFILLE_MONTANTFACTURE (ID, IDMERE, IDDETAILFACTURE, MONTANT, COMPTE, MONTANTDF, MONTANTDFTAUX, DESIGNATION, DEVISE) AS 
  select fc.ID,fc.IDMERE,fc.IDDETAILFACTURE,fc.MONTANT,fc.COMPTE,
       cast(fcf.MONTANT as NUMBER(30, 2)) as MONTANTDF ,
       cast(fcf.MONTANTTAUX as NUMBER(30, 2)) as MONTANTDFTAUX,
       cast(fcf.DESIGNATION as varchar2(500)) as designation,
       cast(fcf.DEVISE as varchar2(500)) as devise
from AvoirFCFille fc
    left join FACTURE_CLIENT_MONTANT fcf on fc.IDDETAILFACTURE = fcf.ID;

CREATE OR REPLACE VIEW FACTUREPROFMSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC, TIERSLIB,ADRESSE,CONTACT)
AS
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
       m.MONTANT,
       M.MONTANTTVA,
       M.MONTANTAVOIR,
       M.MONTANTTTC,
       fup.NOM as tierslib,
       fup.ADRESSE,
       fup.CONTACT
from FACTURECLIENPROFTMSUM m
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = m.TIERS;

create or replace view ACTIVITELIBCOMPLET as
select ac.*,
       ra.DESIGNATION                            as rubriquelib,
       nv.NOM                                    as bateaulib,
       nv.PLT                                    as poids,
       nv.LHT                                    as longueur,
       nv.LM                                     as largeur,
       cast('-' as varchar2(100))                as autres,
       ra.pu,
       ra.devise,
       ra.compte,
       ra.unite,
       ra.direction,
       ra.condition,
       ra.tva,
       ra.objet,
       ra.redevance,
       fup.NOM                                   as clientlib,
       re.VAL                                    as redevancelib,
       di.LIBELLEDIR                             as directionlib,
       case
           when ac.etat = 1 then 'CREE(E)'
           WHEN AC.ETAT = 11 THEN 'VISE(E)'
           WHEN AC.ETAT = 0 THEN 'ANNULE(E)' END AS ETATLIB,
       MOIS.VAL                                  AS MOISLIB
from ACTIVITE ac
         left join RUBRIQUE_ACTIVITE ra on ra.id = ac.RUBRIQUE
         left join NAVIRE nv on nv.ID = ac.BATEAU
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id = ac.CLIENT
         left join REDEVANCE re on re.id = ra.REDEVANCE
         left join direction di on (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
/

DELETE FROM MENUDYNAMIQUE WHERE ID='MENM02';
DELETE FROM MENUDYNAMIQUE WHERE ID='MENM03';
DELETE FROM MENUDYNAMIQUE WHERE ID='MENM04';
DELETE FROM MENUDYNAMIQUE WHERE ID='MENM05';

CREATE OR REPLACE VIEW AS_BONDELIVRAISON_CL_LIBELLE (ID, IDBC,
    REMARQUE, DATY, POINT, ETAT, DESIGNATIONFACTURE ,ETATLIB) AS
select cl.ID,
       cl.IDBC,
       cl.REMARQUE,
       cl.DATY,
       cl.POINT,
       cl.ETAT,
       f.DESIGNATION as designationfacture,
       case
           when cl.etat = 1 then 'CREE(E)'
           WHEN cl.ETAT = 11 THEN 'VISE(E)'
           WHEN cl.ETAT = 0 THEN 'ANNULE(E)' END AS ETATLIB
from as_bondelivraison_cl cl
         left join FACTURECLIENT F on cl.IDBC = F.ID;
		 
CREATE OR REPLACE VIEW AS_BONDELIVRAISON_CL_FILLE_LIB (ID, PRODUIT, NUMBL, QUANTITE, IDDETAILSFACTUREFOURNISSEUR, PRODUITLIB) AS
select cl.ID,
       l.IDPRODUIT as PRODUIT,
       cl.NUMBL,
       cl.QUANTITE,
       cl.IDDETAILSFACTUREFOURNISSEUR,
       l.IDPRODUITLIB as produitlib
from as_bondelivraison_cl_fille cl
         left join FACTURE_CLIENT_FILLE_LIB l on l.ID = cl.IDDETAILSFACTUREFOURNISSEUR;