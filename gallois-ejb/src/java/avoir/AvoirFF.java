/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

import bean.CGenUtil;
import facturefournisseur.FactureFournisseur;
import java.sql.Connection;
import utilitaire.UtilDB;

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
    
    public FactureFournisseur getFactureFournisseurLiee(String nomtable, Connection c) throws Exception {
    int verif = 0;
        try {
            if (c == null) {
                    c = (new UtilDB()).GetConn();
                    verif = 1;
            }
            if(nomtable == null || nomtable.compareTo("")==0) nomtable = "ETATFACTUREMONTANTDATYETATLIB";
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
        if(this.getType().equals("1")){
            this.getFactureFournisseurLiee("facturefournisseur",c).annuler(c);
        }
        return super.validerObject(u, c); 
    }
    
}
