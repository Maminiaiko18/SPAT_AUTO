package utilisateur;

import java.sql.Connection;
import java.sql.SQLException;

import bean.CGenUtil;
import bean.ClassEtat;
import historique.MapUtilisateur;
import mg.cnaps.formation.CodeEtablissement;
import mg.spat.JournalCaisse;
import user.UserEJB;
import utilitaire.UtilDB;

public class Prioritaire extends ClassEtat{
    private String id;
    private String idrole;
    private String refuser;
    private String utilisateur;
    private String roles;
    private String ranglib;
    private String etatlib;
    private int rang; //si 1 tous si 0 dia nenazy ihany zany hoe ex : 400 dia zay manombka am 4

    public Prioritaire() {
       this.setNomTable("PRIORITAIRE");
    }

    public String getRanglib() {
        return ranglib;
    }

    public void setRanglib(String ranglib) {
        this.ranglib = ranglib;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    public String makeListConfidentiality(UserEJB u,String nomolumn) throws Exception{
        String where = "";
        int verif = 0;
        Connection c = null;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
                MapUtilisateur user = u.getUser();
                Prioritaire[] li = this.getListePriorite(c,user);
                boolean rangUser = true;
                CodeEtablissement pr = (CodeEtablissement)new CodeEtablissement().getById(user.getCodeEtablissement(), "CODEETABLISSEMENT_LIB", c);
                String codeetb = pr.getVal();
                if(li == null){
                    if(user.getCodeEtablissement()!=null){
                        if(codeetb.endsWith("00")){
                            where += " and "+ nomolumn +" like '"+codeetb.substring(0,1)+"%'";
                        }
                        else if(codeetb.endsWith("0")){
                            where += " and "+ nomolumn +" like '"+codeetb.substring(0,2)+"%'";
                        }
                        else where += " and "+ nomolumn +" like '"+codeetb+"%'";
                    }
                }else{
                    for(Prioritaire dt : li){
                        if(dt.rang == 0) {
                            rangUser = false;
                        }
                    }

                    if(!rangUser){
                        where += " and "+ nomolumn +" like '"+codeetb.substring(0,1)+"%'";
                    }

                }
                return where;
            } catch (Exception e) {
                if (c != null && verif == 1) {
                    c.rollback();
                }
                throw e;
            } finally {
                if (c != null && verif == 1) {
                    c.close();
                }
            }
        }

    public String getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(String utilisateur) {
        this.utilisateur = utilisateur;
    }

    public String getRoles() {
        return roles;
    }

    public void setRoles(String roles) {
        this.roles = roles;
    }
	


    public Prioritaire[] getListePriorite(Connection c,MapUtilisateur u) throws Exception{
        String where = " AND (REFUSER='"+u.getRefuser()+"' OR IDROLE='"+u.getIdrole()+"') AND ETAT=11";
        Prioritaire[] p = (Prioritaire[]) CGenUtil.rechercher(new Prioritaire(), null, null, c, where);
        if(p.length > 0) return p;
        return null;
    }

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

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
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
