/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author Asus
 */
public class JournalBanque extends ClassEtat{
    
    private String id,folio,caisse,numpiece,libelle,remarque;
    private Date datesaisie,dateeffet;
    private double debit,credit;

    public JournalBanque() {
         super.setNomTable("journalbanque");
    }
    
    

    public JournalBanque(String id, String folio, String caisse, String numpiece, String libelle, String remarque, Date datesaisie, Date dateeffet, double debit, double credit) throws Exception {
        super.setNomTable("journalbanque");
        this.setId(id);
        this.setFolio(folio);
        this.setCaisse(caisse);
        this.setNumpiece(numpiece);
        this.setLibelle(libelle);
        this.setRemarque(remarque);
        this.setDatesaisie(datesaisie);
        this.setDateeffet(dateeffet);
        this.setDebit(debit);
        this.setCredit(credit);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        
        this.caisse = caisse;
    }

    public String getNumpiece() {
        return numpiece;
    }

    public void setNumpiece(String numpiece) {
        this.numpiece = numpiece;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public Date getDatesaisie() {
        return datesaisie;
    }

    public void setDatesaisie(Date datesaisie) {
        
         if(this.getMode().equals("modif")){
            datesaisie = Utilitaire.string_date("YYYY-MM-dd",Utilitaire.dateDuJour());
        }
       
        this.datesaisie = datesaisie;
    }

    public Date getDateeffet() {
        return dateeffet;
    }

    public void setDateeffet(Date dateeffet) {
        this.dateeffet = dateeffet;
    }

    public double getDebit() {
        return debit;
    }

    public void setDebit(double debit) throws Exception {
           if (getMode().compareToIgnoreCase("modif") == 0) {
            if (debit < 0) {
               throw new Exception("debit invalide");
            } 
        }
         this.debit = debit;
        
       
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) throws Exception {
          if (getMode().compareToIgnoreCase("modif") == 0) {
            if (credit < 0) {
               throw new Exception("credit invalide");
            } 
        }
         this.credit = credit;
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
         this.preparePk("JBQ", "getseq_journalbanque");
        this.setId(makePK(c));
        
    }
    
}
