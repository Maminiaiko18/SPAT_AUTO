/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.amadia.facture;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.util.ArrayList;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import factureclient.*;
import user.UserEJB;
import utilitaire.ConstanteEtat;

/**
 *
 * @author Doudou Tiarilala
 */
public class FactureService extends ClassMAPTable {

    private String id;

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public FactureService() {
        //this.setNomTable("");
    }

    
    
    public static FactureClientReport imprimerFacture(String id, Connection c) throws Exception{        
        FactureClientReport ret = null;
        try {
            if (c==null) {
                c = new UtilDB().GetConn();
            }
            FactureClient tmp = new FactureClient();
            tmp.setNomTable("FACTURE_CLIENT_CONTACT");
            FactureClient[] mere = (FactureClient[]) CGenUtil.rechercher(tmp, null, null, c, " and id = '"+id+"'");
            double montantTotal =0;
            if(mere.length ==0) {
                throw new Exception ("Facture '"+ id +"' introuvable");
            } else {
                ret = new FactureClientReport();
                ret.setClient(mere[0].getTiers());
                ret.setAdresse(mere[0].getRemarque());
                ret.setDaty(Utilitaire.formatterDaty(mere[0].getDaty()));
                ret.setId(mere[0].getId());
                ret.setNumFacture(mere[0].getRemarque());
                ret.setMedecin(mere[0].getCompte());
                
                FactureClientDetail tmp2 = new FactureClientDetail();
                tmp2.setNomTable("facture_client_detail");
                FactureClientDetail[] fille = (FactureClientDetail[]) CGenUtil.rechercher(tmp2, null, null, c , " and idfacture = '"+mere[0].getId()+"'");
                if (fille.length > 0) {
                    ArrayList<DetailsFactureSubReport> arrList = new ArrayList<DetailsFactureSubReport>();
                    for (int i=0;i<fille.length;i++) {
                        DetailsFactureSubReport sub = new DetailsFactureSubReport();
                        sub.setDesignations(fille[i].getDesignation());
                        sub.setQuantite(Utilitaire.formaterAr(fille[i].getQuantite()));
                        sub.setPu(Utilitaire.formaterAr(fille[i].getMontant()));
                        sub.setMontant(Utilitaire.formaterAr(fille[i].getQuantite()*fille[i].getMontant()));
                        arrList.add(sub);
                        montantTotal += fille[i].getQuantite()*fille[i].getMontant();
                    }
                    ret.setListeDetails(arrList);
                }
                ret.setMontantTotal( montantTotal );
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if (c!= null) c.close();
        }
//        System.out.println("ret = " + ret.getListeDetails().get(0).getDesignations());
        return ret;
    }
    
    public static String fusionnerFacture(String[] idFacture, Connection c, UserEJB u) throws Exception {
        int etatC = 1;
        String id="";
        if (c == null) {
            c = new UtilDB().GetConn();
            etatC = 0;
            c.setAutoCommit(false);
        }
        try {
            FactureClient fc = new FactureClient();
            FactureClient[] listefactureclient = (FactureClient[]) CGenUtil.rechercher(fc, null, null, c, "and id in ("+Utilitaire.tabToString(idFacture, "'", ",")+")");
            FactureClientDetail[] listeDetail= (FactureClientDetail[]) CGenUtil.rechercher(new FactureClientDetail(), null, null, c, "and idfacture in ("+Utilitaire.tabToString(idFacture, "'", ",")+")");
            double montant = 0;
            FactureClient fatureclient=new FactureClient();
            String tiers="";
            if(idFacture.length!=listefactureclient.length){
                throw new Exception("Tous les factures ne sont pas trouvable");
            }
            else{
                
                for(int i=0; i<listefactureclient.length; i++){
                    if(i==0){
                        tiers=listefactureclient[i].getTiers();
                        fatureclient.setDesignation(listefactureclient[i].getDesignation());
                    }
                    if(tiers.equals(listefactureclient[i].getTiers())==false){
                        throw new Exception("Client différent");
                    }
                    if(listefactureclient[i].getEtat()!=ConstanteEtat.getEtatCreer()){
                        throw new Exception("Les factures doivent etrer à l'etat créer");
                    }
                }
                fatureclient.setDaty(Utilitaire.dateDuJourSql());
                fatureclient.setTiers(tiers);
                fatureclient.setEtat(ConstanteEtat.getEtatCreer());
                fatureclient.construirePK(c);
                id=fatureclient.getId();              
                fatureclient.insertToTableWithHisto(u.getUser().getTuppleID(),c);
                for(int i=0;i<listeDetail.length;i++){
                    listeDetail[i].setIdfacture(fatureclient.getId());
                    listeDetail[i].updateToTableWithHisto(u.getUser().getTuppleID(), c);
                }
               
            }
            if(etatC == 0) c.commit();
        } catch (Exception e) {
            e.printStackTrace();
            c.rollback();
            throw e;
        } finally {
            if (c != null && etatC == 0) {
                c.close();
            }
        }
        return id;
    }
    
}
