package mg.cnaps.paie;
import bean.ClassMAPTable;
import java.sql.Connection;
/**
 *
 * @author nyaina
 */
public class PaieFonction extends ClassMAPTable{
    private String id,val,desce, idgroupefonction, gratification, type_fonction;
    
    public PaieFonction(){
        this.setNomTable("PAIE_FONCTION");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("FONC", "getSeqPaieFonction");
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
    public String getId(){
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

    public String getIdgroupefonction() {
        return idgroupefonction;
    }

    public void setIdgroupefonction(String idgroupefonction) {
        this.idgroupefonction = idgroupefonction;
    }

    public String getGratification() {
        return gratification;
    }

    public void setGratification(String gratification) {
        this.gratification = gratification;
    }

    public String getType_fonction() {
        return type_fonction;
    }

    public void setType_fonction(String type_fonction) {
        this.type_fonction = type_fonction;
    }
    
    @Override
    public String getValColLibelle() {
        return this.val+" - "+this.desce;
    }
    
}
