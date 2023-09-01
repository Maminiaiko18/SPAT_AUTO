package utilisateur;

import java.sql.Connection;

import bean.ClassEtat;

public class Prioritaire extends ClassEtat{
    private String id;
    private String idrole;
    private String refuser;

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PRT", "getseqprioritaire");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getIdrole() {
        return idrole;
    }
    public void setIdrole(String idrole) {
        this.idrole = idrole;
    }
    public String getRefuser() {
        return refuser;
    }
    public void setRefuser(String refuser) {
        this.refuser = refuser;
    }
    @Override
    public String getTuppleID() {
       return this.id;
    }
    @Override
    public String getAttributIDName() {
        return "id";
    }
}
