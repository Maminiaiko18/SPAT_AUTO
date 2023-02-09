
CREATE OR REPLACE VIEW PAIEMENTFACTURECP (ID, IDMVT, IDFACT, MONTANT, CODE, DATY, TYPEFACTURE) AS 
  select pf.ID,
       pf.IDMVT,
       pf.IDFACT,
       pf.MONTANT,
       fc.CODE,
       fc.DATY,
       case when fc.idcategorie like 'CATFCO1' then 'PROF'
       when fc.idcategorie like 'CATFCO2' then 'PROV'
       else 'FF' end as typefacture
from paiementfacture pf
    left join FACTURECLIENT fc on fc.id=pf.IDFACT;

CREATE OR REPLACE VIEW DETAILSFF_CPL_SUM2 (ID, IDINGREDIENT, QTE, PU, IDMERE, COMPTE, PUDEVISE, IDDQE, MARGE, TVA, MONTANTTVA, MONTANTHT, MONTANTTTC) AS 
  SELECT facture_fournisseur_fille.ID,0 AS IDINGREDIENT,facture_fournisseur_fille.QUANTITE as QTE,facture_fournisseur_fille.PU,facture_fournisseur_fille.IDMERE,facture_fournisseur_fille.COMPTE,facture_fournisseur_fille.PUDEVISE,facture_fournisseur_fille.IDDQE,facture_fournisseur_fille.MARGE,facture_fournisseur_fille.TVA,
      0 as montanttva,
       0                   as montantht,
      0           as montantttc
FROM facture_fournisseur_fille;

CREATE OR REPLACE VIEW DETAILS_FF_SUM2 (IDMERE, TVA, MONTANTHT, MONTANTTVA, MONTANTTTC) AS 
  select idmere, sum(TVA)as tva, sum(montantht) as montantht, sum(montanttva) as montanttva, sum(montantttc) as montantttc
from detailsff_cpl_sum2
group by idmere;

CREATE OR REPLACE VIEW FACTUREFOURNISSEURMONTANT2 (ID, DATY, IDFOURNISSEUR, IDTVA, MONTANTTVA, MONTANTHT, MONTANTTTC, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT, RESP, DATYECHEANCE, ETAT, IDFACTUREFOURNISSEUR, BUDGET, TVADETAILS, MONTANTAVOIRHT, MONTANTAVOIRTVA, MONTANTAVOIRTTC, MONTANTADDITIFHT, MONTANTADDITIFTVA, MONTANTADDITIFTTC) AS 
  SELECT 
		  ff.id,
		  ff.daty,
		  ff.TIERS AS idfournisseur,
		  0 AS idtva,
		  de.montanttva,
		  de.montantHt,
		  de.montantttc,
		  ff.remarque,
		  ff.dateemission,
		  ff.designation,
		  0 AS iddevise,
		  ff.numfact,
		  0 AS resp,
		  0 AS datyecheance,
		  ff.etat,
		  0 AS idfacturefournisseur,
		  0 AS budget,
		  0 AS tvadetails,
		  av.MONTANTAVOIRHT,
		  av.MONTANTAVOIRTVA,
		  av.MONTANTAVOIRTTC,
			ad.montantadditifht,
			ad.montantadditiftva,
			ad.montantadditifttc
     FROM facture_fournisseur_mere ff
          JOIN DETAILS_FF_SUM2 de ON de.idmere = ff.id
          LEFT JOIN AVOIR_VISESM_GROUPER av ON av.idfacture = ff.id
          LEFT JOIN ADDITIF_VISESM_GROUPER ad ON ad.idfacture = ff.id;
		  
		  
