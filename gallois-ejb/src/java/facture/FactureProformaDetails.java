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
    private String heureDebut;
    private String heureFin;
    
    public String getHeureDebut() {
        return heureDebut;
    }

    public void setHeureDebut(String heureDebut) {
        this.heureDebut = heureDebut;
    }

    public String getHeureFin() {
        return heureFin;
    }

    public void setHeureFin(String heureFin) {
        this.heureFin = heureFin;
    }

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
}
