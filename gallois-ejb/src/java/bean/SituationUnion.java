package bean;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class SituationUnion extends ClassMAPTable {

  private String id;
  private double montant;
  private double montantMap;
  private int nombreMap;
  public SituationUnion() {
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setMontantMap(double montantMap) {
    this.montantMap = montantMap;
  }
  public double getMontantMap() {
    return montantMap;
  }
  public void setNombreMap(int nombreMap) {
    this.nombreMap = nombreMap;
  }
  public int getNombreMap() {
    return nombreMap;
  }
}