CREATE OR REPLACE VIEW FACTUREFOURNISSEURLETTREMTT2 (ID, DATY, IDFOURNISSEUR, IDTVA, MONTANTHT, MONTANTTVA, MONTANTTTC, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT, DATYECHEANCE, ENTITE, ETAT, BUDGET) AS 
  SELECT ff.id,
          ff.daty,
          ff.idfournisseur AS idfournisseur,
          '' AS idtva,
          ff.montantHt,
          '' AS montanttva,
          ff.montantttc-nvl(ff.MONTANTAVOIRTTC,0)+nvl(ff.montantadditifttc,0) as montantttc,
          ff.remarque,
          ff.dateemission,
          ff.designation,
          ff.iddevise,
          ff.numfact,
          ff.datyecheance,
          '' AS entite,
          CASE
             WHEN ff.etat = 1 THEN 'CREE(E)'
             WHEN ff.etat = 11 THEN 'VALIDE(E)'
             ELSE 'AUTRE'
          END
             AS etat,
          ff.budget
     FROM facturefournisseurmontant2 ff
          LEFT JOIN TIERS c ON c.id = ff.idfournisseur;
		  
		  
CREATE OR REPLACE VIEW ETATFACTUREMONTANT2 (ID, DATY, IDFOURNISSEUR, IDTVA, MONTANTHT, MONTANTTVA, MONTANTTTC, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT, DATYECHEANCE, ETAT, MONTANTPAYE, RESTE, ENTITE, NOMFOURNISSEUR, MONTANTAVOIRHT, MONTANTAVOIRTTC, TET) AS 
  SELECT f.id,
       f.daty,
       f.idfournisseur,
       f.idtva,
       f.montantHt,
       f.montanttva,
       f.montantttc,
       f.remarque,
       f.dateemission,
       f.designation,
       f.iddevise,
       f.numfact,
       f.datyecheance,
       f.etat,
       case when op.DED_ID like '%;%' then
       sum(COALESCE(op.montant, 0))
           else sum(COALESCE (op.MONTANTOP, 0)) end  AS montantpaye,
       f.montantttc -  case when op.DED_ID like '%;%' then
       sum(COALESCE(op.montant, 0))
           else sum(COALESCE(op.MONTANTOP, 0)) end AS reste,
       f.entite,
       f.designation                          AS nomfournisseur,
       0                         AS MONTANTAVOIRHT,
       0                         as montantavoirttc,
       ''                         as tet
FROM facturefournisseurlettremtt2 f
         LEFT JOIN LIAISONINTRATABLE_OP_PARFACT op ON f.id = op.ID1
         left join avoir_visesm av on av.idfacture = f.id
         left join additif_visesm ad on ad.idfacture = f.id
    group by op.DED_ID,f.id, f.daty, f.idfournisseur, f.idtva, f.montantHt, f.montanttva, f.montantttc, f.remarque, f.dateemission, f.designation, f.iddevise, f.numfact, f.datyecheance, f.etat, COALESCE(op.montant, 0), f.montantttc - COALESCE(op.montant, 0), f.entite, f.designation;
	
	
CREATE OR REPLACE VIEW ETATFACTUREMONTANTDATYRETENU2 (ID, DATY, IDFOURNISSEUR, NOMFOURNISSEUR, IDTVA, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT, DATYECHEANCE, ETAT, NUMID, MONTANTPAYE, RESTE, ENTITE, MONTANTTTDEVISE, BUDGET, RETENUE, MONTANT, MONTANTAVOIR, MONTANTADDITIF, MONTANTNET, MONTANTHT, MONTANTTVA, MONTANTTTC, MONTANTAVOIRHT, MONTANTAVOIRTVA, MONTANTAVOIRTTC, MONTANTADDITIFHT, MONTANTADDITIFTVA, MONTANTADDITIFTTC, CODE_ETABLISSEMENT, PROJET) AS 
  SELECT DISTINCT efm.id,
                efm.daty,
                efm.idfournisseur,
                t.nom                                                  AS nomfournisseur,
                efm.idtva,
                --efm.montantttc,
                efm.remarque                                           AS remarque,
                nvl(dff.dateemission, SYSDATE ) AS DATEEMISSION,
                efm.designation,
                efm.iddevise,
                efm.numfact,
                efm.datyecheance,
                efm.etat,
                dff.NUMID,
                COALESCE(efm.montantpaye, 0)                           AS montantpaye,
                COALESCE(efm.reste, 0)                                 AS reste,
                ''                                                     AS entite,
                ''                                         AS montantttdevise,
                ''                                                     AS budget,
                0                                                      AS retenue,
                ''                                             AS montant,
                0 as montantavoir,
                0 as montantadditif,
                0 as montantnet,
                0 as montantht,
                0 as montanttva,
                0 as montantttc,
                0 as montantavoirht,
                0 as montantavoirtva,
                0 as montantavoirttc,
                0 as montantadditifht,
                0 as montantadditifttc,
                0 as montantadditiftva,
                dff.CODE_ETABLISSEMENT,
                dff.PROJET
                -- cast((ff.MONTANT - nvl(av.MONTANT, 0) + nvl(ad.montant, 0)) *(efm.IDTVA / 100) as number(25, 2))                                                          as montanttva
