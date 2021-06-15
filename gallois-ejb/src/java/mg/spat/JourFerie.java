/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import java.sql.Date;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.Utilitaire;

/**
 *
 * @author nyamp
 */
public class JourFerie extends ClassMAPTable{
    private String id;
    private Date daty;
    private String designation, heureDebut;

    
    public JourFerie(){
        this.setNomTable("jour_ferie");
    }
    
   public void construirePK(Connection c) throws Exception {
        this.preparePk("JF", "get_seqjour_ferie");
        this.setId(makePK(c));
    }
    
    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
    
    public String getHeureDebut() {
        return heureDebut;
    }

    public void setHeureDebut(String heureDebut) throws Exception {
        if(getMode().equalsIgnoreCase("modif")){
            if(heureDebut!=null && !heureDebut.isEmpty()) Utilitaire.testHeureValide(heureDebut);
        }
        this.heureDebut = heureDebut;
    }
}
