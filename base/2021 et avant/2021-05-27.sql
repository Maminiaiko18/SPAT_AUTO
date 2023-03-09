
create or replace view FACTURE_CLIENT_FILLE_LIB_RESTE
            (ID, IDMERE, DESIGNATION, QUANTITE, PU, COMPTE, IDPRODUIT, DEVISE, TAUX, QTELIVREE, RESTEALIVRER,
             MONTANTTAUX, MONTANT, MONTANTAVOIRSANSTAUX, MONTANTAVOIRAVECTAUX,
             TVA, idactivite, activitelib)
as
SELECT fc.ID,
       fc.IDMERE,
       fc.DESIGNATION,
       fc.QUANTITE,
       fc.PU,
       fc.COMPTE,
       pr.NOM                                     AS IDPRODUIT,
       fc.DEVISE,
       fc.TAUX,
       CAST(NVL(gr.QUANTITE, 0) AS NUMBER(10, 2)) AS qteLivree,
       CAST(fc.QUANTITE - NVL(gr.QUANTITE, 0) AS NUMBER(10, 2))
                                                  AS resteAlivrer,
       CAST(fcm.MONTANTTAUX AS NUMBER(32, 2)),
       CAST(fcm.MONTANT AS NUMBER(32, 5)),
       CAST(fcm.MONTANTAVOIRSANSTAUX AS NUMBER(32, 2)),
       CAST(fcm.MONTANTAVOIRAVECTAUX AS NUMBER(32, 2)),
       CAST(fcm.tva AS NUMBER(20, 2)),
       idactivite,
       ra.DESIGNATION                             as activitelib
FROM facture_client_fille fc
         LEFT JOIN AS_PRODUITS pr ON pr.ID = fc.IDPRODUIT
         LEFT JOIN as_bondelivraison_cl_grp gr
                   ON gr.IDDETAILSFACTUREFOURNISSEUR = fc.ID
         LEFT JOIN FACTURE_CLIENT_MONTANT fcm ON fcm.id = fc.id
         left join ACTIVITE ra on ra.id = fc.IDACTIVITE;


create or replace view FACTURE_CLIENT_FILLE_PLUS as
SELECT facture_client_fille.ID,
          facture_client_fille.IDMERE,
          facture_client_fille.DESIGNATION,
          facture_client_fille.QUANTITE,
          facture_client_fille.PU,
          facture_client_fille.COMPTE,
          facture_client_fille.IDPRODUIT,
          facture_client_fille.DEVISE,
          facture_client_fille.TAUX,
          CAST (0.0 AS NUMBER (30, 2)) AS montant,
		  facture_client_fille.tva,
       facture_client_fille.IDACTIVITE
     FROM facture_client_fille where 1>2;

create view FACTURE_CLIENT_FILLE_libelle as
select fi.*,
       pr.nom as produit_lib,
       ac.DESIGNATION as activitelib

from FACTURE_CLIENT_FILLE fi
        left join AS_PRODUITS pr on pr.id=fi.IDPRODUIT
         left join activite ac on ac.id=fi.IDACTIVITE ;



create or replace FUNCTION get_seq_Factureclient
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_Factureclient.nextval INTO retour FROM dual;
  return retour;
END;

create or replace FUNCTION get_seq_facture_client_fille
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_facture_client_fille.nextval INTO retour FROM dual;
  return retour;
END;

create or replace FUNCTION get_seqrubrique_activite
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqrubrique_activite.nextval INTO retour FROM dual;
  return retour;
END;

    create or replace FUNCTION get_seqdetFormuFact
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqdetFormuFact.nextval INTO retour FROM dual;
  return retour;
END;

        create or replace FUNCTION get_seqAvoirFC
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqAvoirFC.nextval INTO retour FROM dual;
  return retour;
END;

create or replace FUNCTION get_seqfacture_prof_fille
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqfacture_prof_fille.nextval INTO retour FROM dual;
  return retour;
END;

    create or replace FUNCTION get_seqfacture_prof_mere
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqfacture_prof_mere.nextval INTO retour FROM dual;
  return retour;
END;

create or replace FUNCTION get_seqas_bondelivraison_cl
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqas_bondelivraison_cl.nextval INTO retour FROM dual;
  return retour;
END;

      create or replace FUNCTION get_seqasbondelivraisonclfille
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqasbondelivraison_cl_fille.nextval INTO retour FROM dual;
  return retour;
END;

    create or replace FUNCTION get_seq_facture_client_fille
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seq_facture_client_fille.nextval INTO retour FROM dual;
  return retour;
END;

        create or replace FUNCTION get_seqactivite
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqactivite.nextval INTO retour FROM dual;
  return retour;
END;

create or replace FUNCTION get_seqtransitionPaiementVide
  RETURN NUMBER IS
  retour NUMBER;
BEGIN
  SELECT seqtransitionPaiementVide.nextval INTO retour FROM dual;
  return retour;
END;


update menudynamique set libelle='Activite' where id='MEN0074100';