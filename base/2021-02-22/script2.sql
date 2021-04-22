
ALTER TABLE details_patrimoine ADD utilisateur varchar2(500);
ALTER TABLE details_patrimoine ADD date_debut_contrat date;
ALTER TABLE details_patrimoine ADD date_fin_contrat date;
ALTER TABLE details_patrimoine ADD remarque varchar2(4000);
             


CREATE OR REPLACE  VIEW PATRIMOINELIBCOMPLET 
(ID, IDOBJET, IDTYPEPATRIMOINE, REMARQUE, ETATPATRIMOINE, 
LIBELLE, DESCRIPTION, MONTANT, OCCUPANT, DEBUT_CONTRAT, 
FIN_CONTRAT, UTILISATION, DEVISE, COURS_CHANGE, DATE_CHANGE, 
VALTYPEPATRIMOINE, DESCETYPEPATRIMOINE, VALETATPATRIMOINE, 
DESCEETATPATRIMOINE, IDDEVISE, VALDEVISE, DESCEDEVISE, CDCLT, 
CDCAT, NOMCLT, ADRCLT, NMSTTCLT, TELCLT, FAXCLT, NMCIN, NIF, RC, 
CATEGORIE, DENOMINATION, DATE_AQUISITION, IDMARQUE, PUISSANCE, DETENTEUR, 
MAINTENANCE, IDTYPE_MATERIEL, IMMATRICULATION, ETAT, VALMARQUE, DESCEMARQUE, 
VALTYPEMATERIEL, DESCETYPEMATERIEL,SUPERFICIE) AS 
  select
        p.ID,p.IDOBJET,p.IDTYPEPATRIMOINE,p.REMARQUE,p.ETAT as etatpatrimoine,p.LIBELLE,p.DESCRIPTION,p.MONTANT,p.OCCUPANT,p.DEBUT_CONTRAT,p.FIN_CONTRAT,p.UTILISATION,
        p.DEVISE, p.COURS_CHANGE, p.DATE_CHANGE,
        type.val as valtypepatrimoine, type.desce as descetypepatrimoine,
        etat.VAL as valetatpatrimoine, etat.DESCE as desceetatpatrimoine,
        dev.id as iddevise, dev.val as valdevise, dev.DESCE as descedevise,
        clt.CDCLT, CDCAT, NOMCLT, ADRCLT, NMSTTCLT, TELCLT, FAXCLT, NMCIN, NIF, RC, CATEGORIE,
        mat.DENOMINATION, DATE_AQUISITION, IDMARQUE, PUISSANCE, DETENTEUR, MAINTENANCE, IDTYPE_MATERIEL, 
        IMMATRICULATION, mat.ETAT, VALMARQUE, DESCEMARQUE, VALTYPEMATERIEL, DESCETYPEMATERIEL,
        SUPERFICIE 
    from PATRIMOINE p
        LEFT join TYPEPATRIMOINE type on p.IDTYPEPATRIMOINE = type.ID
        LEFT join ETATPATRIMOINE etat on p.ETAT = etat.ID
        LEFT join V_CLIENT_CATEGORIE clt on clt.cdclt=p.occupant
        LEFT join DEVISEDEMAT dev on dev.ID=p.DEVISE
        left join MATERIELNAVALLIBCOMPLET mat on mat.id = p.IDOBJET;

  CREATE OR REPLACE VIEW DETAILSPATRIMOINELIB (IDOBJET, IDTYPEPATRIMOINE, REMARQUE, ETATPATRIMOINE, LIBELLE, DESCRIPTION, MONTANT, OCCUPANT, DEBUT_CONTRAT, FIN_CONTRAT, UTILISATION, DEVISE, COURS_CHANGE, DATE_CHANGE, VALTYPEPATRIMOINE, DESCETYPEPATRIMOINE, VALETATPATRIMOINE, DESCEETATPATRIMOINE, IDDEVISE, VALDEVISE, DESCEDEVISE, CDCLT, CDCAT, NOMCLT, ADRCLT, NMSTTCLT, TELCLT, FAXCLT, NMCIN, NIF, RC, CATEGORIE, DENOMINATION, DATE_AQUISITION, IDMARQUE, PUISSANCE, DETENTEUR, MAINTENANCE, IDTYPE_MATERIEL, IMMATRICULATION, ETAT, VALMARQUE, DESCEMARQUE, VALTYPEMATERIEL, DESCETYPEMATERIEL, ID, IDPATRIMOINE, NATUREOBJET, SURFACEOCCUPE, SURFACEDISPONIBLE) AS 
  select
        p.idobjet, idtypepatrimoine, p.remarque, etatpatrimoine, libelle, description, montant, occupant, debut_contrat, fin_contrat, utilisation, devise, cours_change, date_change, valtypepatrimoine, descetypepatrimoine, valetatpatrimoine, desceetatpatrimoine, iddevise, valdevise, descedevise, cdclt, cdcat, nomclt, adrclt, nmsttclt, telclt, faxclt, nmcin, nif, rc, categorie, denomination, date_aquisition, idmarque, puissance, detenteur, maintenance, idtype_materiel, immatriculation, etat, valmarque, descemarque, valtypemateriel, descetypemateriel,
        det.id,
        p.libelle as idpatrimoine,
        det.natureObjet,
        det.surfaceOccupe,
        det.surfaceDisponible
    from Details_Patrimoine det
	    join PATRIMOINELIBCOMPLET p on det.idPatrimoine = p.id;

create or replace view journalcaisse_sommeCredit as
select j.*, 0 as sommeCredit from journalcaisse j;
