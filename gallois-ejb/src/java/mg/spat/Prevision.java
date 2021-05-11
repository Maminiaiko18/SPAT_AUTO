/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import service.NavireService;
import service.PrevisionService;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Asus
 */
public class Prevision extends ClassEtat {

    private String id;
    private Date date_rade;
    private String provenance;
    private String navire;
    private String consignataire;
    private String cargaison;
    private String pilote;
    private Date date_arrivee;
    private String heure_arrivee;
    private Date date_depart;
    private String heure_depart;
    private String destination, escale;
    private String couleur = "#1E90FF";
    private String noVoyage;

    

    

    public Prevision() {
        super.setNomTable("prevision");
    }

    @Override
    public ClassMAPTable createObject(String u,Connection c) throws Exception {
        controlerDoublon(c);
        super.createObject(u, c);
        return this;
    }

    private void controlerDoublon(Connection c) throws Exception {
        if (this.getEscale() != null && !this.getEscale().equalsIgnoreCase("")) {
            Prevision[] tmp = (Prevision[]) CGenUtil.rechercher(new Prevision(), null, null, c, " and escale like '" + this.getEscale() + "'");
            if (tmp != null && tmp.length > 0) {
                throw new Exception("Erreur doublon: Escale!");
            }
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProvenance() {
        return provenance;
    }

    public void setProvenance(String provenance) {
        this.provenance = provenance;
    }
    public String getCouleur() {
        return couleur;
    }

    public void setCouleur(String couleur) {
        this.couleur = couleur;
    }
    
    public String getNoVoyage() {
        return noVoyage;
    }

    public void setNoVoyage(String noVoyage) {
        this.noVoyage = noVoyage;
    }
    
    public String getNavire() {
        return navire;
    }

    public void setNavire(String navire) {
        this.navire = navire;
    }

    public String getConsignataire() {
        return consignataire;
    }

    public void setConsignataire(String consignataire) {
        this.consignataire = consignataire;
    }

    public String getCargaison() {
        return cargaison;
    }

    public void setCargaison(String cargaison) {
        this.cargaison = cargaison;
    }

    public String getPilote() {
        return pilote;
    }

    public void setPilote(String pilote) {
        this.pilote = pilote;
    }

    public Date getDate_rade() {
        return date_rade;
    }

    public void setDate_rade(Date date_rade) {
        if (this.getMode().equals("modif")) {
            date_rade = Utilitaire.string_date("dd/MM/yyyy", Utilitaire.dateDuJour());
        }
        this.date_rade = date_rade;
    }

    public Date getDate_arrivee() {
        return date_arrivee;
    }

    public void setDate_arrivee(Date date_arrivee) throws Exception {
        this.date_arrivee = date_arrivee;
    }

    public String getHeure_arrivee() {
        return heure_arrivee;
    }

    public void setHeure_arrivee(String heure_arrivee) {
        this.heure_arrivee = heure_arrivee;
    }

    public Date getDate_depart() {
        return date_depart;
    }

    public String getEscale() {
        return escale;
    }

    public void setEscale(String esc) throws Exception {
        if (this.getMode().compareTo("modif") == 0) {
            if (esc != null && esc.equalsIgnoreCase("") == false && esc.length() != 11) {
                throw new Exception("Le nombre de caractères pour l\\'escale doit être égale à 11");
            }
        }
        this.escale = esc;
    }

    public void setDate_depart(Date date_depart) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (date_depart != null) {
                if (Utilitaire.compareDaty(date_depart, this.getDate_arrivee()) < 0) {
                    throw new Exception("Date depart invalide par rapport à la date d arrivee");
                }
            }
        }
        this.date_depart = date_depart;
    }

    public String getHeure_depart() {
        return heure_depart;
    }

    public void setHeure_depart(String heure_depart) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (heure_depart != null && heure_depart.compareTo("") != 0) {
                Utilitaire.testHeureValide(heure_depart);
                if (Utilitaire.compareDaty(this.getDate_depart(), this.getDate_arrivee()) == 0 && Utilitaire.comparerHeure(this.getHeure_arrivee(), heure_depart) < 0) {
                    throw new Exception("Heure de départ invalide par rapport à l heure d arrivee");
                }
            }
        }
        this.heure_depart = heure_depart;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) throws Exception {
        if (this.getMode().equalsIgnoreCase("modif")) {
            if (destination != null && destination.compareTo("") != 0 && this.getProvenance().equalsIgnoreCase(destination)) {
                throw new Exception("La destination et la provenance ne peuvent être la même!");
            }
        }

        this.destination = destination;
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PREV", "getseqprevision");
        this.setId(makePK(c));
    }

    public PrevisionLibComplet getPrevisionLibCompletById(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            PrevisionLibComplet prev = new PrevisionLibComplet();
            prev.setId(this.getId());
            PrevisionLibComplet[] liste = (PrevisionLibComplet[]) CGenUtil.rechercher(prev, null, null, c, "");
            if (liste.length > 0) {
                return liste[0];
            }
            return null;
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (verif == 1 && c != null) {
                c.close();
            }
        }
    }
}
