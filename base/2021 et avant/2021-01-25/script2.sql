create view CODEETABLISSEMENT_LIBCOMPLET AS
select co.*,
       di.LIBELLEDIR as descelib,
       dept1.val     as departementlib,
       serv.val      as servicelib
from CODEETABLISSEMENT co
         left join direction di on di.IDDIR = co.DESCE
         LEFT JOIN departement dept1 ON co.departement = dept1.id
         LEFT JOIN service serv ON co.service = serv.id;

create view ETATFACTUREMONTANTDATY_LIB
            (ID, DATY, IDFOURNISSEUR, NOMFOURNISSEUR, IDTVA, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT,
             DATYECHEANCE, ETAT, MONTANTPAYE, RESTE, ENTITE, MONTANTTTDEVISE, BUDGET, RETENUE, NUMID, TIERSLIB, TVA,
             MONTANT, MONTANTAVOIR, MONTANTADDITIF, MONTANTNET, MONTANTTVA, MONTANTTTC, MONTANTTOTALAPAYER, TYPE,
             CODE_ETABLISSEMENT, PROJET,direction,service,departement)
as
SELECT et.id,
       et.daty,
       et.idfournisseur,
       et.nomfournisseur,
       et.idtva,
       et.remarque,
       et.dateemission,
       et.designation,
       et.iddevise,
       et.numfact,
       et.datyecheance,
       CASE
           WHEN et.etat = 'VALIDE(E)' THEN '11'
           WHEN et.etat = 'CREE(E)' THEN '1'
           ELSE '0'
           END
                                                              AS etat,
       NVL(et.montantpaye, 0)                                 AS montantpaye,
       RESTE                                                  AS reste,
       et.entite,
       et.montantttdevise,
       et.budget,
       et.retenue,
       et.NUMID,
       t.NOM                                                  AS tierslib,
       et.IDTVA                                               AS tva,
       et.montantht + et.montantadditifht - et.montantavoirht AS montant,
       (et.montantavoir),
       (et.montantadditif),
       (et.montantnet),
       et.montanttva + et.montantadditiftva - et.montantavoirtva
                                                              AS montanttva,
       et.montantttc,
       reste                                                  AS montantTotalApayer,
       ff.TYPE,
       co.val                                                 as CODE_ETABLISSEMENT,
       pr.DESIGNATION                                         as PROJET,
       co.descelib                                            as direction,
       co.servicelib                                          as service,
       co.departementlib                                      as departement
FROM etatfacturemontantdatyretenu et
         JOIN facturefournisseur_SumMtt ff ON ff.id = et.id
         LEFT JOIN TIERS t ON t.id = et.idfournisseur
         left join projet pr on pr.id = et.PROJET
         left join CODEETABLISSEMENT_LIBCOMPLET co on co.id = et.CODE_ETABLISSEMENT
/