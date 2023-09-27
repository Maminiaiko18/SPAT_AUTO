/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.travaux;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import user.UserEJBBean;

/**
 *
 * @author rajao
 */
public class PourcentageProjet extends ClassEtat{
    private String id,idChantier,observation,idUtilisateur;
    Date daty;
    private double pourcentage;
    String etatlib;
    
    public PourcentageProjet()
    {
        super.setNomTable("pourcentageProjet");
    }
    public String getId() {
        return id;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdChantier() {
        return idChantier;
    }

    public void setIdChantier(String idChantier) {
        this.idChantier = idChantier;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public String getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(String idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    public double getPourcentage() {
        return pourcentage;
    }

    public void setPourcentage(double pourcentage)throws Exception {
        if(getMode().compareToIgnoreCase("modif")==0)
        {
            if(pourcentage < 0 || pourcentage > 100)
            {
                throw new Exception("Pourcentage ne peut pas \\352tre inf\\351rieure \\340 0 ou sup\\351rieur \\340 100.");
            }
        }
        this.pourcentage = pourcentage;
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
        this.preparePk("PP", "GETSEQpourcentageprojet");
        this.setId(makePK(c));
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        try{
            if(this.getIdChantier() != null){
                this.controlePourcentage(c);
            }
            
            return super.validerObject(u, c);
        }
        catch(Exception e){
            throw e;
        }
    }
    
    public void controlePourcentage(Connection c) throws Exception {
        try{
            PourcentageProjet[] pourcentageProjets = (PourcentageProjet[]) CGenUtil.rechercher(new PourcentageProjet(), null, null, c, " and idchantier ='" + this.getIdChantier() + "' and etat >= 11");
            double somme = this.getPourcentage();
            if(pourcentageProjets.length > 0)
                somme += AdminGen.calculSommeDouble(pourcentageProjets, "pourcentage");
            if(somme > 100){
                throw new Exception("Pourcentage total sup\\351rieur \\340 100.");
            }
        }
        catch(Exception e){
            throw e;
        }
    }
}
