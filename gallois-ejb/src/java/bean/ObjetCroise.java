package bean;

/**
 * <p>Title: Gestion des recettes : Societe du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ObjetCroise {

    double[][]croise=null;
    String nomCol;
    String nomLigne;
    String[] valCol=null;
    String[] valLigne=null;
    Object[] aCroise;
    String nomTable;
    String nomCentre;
    double[] sommeColonne=null;
    double[] sommeLigne=null;
    double sommeTotal=0;

    public ObjetCroise(Object[] obj,String nomCol,String nomLigne,String centre,String table) throws Exception
    {
      this.setACroise(obj);
      this.setNomCol(nomCol);
      this.setNomLigne(nomLigne);
      if (nomCol.compareToIgnoreCase(nomLigne)==0)
        throw new Exception("Colonne et ligne identique");
     this.setNomTable(table);
      this.setNomCentre(centre);
      this.setValColBdd();
     this.calculCroise();
      this.calculSommeColonne();
      this.setValColBdd();
      this.calculSommeLigne();

      this.calculSommeTotal();
    }
    public void calculSommeTotal()
    {
      for (int i=0;i<sommeLigne.length;i++)
      {
        sommeTotal=sommeTotal+sommeLigne[i];
      }
    }
    public void calculSommeLigne()
    {
      sommeLigne=new double[valLigne.length];
      for (int i=0;i<valLigne.length;i++)
      {
        sommeLigne[i]=0;
        for(int k=0;k<valCol.length;k++)
        {
          sommeLigne[i]=sommeLigne[i]+croise[i][k];
        }
      }
    }
    public void calculSommeColonne()
    {
      sommeColonne=new double[valCol.length];
      for (int i=0;i<valCol.length;i++)
      {
        sommeColonne[i]=0;
        for(int k=0;k<valLigne.length;k++)
        {
          sommeColonne[i]=sommeColonne[i]+croise[k][i];
        }
      }
    }
    public void calculCroise()
    {
      croise=new double[valLigne.length][valCol.length];
      for (int i=0;i<valLigne.length;i++)
      {
        for(int j=0;j<valCol.length;j++)
        {
          croise[i][j]=getSommeUnique(valLigne[i],valCol[j]);
        }
      }
    }


    public String getSortie()
    {
      String resultat="";
      double retour=0;
      try {
        for (int i=0;i<aCroise.length;i++)
        {
          String valColAi=(String) (aCroise[i].getClass().getMethod("get"+utilitaire.Utilitaire.convertDebutMajuscule(nomCol),null).invoke(aCroise[i],null));
          String valLigneAi=(String) (aCroise[i].getClass().getMethod("get"+utilitaire.Utilitaire.convertDebutMajuscule(nomLigne),null).invoke(aCroise[i],null));


            //Double temp=(Double) (aCroise[i].getClass().getMethod("get"+utilitaire.Utilitaire.convertDebutMajuscule(nomCentre),null).invoke(aCroise[i],null));
            resultat =resultat + (String) (aCroise[i].getClass().getMethod("get"+utilitaire.Utilitaire.convertDebutMajuscule(nomCentre),null).invoke(aCroise[i],null));


        }
        return resultat;
      }
      catch (Exception ex) {
        ex.printStackTrace();
       return resultat;
      }
    }


    public double getSommeUnique(String valLi,String valCo)
    {
      double retour=0;
      try {
        for (int i=0;i<aCroise.length;i++)
        {
          String valColAi=(String) (aCroise[i].getClass().getMethod("get"+utilitaire.Utilitaire.convertDebutMajuscule(nomCol),null).invoke(aCroise[i],null));
          String valLigneAi=(String) (aCroise[i].getClass().getMethod("get"+utilitaire.Utilitaire.convertDebutMajuscule(nomLigne),null).invoke(aCroise[i],null));
          if(valColAi.compareToIgnoreCase(valCo)==0 && valLigneAi.compareToIgnoreCase(valLi)==0)
          {
            Double temp=(Double) (aCroise[i].getClass().getMethod("get"+utilitaire.Utilitaire.convertDebutMajuscule(nomCentre),null).invoke(aCroise[i],null));
            retour=retour+temp.doubleValue();
          }
        }
        return retour;
      }
      catch (Exception ex) {
        ex.printStackTrace();
        return 0;
      }
    }
    public void setValColBdd()
    {
		try{
      valCol=utilitaire.Utilitaire.getvalCol(nomTable,nomCol);
      valLigne=utilitaire.Utilitaire.getvalCol(nomTable,nomLigne);
	  }catch(Exception ex){
	  ex.printStackTrace();
	  }
    }
  public Object[] getACroise() {
    return aCroise;
  }
  public double[][] getCroise() {
    return croise;
  }
  public String getNomCol() {
    return nomCol;
  }
  public String getNomLigne() {
    return nomLigne;
  }
  public String[] getValCol() {
    return valCol;
  }
  public String[] getValLigne() {
    return valLigne;
  }
  public void setNomLigne(String nomLigne) {
    this.nomLigne = nomLigne;
  }
  public void setNomCol(String nomCol) {
    this.nomCol = nomCol;
  }
  public void setCroise(double[][] croise) {
    this.croise = croise;
  }
  public void setACroise(Object[] aCroise) {
    this.aCroise = aCroise;
  }
  public String getNomTable() {
    return nomTable;
  }
  public void setNomTable(String nomTable) {
    this.nomTable = nomTable;
  }
  public String getNomCentre() {
    return nomCentre;
  }
  public void setNomCentre(String nomCentre) {
    this.nomCentre = nomCentre;
  }
  public double[] getSommeLigne() {
    return sommeLigne;
  }
  public double[] getSommeColonne() {
    return sommeColonne;
  }
  public double getSommeTotal() {
    return sommeTotal;
  }
}