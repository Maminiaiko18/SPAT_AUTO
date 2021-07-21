/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import java.sql.Connection;

/**
 *
 * @author je sais pas
 */
public class FactureProformaDetails extends FactureClientDetails {
    

    public FactureProforma getMere(Connection c) throws Exception {
        FactureProforma mere = new FactureProforma();
        mere.setId(getIdmere());
        mere = (FactureProforma) mere.getById(getIdmere(), null, c);
        if(mere == null){
            throw new Exception("Facture Proforma mere non trouvee !");
        }
        return mere;
    }
    
    public FactureProformaDetails() throws Exception {
        super.setNomTable("facture_prof_fille");
        setLiaisonMere("idmere");
        this.setNomClasseMere("facture.FactureProforma");
    }
    
    @Override
    public String getLiaisonMere(){
        return "idmere";
    }
    
    public String moislib;
    public String anneelib;

    public String getMoislib() {
        return moislib;
    }

    public void setMoislib(String moislib) {
        this.moislib = moislib;
    }

    public String getAnneelib() {
        return anneelib;
    }

    public void setAnneelib(String anneelib) {
        this.anneelib = anneelib;
    }
}
