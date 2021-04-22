package historique;

public class MapRoles extends bean.ClassMAPTable implements java.io.Serializable {

    public String idrole;
    public String descrole;
    public int rang;

    /**
     * Constructeur par defaut
     */
    public MapRoles() {
        super.setNomTable("roles");
    }

    public MapRoles(String descRole, String idRole) {
        this.descrole = descRole;
        this.idrole = idRole;
        super.setNomTable("roles");
    }

    public MapRoles(String descRole, String idRole, int rang) {
        this.descrole = descRole;
        this.idrole = idRole;
        this.setRang(rang);
        super.setNomTable("roles");
    }

    @Override
    public String getAttributIDName() {
        return "idrole";
    }

    @Override
    public String getTuppleID() {
        return idrole;
    }

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
    }

    public String getDescrole() {
        return descrole;
    }

    public void setDescrole(String descrole) {
        this.descrole = descrole;
    }

    public void setIdrole(String idrole) {
        this.idrole = idrole;
    }

    public String getIdrole() {
        return idrole;
    }
}
