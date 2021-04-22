package bean;

import java.sql.*;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class CaractTable extends bean.ClassMAPTable {

  private String id;
  private String nomTable;
  private String nomSeq;
  private String nomProc;
  private String nomFille;
  public CaractTable() {
  }
  public String getAttributIDName() {
          return "id";
  }

  public String getTuppleID() {
          return id;
	}
  public CaractTable(String i,String nomT,String nomS,String nomProc) {
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setNomTable(String nomTable) {
    this.nomTable = nomTable;
  }
  public String getNomTable() {
    return nomTable;
  }
  public void setNomSeq(String nomSeq) {
    this.nomSeq = nomSeq;
  }
  public String getNomSeq() {
    return nomSeq;
  }
  public void setNomProc(String nomProc) {
    this.nomProc = nomProc;
  }
  public String getNomProc() {
    return nomProc;
  }
  public void setNomFille(String nomFille) {
    this.nomFille = nomFille;
  }
  public String getNomFille() {
    return nomFille;
  }
}