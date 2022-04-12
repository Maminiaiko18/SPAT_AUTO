/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

/**
 *
 * @author je sais pas
 */
public class AvoirFCFilleLib extends AvoirFCFille{
    private String devise, designation;
    private double tvaDf, tvaAv;
    
    public AvoirFCFilleLib() throws Exception{
        setNomTable("AvoirFCFille_plus");
    }

    public double getTvaDf() {
        return tvaDf;
    }

    public void setTvaDf(double tvaDf) {
        this.tvaDf = tvaDf;
    }

    public double getTvaAv() {
        return tvaAv;
    }

    public void setTvaAv(double tvaAv) {
        this.tvaAv = tvaAv;
    }
    
    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
}
