/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;
import java.sql.Date;

/**
 *
 * @author Toavina
 */
public class LibererLib extends Liberer {

    private String id,etatlib,num,codeEtablissementLib,projetLib;
    private Date  daty;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

      @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getCodeEtablissementLib() {
        return codeEtablissementLib;
    }

    public void setCodeEtablissementLib(String codeEtablissement) {
        this.codeEtablissementLib = codeEtablissement;
    }

    public String getProjetLib() {
        return projetLib;
    }

    public void setProjetLib(String projetLib) {
        this.projetLib = projetLib;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }
    
}
