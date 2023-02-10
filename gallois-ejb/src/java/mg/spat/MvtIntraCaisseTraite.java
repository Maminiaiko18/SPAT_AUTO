/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;
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
    private Date echeance;
    private double montanttraite;

    public void setDatetraite (Date datetraite){
        this.datetraite = datetraite;
    }

    public void setEcheance (Date echeance){
        this.echeance = echeance;
    }

    public void setMontanttraite (double montanttraite){
        this.montanttraite = montanttraite;
    }

    public Date getEcheance (){
        return this.echeance;
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

}
