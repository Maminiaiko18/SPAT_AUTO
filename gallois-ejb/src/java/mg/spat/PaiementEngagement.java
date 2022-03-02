/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassMAPTable;
import ded.OrdonnerPayement;
import java.sql.Connection;
import utilitaire.ConstanteEtat;

/**
 *
 * @author Nouta
 */
public class PaiementEngagement extends ClassMAPTable {
    private String id, idEngagement, idOP ;

    public PaiementEngagement() {
        super.setNomTable("payementEngagement");
    }

    public PaiementEngagement(String idEngagement, String idOP) throws Exception {
        setIdEngagement(idEngagement);
        setIdOP(idOP);
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdEngagement() {
        return idEngagement;
    }

    public void setIdEngagement(String idEngagement) throws Exception{
        if(this.getMode().compareToIgnoreCase("modif")==0&&(idEngagement == null || idEngagement == " " )) throw new Exception("idEngagement invalide");
        this.idEngagement = idEngagement;
    }

    public String getIdOP() {
        return idOP;
    }

    public void setIdOP(String idOP) throws Exception{
        if(this.getMode().compareToIgnoreCase("modif")==0&&(idOP == null || idEngagement == " ")) throw new Exception("idOP invalide");
        this.idOP = idOP;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CR","getseqpayementEngagement");
        setId(makePK(c));
    }
    
    public OrdonnerPayement findOP(String nomtable, Connection c) throws Exception{
        if(nomtable == null) nomtable = "OrdonnerPayement";
        OrdonnerPayement op = new OrdonnerPayement();
        op.setNomTable(nomtable);
        op.setId(this.getIdOP());
        OrdonnerPayement[] result = (OrdonnerPayement[])CGenUtil.rechercher(op, null, null, c, "");
        if(result.length > 0) return result[0];
        return null;
    }
    
    public EngagementFille findEngagementFille(String nomtable, Connection c) throws Exception{
        if(nomtable == null) nomtable = "engagement_fille";
        EngagementFille ef = new EngagementFille();
        ef.setNomTable(nomtable);
        ef.setId(this.getIdEngagement());
        EngagementFille[] result = (EngagementFille[])CGenUtil.rechercher(ef, null, null, c, "");
        if(result.length > 0) return result[0];
        return null;
    }

    @Override
    public void controler(Connection c) throws Exception {
        if(this.getIdOP()==null){
            OrdonnerPayement op=this.findOP(null, c);
            if(op.getEtat()< ConstanteEtat.getEtatValider()){
                throw new Exception ("OP non visé");
            }
        }      
        super.controler(c); 
    }
    
    
}
