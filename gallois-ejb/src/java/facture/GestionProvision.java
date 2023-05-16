package facture;

import bean.*;    
import java.sql.*;
import utilitaire.Utilitaire;

public class GestionProvision extends ClassMAPTable {
    
    private String id , idProvision, identification;
    private Date daty;

    public String calculerIndentification(Connection c) throws Exception{
        String dateEffetStr = Utilitaire.datetostring(this.getDaty()) ;
        String annee = Utilitaire.getAnnee(dateEffetStr);
        String mois = Utilitaire.getMois(dateEffetStr);
        String seq="";
        String rqt="SELECT nvl(max(maxidparmoisane)+1,1) AS numerosuivant FROM numero_gestion_prov where annee="+annee+" and mois="+mois;
        NumeroFacture[] result = (NumeroFacture[])CGenUtil.rechercher(new NumeroFacture(), rqt, c);
        if(result.length>0) seq=Utilitaire.completerInt(3, result[0].getNumerosuivant());
        return Utilitaire.genererAnnee(dateEffetStr) + mois + seq;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

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

    public GestionProvision(String idProvision, String identification) {
        this.idProvision = idProvision;
        this.identification = identification;
    }
    
    public GestionProvision(){
        this.setNomTable("GESTIONPROVISION");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PROV", "getseqgestionprov");
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
}
