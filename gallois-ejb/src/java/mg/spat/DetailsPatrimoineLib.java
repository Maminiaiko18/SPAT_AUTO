/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author john
 */
public class DetailsPatrimoineLib extends ClassMAPTable{

    private String valmarque, descemarque,valtypemateriel, descetypemateriel, id, idpatrimoine, natureobjet, surfaceoccupe, surfacedisponible, idobjet, idtypepatrimoine, remarque, etatpatrimoine,
    libelleimmatriculation , idmarque, detenteur, maintenance, idtype_materiel, rc, categorie, denomination, description, occupant, utilisation, devise, valtypepatrimoine, descetypepatrimoine, valetatpatrimoine, desceetatpatrimoine, idDevise, valDevise, desceDevise, cdclt, cdcat, nomclt, adrclt, nmsttclt, telclt, faxclt, nmcin, nif;
    private double montant, cours_change;
    private Date debut_contrat, fin_contrat, date_change, date_aquisition;
    private int puissance, etat;
    public DetailsPatrimoineLib(String valmarque, String descemarque, String valtypemateriel, String descetypemateriel, String id, String idpatrimoine, String natureobjet, String surfaceoccupe, String surfacedisponible, String idobjet, String idtypepatrimoine, String remarque, String etatpatrimoine, String libelleimmatriculation, String idmarque, String detenteur, String maintenance, String idtype_materiel, String rc, String categorie, String denomination, String description, String occupant, String utilisation, String devise, String valtypepatrimoine, String descetypepatrimoine, String valetatpatrimoine, String desceetatpatrimoine, String idDevise, String valDevise, String desceDevise, String cdclt, String cdcat, String nomclt, String adrclt, String nmsttclt, String telclt, String faxclt, String nmcin, String nif, double montant, double cours_change, Date debut_contrat, Date fin_contrat, Date date_change, Date date_aquisition, int puissance, int etat) {
        this.valmarque = valmarque;
        this.descemarque = descemarque;
        this.valtypemateriel = valtypemateriel;
        this.descetypemateriel = descetypemateriel;
        this.id = id;
        this.idpatrimoine = idpatrimoine;
        this.natureobjet = natureobjet;
        this.surfaceoccupe = surfaceoccupe;
        this.surfacedisponible = surfacedisponible;
        this.idobjet = idobjet;
        this.idtypepatrimoine = idtypepatrimoine;
        this.remarque = remarque;
        this.etatpatrimoine = etatpatrimoine;
        this.libelleimmatriculation = libelleimmatriculation;
        this.idmarque = idmarque;
        this.detenteur = detenteur;
        this.maintenance = maintenance;
        this.idtype_materiel = idtype_materiel;
        this.rc = rc;
        this.categorie = categorie;
        this.denomination = denomination;
        this.description = description;
        this.occupant = occupant;
        this.utilisation = utilisation;
        this.devise = devise;
        this.valtypepatrimoine = valtypepatrimoine;
        this.descetypepatrimoine = descetypepatrimoine;
        this.valetatpatrimoine = valetatpatrimoine;
        this.desceetatpatrimoine = desceetatpatrimoine;
        this.idDevise = idDevise;
        this.valDevise = valDevise;
        this.desceDevise = desceDevise;
        this.cdclt = cdclt;
        this.cdcat = cdcat;
        this.nomclt = nomclt;
        this.adrclt = adrclt;
        this.nmsttclt = nmsttclt;
        this.telclt = telclt;
        this.faxclt = faxclt;
        this.nmcin = nmcin;
        this.nif = nif;
        this.montant = montant;
        this.cours_change = cours_change;
        this.debut_contrat = debut_contrat;
        this.fin_contrat = fin_contrat;
        this.date_change = date_change;
        this.date_aquisition = date_aquisition;
        this.puissance = puissance;
        this.etat = etat;
    }
    public DetailsPatrimoineLib() {
        super.setNomTable("DETAILSPATRIMOINELIB");
    }
    
     @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getValmarque() {
        return valmarque;
    }

    public void setValmarque(String valmarque) {
        this.valmarque = valmarque;
    }

    public String getDescemarque() {
        return descemarque;
    }

    public void setDescemarque(String descemarque) {
        this.descemarque = descemarque;
    }

    public String getValtypemateriel() {
        return valtypemateriel;
    }

    public void setValtypemateriel(String valtypemateriel) {
        this.valtypemateriel = valtypemateriel;
    }

    public String getDescetypemateriel() {
        return descetypemateriel;
    }

