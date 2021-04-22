
create or replace view FOURNISSEUR_UNION_PERSONNEL as 
SELECT tp.ID,
          tp.NOM,
          tp.DESCRIPTION,
          tp.NIF,
          tp.STAT,
          tp.CONTACT,
          tp.RESPONSABLE,
          tp.ADRESSE,
          tp.TYPE,
          tp.ETAT
     FROM TIERS_PRESTATAIRE tp
   UNION
   SELECT an.SA_COMPTEURNUMERO AS ID,
          an.NOM || ' ' || an.PRENOM AS nom,
          '' AS DESCRIPTION,
          '' AS NIF,
          '' AS STAT,
          an.TELEPHONE AS CONTACT,
          '' AS RESPONSABLE,
          an.RUE1 AS ADRESSE,
          an.TYPE,
          11 AS etat
     FROM ANALYSEPERSONNELUNION an
 union
    select
        cl.cdclt as ID,
        cl.nomclt as nom,
        '' AS DESCRIPTION,
        cl.nif AS NIF,
        cl.nmsttclt AS STAT,
        cl.telclt AS CONTACT,
        '' AS RESPONSABLE,
        cl.adrclt AS ADRESSE,
        cl.cdcat as TYPE,
        11 AS etat
    from V_CLIENT_CATEGORIE cl;
    
delete from menudynamique where id in ('MEN00501','MEN00501S','MEN00501L');