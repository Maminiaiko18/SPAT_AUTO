/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Asus
 */
public class HistoriquePatrimoine extends ClassMAPTable{
    
    private String id,idPatrimoine,etatPatrimoine;
    private Date daty;
    private int etat,idUtilisateur;

    public HistoriquePatrimoine() {
           this.setNomTable("historique_patrimoine");
    }

    public HistoriquePatrimoine(String id, String idPatrimoine, int idUtilisateur, String etatPatrimoine, Date daty, int etat) {
        
        this.setNomTable("historique_patrimoine");
        this.setId(id);
        this.setIdPatrimoine(idPatrimoine);
        this.setIdUtilisateur(idUtilisateur);
        this.setEtatPatrimoine(etatPatrimoine);
        this.setDaty(daty);
        this.setEtat(etat);
    }
    
    public HistoriquePatrimoine( String idPatrimoine, int idUtilisateur, String etatPatrimoine, Date daty, int etat) {
        
        this.setNomTable("historique_patrimoine");
         this.setIdPatrimoine(idPatrimoine);
        this.setIdUtilisateur(idUtilisateur);
        this.setEtatPatrimoine(etatPatrimoine);
        this.setDaty(daty);
        this.setEtat(etat);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPatrimoine() {
        return idPatrimoine;
    }

    public void setIdPatrimoine(String idPatrimoine) {
        this.idPatrimoine = idPatrimoine;
    }

    public int getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(int idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

   

    public String getEtatPatrimoine() {
        return etatPatrimoine;
    }

    public void setEtatPatrimoine(String etatPatrimoine) {
        this.etatPatrimoine = etatPatrimoine;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }
    
    
    

    @Override
    public String getTuppleID() {
     return id;
    }

    @Override
    public String getAttributIDName() {
     return "id"; 
    }
     public void construirePK(Connection c) throws Exception {
        this.preparePk("PAT", "getseq_historique_patrimoine");
        this.setId(makePK(c)); 
    }
    
}
