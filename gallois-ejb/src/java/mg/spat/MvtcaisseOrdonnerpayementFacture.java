/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.UtilDB;
/**
 *
 * @author Sanda
 */
public class MvtcaisseOrdonnerpayementFacture  extends ClassMAPTable{
    private String id,nomfournisseur,idordre,idfournisseur;
    private double montantttc, reste;
    private String tiers , tierslib , remarque , modepaiement ;

    public MvtcaisseOrdonnerpayementFacture(){
        super.setNomTable("mvtcaisse_ordonnerpayement_F");
    }
    public MvtcaisseOrdonnerpayementFacture(String idordre){
        super.setNomTable("mvtcaisse_ordonnerpayement_F");
        this.setIdordre(idordre);
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getModepaiement() {
        return modepaiement;
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    public String getIdfournisseur() {
        return idfournisseur;
    }

    public void setIdfournisseur(String idfournisseur) {
        this.idfournisseur = idfournisseur;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNomfournisseur() {
        return nomfournisseur;
    }

    public void setNomfournisseur(String nomfournisseur) {
        this.nomfournisseur = nomfournisseur;
    }

    public String getIdordre() {
        return idordre;
    }

    public void setIdordre(String idordre) {
        this.idordre = idordre;
    }

    public double getMontantttc() {
        return montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }
        
    public MvtcaisseOrdonnerpayementFacture getOrdre(Connection c)throws Exception{
        int verif=0;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                verif=1;
            }
            MvtcaisseOrdonnerpayementFacture retour = new MvtcaisseOrdonnerpayementFacture();
            MvtcaisseOrdonnerpayementFacture[] lsf=(MvtcaisseOrdonnerpayementFacture[]) CGenUtil.rechercher(this, null, null, c, "");
            if(lsf.length >0){
                retour = lsf[0];
            }
            return retour;
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
        finally{
            if(c!=null && verif==1)c.close();
        }
    }
}
