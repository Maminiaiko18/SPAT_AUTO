alter table FACTURE_CLIENT_FILLE add idactivite varchar2(100) constraint iactivite_fc_fk references ACTIVITE;


  CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET  AS
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
       MOIS.VAL                                  AS MOISLIB,
       ra.CATEGORIE,
       cf.VAL as CATEGORIELIB
from ACTIVITE ac
         left join RUBRIQUE_ACTIVITE ra on ra.id = ac.RUBRIQUE
         left join NAVIRE nv on nv.ID = ac.BATEAU
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id = ac.CLIENT
         left join REDEVANCE re on re.id = ra.REDEVANCE
         left join direction di on (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS
         left join CATEGORIEFACTURATION cf on ra.CATEGORIE = cf.ID;

create view facture_client_fille_vm as
select fcf.*
from facture_client_fille fcf
         join factureclient fc on fcf.IDMERE = fc.ID
where fc.etat >= 11;
		 
create view activitesNonFacturees as
select ac.*
from ACTIVITELIBCOMPLET ac
where id not in (select idactivite from facture_client_fille_vm);

CREATE OR REPLACE VIEW ACTIVITELIBCOMPLET AS 
  select ac.ID,ac.DESIGNATION,ac.CLIENT,ac.RUBRIQUE,ac.QTE,ac.MOIS,ac.ANNEE,ac.DATY,ac.BATEAU,ac.ETAT,
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
       MOIS.VAL                                  AS MOISLIB,
       ra.CATEGORIE
from ACTIVITE ac
         left join RUBRIQUE_ACTIVITE ra on ra.id = ac.RUBRIQUE
         left join NAVIRE nv on nv.ID = ac.BATEAU
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id = ac.CLIENT
         left join REDEVANCE re on re.id = ra.REDEVANCE
         left join direction di on (di.IDDIr) = ra.DIRECTION
         LEFT JOIN MOIS ON MOIS.ID = AC.MOIS;
		 
 CREATE OR REPLACE VIEW ACTIVITESNONFACTUREES ("ID", "DESIGNATION", "CLIENT", "RUBRIQUE", "QTE", "MOIS", "ANNEE", "DATY", "BATEAU", "ETAT", "RUBRIQUELIB", "BATEAULIB", "POIDS", "LONGUEUR", "LARGEUR", "AUTRES", "PU", "DEVISE", "COMPTE", "UNITE", "DIRECTION", "CONDITION", "TVA", "OBJET", "REDEVANCE", "CLIENTLIB", "REDEVANCELIB", "DIRECTIONLIB", "ETATLIB", "MOISLIB") AS 
  select ac."ID",ac."DESIGNATION",ac."CLIENT",ac."RUBRIQUE",ac."QTE",ac."MOIS",ac."ANNEE",ac."DATY",ac."BATEAU",ac."ETAT",ac."RUBRIQUELIB",ac."BATEAULIB",ac."POIDS",ac."LONGUEUR",ac."LARGEUR",ac."AUTRES",ac."PU",ac."DEVISE",ac."COMPTE",ac."UNITE",ac."DIRECTION",ac."CONDITION",ac."TVA",ac."OBJET",ac."REDEVANCE",ac."CLIENTLIB",ac."REDEVANCELIB",ac."DIRECTIONLIB",ac."ETATLIB",ac."MOISLIB"
from ACTIVITELIBCOMPLET ac
where id not in (select idactivite from facture_client_fille_vm WHERE ac.id = IDACTIVITE);