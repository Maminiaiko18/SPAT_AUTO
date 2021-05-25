/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;
import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Andriamiary
 */
public class TransitionPaiementVide extends ClassMAPTable{
    
    private String id, caisse, modepaiement, numcheque, typecheque, iddevise;
    
    public TransitionPaiementVide(){
        this.setNomTable("TRANSITIONPAIEMENTVIDE");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public String getModepaiement() {
        return modepaiement;
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }

    public String getNumcheque() {
        return numcheque;
    }

    public void setNumcheque(String numcheque) {
        this.numcheque = numcheque;
    }

    public String getTypecheque() {
        return typecheque;
    }

    public void setTypecheque(String typecheque) {
        this.typecheque = typecheque;
    }

    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("TPV", "get_seqtransitionPaiementVide");
        setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
}
