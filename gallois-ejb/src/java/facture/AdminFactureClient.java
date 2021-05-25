/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import java.sql.Connection;
import user.UserEJB;
import user.UserEJBBean;
import utilitaire.Constante;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author
 */
public class AdminFactureClient {

    private FactureClient[] listeFactureClient;
    private TransitionPaiementVide transPV;

    public AdminFactureClient() {
    }

    public AdminFactureClient(TransitionPaiementVide transPV) {
        setTransPV(transPV);
    }

    public FactureClient[] getListeFactureClient() {
        return listeFactureClient;
    }

    public void setListeFactureClient(FactureClient[] listeFactureClient) {
        this.listeFactureClient = listeFactureClient;
    }

    public void findFactureClient(String[] ids, Connection c) throws Exception {
        String id = Utilitaire.tabToString(ids, "'", ",");
        FactureClient fc = new FactureClient();
        fc.setNomTable("factureclientMSum_lib");
        FactureClient[] listeFact = (FactureClient[]) CGenUtil.rechercher(fc, null, null, c, " and  id in(" + id + ")");
        this.setListeFactureClient(listeFact);
    }
    
    public void payer(UserEJBBean u) throws Exception {
        Connection c = null;
        
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            
            payer(u, c);
            
            c.commit();
        } catch (Exception e) {
            if(c != null) c.rollback();
            throw e;
        }
        finally {
            if(c != null) c.close();
        }
    }
    
    public void payer(UserEJBBean u, Connection c) throws Exception {
        try {
        if (listeFactureClient != null && listeFactureClient.length > 0 && transPV != null) {
            String idTiers = listeFactureClient[0].getTiers();

            for (FactureClient fc : listeFactureClient) {
                if (!fc.getTiers().equalsIgnoreCase(idTiers)) {
                    throw new Exception("Tiers différents pour les factures à payer");
                }

                fc.payer(transPV.getCaisse(), transPV.getModepaiement(), transPV.getNumcheque(), transPV.getTypecheque(), transPV.getIddevise(), u, c);
            }
        }
        }
        catch(Exception ex) {
            if(c != null) c.rollback();
            throw ex;
        }
    }

    public TransitionPaiementVide getTransPV() {
        return transPV;
    }

    public void setTransPV(TransitionPaiementVide transPV) {
        this.transPV = transPV;
    }
    
}
