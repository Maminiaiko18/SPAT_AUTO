/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facturefournisseur;

import java.sql.Connection;
import utilitaire.UtilDB;
import bean.CGenUtil;
import mg.spat.JournalCaisse;
import ded.OrdonnerPayement;

/**
 *
 * @author MEVA
 */
public class EtatFactureData {
    private EtatFacture ff;
    private Detailsffbonlivraison[] listeFactureBonLivraison;
    private JournalCaisse[] payment;
    private OrdonnerPayement[] ordonner;
    public EtatFactureData(EtatFacture ff) throws Exception {
        boolean estOuvert=false;
        Connection c=null;
        try{
            c=new UtilDB().GetConn();
            estOuvert=false;
            
            listeFactureBonLivraison=ff.getFilleBL("Detailsffbonlivraison",c);
            JournalCaisse journalCaisse=new JournalCaisse();
            journalCaisse.setNomTable("journalcaisseOP");
//            payment=(JournalCaisse[]) CGenUtil.rechercher(journalCaisse, null, null, c, " and DED_ID='" + ff.getId() + "'");
            OrdonnerPayement o=new OrdonnerPayement();
            ordonner=(OrdonnerPayement[]) CGenUtil.rechercher(o, null, null, c, " and DED_ID like'%" + ff.getId() + "%'");
        }catch(Exception e){
            throw e;
        }finally{
            if(estOuvert)c.close();
        }
    }

    public OrdonnerPayement[] getOrdonner() {
        return ordonner;
    }

    public void setOrdonner(OrdonnerPayement[] ordonner) {
        this.ordonner = ordonner;
    }
    
    

    public Detailsffbonlivraison[] getListeFactureBonLivraison() {
        return listeFactureBonLivraison;
    }

    public void setListeFactureBonLivraison(Detailsffbonlivraison[] listeFactureBonLivraison) {
        this.listeFactureBonLivraison = listeFactureBonLivraison;
    }

    public JournalCaisse[] getPayment() {
        return payment;
    }

    public void setPayment(JournalCaisse[] payment) {
        this.payment = payment;
    }

    
    
}
