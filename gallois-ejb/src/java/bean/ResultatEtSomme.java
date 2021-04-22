package bean;

/**
 * <p>
 * Title: </p>
 * <p>
 * Description: </p>
 * <p>
 * Copyright: Copyright (c) 2008</p>
 * <p>
 * Company: </p>
 *
 * @author unascribed
 * @version 1.0
 */
public class ResultatEtSomme {

    Object[] resultat;
    private double[] sommeEtNombre;

    public ResultatEtSomme() {
    }

    public ResultatEtSomme(Object[] r, double[] rn) {
        this.setResultat(r);
        this.setSommeEtNombre(rn);
    }

    public ResultatEtSomme(Object[] r) {
        this.setResultat(r);
        //this.setSommeEtNombre(rn);
    }

    public Object[] getResultat() {
        return resultat;
    }

    public double[] getSommeEtNombre() {
        return sommeEtNombre;
    }

    public void setResultat(Object[] resultat) {
        this.resultat = resultat;
    }

    public void setSommeEtNombre(double[] sommeEtNombre) {
        this.sommeEtNombre = sommeEtNombre;
    }

    public void initialise(String[] colSomme) {
        resultat = new bean.ClassMAPTable[0];

        if (colSomme == null) {
            sommeEtNombre = new double[1];
            sommeEtNombre[0] = 0;
        } else {
            sommeEtNombre = new double[colSomme.length + 1];
            for (int i = 0; i < colSomme.length; i++) {
                sommeEtNombre[i] = 0;
            }
            sommeEtNombre[colSomme.length] = 0;
        }
    }
}
