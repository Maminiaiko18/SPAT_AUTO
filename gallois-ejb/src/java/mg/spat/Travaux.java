/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Asus
 */
public class Travaux extends ClassEtat {

    private String id, nom, description, idpatrimoine, idtypetravaux, iddevise, projet, codeetablissement, projetlib, codeetablissementlib, tiers, tierslib;
    private Date datedebut, datefin;
    private double montant, avancement;
    private String patrimoinelib;
    ;
    private String patrimoinedesce;

    public String getPatrimoinelib() {
        return patrimoinelib;
    }

    public String getIdpatrimoine() {
        return idpatrimoine;
    }

    public void setIdpatrimoine(String idpatrimoine) {
        this.idpatrimoine = idpatrimoine;
    }

    public void setPatrimoinelib(String patrimoinelib) {
        this.patrimoinelib = patrimoinelib;
    }

    public String getPatrimoinedesce() {
        return patrimoinedesce;
    }

    public void setPatrimoinedesce(String patrimoinedesce) {
        this.patrimoinedesce = patrimoinedesce;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public Travaux(String id) {
        this.setId(id);
        this.setNomTable("travaux");
    }

    public Travaux() {
        this.setNomTable("travaux");
    }

    public Travaux(String id, String nom, String description, String idtypetravaux, Date date_debut, Date date_fin, double montant_prevue, double avancement) throws Exception {
        this.setNomTable("travaux");
        this.setId(id);
        this.setNom(nom);
        this.setDescription(description);
        this.setIdtypetravaux(idtypetravaux);
        this.setDatedebut(date_debut);
        this.setDatefin(date_fin);
        this.setMontant(montant_prevue);
        this.setAvancement(avancement);
    }

    public Travaux(String id, String nom, String description, String idtypetravaux, String iddevise, Date date_debut, Date date_fin, double montant_prevue, double avancement) throws Exception {
        this.setNomTable("travaux");
        this.setId(id);
        this.setNom(nom);
        this.setDescription(description);
        this.setIdtypetravaux(idtypetravaux);
        this.setDatedebut(date_debut);
        this.setDatefin(date_fin);
        this.setMontant(montant_prevue);
        this.setIddevise(iddevise);
        this.setAvancement(avancement);
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getCodeetablissement() {
        return codeetablissement;
    }

    public void setCodeetablissement(String codeetablissement) {
        this.codeetablissement = codeetablissement;
    }

    public String getProjetlib() {
        return projetlib;
    }

    public void setProjetlib(String projetlib) {
        this.projetlib = projetlib;
    }

    public String getCodeetablissementlib() {
        return codeetablissementlib;
    }

    public void setCodeetablissementlib(String codeetablissementlib) {
        this.codeetablissementlib = codeetablissementlib;
    }

    @Override
    public String getValColLibelle() {
        return nom+";"+idpatrimoine+";"+patrimoinelib;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDatedebut() {
        return datedebut;
    }

    public void setDatedebut(Date datedebut) throws Exception {

        this.datedebut = datedebut;

    }

    public String getIdtypetravaux() {
        return idtypetravaux;
    }

    public void setIdtypetravaux(String idtypetravaux) {
        this.idtypetravaux = idtypetravaux;
    }

    public Date getDatefin() {
        return datefin;
    }

    public void setDatefin(Date datefin) throws Exception {
        if (this.getMode().compareTo("modif") == 0) {
            if (this.getDatedebut() != null && Utilitaire.compareDaty(datefin, this.getDatedebut()) == -1) {
                throw new Exception("La date de début doit être supérieure à la date de fin");
            }
        }
        this.datefin = datefin;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (montant < 0) {
                throw new Exception("montant invalide");
            }
        }

        this.montant = montant;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public double getAvancement() {
        return avancement;
    }

    public void setAvancement(double avancement) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (avancement < 0) {
                throw new Exception("avancement invalide");
            }
        }
        this.avancement = avancement;
    }

    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("TRA", "getseq_travaux");
        this.setId(makePK(c));
    }

    public double getValueAvancement(String idtravaux, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            Chantier[] tchantier = this.getChantierProjet(idtravaux, c);
            double valiny = moyenneAvancementProjet(tchantier, c);
            if (Double.isNaN(valiny)) {
                valiny = 0;
            }
            return valiny;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public Chantier[] getChantierProjet(String idtravaux, Connection c) throws Exception {
        Chantier[] chantier = null;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            Chantier ch = new Chantier();
            ch.setNomTable("chantierlibelle");
            chantier = (Chantier[]) CGenUtil.rechercher(ch, null, null, c, " and travaux='" + idtravaux + "' and etat>=" + ConstanteEtat.getEtatValider());
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return chantier;
    }

    public double moyenneAvancementProjet(Chantier[] chantier, Connection c) {
        double valiny = 0;
        try {
            valiny = AdminGen.calculSommeDouble(chantier, "avancement");
            valiny = valiny / chantier.length;
        } catch (Exception e) {
            throw e;
        }
        return valiny;
    }

}
