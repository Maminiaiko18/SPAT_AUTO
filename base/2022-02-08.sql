create or replace view factureclientMA as
select fdc.*,EXTRACT (MONTH FROM fdc.daty) AS mois,
          EXTRACT (YEAR FROM fdc.daty) AS annee,
          CASE WHEN TYPE = 'TFC001' THEN 1 ELSE 0 END AS nbreacredit,
          CASE WHEN TYPE = 'TFC002' THEN 1 ELSE 0 END AS aucomptant
           from factureClient fdc
           where fdc.etat>=11 and FDC.IDCATEGORIE!='CATFCO2' ;
           
           
create or replace view factureClientMAGroupe as
select mois,annee,sum(nbreacredit) as nbCredit,sum(aucomptant) as nbComptant from factureclientMA
group by mois, annee;