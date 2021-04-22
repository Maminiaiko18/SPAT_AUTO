package utilitaire;
import bean.ClassMAPTable;
import java.sql.Connection;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class TestValeur extends ClassMAPTable{

  private String id;
  private double valeur;
  public TestValeur() {
    super.setNomTable("testvaleur");
  }
  public String getTuppleID(){
  return id;
}
public String getAttributIDName(){
  return "id";
}
public void construirePK(Connection c) throws Exception{
 super.setNomTable("testvaleur");
 this.preparePk("TES","getSeqTestValeur");
 this.setId(makePK(c));
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setValeur(double valeur) {
    this.valeur = valeur;
  }
  public double getValeur() {
    return valeur;
  }
}