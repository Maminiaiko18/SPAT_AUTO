/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Nouta
 */
public class FactureMereAncienne extends ClassMAPTable{
    private String nmfact,cdmonn,cddosclt,nmfact_rem,nmfact_pro,noteexpl,annulee,editee,nmcptgen;
    private Date dtfact,dtcours;
    private double mtthtva,taxe,mtttva,mttdevise,rstapayer;

    public FactureMereAncienne() {
        super.setNomTable("facture");
    }

    public FactureClient genererFacture(Connection c, String u) throws Exception {
        FactureClient facture=null;
        boolean estOuvert=false;
        try
        {
            if(c==null)
            {
                c=new UtilDB().GetConn();
                estOuvert=true;
            }
            facture = this.genererFactureMere(u);
            FactureFilleAncienne filleTemporaire= new FactureFilleAncienne();
            filleTemporaire.setNomTable("factprtmat" );
            FactureFilleAncienne[] fille= (FactureFilleAncienne[]) CGenUtil.rechercher(filleTemporaire, null, null, c, " and NMFACT ='"+this.getNmfact()+"'");
            if(fille.length==0){
                throw new Exception("Details introuvable");
            }
            FactureClientDetails[] factureDetail=new FactureClientDetails[fille.length];
            for(int i=0;i<fille.length;i++){
                factureDetail[i]=fille[i].genererFactureFille();
            }
            facture.setFille(factureDetail);
            facture=(FactureClient)facture.createObject(u,c);
            return facture;

        }
        catch(Exception e)
        {
            if(c!=null&&estOuvert==true)c.rollback();
            throw e;
        }
        finally
        {
            if(c!=null&&estOuvert==true)c.close();
        }
    }
    
    public static FactureClient[] genererFactureMultiple(Connection con, String ids, String user) throws Exception {
        boolean checkCon = false;
        
        try {
            if(con == null) {
                con = (new UtilDB()).GetConn();
                con.setAutoCommit(false);
                checkCon = true;
            }
            
            String awhereId = Utilitaire.tabToString(Utilitaire.stringToTab(ids, ";"), "'", ",");
            
            String awhere = String.format(" and nmfact in (%s)", awhereId);
            FactureMereAncienne[] mere = (FactureMereAncienne[]) CGenUtil.rechercher(new FactureMereAncienne(), null, null, con, awhere);
            if(mere == null || mere.length == 0) throw new Exception("Facture introuvable");
            
            FactureClient[] mereRetour = new FactureClient[mere.length];
            for(int i=0; i < mere.length; i++) {
                mereRetour[i] = mere[i].genererFacture(con, user);
            }
            
            if(checkCon) con.commit();
            
            return mereRetour;
        } catch (Exception exp) {
            if(checkCon && con != null) con.rollback();
            throw exp;
        }
        finally {
            if(checkCon && con != null) con.close();
        }
    }
 
    public String getNmfact() {
        return nmfact;
    }

    public void setNmfact(String nmfact) {
        this.nmfact = nmfact;
    }

    public String getCdmonn() {
        return cdmonn;
    }

    public void setCdmonn(String cdmonn) {
        this.cdmonn = cdmonn;
    }

    public String getCddosclt() {
        return cddosclt;
    }

    public void setCddosclt(String cddosclt) {
        this.cddosclt = cddosclt;
    }

    public String getNmfact_rem() {
        return nmfact_rem;
    }

    public void setNmfact_rem(String nmfact_rem) {
        this.nmfact_rem = nmfact_rem;
    }

    public String getNmfact_pro() {
        return nmfact_pro;
    }

    public void setNmfact_pro(String nmfact_pro) {
        this.nmfact_pro = nmfact_pro;
    }

    public String getNoteexpl() {
        return noteexpl;
    }

    public void setNoteexpl(String noteexpl) {
        this.noteexpl = noteexpl;
    }

    public String getAnnulee() {
        return annulee;
    }

    public void setAnnulee(String annulee) {
        this.annulee = annulee;
    }

    public String getEditee() {
        return editee;
    }

    public void setEditee(String editee) {
        this.editee = editee;
    }

    public String getNmcptgen() {
        return nmcptgen;
    }

    public void setNmcptgen(String nmcptgen) {
        this.nmcptgen = nmcptgen;
    }

    public Date getDtfact() {
        return dtfact;
    }

    public void setDtfact(Date dtfact) {
        this.dtfact = dtfact;
    }

    public Date getDtcours() {
        return dtcours;
    }

    public void setDtcours(Date dtcours) {
        this.dtcours = dtcours;
    }

    public Double getMtthtva() {
        return mtthtva;
    }

    public void setMtthtva(Double mtthtva) {
        this.mtthtva = mtthtva;
    }

    public Double getTaxe() {
        return taxe;
    }

    public void setTaxe(Double taxe) {
        this.taxe = taxe;
    }

    public Double getMtttva() {
        return mtttva;
    }

    public void setMtttva(Double mtttva) {
        this.mtttva = mtttva;
    }

    public Double getMttdevise() {
        return mttdevise;
    }

    public void setMttdevise(Double mttdevise) {
        this.mttdevise = mttdevise;
    }

    public Double getRstapayer() {
        return rstapayer;
    }

    public void setRstapayer(Double rstapayer) {
        this.rstapayer = rstapayer;
    }

    @Override
    public String getTuppleID() {
        return nmfact; 
    }

    @Override
    public String getAttributIDName() {
        return "nmfact";
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("FM","GETSEQfacture");
        setNmfact(makePK(c));
    }
    
    public FactureClient genererFactureMere(String u) throws Exception{
        FactureClient fc = new FactureClient();
        fc.setCode(this.getNmfact());
        fc.setTiers(this.getCddosclt());
        fc.setDaty(this.getDtfact());
        fc.setDesignation(this.getNoteexpl());
        fc.setIduser(u);
        fc.setEstMictsl("0");
        fc.setTypeEngagement("normal");
        fc.setEstAncienne(1);
        fc.setEtat(11);
        return fc;
    }
}
