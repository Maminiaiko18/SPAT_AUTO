package historique;

import bean.*;


/**
 * <p>Title: Gestion des recettes : Societe du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AnnulationUtilisateur extends ClassMAPTable {
  public String idAnnulationUser;
  public String refUser;
  public java.sql.Date daty;
  public AnnulationUtilisateur(String id,String ref, java.sql.Date dat) {
    this.setIdAnnulationUser(id);
    this.setRefUser(ref);
    this.setDaty(dat);
    this.setNomTable("AnnulationUtilisateur");
  }
  public AnnulationUtilisateur(String ref, java.sql.Date dat) {
    setIndicePk("ANU");
    setNomProcedureSequence("getSeqAnnulationUser");
    this.setIdAnnulationUser(makePK());
    this.setRefUser(ref);
    this.setDaty(dat);
    this.setNomTable("AnnulationUtilisateur");
  }
  public AnnulationUtilisateur(String ref, String dat) {
    setIndicePk("ANU");
    setNomProcedureSequence("getSeqAnnulationUser");
    this.setIdAnnulationUser(makePK());
//    this.setRefUser(ref);
    if (ref.compareTo("")==0 || ref==null) {
      this.setRefUser("-");
    }
    else this.setRefUser(ref);

//    this.setDaty(dat);
    if (String.valueOf(dat).compareTo("")==0 || dat==null){
      this.setDaty(utilitaire.Utilitaire.dateDuJourSql());
    }
    else this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dat));

    this.setNomTable("AnnulationUtilisateur");
  }
   public AnnulationUtilisateur(String ref) {
    setIndicePk("ANU");
    setNomProcedureSequence("getSeqAnnulationUser");
    this.setIdAnnulationUser(makePK());
    this.setRefUser(ref);
    this.setDaty(utilitaire.Utilitaire.dateDuJourSql());
    this.setNomTable("AnnulationUtilisateur");
  }
  public String getAttributIDName() {
    return "idAnnulationUser";
 }
  public String getTuppleID() {
    return this.getIdAnnulationUser();
    }
  public void setIdAnnulationUser(String idAnnulationUser) {
    this.idAnnulationUser = idAnnulationUser;
  }
  public String getIdAnnulationUser() {
    return idAnnulationUser;
  }
  public void setRefUser(String refUser) {
    this.refUser = refUser;
  }
  public String getRefUser() {
    return refUser;
  }
  public void setDaty(java.sql.Date daty) {
    if (String.valueOf(daty).compareTo("")==0 || daty==null){
      this.daty=utilitaire.Utilitaire.dateDuJourSql();
    }
    else this.daty= daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
}