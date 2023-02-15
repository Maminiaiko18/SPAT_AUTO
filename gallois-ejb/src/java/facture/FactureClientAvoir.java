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

    public FactureClientAvoir(String idfc, String idavoir, double montant) {
        this.idfc = idfc;
        this.idavoir = idavoir;
        this.montant = montant;
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

    public void setMontant(double montant) {
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
        avoirFC.setNomTable("avoirfc_montant_regroup");
        AvoirFC[] avoirFCs = (AvoirFC[]) CGenUtil.rechercher(avoirFC, null, null, con, " AND id in ("+Utilitaire.tabToString(this.idavoir.split(";"), "'", ",")+") ORDER by daty ASC");
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
    
    public void payerAvoirFacture(String u,Connection con) throws Exception{
        AvoirFC[] avoirFCs = getAvoirsOrderByDate(con);
        FactureClient aPayer = getFactureAPayer(con);
        aPayer.payerAPartirAvoirs(avoirFCs, this.montant, u, con);
    }
   
}
