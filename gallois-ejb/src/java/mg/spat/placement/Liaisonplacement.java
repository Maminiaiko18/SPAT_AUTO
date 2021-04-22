/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.placement;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;
/**
 *
 * @author Asus
 */
public class Liaisonplacement extends ClassMAPTable{
    
    private String id,identite,idbanque;

    public Liaisonplacement() {
        super.setNomTable("liaisonplacement");
    }

    public Liaisonplacement(String id, String identite, String idbanque) {
        this.id = id;
        this.identite = identite;
        this.idbanque = idbanque;
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdentite() {
        return identite;
    }

    public void setIdentite(String identite) {
        this.identite = identite;
    }

    public String getIdbanque() {
        return idbanque;
    }

    public void setIdbanque(String idbanque) {
        this.idbanque = idbanque;
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

         this.preparePk("LPLT", "getseqliaisonplacement");
         this.setId(makePK(c));
        
    }
    
}
