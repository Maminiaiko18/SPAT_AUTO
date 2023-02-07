/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassMAPTable;

/**
 *
 * @author bici
 */
public class PaiementFactureLibJc extends ClassMAPTable {
    String id,idmvt,idfact,idmode,idtraite;
    double montant;

    public PaiementFactureLibJc() {
        this.setNomTable("paiementfacturelibjc");
    }

    public PaiementFactureLibJc(String id, String idmvt, String idfact, String idmode, String idtraite, double montant) {
        this.id = id;
        this.idmvt = idmvt;
        this.idfact = idfact;
        this.idmode = idmode;
        this.idtraite = idtraite;
        this.montant = montant;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmvt() {
        return idmvt;
    }

    public void setIdmvt(String idmvt) {
        this.idmvt = idmvt;
    }

    public String getIdfact() {
        return idfact;
    }

    public void setIdfact(String idfact) {
        this.idfact = idfact;
    }

    public String getIdmode() {
        return idmode;
    }

    public void setIdmode(String idmode) {
        this.idmode = idmode;
    }

    public String getIdtraite() {
        return idtraite;
    }

    public void setIdtraite(String idtraite) {
        this.idtraite = idtraite;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    @Override
    public String getTuppleID() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
