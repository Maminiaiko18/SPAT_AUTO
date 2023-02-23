/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;
import mg.spat.MvttIntraCaisse;
import java.sql.Connection;
import bean.CGenUtil;
import utilitaire.UtilDB;
import java.sql.Date;

/**
 *
 * @author je sais pas
 */
public class MvtIntraCaisseTraite extends MvttIntraCaisse{
    private Date datetraite; 
    private Date dateecheance;
    private double montanttraite;
    private String finaledestinationlib;

    public void setDatetraite (Date datetraite){
        this.datetraite = datetraite;
    }

    public void setDateecheance (Date echeance){
        this.dateecheance = echeance;
    }

    public void setMontanttraite (double montanttraite){
        this.montanttraite = montanttraite;
    }

    public Date getDateecheance (){
        return this.dateecheance;
    }

    public Date getDatetraite (){
        return this.datetraite;
    }

    public double getMontanttraite (){
        return this.montanttraite;
    }

    public MvtIntraCaisseTraite(){
        super.setNomTable("mvtintracaissetraite");
    }

    public String getFinaledestinationlib() {
        return finaledestinationlib;
    }

    public void setFinaledestinationlib(String finaledestinationlib) {
        this.finaledestinationlib = finaledestinationlib;
    }

}
