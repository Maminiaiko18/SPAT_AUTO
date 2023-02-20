/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package facture;

import avoir.AvoirFC;
import bean.CGenUtil;
import bean.ClassMAPTable;
import ded.OrdonnerPayement;
import java.sql.Connection;
import mg.spat.JournalCaisse;
import utilitaire.Constante;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Heriniaina
 */
public class FactureClientAvoir extends ClassMAPTable{
    String id;
    String idfc;
    String idavoir;
    double montant;

    public FactureClientAvoir(String idfc, String idavoir, double montant) throws Exception {
        this.idfc = idfc;
        this.idavoir = idavoir;
        this.setMontant(montant);
        this.setNomTable("FactureClientAvoir");
    }

    public FactureClientAvoir() {
        this.setNomTable("FactureClientAvoir");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdfc() {
        return idfc;
    }

    public void setIdfc(String idfc) {
        this.idfc = idfc;
    }

    public String getIdavoir() {
        return idavoir;
    }

    public void setIdavoir(String idavoir) {
        this.idavoir = idavoir;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
        if(montant <= 0){
            throw new Exception("Le montant de regularisation ne peut pas être negatif ou nul");
        }
        this.montant = montant;
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public AvoirFC[] getAvoirsOrderByDate(Connection con) throws Exception{
        AvoirFC avoirFC = new AvoirFC();
        avoirFC.setNomTable("AVOIRFC_MONTANT_REGROUP_V");
        AvoirFC[] avoirFCs = (AvoirFC[]) CGenUtil.rechercher(avoirFC, null, null, con, " AND montantreste > 0 AND id in ("+Utilitaire.tabToString(this.idavoir.split(";"), "'", ",")+") ORDER by daty ASC");
       return avoirFCs;
    }
   
    public FactureClient getFactureAPayer(Connection con) throws Exception{
        FactureClient factureClient = new FactureClient();
        factureClient.setNomTable("FACTURECLIENTVALIDE2");
        factureClient.setId(this.idfc);
        FactureClient[] resultats = (FactureClient[])CGenUtil.rechercher(factureClient, null, null, con,"");
        if(resultats.length > 0) return resultats[0];
        throw new Exception("Facture à payer non existante !");
    }
    
    public void payerAvoirFacture(String u) throws Exception{
        Connection con = null;
        try{
            con = new UtilDB().GetConn();
            con.setAutoCommit(false);
            payerAvoirFacture(u, con);
            con.commit();
        }
        catch(Exception e){
            if(con!=null) con.rollback();
            throw e; 
        }
        finally{
            if(con!=null) con.close();
        }
    }
    public void controlerPayerFacture(FactureClient aPayer, AvoirFC[] avoirFCs) throws Exception{
        if(aPayer.getMontantreste() < this.montant){
            throw new Exception("Il n'est pas possible de regulariser un montant supérieur au montant à Payer");
        }
    } 
    public void payerAvoirFacture(String u,Connection con) throws Exception{
        FactureClient aPayer = getFactureAPayer(con);
        AvoirFC[] avoirFCs = getAvoirsOrderByDate(con);
        this.controlerPayerFacture(aPayer, avoirFCs);
        aPayer.payerAPartirAvoirs(avoirFCs, this.montant, u, con);
    }
   
}
