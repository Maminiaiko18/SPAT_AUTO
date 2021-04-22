/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import java.sql.Connection;
import utilitaire.UtilDB;

/**
 *
 * @author MEVA
 */
public class BonProvisoireData {
    RegulBonProvisoire[] listeRegul;
    RegulBonProvisoire[] listeRetour;

    public BonProvisoireData(BonProvisoire bp) throws Exception {
        Connection c=null;
        try{
            c=new UtilDB().GetConn();
            listeRegul=bp.getRegulBonPrpvisoire(c);
            listeRetour=bp.getRetourBonPrpvisoire(c);
        }catch(Exception e){
            throw e;
        }finally{
            if(c!=null) c.close();
        }
    }

    public RegulBonProvisoire[] getListeRegul() {
        return listeRegul;
    }

    public void setListeRegul(RegulBonProvisoire[] listeRegul) {
        this.listeRegul = listeRegul;
    }

    public RegulBonProvisoire[] getListeRetour() {
        return listeRetour;
    }

    public void setListeRetour(RegulBonProvisoire[] listeRetour) {
        this.listeRetour = listeRetour;
    }
    
}
