

  CREATE OR REPLACE VIEW FACTURE_CLIENT_FILLE_LIB_RESTE (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER, MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX) AS
  select fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM as IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       cast(nvl(gr.QUANTITE, 0) as number(10,2)) as qteLivree,
           cast(fc.QUANTITE-nvl(gr.QUANTITE, 0) as number(10,2)) as resteAlivrer,
         cast(fcm.MONTANTTAUX as number(32,2)),
         cast(fcm.MONTANT as number(32,5)),
         cast(fcm.MONTANTAVOIRSANSTAUX as NUMBER(32,2)),
         cast(fcm.MONTANTAVOIRAVECTAUX as NUMBER(32,2))
from facture_client_fille fc
         left join AS_PRODUITS pr on pr.ID = fc.IDPRODUIT
         left join as_bondelivraison_cl_grp gr on gr.IDDETAILSFACTUREFOURNISSEUR=fc.ID
         left join FACTURE_CLIENT_MONTANT fcm on fcm.id=fc.id;

		 
  CREATE OR REPLACE VIEW FACTURECLIENTMSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, TIERSLIB) AS
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
       fup.NOM as tierslib
from factureclientMSum m
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = m.tiers;

  CREATE OR REPLACE VIEW FACTURECLIENTMSUM_LIB (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE,
      IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTAVOIR, MONTANTTTC, TIERSLIB,CONTACT,ADRESSE) AS
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
       fup.NOM as tierslib,
       fup.CONTACT,
       fup.ADRESSE
from factureclientMSum m
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = m.tiers;

create or replace view AS_BONDELIVRAISON_CL_PDT as
select fi.ID,
       nvl(fil.idPRODUIT,fil.DESIGNATION) as produit,
       fi.NUMBL,
       fi.QUANTITE,
       fi.IDDETAILSFACTUREFOURNISSEUR,
       cast('' as varchar2(400)) as pdt
from as_bondelivraison_cl_fille fi
    left join FACTURE_CLIENT_FILLE fil on fi.IDDETAILSFACTUREFOURNISSEUR = fil.ID
/

create or replace view AS_BONDELIVRAISON_CL_FILLE_LIB as
select cl.ID,
       nvl(l.IDPRODUIT,l.DESIGNATION) as PRODUIT,
       cl.NUMBL,
       cl.QUANTITE,
       cl.IDDETAILSFACTUREFOURNISSEUR,
       l.IDPRODUITLIB as produitlib
from as_bondelivraison_cl_fille cl
         left join FACTURE_CLIENT_FILLE_LIB l on l.ID = cl.IDDETAILSFACTUREFOURNISSEUR
/