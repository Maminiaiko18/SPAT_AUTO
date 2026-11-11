CREATE OR REPLACE VIEW FACTURE_FOURNISSEUR_QTE AS
select f.idblf, cast(sum(f.QUANTITE) as NUMBER(10, 2)) as quantite
from FACTURE_FOURNISSEUR_FILLE f
where not exists (select 1 from FACTURE_FOURNISSEUR_MERE m where m.id = f.idmere and m.etat = 0)
group by f.idblf;