FROM etatfacturemontant2 efm
         JOIN FACTURE_FOURNISSEUR_MERE dff ON dff.id = efm.id
         LEFT JOIN tiers t ON dff.TIERS  = t.id
         join facturefournisseur_SumMtt2 ff on ff.id = efm.id
         left join AVOIR_VISESM_grouper av on av.idfacture = ff.id
         left join additif_VISESM_grouper ad on ad.idfacture = ff.id;
		 
		 
CREATE OR REPLACE VIEW ETATFACTUREMONTANTDATY_LIB2 (ID, DATY, IDFOURNISSEUR, NOMFOURNISSEUR, IDTVA, REMARQUE, DATEEMISSION, DESIGNATION, IDDEVISE, NUMFACT, DATYECHEANCE, ETAT, MONTANTPAYE, RESTE, ENTITE, MONTANTTTDEVISE, BUDGET, RETENUE, NUMID, TIERSLIB, TVA, MONTANT, MONTANTAVOIR, MONTANTADDITIF, MONTANTNET, MONTANTTVA, MONTANTTTC, MONTANTTOTALAPAYER, TYPE, CODE_ETABLISSEMENT, PROJET, DIRECTION, SERVICE, DEPARTEMENT) AS 
  SELECT ff.id,
       et.daty,
       et.idfournisseur,
       et.nomfournisseur,
       et.idtva,
       et.remarque,
       et.dateemission,
       et.designation,
       et.iddevise,
       et.numfact,
       nvl(ff.datyecheance,SYSDATE) AS DATYECHEANCE, 
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
       co.VAL                                           as direction,
       co.servicelib                                          as service,
       co.departementlib                                      as departement
FROM etatfacturemontantdatyretenu2 et
         JOIN facturefournisseur_SumMtt2 ff ON ff.idfournisseur = et.idfournisseur
         LEFT JOIN TIERS t ON t.id = et.idfournisseur
         left join projet pr on pr.id = et.PROJET
         left join CODEETABLISSEMENT_LIBCOMPLET co on co.id = et.CODE_ETABLISSEMENT;

CREATE table type_piece (
id varchar (100) CONSTRAINT type_piece_pk PRIMARY key,
val varchar(100),
desce varchar(100)
);


CREATE SEQUENCE   seqtype_piece
 	INCREMENT  BY  1 
    MINVALUE 1 
    MAXVALUE 999999999999999
    START  WITH  1  
    CACHE 20  ;
    
   
CREATE OR REPLACE FUNCTION getseqtype_piece    		
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqtype_piece.nextval INTO retour FROM dual;
  return retour;	
END;  

INSERT INTO TYPE_PIECE
(ID, VAL, DESCE)
VALUES('TP01', 'Traite', 'Traite');


INSERT INTO TYPE_PIECE
(ID, VAL, DESCE)
VALUES('TP02', 'Chèque', 'Chèque');


ALTER TABLE traite add
idtypepiece varchar(100) CONSTRAINT traite_typepiece_fk  references type_piece(id);


ALTER TABLE JOURNALCAISSE ADD 
idtraite varchar(100) CONSTRAINT jc_traite_fk  references traite(id);

ALTER TABLE JOURNALCAISSE ADD 
etatversement integer;

ALTER TABLE JOURNALCAISSE ADD 
idfinaledestination varchar(100) CONSTRAINT jc_caisse_fk references caisse(id)


ALTER TABLE mvtintracaisse add
etatversement integer;

ALTER TABLE mvtintracaisse add
idfinaledestionation varchar(100)  CONSTRAINT mvtintracaisse_caisse_fk references caisse(id);