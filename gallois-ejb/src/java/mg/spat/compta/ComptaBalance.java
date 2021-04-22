/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.ClassMAPTable;
import utilitaire.Utilitaire;

/**
 *
 * @author MEVA
 */
public class ComptaBalance extends ClassMAPTable{
//    private String id;
    private String compte;
    private String idcompte;
//    private String typecompte;
//    private Date daty;
    private double debit;
    private double credit;
//    private String mere;
    private String exercice;
    private String intitule;
    
    
    public ComptaBalance() {
        this.setNomTable("compta_sous_ecriture_vise");
    }

//    public String getId() {
//        return id;
//    }
//
//    public void setId(String id) {
//        this.id = id;
//    }

    public String getCompte() {
        return Utilitaire.champNull(compte);
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getIdcompte() {
        return Utilitaire.champNull(idcompte);
    }

    public void setIdcompte(String idcompte) {
        this.idcompte = idcompte;
    }
//
//    public String getTypecompte() {
//        return Utilitaire.champNull(typecompte);
//    }
//
//    public void setTypecompte(String typecompte) {
//        this.typecompte = typecompte;
//    }

    public double getDebit() {
        return debit;
    }

    public void setDebit(double debit) {
        this.debit = debit;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }
//
//    public String getMere() {
//        return Utilitaire.champNull(mere);
//    }
//
//    public void setMere(String mere) {
//        this.mere = mere;
//    }

    public String getExercice() {
        return Utilitaire.champNull(exercice);
    }

    public void setExercice(String exercice) {
        this.exercice = exercice;
    }

    public String getIntitule() {
        return Utilitaire.champNull(intitule);
    }

    public void setIntitule(String intitule) {
        this.intitule = intitule;
    }

//    public Date getDaty() {
//        return daty;
//    }
//
//    public void setDaty(Date daty) {
//        this.daty = daty;
//    }

    public String getTuppleID() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public String getAttributIDName() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    
    
}