    public void setDescetypemateriel(String descetypemateriel) {
        this.descetypemateriel = descetypemateriel;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdpatrimoine() {
        return idpatrimoine;
    }

    public void setIdpatrimoine(String idpatrimoine) {
        this.idpatrimoine = idpatrimoine;
    }

    public String getNatureobjet() {
        return natureobjet;
    }

    public void setNatureobjet(String natureobjet) {
        this.natureobjet = natureobjet;
    }

    public String getSurfaceoccupe() {
        return surfaceoccupe;
    }

    public void setSurfaceoccupe(String surfaceoccupe) {
        this.surfaceoccupe = surfaceoccupe;
    }

    public String getSurfacedisponible() {
        return surfacedisponible;
    }

    public void setSurfacedisponible(String surfacedisponible) {
        this.surfacedisponible = surfacedisponible;
    }

    public String getIdobjet() {
        return idobjet;
    }

    public void setIdobjet(String idobjet) {
        this.idobjet = idobjet;
    }

    public String getIdtypepatrimoine() {
        return idtypepatrimoine;
    }

    public void setIdtypepatrimoine(String idtypepatrimoine) {
        this.idtypepatrimoine = idtypepatrimoine;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getEtatpatrimoine() {
        return etatpatrimoine;
    }

    public void setEtatpatrimoine(String etatpatrimoine) {
        this.etatpatrimoine = etatpatrimoine;
    }

    public String getLibelleimmatriculation() {
        return libelleimmatriculation;
    }

    public void setLibelleimmatriculation(String libelleimmatriculation) {
        this.libelleimmatriculation = libelleimmatriculation;
    }

    public String getIdmarque() {
        return idmarque;
    }

    public void setIdmarque(String idmarque) {
        this.idmarque = idmarque;
    }

    public String getDetenteur() {
        return detenteur;
    }

    public void setDetenteur(String detenteur) {
        this.detenteur = detenteur;
    }

    public String getMaintenance() {
        return maintenance;
    }

    public void setMaintenance(String maintenance) {
        this.maintenance = maintenance;
    }

    public String getIdtype_materiel() {
        return idtype_materiel;
    }

    public void setIdtype_materiel(String idtype_materiel) {
        this.idtype_materiel = idtype_materiel;
    }

    public String getRc() {
        return rc;
    }

    public void setRc(String rc) {
        this.rc = rc;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public String getDenomination() {
        return denomination;
    }

    public void setDenomination(String denomination) {
        this.denomination = denomination;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getOccupant() {
        return occupant;
    }

    public void setOccupant(String occupant) {
        this.occupant = occupant;
    }

    public String getUtilisation() {
        return utilisation;
    }

    public void setUtilisation(String utilisation) {
        this.utilisation = utilisation;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getValtypepatrimoine() {
        return valtypepatrimoine;
    }

    public void setValtypepatrimoine(String valtypepatrimoine) {
        this.valtypepatrimoine = valtypepatrimoine;
    }

    public String getDescetypepatrimoine() {
        return descetypepatrimoine;
    }

    public void setDescetypepatrimoine(String descetypepatrimoine) {
        this.descetypepatrimoine = descetypepatrimoine;
    }

    public String getValetatpatrimoine() {
        return valetatpatrimoine;
    }

    public void setValetatpatrimoine(String valetatpatrimoine) {
        this.valetatpatrimoine = valetatpatrimoine;
    }

    public String getDesceetatpatrimoine() {
        return desceetatpatrimoine;
    }

    public void setDesceetatpatrimoine(String desceetatpatrimoine) {
        this.desceetatpatrimoine = desceetatpatrimoine;
    }

    public String getIdDevise() {
        return idDevise;
    }

    public void setIdDevise(String idDevise) {
        this.idDevise = idDevise;
    }

    public String getValDevise() {
        return valDevise;
    }

    public void setValDevise(String valDevise) {
        this.valDevise = valDevise;
    }

    public String getDesceDevise() {
        return desceDevise;
    }

    public void setDesceDevise(String desceDevise) {
        this.desceDevise = desceDevise;
    }

    public String getCdclt() {
        return cdclt;
    }

    public void setCdclt(String cdclt) {
        this.cdclt = cdclt;
    }

    public String getCdcat() {
        return cdcat;
    }

    public void setCdcat(String cdcat) {
        this.cdcat = cdcat;
    }

    public String getNomclt() {
        return nomclt;
    }

    public void setNomclt(String nomclt) {
        this.nomclt = nomclt;
    }

    public String getAdrclt() {
        return adrclt;
    }

    public void setAdrclt(String adrclt) {
        this.adrclt = adrclt;
    }

    public String getNmsttclt() {
        return nmsttclt;
    }

    public void setNmsttclt(String nmsttclt) {
        this.nmsttclt = nmsttclt;
    }

    public String getTelclt() {
        return telclt;
    }

    public void setTelclt(String telclt) {
        this.telclt = telclt;
    }

    public String getFaxclt() {
        return faxclt;
    }

    public void setFaxclt(String faxclt) {
        this.faxclt = faxclt;
    }

    public String getNmcin() {
        return nmcin;
    }

    public void setNmcin(String nmcin) {
        this.nmcin = nmcin;
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getCours_change() {
        return cours_change;
    }

    public void setCours_change(double cours_change) {
        this.cours_change = cours_change;
    }

    public Date getDebut_contrat() {
        return debut_contrat;
    }

    public void setDebut_contrat(Date debut_contrat) {
        this.debut_contrat = debut_contrat;
    }

    public Date getFin_contrat() {
        return fin_contrat;
    }

    public void setFin_contrat(Date fin_contrat) {
        this.fin_contrat = fin_contrat;
    }

    public Date getDate_change() {
        return date_change;
    }

    public void setDate_change(Date date_change) {
        this.date_change = date_change;
    }

    public Date getDate_aquisition() {
        return date_aquisition;
    }

    public void setDate_aquisition(Date date_aquisition) {
        this.date_aquisition = date_aquisition;
    }

    public int getPuissance() {
        return puissance;
    }

    public void setPuissance(int puissance) {
        this.puissance = puissance;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

}
