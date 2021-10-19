/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

import bean.CGenUtil;
import bean.ClassMAPTable;
import ded.OrdonnerPayement;
import facturefournisseur.FactureFournisseur;
import java.sql.Connection;
import mg.spat.JournalCaisse;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Princie
 */
public class AvoirFF extends AvoirFC {
    public AvoirFF() throws Exception {
        setNomTable("AvoirFF");
        this.setLiaisonFille("idmere");
        this.setNomClasseFille("avoir.AvoirFFFille");
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        this.setId(null);
        return super.createObject(u, c);
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("AVRFF", "GET_SEQ_AVOIRFF");
        setId(makePK(c));
    }
    
    public FactureFournisseur getFactureFournisseurLiee(String nomtable, Connection c) throws Exception {
    int verif = 0;
        try {
            if (c == null) {
                    c = (new UtilDB()).GetConn();
                    verif = 1;
            }
            if(nomtable == null || nomtable.compareTo("")==0) nomtable = "ETATFACTUREMONTANTDATY";
            FactureFournisseur ff = new FactureFournisseur();
            ff.setNomTable(nomtable);
            String awhere = String.format(" and id = '%s' ", this.getIdfacture());
            FactureFournisseur[] result = (FactureFournisseur[])CGenUtil.rechercher(ff, null, null, c, awhere);
            if(result != null && result.length > 0) 
                    return result[0];
            return null;
        } catch(Exception e){
            throw e;
        }finally {
            if (c != null && verif == 1) {
                    c.close();
            }
        }
    }
    
    public AvoirFFFille[] getAvoirFFFilles(String nomTable, Connection c) throws Exception{
        if(nomTable == null){
            nomTable = "avoirFFFille";
        }
        String requete = "SELECT * from %s WHERE idmere = '%s'";
        requete = String.format(requete, nomTable, this.getId());
        AvoirFFFille fille = new AvoirFFFille();
        fille.setNomTable(nomTable);
        AvoirFFFille[] filles = (AvoirFFFille[])CGenUtil.rechercher(fille, requete, c);
        return filles;
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        setMode("modif");
        controler(c);
        this.setEtat(ConstanteEtat.getEtatValider());
        this.updateToTableWithHisto(u, c);
        return this; 
    }
    
    public OrdonnerPayement genererOP(Connection c) throws Exception{
        OrdonnerPayement op = new OrdonnerPayement();
        op.setDed_Id(this.getId());
        AvoirFF avoirFCMontant = new AvoirFF();
        avoirFCMontant.setNomTable("avoirFF_montant");
        AvoirFF[] result = (AvoirFF[])CGenUtil.rechercher(avoirFCMontant, null, null, c, String.format(" and id = '%s' ", this.getId()));
        if(result.length > 0)
            op.setMontant(result[0].getMontant());
        op.setRemarque("Paiement avoir "+this.getId());
        op.setDaty(Utilitaire.dateDuJourSql());
        return op;
    }
    
    public void controlerPaiement(Connection c) throws Exception{
        JournalCaisse j = new JournalCaisse();
        j.setNomTable("journalcaisselib_vise");
        JournalCaisse[] result = (JournalCaisse[])CGenUtil.rechercher(j, null, null, c, " and idplacement ='"+this.getId()+"'");
        if(result.length!=0){
            throw new Exception("Avoir FF deja payer"); 
        }
        
        
    
    }
}
