/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Constante;
import utilitaire.Utilitaire;

/**
 *
 * @author Sanda
 */
public class MvttIntraCaisse extends ClassEtat {
    private String id,caissedepart,caissearrivee,modepaiement,remarque,designation;
    private Date daty;
    private double montant;
    
    public MvttIntraCaisse(){
        super.setNomTable("mvtintracaisse");
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCaissedepart() {
        return caissedepart;
    }

    public void setCaissedepart(String caissedepart) {
        this.caissedepart = caissedepart;
    }

    public String getCaissearrivee() {
        return caissearrivee;
    }

    public void setCaissearrivee(String caissearrivee) {
        this.caissearrivee = caissearrivee;
    }

    public String getModepaiement() {
        return modepaiement;
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        super.preparePk("MIC", "get_seq_mvtintracaisse");
        this.setId(makePK(c));
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        JournalCaisse sortie = new JournalCaisse(null, this.getCaissedepart(), null, this.getDesignation(), null, Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), this.getMontant(), 0);
        sortie.setIddevise(Constante.deviseAr);
        sortie.setIdmode(this.getModepaiement());

        sortie.createObject(u, c);
        sortie.validerObject(u, c);
        
        JournalCaisse entree = new JournalCaisse(null, this.getCaissearrivee(), null, this.getDesignation(), null, Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), 0, this.getMontant());
        entree.setIddevise(Constante.deviseAr);
        entree.setIdmode(this.getModepaiement());

        entree.createObject(u, c);
        entree.validerObject(u, c);
        
        return super.validerObject(u, c); //To change body of generated methods, choose Tools | Templates.
    }
    
    @Override
    public void controler(Connection c) throws Exception{
        if(this.getCaissedepart() != null && this.getCaissearrivee() != null){
            if(this.getCaissedepart().equalsIgnoreCase(this.getCaissearrivee())){
                throw new Exception("Caisse de départ et d' arrivée identiques");
            }
        }
    }
}
