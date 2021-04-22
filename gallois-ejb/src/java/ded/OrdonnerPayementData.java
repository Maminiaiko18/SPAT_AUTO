/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ded;

import bean.CGenUtil;
import factureclient.PaiementFactureRemise;
import facturefournisseur.EtatFactureMontantDaty;
import facturefournisseur.RegulFacture;
import java.sql.Connection;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Sanda
 */
public class OrdonnerPayementData {
    private double montant = 0;
    private String idfacture;

    public double getMontant() {
        return montant;
    }

    public String getIdfacture() {
        return idfacture;
    }
    
    public OrdonnerPayementData(String id, String dedid) throws Exception{
        Connection c=null;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            if(id != null && "".equalsIgnoreCase(id)== false){
                RegulFacture temp = new RegulFacture();
                RegulFacture[] bases = (RegulFacture[]) CGenUtil.rechercher(temp, null, null, c, " and id = '"+id+"'");
                if(bases != null && bases.length >0){
                    this.montant = bases[0].getMontantAPayer(c);
                    this.idfacture = bases[0].getIdfacture();
                }
            }else{
                if(dedid!=null && dedid.compareTo("")!=0){
                    /*if(!dedid.contains(";")){
                        EtatFactureMontantDaty[] efd=(EtatFactureMontantDaty[])CGenUtil.rechercher(new EtatFactureMontantDaty(), null, null, c, " and id='"+dedid+"'");
                        if(efd.length>0){
                            this.montant=efd[0].getReste();
                        }
                    }*/
                    String[] ids=dedid.split(";");
                    String apres=Utilitaire.tabToString(ids, "'", ",");
                    if(dedid.startsWith("FC")){
                         PaiementFactureRemise res=new  PaiementFactureRemise();
                         res.setNomTable("PAIEMENT_FACTURECLIENT_REMISE");
                         PaiementFactureRemise[] tab=(PaiementFactureRemise[])CGenUtil.rechercher(res, null, null, c, " and id in ("+apres+")");
                         if(tab.length>0){
                            for(int i=0;i<tab.length;i++){
                                this.montant+=tab[i].getResteapayer();
                            }
                        }
                    }
                    else{
                       
                        EtatFactureMontantDaty[] efd=(EtatFactureMontantDaty[])CGenUtil.rechercher(new EtatFactureMontantDaty(), null, null, c, " and id in ("+apres+")");
                        if(efd.length>0){
                            for(int i=0;i<efd.length;i++){
                                this.montant+=efd[i].getReste();
                            }
                        }
                    }
                   
                }
                
            }
            if(c!=null && verif==1) c.commit();
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
   
}
