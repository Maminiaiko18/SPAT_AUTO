alter table facture_client_fille
    add constraint facture_client_produit_fk foreign key (idproduit) references AS_PRODUITS;
	

  CREATE OR REPLACE VIEW FACTURECLIENTMSUM (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA, MONTANTTTC) AS
  select fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(nvl(grp.montanttaux, 0) as number(30, 2))                            as montant,
       cast(nvl((grp.montanttaux * fc.TVA)/100, 0) as number(30, 2))                   as montanttva,
       cast(nvl(((grp.montanttaux * fc.TVA)/100) + grp.montanttaux, 0) as number(30, 2)) as montantttc

from FACTURECLIENT fc
         left join facture_client_grp grp on grp.idmere = fc.id;
	
CREATE OR REPLACE VIEW FACTURECLIENTMSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER,
                DATE_ECHEANCE, ETAT, MONTANT,MONTANTTVA,MONTANTTTC,TIERSLIB) AS
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
       M.MONTANTTTC,
       fup.NOM as tierslib
from factureclientMSum m
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = m.tiers;
		 
create or replace view factureclientMSumC
as select *from FACTURECLIENTMSUM_LIB where etat=1;
create or replace view factureclientMSumV
as select *from FACTURECLIENTMSUM_LIB where etat>=11;


create or replace view avoirfcavectaux as
select ac.*,
       cast(nvl(fc.TAUX,1) as number(30,2)) as taux,
       nvl(fc.DEVISE,'Ar') as devise,
       cast(ac.MONTANT*nvl(fc.TAUX,1) as number(30,2)) as montantavectsaux,
       a.ETAT
from AVOIRFCFILLE ac
         left join FACTURE_CLIENT_FILLE fc on fc.ID = ac.IDDETAILFACTURE
        left join avoirfc a on ac.IDMERE = a.ID;


create view avoirfcavectaux_grp as
select ac.IDDETAILFACTURE ,
       sum(MONTANT) as montantsanstaux,
       sum(montantavectsaux) as montantavectsaux
from avoirfcavectaux ac
    where etat>=11
group by ac.IDDETAILFACTURE;


CREATE OR REPLACE VIEW FACTURE_CLIENT_MONTANT
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTAUX, montantavoirsanstaux,
             montantavoiravectaux)
AS
select fm.ID,
       fm.IDMERE,
       fm.DESIGNATION,
       fm.QUANTITE,
       fm.PU,
       fm.COMPTE,
       fm.IDPRODUIT,
       fm.DEVISE,
       fm.TAUX,
       fm.DATY,
       fm.TIERS,
       fm.DESIGNATIONMERE,
       fm.TYPE,
       fm.TVA,
       fm.REMARQUE,
       fm.IDUSER,
       fm.DATE_ECHEANCE,
       fm.ETAT,
       cast(fm.pu * fm.quantite as number(30, 2))                 as Montant,
       cast((fm.pu * fm.quantite) * fm.taux as NUMBER(30, 2))     as montanttaux,
       nvl(montantsanstaux, 0)                                    as montantavoirsanstaux,
       cast(nvl((montantsanstaux * fm.TAUX), 0) as number(30, 2)) as montantavoiravectaux
from facture_client_Mere_fille fm
         left join avoirfcavectaux_grp grp on grp.IDDETAILFACTURE = fm.ID;

		 create or replace view FACTURE_CLIENT_GRP as
select sum(fm.MONTANT) as montant,
       sum(fm.montanttaux) as montanttaux,
       sum(fm.MONTANTAVOIRSANSTAUX)as MONTANTAVOIRSANSTAUX,
       sum(fm.montantavoiravectaux)as montantavoiravectaux,
       fm.idmere
from facture_client_montant fm
group by fm.idmere
/
CREATE OR REPLACE VIEW FACTURECLIENTMSUM
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,
             MONTANTAVOIR, MONTANTTTC)
AS
select fc.ID,
       fc.DATY,
       fc.TIERS,
       fc.DESIGNATION,
       fc.TYPE,
       fc.TVA,
       fc.REMARQUE,
       fc.IDUSER,
       fc.DATE_ECHEANCE,
       fc.ETAT,
       cast(nvl(grp.montanttaux, 0) as number(30, 2))                  as montant,
       cast(nvl((grp.montanttaux * fc.TVA) / 100, 0) as number(30, 2)) as montanttva,
       nvl(grp.montantavoiravectaux, 0)                                as montantavoir,
       cast(nvl(((grp.montanttaux * fc.TVA) / 100) + grp.montanttaux, 0) -
            nvl(grp.montantavoiravectaux, 0) as number(30, 2))         AS MONTANTTTC

from FACTURECLIENT fc
         left join facture_client_grp grp on grp.idmere = fc.id;
		 
CREATE OR REPLACE VIEW FACTURECLIENTMSUM_LIB
            (ID, DATY, TIERS, DESIGNATION, TYPE, TVA, REMARQUE, IDUSER,
             DATE_ECHEANCE, ETAT, MONTANT, MONTANTTVA,MONTANTAVOIR, MONTANTTTC, TIERSLIB)
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
       fup.NOM as tierslib
from factureclientMSum m
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.ID = m.tiers;

create or replace view factureclientMSumC
as
select *
from FACTURECLIENTMSUM_LIB
where etat = 1;
create or replace view factureclientMSumV
as
select *
from FACTURECLIENTMSUM_LIB
where etat >= 11;

