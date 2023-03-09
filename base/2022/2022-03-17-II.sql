create view LIGNECREDITDEPENSELIB as
select lc.ID,
       DESIGNATION,
       QUANTITE,
       MONTANT,
       ANNEE,
       COMPTE,
       ETAT,
       COMPTEG,
       di.LIBELLEDIR as IDDIRECTION
from LIGNECREDITDEPENSE lc
        left join direction di on di.IDDIR=lc.IDDIRECTION;