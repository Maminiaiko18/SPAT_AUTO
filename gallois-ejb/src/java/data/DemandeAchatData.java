package data;

import java.sql.Connection;

import bean.CGenUtil;
import mg.spat.DemandeAchatFille;
import mg.spat.DemandeAchatMere;
import utilitaire.UtilDB;

public class DemandeAchatData {
    private DemandeAchatMere demandeAchatMere;
    private DemandeAchatFille demandeAchatFille;

    public DemandeAchatData(){}

    public void getDemandeAchatByEngagement(String idEngagement) throws Exception{
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            String queryWhereEngagementlib = " and id ='"+ idEngagement +"'";
            String queryWhereEngagement_fillelib = " and idMere='"+idEngagement+"'";

            String engagementlib = "engagementlib";
            String engagement_fillelib = "engagement_fillelib";

            DemandeAchatMere dmdAchMere = new DemandeAchatMere();
            dmdAchMere.setNomTable(engagementlib);

            DemandeAchatFille dmdAchFille = new DemandeAchatFille();
            dmdAchFille.setNomTable(engagement_fillelib);

            DemandeAchatMere[] rsDmdAchMere = (DemandeAchatMere[]) CGenUtil.rechercher(dmdAchMere, null, null, c, queryWhereEngagementlib);
            DemandeAchatFille[] rsDmdAchFille = (DemandeAchatFille[]) CGenUtil.rechercher(dmdAchFille, null, null, c, queryWhereEngagement_fillelib);
            
            if(rsDmdAchMere != null && rsDmdAchMere.length > 0) {
                this.setDemandeAchatMere(rsDmdAchMere[0]);
            }
            if(rsDmdAchFille != null && rsDmdAchFille.length > 0) {
                this.setDemandeAchatFille(rsDmdAchFille[0]);
            }
        } catch(Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if(c!=null)c.close();
        }
    }

    public DemandeAchatMere getDemandeAchatMere() {
        return this.demandeAchatMere;
    }

    public void setDemandeAchatMere(DemandeAchatMere demandeAchatMere) {
        this.demandeAchatMere = demandeAchatMere;
    }

    public DemandeAchatFille getDemandeAchatFille() {
        return this.demandeAchatFille;
    }

    public void setDemandeAchatFille(DemandeAchatFille demandeAchatFille) {
        this.demandeAchatFille = demandeAchatFille;
    }


}
