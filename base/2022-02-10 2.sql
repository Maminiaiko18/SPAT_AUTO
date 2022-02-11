delete from lignecreditrecette;
insert into lignecreditrecette values('1','DROIT DE PORT SUR HYDROCARBURES',0,'5202502935',2022,'70662',11,'70662');
insert into lignecreditrecette values('3','DROIT DE PORT',0,'1723075880,42192',2022,'70680',11,'706661');
insert into lignecreditrecette values('7','STATIONNEMENT',0,'5269367747,76968',2022,'70684',11,'706662');
insert into lignecreditrecette values('12','PEAGE SUR MARCHANDISES EMBARQUEES',0,'221351829,4',2022,'70672',11,'706671');
insert into lignecreditrecette values('13','PEAGE SUR MARCHANDISES DEBARQUEES',0,'29786795,9333333',2022,'70671',11,'706672');
insert into lignecreditrecette values('18','REDEVANCE D EXPLOITATION',0,'50715567262,4748',2022,'70630',11,'70630');
insert into lignecreditrecette values('33','REDEVANCES LOCATIVES:',0,'1539145547,39111',2022,'70631',11,'70631');
insert into lignecreditrecette values('52','REDEVANCES DOMANIALES',0,'16624690777,8155',2022,'70632',11,'70632');
insert into lignecreditrecette values('73','AUTRES PRESTATIONS CONNEXES',0,'71924600,883905',2022,'70610',11,'70610');
insert into lignecreditrecette values('74','OUVERTURE MAGASIN',0,'',2022,'70611',11,'70611');
insert into lignecreditrecette values('75','PRESTATIONS SLIPWAY/ASCOM',0,'490937433,134517',2022,'70612',11,'70612');
insert into lignecreditrecette values('87','LAMANAGE',0,'3326446712,52415',2022,'70681',11,'70681');
insert into lignecreditrecette values('88','PILOTAGE',0,'4667703298,04103',2022,'70682',11,'70682');
insert into lignecreditrecette values('89','REMORQUAGE',0,'18770435745,3064',2022,'70683',11,'70683');
insert into lignecreditrecette values('90','VEILLE SECURITE',0,'1313617135,932',2022,'70685',11,'70685');
insert into lignecreditrecette values('91','CESSION EAU DOUCE',0,'161808339',2022,'70600',11,'70686');
insert into lignecreditrecette values('92','STATIONNEMENT OU IMMOBILISATION',0,'9005867,76',2022,'70602',11,'70687');
insert into lignecreditrecette values('93','LOCATION REMORQUEURS',0,'1176971555,935',2022,'70603',11,'70688');
insert into lignecreditrecette values('94','LOCATION VEDETTES DE SERVITUDES',0,'43193417,53575',2022,'70604',11,'70689');
insert into lignecreditrecette values('95','PIQUAGES, PEINTURES, ...',0,'35694792,38',2022,'70605',11,'706810');
insert into lignecreditrecette values('96','PIQUET D INCENDIE',0,'22360875,328',2022,'70606',11,'706811');
insert into lignecreditrecette values('98','CONSOMMATION EAU COURANTE',0,'',2022,'70651',11,'70651');
insert into lignecreditrecette values('99','PERCEPTION ANNULATION FACTURES',0,'',2022,'70652',11,'70652');
insert into lignecreditrecette values('100','REDEVANCE SANITAIRE',0,'',2022,'70653',11,'70653');

CREATE OR REPLACE VIEW FACTURE_CLIENT_MF_PAYE_BDG
AS
   SELECT fcf.ID,
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
          fcf.TYPE,
          fcf.TVA,
          fcf.ETAT,
          (fcf.MONTANTTTC) AS MONTANTTTC,
          (fcf.MONTANT) AS MONTANTHT,
          ROUND ( (l.MONTANTPAYE) / NVL (NULLIF (l.MONTANTTTC, 0), 1), 3)
             AS montantpayepourc,
          ROUND (
               (fcf.MONTANTTTC)
             * ( (l.MONTANTPAYE) / NVL (NULLIF (l.MONTANTTTC, 0), 1)),
             3)
             AS montantpaye,
          ROUND (
               (fcf.MONTANT)
             * ( (l.MONTANTPAYE) / NVL (NULLIF (l.MONTANT, 0), 1)),
             3)
             AS montantHTpaye,
          l.EXERCICE,
          fcf.mois,
          fcf.annee
     FROM FACTURECLIENTMSUM_LIB l
          RIGHT JOIN CAFCFILLECOMPLET fcf ON fcf.IDMERE = l.id
    WHERE l.ETAT >= 11;