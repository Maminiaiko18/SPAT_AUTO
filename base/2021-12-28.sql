update facture_fournisseur_mere set exercice=extract(YEAR from daty);
update factureclient set exercice=extract(YEAR from daty);


CREATE OR REPLACE VIEW FACTURE_CLIENT_MF_PAYE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, DATY, TIERS, DESIGNATIONMERE, TYPE,
             TVA, REMARQUE, IDUSER, DATE_ECHEANCE, ETAT, MONTANTTTC, MONTANTPAYEPOURC, MONTANTPAYE,exercice)
AS
select fcf.ID,
       fcf.IDMERE,
       fcf.DESIGNATION,
       fcf.QUANTITE,
       fcf.PU,
       fcf.COMPTE,
       fcf.IDPRODUIT,
       fcf.DEVISE,
       fcf.TAUX,
       fcf.DATY,
       fcf.TIERS,
       fcf.DESIGNATIONMERE,
       fcf.TYPE,
       fcf.TVA,
       fcf.REMARQUE,
       fcf.IDUSER,
       fcf.DATE_ECHEANCE,
       fcf.ETAT,
       fcf1.MONTANTTTC,
       (l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1)                     as montantpayepourc,
       fcf1.MONTANTTTC * ((l.MONTANTPAYE) / nvl(nullif(l.MONTANTTTC, 0), 1)) as montantpaye,
       EXERCICE
from FACTURECLIENTMSUM_LIB l
         right join FACTURE_CLIENT_MERE_FILLE fcf on fcf.IDMERE = l.id
         join FACTURE_CLIENT_FILLETTC fcf1 on fcf1.id = fcf.id
where l.ETAT >= 11;



CREATE OR REPLACE VIEW DETAILSFACTUREFOURNISSEUR_PAYE
            (ID, IDINGREDIENT, QTE, PU, IDMERE, COMPTE, PUDEVISE, IDDQE, MARGE, TVA, DATY, MONTANTTTC, MONTANTPAYEPOURC,
             MONTANTPAYE,EXERCICE)
AS
select dff.ID,
       cast('-' as varchar2(100))                                                   IDINGREDIENT,
       dff.QUANTITE                                                              as QTE,
       dff.PU,
       dff.IDMERE,
       dff.COMPTE,
       dff.PUDEVISE,
       dff.IDDQE,
       dff.MARGE,
       dff.TVA,
       DATY,
       dff1.MONTANTTTC,
       ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1))                     as montantpayepourc,
       (dff1.MONTANTTTC) * ((ff.MONTANTPAYE) / nvl(nullif(ff.MONTANTTTC, 0), 1)) as montantpaye,
       ff.EXERCICE
from factfourn_msum_lib ff
         right join FACTURE_FOURNISSEUR_FILLE dff on dff.IDMERE = ff.id
         right join FACTFOURN_FILLETTC dff1 on dff1.id = dff.id
where ETAT >= 11;



alter table factureclient add idavoir varchar2(100) constraint factureclient_avoir_fkr references AVOIRFC;
