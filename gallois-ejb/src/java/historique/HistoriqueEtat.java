package historique;

import bean.*;
import utilitaire.Utilitaire;


/**
 * <p>Title: Gestion des recettes : Societe du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class HistoriqueEtat extends ClassMAPTable {

  public String id;
  public String idMere;
  public String idUser;
  public String idEtat;
  public java.sql.Date dateModification;
  public HistoriqueEtat(String i, String mere, String user, String idEta, java.sql.Date dateModif) {
    super.setNomTable("historiqueetat");
    this.setId(i);
    this.setIdMere(mere);
    this.setIdUser(user);
    this.setIdEtat(idEta);
    this.setDateModification(dateModif);
  }
  public HistoriqueEtat(String mere, String user, String idEta, java.sql.Date dateModif) {
    super.setNomTable("historiqueetat");
    setIndicePk("HE");
    setNomProcedureSequence("getSeqHistoriqueEtat");
    this.setId(makePK());
    this.setIdMere(mere);
    this.setIdUser(user);
    this.setIdEtat(idEta);
    this.setDateModification(dateModif);
  }
  public HistoriqueEtat(String mere, String user, String idEta, String dateModif) {
   super.setNomTable("historiqueetat");
   setIndicePk("HE");
   setNomProcedureSequence("getSeqHistoriqueEtat");
   this.setId(makePK());
//   this.setIdMere(mere);
   if (mere.compareTo("")==0 || mere==null) {
     this.setIdMere("-");
   }
   else this.setIdMere(mere);

//   this.setIdUser(user);
   if (user.compareTo("")==0 || user==null) {
     this.setIdUser("-");
   }
   else this.setIdUser(user);

//   this.setIdEtat(idEta);
   if (idEta.compareTo("")==0 || idEta==null) {
     this.setIdEtat("-");
   }
   else this.setIdEtat(idEta);

//   this.setDateModification(dateModif);
   if (String.valueOf(dateModif).compareTo("")==0 || dateModif==null){
     this.setDateModification(utilitaire.Utilitaire.dateDuJourSql());
   }
   else this.setDateModification(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dateModif));

 }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return String.valueOf(id);
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setIdMere(String idMere) {
    this.idMere = idMere;
  }
  public String getIdMere() {
    return idMere;
  }
  public void setIdUser(String idUser) {
      if (getMode().compareTo("modif") == 0 && idUser != null && idUser.contains("/")) {
          String[] g = Utilitaire.split(idUser, "/");
          String t = g[0];
          this.idUser = g[0];
          return;
      }
    this.idUser = idUser;
  }
  public String getIdUser() {
    return idUser;
  }
  public void setIdEtat(String idEtat) {
    this.idEtat = idEtat;
  }
  public String getIdEtat() {
    return idEtat;
  }
  public void setDateModification(java.sql.Date dateModification) {
    this.dateModification = dateModification;
  }
  public java.sql.Date getDateModification() {
    return dateModification;
  }
}