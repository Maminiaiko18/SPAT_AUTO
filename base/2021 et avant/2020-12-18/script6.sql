create or replace view ETATFACTUREMONTANTDATY as
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
           WHEN et.etat = 'VALIDER' THEN '11'
           WHEN et.etat = 'CREER' THEN '1'
           ELSE '0'
           END               AS etat,
       et.montantpaye,
       et.reste - et.retenue AS reste,
       et.entite,
       et.montantttdevise,
       et.budget,
       et.retenue,
       ff.montant,
       t.NOM as tierslib,
       et.IDTVA as tva,
       cast(ff.MONTANT*(et.IDTVA/100) as number(25,2))as montanttva,
       cast(ff.montant+ff.MONTANT*(et.IDTVA/100) as number(25,2))  as montantttc

FROM etatfacturemontantdatyretenu et
        join facturefournisseur_SumMtt ff on ff.id=et.id
        left join TIERS t on t.id=et.idfournisseur;

CREATE or replace VIEW EtatFactureMontantDatyVISE AS SELECT * FROM EtatFactureMontantDaty WHERE etat = 11;
CREATE or replace VIEW EtatFactureMontantDatyCREE AS SELECT * FROM EtatFactureMontantDaty WHERE etat = 1;
