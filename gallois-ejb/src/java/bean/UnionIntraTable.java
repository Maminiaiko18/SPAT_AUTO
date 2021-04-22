package bean;

import java.sql.Statement;
import utilitaire.UtilDB;
import java.sql.Connection;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class UnionIntraTable extends ClassMAPTable {

  public String id;
  public String id1;
  public String id2;
  public String remarque;
  public double montantMere=0;
  public int etat;
  public String getEtatLettre()
  {
    if(etat==0)
      return "cree";
    if(etat==1)
      return "valide";
    return "-";
  }
  public UnionIntraTable() {
  }
  public UnionIntraTable(String nomTable,String ide,String id1e,String id2e,String remarqueE, double montantE,int eta){
    this.setNomTable(nomTable);
    this.setId(ide);
    this.setId1(id1e);
    this.setId2(id2e);
    this.setRemarque(remarqueE);
    this.setMontantMere(montantE);
    this.setEtat(eta);
  }
  public UnionIntraTable(String nomTable,String id1e,String id2e,String remarqueE, String montantE){
    this.setNomTable(nomTable);
    this.setId1(id1e);
    this.setId2(id2e);
    this.setRemarque(remarqueE);
    this.setMontantMere(montantE);
    this.setEtat(0);
    CaractTable ct=(CaractTable)new bean.CaractTableUtil().rechercher(2,nomTable)[0];
    setIndicePk(ct.getNomSeq());
    setNomProcedureSequence(ct.getNomProc());
    this.setId(makePK());
  }
  public UnionIntraTable(String nomTable,String id1e,String id2e,String remarqueE, String montantE,Connection c)throws Exception{
    this.setNomTable(nomTable);
    this.setId1(id1e);
    this.setId2(id2e);
    this.setRemarque(remarqueE);
    this.setMontantMere(montantE);
    this.setEtat(0);
    CaractTable ct=(CaractTable)new bean.CaractTableUtil().rechercher(2,nomTable,c)[0];
    setIndicePk(ct.getNomSeq());
    setNomProcedureSequence(ct.getNomProc());
    this.setId(makePK());
  }
  public UnionIntraTable(String nomTable,String id){
    this.setNomTable(nomTable);
    this.setId(id);
  }
  public UnionIntraTable(String nomTable,String ide,String id1e,String id2e,String remarqueE, String montantE,String eta){
    this.setNomTable(nomTable);
    this.setId(ide);
    this.setId1(id1e);
    this.setId2(id2e);
    this.setRemarque(remarqueE);
    this.setMontantMere(utilitaire.Utilitaire.stringToDouble(montantE));
    this.setEtat(utilitaire.Utilitaire.stringToInt(eta));
  }
  public UnionIntraTable(String ide,String id1e,String id2e,String remarqueE, double montantE,int eta){
    this.setId(ide);
    this.setId1(id1e);
    this.setId2(id2e);
    this.setRemarque(remarqueE);
    this.setMontantMere(montantE);
    this.setEtat(eta);
  }
  public UnionIntraTable(String ide,String id1e,String id2e,String remarqueE, double montantE,String eta){
    this.setId(ide);
    this.setId1(id1e);
    this.setId2(id2e);
    this.setRemarque(remarqueE);
    this.setMontantMere(montantE);
    this.setEtat(utilitaire.Utilitaire.stringToInt(eta));
  }
  public UnionIntraTable(String nomTable,String nomProcedure,String suff,String id1e,String id2e,String remarqueE, double montantE,int eta){
    setNomTable(nomTable);
    setNomProcedureSequence(nomProcedure);
    setIndicePk(suff);
    id = makePK();
    this.setId1(id1e);
    this.setId2(id2e);
    this.setRemarque(remarqueE);
    this.setMontantMere(montantE);
    this.setEtat(eta);
  }
  public UnionIntraTable(String nomTable,String nomProcedure,String suff,String id1e,String id2e,String remarqueE, String montantE,String eta){
    setNomTable(nomTable);
    setNomProcedureSequence(nomProcedure);
    setIndicePk(suff);
    id = makePK();
    this.setId1(id1e);
    this.setId2(id2e);
    this.setRemarque(remarqueE);
    this.setMontantMere(utilitaire.Utilitaire.stringToDouble(montantE));
    this.setEtat(utilitaire.Utilitaire.stringToInt(eta));
  }
  public String getAttributIDName() {
    /**@todo Implement this bean.ClassMAPTable abstract method*/
    return "id";
  }
  public String getTuppleID() {
    return this.getId();
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setId1(String id1) {
    this.id1 = id1;
  }
  public String getId1() {
    return id1;
  }
  public void setId2(String id2) {
    this.id2 = id2;
  }
  public String getId2() {
    return id2;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setMontantMere(double montantMere) {
    this.montantMere = montantMere;
  }
  public void setMontantMere(String montantMere) {
    if(montantMere!=null && montantMere.compareToIgnoreCase("")!=0)
      this.montantMere =  utilitaire.Utilitaire.stringToDouble(montantMere);
  }
  public double getMontantMere() {
    return montantMere;
  }
  public String getMontantMereLettre()
  {
    return utilitaire.Utilitaire.formaterAr(getMontantMere());
  }
  public void setEtat(int etat) {
    this.etat = etat;
  }
  public int getEtat() {
    return etat;
  }
  public boolean estIlModifiable()
  {
    if (this.getEtat()>=9)
      return false;
    return true;
  }
  public static String updateMontantMere(String nomTable,String id1,String id2,String montant,java.sql.Connection c) throws Exception
  {
    Statement st= null;
    try {
      UnionIntraTableUtil uti=new UnionIntraTableUtil();
      uti.setNomTable(nomTable);
      UnionIntraTable[] ui=(UnionIntraTable[])uti.rechercher(2,id1);
      if((ui.length>0)&&(ui[0].estIlModifiable()==false)) throw new Exception("Mappage deja valide");
      String rek="update "+nomTable+"  set montantMere="+ montant+" where id1='"+id1+"' and id2='"+id2+"'";
      st=c.createStatement();
      st.executeUpdate(rek);
      return id1;
    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }
    finally{
      if(st!=null)
        st.close();
    }
  }
  public static String updateMontantMere(String nomTable,String id1,String id2,String montant) throws Exception
   {
    java.sql.Connection c=null;
     Statement st= null;
     try {
       c=new UtilDB().GetConn();
       return updateMontantMere(nomTable,id1,id2,montant,c);
     }
     catch (Exception ex) {
       throw new Exception(ex.getMessage());
     }
     finally{
       if(c!=null)
         c.close();
     }
  }
  public static UnionIntraTable[] getMemeId2(String i2,String nomTable,Connection c) throws Exception
  {
    UnionIntraTable crt=new UnionIntraTable();
    crt.setNomTable(nomTable);
    crt.setId2(i2);
    return (UnionIntraTable[])CGenUtil.rechercher(crt,null,null,c,"");
  }
  public static UnionIntraTable[] getMemeId1(String i1,String nomTable,Connection c) throws Exception
  {
    UnionIntraTable crt=new UnionIntraTable();
    crt.setNomTable(nomTable);
    crt.setId1(i1);
    return (UnionIntraTable[])CGenUtil.rechercher(crt,null,null,c,"");
  }
}
