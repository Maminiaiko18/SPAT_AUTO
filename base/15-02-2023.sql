
----create
        CREATE OR REPLACE  VIEW PAIEMENTFACTUREBPCPL AS 
  SELECT pf.ID,
          pf.IDMVT,
          pf.IDFACT,
          CAST(pf.MONTANT AS number(30,2)) AS montant,
          ff.DESIGNATION,
          ff.NUMFACT ,
          ff.DATY 
     FROM paiementfacturef pf JOIN facture_fournisseur_mere ff ON ff.id = pf.idfact
    WHERE ff.etat >= 11 AND ff.idcategorie = 'CATGFF002';

   
   ----add column deviselib
   
   CREATE OR REPLACE  VIEW ORDONNERPAYEMENT_LIB (ID, DED_ID, IDLIGNE, DESTINATION, DATY, MONTANT, REMARQUE, ETAT, NUMEROOP, MODEPAIEMENT, TIERS, ADRESSE, NUMFACT, DESTINATIONLIB, BENEFICIAIRE, DEVISE,deviselib) AS 
  select op.ID,
       op.DED_ID,
       op.IDLIGNE,
       op.DESTINATION,
       op.DATY,
       op.MONTANT,
       op.REMARQUE,
       op.ETAT,
       op.NUMEROOP,
       mp.VAL  as MODEPAIEMENT,
       fup.NOM as TIERS,
       fup.ADRESSE,
       op1.numfact,
       de.val as destinationlib,
       op.tiers as beneficiaire,
       f.DEVISEMERE,
       d.desce AS deviselib
from ORDONNERPAYEMENT op
         left join MODEPAIEMENT mp on mp.id = op.MODEPAIEMENT
         left join FOURNISSEUR_UNION_PERSONNEL fup on fup.id = op.TIERS
         left join concat_numfact_ff op1 on op.id=op1.id2
         left join DESTINATION de on de.id = op.DESTINATION
         left join FACTURE_FOURNISSEUR_MERE f on f.id =  nvl(SUBSTR(op.DED_ID, 0, INSTR(op.DED_ID, ';') - 1) ,op.DED_ID)
		 LEFT JOIN devise d ON d.id =f.DEVISEMERE;
  
  
 
  CREATE OR REPLACE VIEW TRAITE_LIB (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT, REFERENCE, CDCLT, IDBANQUE) AS 
  select
	tr.id,
	tr.daty,
	ti.nomclt as tiers,
	ba.val as banque,
	tr.dateEcheance,
	tr.etat,
	tr.montant,
	tr.REFERENCE,
	ti.CDCLT,
	ba.ID AS idbanque
	from traite tr
	left join client_union ti on tr.tiers = ti.CDCLT 
	left join banque ba on tr.banque = ba.id;

CREATE OR REPLACE VIEW TRAITE_LIBMTT (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT, ESCOMPTE, TOTAL, REFERENCE, CDCLT, IDBANQUE) AS 
  select t.ID,t.DATY,t.TIERS,t.BANQUE,t.DATEECHEANCE,t.ETAT,t.MONTANT,
sum(nvl(e.FRAIS,0)) AS escompte,
montant - sum(nvl(e.FRAIS, 0)) AS total, t.reference,
t.CDCLT,
t.idbanque
from traite_lib t
LEFT JOIN ESCOMPTE_LIBV e ON e.IDTRAITE = t.id
GROUP BY t.id, t.DATY ,t.TIERS ,t.BANQUE ,t.DATEECHEANCE ,t.ETAT ,t.MONTANT,t.REFERENCE, t.CDCLT, t.idbanque ;


CREATE OR REPLACE VIEW TRAITEMTTRESTE (ID, DATY, TIERS, BANQUE, DATEECHEANCE, ETAT, MONTANT, ESCOMPTE, TOTAL, REFERENCE, MONTANTRESTE, CDCLT, IDBANQUE) AS 
  SELECT t.ID,t.DATY,t.TIERS,t.BANQUE,t.DATEECHEANCE,t.ETAT,t.MONTANT,t.ESCOMPTE,t.TOTAL,t.REFERENCE,
 (t.total-tf. montantenlevetraite) AS montantreste, t.cdclt, t.idbanque
 FROM TRAITE_LIBMTT t 
 LEFT JOIN traitemttfc tf ON tf.id=t.id;
 
 
 
 
 
 CREATE OR REPLACE VIEW PAIEMENTFC_TOUS (ID, DATEEFFET, CAISSE, TIERSLIB, LIBELLE, MONTANT, IDFACT, ETAT, ETATLIB, VALCAISSE) AS 
  select
    jc.id,
    JC.DATEEFFET,
    jc.caisse,
    jc.tierslib,
    jc.libelle,
    pf.montant,
    pf.idfact,
    jc.etat,
    CASE 
    	WHEN jc.etat = 1
    		THEN 'Créé'
        WHEN jc.ETAT >= 11
        	THEN 'visée'
        WHEN jc.ETAT =0
        	THEN 'Annulée'
    END AS etatlib,
    jc.VALCAISSE 
    from
   JOURNALCAISSELIBCOMPLET jc
   left join paiementfacture pf
   on pf.idmvt=jc.id
;
