package mg.cnaps.paie;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author NERD
 */
public class Paiecategorie extends ClassMAPTable{
    private String id;
    private String val;
    private String desce;
    private String taux;
    public Paiecategorie() {
        super.setNomTable("paie_categorie");
    }

    public Paiecategorie(String val, String desce, String categorie) {
        this.val = val;
        this.desce = desce;
        this.taux = categorie;
        super.setNomTable("paie_categorie");
    }

    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CAT", "getSeqpaiecategorie");
        this.setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public String getDesce() {
        return desce;
    }

    public void setDesce(String desce) {
        this.desce = desce;
    }

    public String getTaux() {
        return taux;
    }

    public void setTaux(String taux) {
        this.taux = taux;
    } 
    
}
