
import bean.ClassMAPTable;
    

public class GestionProvision extends ClassMAPTable {
    
    private String id , idProvision, identification;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdProvision() {
        return idProvision;
    }

    public void setIdProvision(String idProvision) {
        this.idProvision = idProvision;
    }

    public String getIdentification() {
        return identification;
    }

    public void setIdentification(String identification) {
        this.identification = identification;
    }

    public GestionProvision(String id, String idProvision, String identification) {
        this.id = id;
        this.idProvision = idProvision;
        this.identification = identification;
    }
    
    public GestionProvision(){
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
}
