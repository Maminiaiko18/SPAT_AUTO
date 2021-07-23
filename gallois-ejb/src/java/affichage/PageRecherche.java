package affichage;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;

import utilitaire.Constante;
import utilitaire.Utilitaire;

/**
 * <p>
 * Title: Gestion des recettes </p>
 * <p>
 * Description: </p>
 * <p>
 * Copyright: Copyright (c) 2005</p>
 * <p>
 * Company: </p>
 *
 * @author unascribed
 * @version 1.0
 */
public class PageRecherche extends Page {

    private TableauRecherche listeTabDet;
    private bean.ClassMAPTable[] liste;
    private bean.ClassMAPTable critere;
    private String[] colInt;
    private String[] valInt;
    private bean.ResultatEtSomme rs;
    private int numPage = 1;
    private String[] colSomme;
    private String apres;
    private String aWhere = "";
    private String ordre = "";
    private String apresLienPage = "";
    private int npp = 0;
    private String[] tableauAffiche;
    private int nbTableauAffiche;
    private boolean premier = false;
    private String[] tableauAfficheDefaut;
    
    public void makeTableauAffiche() throws Exception {
        String temp[] = new String[getNbTableauAffiche()];
        for (int i = 0; i < temp.length; i++) {
            temp[i] = getReq().getParameter("colAffiche" + (i + 1));
        }
        setTableauAffiche(Utilitaire.formerTableauGroupe(temp));
    }

    public void preparerDataList(Connection c) throws Exception {
        critere.setNomTable(getBase().getNomTable());
        makeCritere();
        if (premier == true) {
            rs = new bean.ResultatEtSomme();
            rs.initialise(getColSomme());
        } else {
            //System.out.println("NIDITRA PREPARER DATALIST Bouton ");
            String recap = getReq().getParameter("recap");
            if (recap != null && recap.compareToIgnoreCase("checked") == 0) {
                recap = "checked";
                this.getFormu().setRecapcheck(recap);
                rs = getUtilisateur().getDataPage(critere, getColInt(), getValInt(), getNumPage(), getAWhere(), getColSomme(), c, npp);
            } else {
                recap = "";
                rs = getUtilisateur().getDataPageMaxSansRecap(critere, getColInt(), getValInt(), getNumPage(), getAWhere(), getColSomme(), c, npp);
            }
        }
        setListe((bean.ClassMAPTable[]) rs.getResultat());
    }

    public String getOrdre() {
        return ordre;
    }

    public void setOrdre(String ordre) {
        this.ordre = ordre;
    }

    public void preparerDataFormu() throws Exception {
        Connection c = null;
        try {
            c = new utilitaire.UtilDB().GetConn();
            formu.getAllData(c);
        } catch (Exception ex) {
            throw (ex);
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void setPremier(boolean premier) {
        this.premier = premier;
    }

    public boolean getPremier() {
        return premier;
    }

    public boolean isPremier() {
        return premier;
    }

    public void preparerData() throws Exception {
        Connection c = null;
        try {
            c = new utilitaire.UtilDB().GetConn();
            preparerDataList(c);
            formu.getAllData(c);
            getReq().getSession().setAttribute("critere", getCritere());
        } catch (Exception ex) {
            throw (ex);
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void makeCritere() throws Exception {
        Vector colIntv = new Vector();
        Vector valIntv = new Vector();
        Champ[] tempChamp = formu.getCrtFormu();
        this.getCritere().setMode("select");

        String temp = "";
        for (int i = 0; i < tempChamp.length; i++) {
            Field f = bean.CGenUtil.getField(getBase(), tempChamp[i].getNom());
            //System.out.println("getParamSansnUll "+getParamSansNull(tempChamp[i].getNom()) + "tempChamp === "+tempChamp[i].getValeur());
            if (tempChamp[i].getEstIntervalle() == 1) {
                colIntv.add(tempChamp[i].getNom());
                if((getParamSansNull(tempChamp[i].getNom() + "1")==null||getParamSansNull(tempChamp[i].getNom() + "1").compareToIgnoreCase("")==0)&&this.getFormu().getChamp((tempChamp[i].getNom() + "1"))!=null&&this.getFormu().getChamp((tempChamp[i].getNom() + "1")).getDefaut()!=null&&this.getFormu().getChamp((tempChamp[i].getNom() + "1")).getDefaut().compareToIgnoreCase("")!=0)
                {
                    valIntv.add(this.getFormu().getChamp((tempChamp[i].getNom() + "1")).getDefaut());
                }
                else valIntv.add(getParamSansNull(tempChamp[i].getNom() + "1"));
                if((getParamSansNull(tempChamp[i].getNom() + "2")==null||getParamSansNull(tempChamp[i].getNom() + "2").compareToIgnoreCase("")==0)&&this.getFormu().getChamp((tempChamp[i].getNom() + "2"))!=null&&this.getFormu().getChamp((tempChamp[i].getNom() + "2")).getDefaut()!=null&&this.getFormu().getChamp((tempChamp[i].getNom() + "2")).getDefaut().compareToIgnoreCase("")!=0)
                {
                    valIntv.add(this.getFormu().getChamp((tempChamp[i].getNom() + "2")).getDefaut());
                }
                else valIntv.add(getParamSansNull(tempChamp[i].getNom() + "2"));
            } else if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0) {
                if((getParamSansNull(tempChamp[i].getNom())==null||getParamSansNull(tempChamp[i].getNom()).compareToIgnoreCase("")==0)&&this.getFormu().getChamp((tempChamp[i].getNom()))!=null&&this.getFormu().getChamp((tempChamp[i].getNom())).getDefaut()!=null&&this.getFormu().getChamp((tempChamp[i].getNom())).getDefaut().compareToIgnoreCase("")!=0)
                {
                    bean.CGenUtil.setValChamp(getCritere(), f, this.getFormu().getChamp(tempChamp[i].getNom()).getValeur());
                }
                else
                {
                    String valeurChamp = getReq().getParameter(utilitaire.Utilitaire.remplacerUnderscore(tempChamp[i].getNom()));
                    if (valeurChamp != null && valeurChamp.compareTo("") != 0) {
                        // System.out.println(" getCritere() = " + getCritere() + " f.getName() " + f.getName() + " getParamSansNull(tempChamp[i].getNom()) " + getParamSansNull(tempChamp[i].getNom()));

                        bean.CGenUtil.setValChamp(getCritere(), f, getParamSansNull(tempChamp[i].getNom()));
                    }
                }
            } 
            else {
                if((getParamSansNull(tempChamp[i].getNom())==null||getParamSansNull(tempChamp[i].getNom()).compareToIgnoreCase("")==0)&&this.getFormu().getChamp((tempChamp[i].getNom()))!=null&&this.getFormu().getChamp((tempChamp[i].getNom())).getDefaut()!=null&&this.getFormu().getChamp((tempChamp[i].getNom())).getDefaut().compareToIgnoreCase("")!=0)
                    aWhere += " and " + f.getName() + " like '" + Utilitaire.getValeurNonNull(this.getFormu().getChamp(tempChamp[i].getNom()).getValeur()) + "'";
                else    
                    aWhere += " and " + f.getName() + " like '" + Utilitaire.getValeurNonNull(getParamSansNull(tempChamp[i].getNom())) + "'";
            }
        }
        colInt = new String[colIntv.size()];
        colIntv.copyInto(colInt);
        valInt = new String[valIntv.size()];
        valIntv.copyInto(valInt);
        if (getReq().getParameter("triCol") != null) {
            formu.getChamp("colonne").setValeur(getReq().getParameter("newcol"));
            if (getReq().getParameter("ordre").compareToIgnoreCase("") == 0) {
                formu.getChamp("ordre").setValeur("asc");
                this.setOrdre(" order by " + getReq().getParameter("newcol") + " asc ");
            } else if (getReq().getParameter("ordre").compareToIgnoreCase("desc") == 0) {
                formu.getChamp("ordre").setValeur("asc");
                this.setOrdre(" order by " + getReq().getParameter("newcol") + " asc ");
            } else {
                formu.getChamp("ordre").setValeur("desc");
                this.setOrdre(" order by " + getReq().getParameter("newcol") + " desc ");
            }
        }
        if (formu.getChamp("colonne").getValeur() != null && formu.getChamp("ordre").getValeur().compareToIgnoreCase("-") != 0 && formu.getChamp("colonne").getValeur().compareToIgnoreCase("") != 0 ) {
            this.setOrdre(" order by " + formu.getChamp("colonne").getValeur() + " " + formu.getChamp("ordre").getValeur());
        }
        aWhere += this.getOrdre();
    }
    
    /*public void makeCritere() throws Exception {
        Vector colIntv = new Vector();
        Vector valIntv = new Vector();
        Champ[] tempChamp = formu.getCrtFormu();

        String temp = "";
        for (int i = 0; i < tempChamp.length; i++) {
            Field f = bean.CGenUtil.getField(getBase(), tempChamp[i].getNom());
            if (tempChamp[i].getEstIntervalle() == 1) {
                colIntv.add(tempChamp[i].getNom());
                valIntv.add(getParamSansNull(tempChamp[i].getNom() + "1"));
                valIntv.add(getParamSansNull(tempChamp[i].getNom() + "2"));
            } else if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0) {
                String valeurChamp = getReq().getParameter(utilitaire.Utilitaire.remplacerUnderscore(tempChamp[i].getNom()));
                if (valeurChamp != null && valeurChamp.compareTo("") != 0) {
                    // System.out.println(" getCritere() = " + getCritere() + " f.getName() " + f.getName() + " getParamSansNull(tempChamp[i].getNom()) " + getParamSansNull(tempChamp[i].getNom()));
                    bean.CGenUtil.setValChamp(getCritere(), f, getParamSansNull(tempChamp[i].getNom()));
                }
            } else {
                aWhere += " and " + f.getName() + " like '" + Utilitaire.getValeurNonNull(getParamSansNull(tempChamp[i].getNom())) + "'";
            }
        }
        colInt = new String[colIntv.size()];
        colIntv.copyInto(colInt);
        valInt = new String[valIntv.size()];
        valIntv.copyInto(valInt);
        if (getReq().getParameter("triCol") != null) {
            formu.getChamp("colonne").setValeur(getReq().getParameter("newcol"));
            if (getReq().getParameter("ordre").compareToIgnoreCase("") == 0) {
                formu.getChamp("ordre").setValeur("asc");
                this.setOrdre(" order by " + getReq().getParameter("newcol") + " asc ");
            } else if (getReq().getParameter("ordre").compareToIgnoreCase("desc") == 0) {
                formu.getChamp("ordre").setValeur("asc");
                this.setOrdre(" order by " + getReq().getParameter("newcol") + " asc ");
            } else {
                formu.getChamp("ordre").setValeur("desc");
                this.setOrdre(" order by " + getReq().getParameter("newcol") + " desc ");
            }
        }
        if (formu.getChamp("colonne").getValeur() != null && formu.getChamp("ordre").getValeur().compareToIgnoreCase("-") != 0 && formu.getChamp("colonne").getValeur().compareToIgnoreCase("") != 0) {
            this.setOrdre(" order by " + formu.getChamp("colonne").getValeur() + " " + formu.getChamp("ordre").getValeur());
        }
        aWhere += this.getOrdre();
    }*/
    /*
     public void creerObjetPage(String libEntete[]) throws Exception
     {
     getValeurFormulaire();
     preparerData();
     makeTableauRecap();
     setTableau(new TableauRecherche(getListe(),libEntete));
     }*/

    public void creerObjetPage(String libEntete[]) throws Exception {
        getValeurFormulaire();
        preparerData();
        makeTableauRecap();
        String critereLienTab = "<a href=" + getLien() + "?but=" + getApres() + "&numPag=1" + getApresLienPage() + formu.getListeCritereString() + "";

        ClassMAPTable crt = getCritere();
        Field[] listF = crt.getClass().getDeclaredFields();
        setTableau(new TableauRecherche(getListe(), libEntete, critereLienTab, listF));

    }

    public void creerObjetPage(ClassMAPTable[] liste, String libEntete[]) throws Exception {
        setListe(liste);
        creerObjetPage(libEntete);
    }
    /*
     public void creerObjetPage(String libEnteteDefaut[],String []colSom) throws Exception
     {
     setColSomme(colSom);
     getValeurFormulaire();
     preparerData();
     makeTableauRecap();
     String[]enteteAuto= getTableauAffiche();
     if(getTableauAffiche()==null){
     setTableau(new TableauRecherche(getListe(),libEnteteDefaut));
     }
     else
     setTableau(new TableauRecherche(getListe(),enteteAuto));
     }*/

    public void creerObjetPage(String libEnteteDefaut[], String[] colSom) throws Exception {
        setColSomme(colSom);
        getValeurFormulaire();
        preparerData();
        makeTableauRecap();
        String critereLienTab = "<a href=" + getLien() + "?but=" + getApres() + "&numPag=1" + getApresLienPage() + formu.getListeCritereString();

        ClassMAPTable crt = getCritere();
        Field[] listF = crt.getClass().getDeclaredFields();

        String[] enteteAuto = getTableauAffiche();
        if (getTableauAffiche() == null) {
//            System.out.println(" ICI KOTO ==== null");
            setTableau(new TableauRecherche(getListe(), libEnteteDefaut, critereLienTab, listF));
        } else {
//            System.out.println(" ICI KOTO ==== NOT null");
            setTableau(new TableauRecherche(getListe(), enteteAuto, critereLienTab, listF));
        }
        //this.getTableau().setListeField(listF);
    }
    /* public void creerObjetPage() throws Exception
     {
     getValeurFormulaire();
     preparerData();
     makeTableauRecap();
     String[]enteteAuto= getTableauAffiche();
     setTableau(new TableauRecherche(getListe(),enteteAuto));
     } */

    public PageRecherche(bean.ClassMAPTable o, HttpServletRequest req, String[] vrt, String[] listInterval, int nbRange, String[] tabAff, int nbAff) throws Exception {
        setBase(o);
        //setTitre(titre);
        setCritere((bean.ClassMAPTable) (Class.forName(o.getClassName()).newInstance()));
        setReq(req);
        if (getReq().getParameter("premier") != null && getReq().getParameter("premier").compareToIgnoreCase("") != 0) {
            setPremier(Boolean.valueOf(getReq().getParameter("premier")).booleanValue());
        }
        formu = new Formulaire();
        formu.setObjet(getBase());
        formu.makeChampFormu(vrt, listInterval, nbRange);
        setNbTableauAffiche(nbAff);
        setTableauAfficheDefaut(tabAff);
        makeTableauAffiche();
        formu.makeChampTableauAffiche(getNbTableauAffiche(), tabAff);
        if (req != null) {
            if (req.getSession().getAttribute("lang") != null) {
                formu.lang = String.valueOf(req.getSession().getAttribute("lang"));
            }
        }
    }

    public PageRecherche() {
    }

    public PageRecherche(bean.ClassMAPTable o, HttpServletRequest req, String[] vrt, String[] listInterval, int nbRange) throws Exception {
        setBase(o);
        //setTitre(titre);
        setCritere((bean.ClassMAPTable) (Class.forName(o.getClassName()).newInstance()));
        setReq(req);
        if (getReq().getParameter("premier") != null && getReq().getParameter("premier").compareToIgnoreCase("") != 0) {
            setPremier(Boolean.valueOf(getReq().getParameter("premier")).booleanValue());
        }
        formu = new Formulaire();
        formu.setObjet(getBase());
        formu.makeChampFormu(vrt, listInterval, nbRange);
    }

    public bean.ClassMAPTable[] getListe() {
        return liste;
    }

    public void setListe(bean.ClassMAPTable[] liste) {
        this.liste = liste;
    }

    public void setListeTabDet(TableauRecherche listeTabDet) {
        this.listeTabDet = listeTabDet;
    }

    public TableauRecherche getListeTabDet() {
        return listeTabDet;
    }

    public void setCritere(bean.ClassMAPTable critere) {
        this.critere = critere;
    }

    public bean.ClassMAPTable getCritere() {
        return critere;
    }

    public void setColInt(String[] colInt) {
        this.colInt = colInt;
    }

    public String[] getColInt() {
        return colInt;
    }

    public void setValInt(String[] valInt) {
        this.valInt = valInt;
    }

    public String[] getValInt() {
        return valInt;
    }

    public void makeHtml() {

    }

    public void setRs(bean.ResultatEtSomme rs) {
        this.rs = rs;
    }

    public bean.ResultatEtSomme getRs() {
        return rs;
    }

    public void setNumPage(int numPage) {
        this.numPage = numPage;
    }

    public int getNumPage() {
        int temp = 1;
        String tempS = getParamSansNull("numPag");
        //System.out.println("tempsS==>"+tempS);
        if (tempS == null || tempS.compareToIgnoreCase("") == 0) {
            return numPage;
        }
        temp = utilitaire.Utilitaire.stringToInt(tempS);
        if (temp > 0) {
            return temp;
        }
        return numPage;
    }

    public void setColSomme(String[] colSomme) {
        this.colSomme = colSomme;
    }

    public String[] getColSomme() {
        return colSomme;
    }

    public void makeTableauRecap() throws Exception {
        String lang = String.valueOf(getReq().getSession().getAttribute("lang"));
        ResourceBundle RB = ResourceBundle.getBundle("text", new Locale(lang));

        String[][] data = null;
        String[] entete = null;
        int nbColSomme = 0;
        if (getColSomme() != null) {
            nbColSomme = getColSomme().length;
        }
        entete = new String[nbColSomme + 2];
        data = new String[1][entete.length];
        entete[0] = "";
        data[0][0] = RB.getString("total");
        entete[1] = RB.getString("nombre");
        data[0][1] = utilitaire.Utilitaire.formaterSansVirgule(rs.getSommeEtNombre()[nbColSomme]);
        for (int i = 0; i < nbColSomme; i++) {
            data[0][i + 2] = utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[i]));
            entete[i + 2] = RB.getString("sommede") + " " + String.valueOf(getColSomme()[i]);
        }
        TableauRecherche t = new TableauRecherche(data, entete);
        t.setTitre(RB.getString("recapitulation"));
        setTableauRecap(t);
    }

    public int getNombrePage() {
        return (Utilitaire.calculNbPage(rs.getSommeEtNombre()[getNombreColonneSomme()], getNpp()));
    }

    public int getNombreColonneSomme() {
        int nbColSomme = 0;
        if (getColSomme() != null) {
            nbColSomme = getColSomme().length;
        }
        return nbColSomme;
    }
    /*public String getBasPage()
     {
     String retour="";
     retour+="<div class='col-md-12'>";
     retour+="<div class='col-md-6'>";
     retour+="<b>Nombre de r&eacute;sultats trouv&eacute;s:</b> "+utilitaire.Utilitaire.formaterSansVirgule(rs.getSommeEtNombre()[getNombreColonneSomme()])+"";
     retour+="</div>";
     retour+="<div class='col-md-6'>";
     retour+="<div class='col-md-2' align='left'>";
     retour+="<p><button class='btn btn-block btn-default btn-flat ";
     System.out.println(getNumPage());
     System.out.println("==============");
     if(getNumPage()<=1)
     {
     retour+="disabled";
     }
     retour+="'><a href="+getLien()+"?but="+getApres()+"&numPag="+String.valueOf(getNumPage()-1)+getApresLienPage()+formu.getListeCritereString()+"><i class='fa fa-arrow-circle-left'></i> </a></button>";
     retour+="</div>";
     retour+="<div class='col-md-2' align='center'>";
     retour+="<strong>page</strong> "+getNumPage()+" <b>sur </b>"+getNombrePage()+"";
     retour+="</div>";
     retour+="<div class='col-md-2' align='right'>";
     retour+="<button class='btn btn-block btn-default btn-flat ";
     if(getNumPage()>=getNombrePage())
     {
     retour+="disabled";
     }
     retour+="'><a href="+getLien()+"?but="+getApres()+"&numPag="+String.valueOf(getNumPage()+1)+getApresLienPage()+formu.getListeCritereString()+"> <i class='fa fa-arrow-circle-right'></i> </a></button></p>";
     retour+="</div>";
     retour+="</div></div>";
     return retour;
     }*/

    public String getBasPage() throws Exception {
        String lang = String.valueOf(getReq().getSession().getAttribute("lang"));
        ResourceBundle RB = ResourceBundle.getBundle("text", new Locale(lang));

        String retour = "";
        retour += "<table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>";
        retour += "<tr><td height=25><b>" + RB.getString("nbresultat") + " :</b> " + utilitaire.Utilitaire.formaterSansVirgule(rs.getSommeEtNombre()[getNombreColonneSomme()]) + "</td><td align='right'><strong>page</strong> " + getNumPage() + " <b>sur</b> " + getNombrePage() + "</td>";
        retour += "</tr>";
        retour += "<tr>";
        retour += "<td width=50% valign='top' height=25>";
        if (getNumPage() > 1) {
            retour += "<a href=" + getLien() + "?but=" + getApres() + "&recap=" + getFormu().getRecapcheck() + "&premier=" + getPremier() + "&numPag=" + String.valueOf(getNumPage() - 1) + getApresLienPage() + formu.getListeCritereString() + ">&lt;&lt;" + RB.getString("pageprecedente") + "</a>";
        }
        retour += "</td>";
        retour += "<td width=50% align=right>";
        if (getNumPage() < getNombrePage()) {
            retour += "<a href=" + getLien() + "?but=" + getApres() + "&recap=" + getFormu().getRecapcheck() + "&premier=" + getPremier() + "&numPag=" + String.valueOf(getNumPage() + 1) + getApresLienPage() + formu.getListeCritereString() + ">" + RB.getString("pagesuivante") + "&gt;&gt;</a>";
        }
        retour += "</td>";
        retour += "</tr>";
        retour += "</table>";
        retour += getDownloadForm();
        return retour;
    }

    public String getBasPagee() {

        String lang = String.valueOf(getReq().getSession().getAttribute("lang"));
        ResourceBundle RB = ResourceBundle.getBundle("text", new Locale(lang));

        String retour = "";
        retour += "<table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>";
        retour += "<tr><td height=25><b>" + RB.getString("nbresultat") + " :</b> " + utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[getNombreColonneSomme()])) + "</td><td align='right'><strong>page</strong> " + getNumPage() + " <b>sur</b> " + getNombrePage() + "</td>";
        retour += "</tr>";
        retour += "<tr>";
        retour += "<td width=50% valign='top' height=25>";
        if (getNumPage() > 1) {
            retour += "<a href=" + getApres() + "?a=1" + formu.getListeCritereString() + "&premier=" + getPremier() + "&numPag=" + String.valueOf(getNumPage() - 1) + getApresLienPage() + "&champReturn=etudiant>&lt;&lt;" + RB.getString("pageprecedente") + "</a>";
        }
        retour += "</td>";
        retour += "<td width=50% align=right>";
        if (getNumPage() < getNombrePage()) {
            retour += "<a href=" + getApres() + "?a=1" + formu.getListeCritereString() + "&premier=" + getPremier() + "&numPag=" + String.valueOf(getNumPage() + 1) + getApresLienPage() + "&champReturn=etudiant>" + RB.getString("pagesuivante") + "&gt;&gt;</a>";
        }
        retour += "</td>";
        retour += "</tr>";
        retour += "</table>";
        return retour;
    }

    public void setApres(String apres) {
        this.apres = apres;
    }

    public String getApres() {
        return apres;
    }

    public String getAWhere() {
        return aWhere;
    }

    public void setAWhere(String aWhere) {
        this.aWhere = aWhere;
    }

    public void setApresLienPage(String apresLienPage) {
        this.apresLienPage = apresLienPage;
    }

    public String getApresLienPage() {
        return apresLienPage;
    }

    public void setNpp(int npp) {
        this.npp = npp;
    }

    public int getNpp() {
        return npp;
    }

    public void setTableauAffiche(String[] tableauAffiche) {
        this.tableauAffiche = tableauAffiche;
    }

    public int getNbTableauAffiche() {
        return nbTableauAffiche;
    }

    public void setNbTableauAffiche(int nbTableauAffiche) {
        this.nbTableauAffiche = nbTableauAffiche;
    }

    public String getDownloadForm() throws Exception {
        String lang = String.valueOf(getReq().getSession().getAttribute("lang"));
        ResourceBundle RB = ResourceBundle.getBundle("text", new Locale(lang));

        String tab = "";
        String tab1 = "";
        try {
            tab = this.getTableau().getHtml();
            tab1 = this.getTableau().getHtmlPDF();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String awhere = " AND " + CGenUtil.makeWhere(getBase()) + CGenUtil.makeWhereIntervalle(colInt, valInt) + this.getAWhere().replace('"', '\'');
        String temp = "";
        temp += "<div class='row'>";
        temp += "<div class='row col-md-12'>";
        temp += "<div class='box box-solid collapsed-box'>";
        temp += "<div style='background-color:"+ Constante.constanteCouleur+"; color:white;'class='box-header with-border'>";
        temp += "<h3 class='box-title'>" + RB.getString("exporter") + "</h3>";
        temp += "<div class='box-tools pull-right'><button data-original-title='Collapse' class='btn btn-box-tool' data-widget='collapse' data-toggle='tooltip' title=''><i class='fa fa-plus'></i></button> </div>";
        temp += "</div>";
        temp += "<div class='box-body'>";
        temp += "<form action=\"../download\" method=\"post\">";
        temp += "<table id='export'>";
        temp += "<tr>";
        temp += "<th colspan='4'><h3 class='box-title'>" + RB.getString("format") + "</h3></th>";
        temp += "<th colspan='2'><h3 class='box-title'>" + RB.getString("donneeexport") + "</h3></th>";
        temp += "<th colspan='2'><h3 class='box-title'><strong>LANDSCAPE</strong>(pour pdf)</h3></th>";
        temp += "<th></th>";
        temp += "</tr>";
        temp += "<tr>";
        temp += "<td>";
        temp += "<img src='../dist/img/csv_text.png'>";
        temp += "<input type='radio' name='ext' value='csv' checked='checked' />";
        temp += "</td>";
        temp += "<td>";
        temp += "<img src='../dist/img/file_xls.png'>";
        temp += "<input type='radio' name='ext' value='xls' />";
        temp += "</td>";
        temp += "<td>";
        temp += "<img src='../dist/img/file_xml.png'>";
        temp += "<input type='radio' name='ext' value='xml' />";
        temp += "</td>";
        temp += "<td>";
        temp += "<img src='../dist/img/file_pdf.png'>";
        temp += "<input type='radio' name='ext' value='pdf' />";
        temp += "</td>";
        temp += "<td>";
        temp += "<label for='donnee'>" + RB.getString("pageencours") + " </label>";
        temp += "<input type='radio' name='donnee' value=\"" + 0 + "\" checked='checked' />";
        temp += "</td>";
        temp += "<td>";
        temp += "<label for='donnee'>" + RB.getString("toutes") + " </label>";
        temp += "<input type='radio' name='donnee' value=\"" + 1 + "\" />";
        temp += "</td>";
        temp += "<td>";
        temp += "<label for='landscape'>Portrait</label>";
        temp += "<input type='radio' name='landscape' value=\"" + 0 + "\" checked='checked' />";
        temp += "</td>";
        temp += "<td>";
        temp += "<label for='landscape'>Paysage</label>";
        temp += "<input type='radio' name='landscape' value=\"" + 1 + "\" />";
        temp += "</td>";
        temp += "<td>";
        if (this.getTableau().getExpxml() != null) {
            temp += "<input type=\"hidden\" name=\"xml\" value=\"" + this.getTableau().getExpxml().replace('"', '*') + "\" />";
            temp += "<input type=\"hidden\" name=\"csv\" value=\"" + this.getTableau().getExpcsv().replace('"', '*') + "\" />";
            temp += "<input type=\"hidden\" name=\"awhere\" value=\"" + awhere + "\" />";
            temp += "<input type=\"hidden\" name=\"table\" value=\"" + tab1.replace('"', '*').replace("\u0027", " ").replace("\"", " ") + "\" />";
            temp += "<input type=\"hidden\" name=\"entete\" value=\"" + Utilitaire.tabToString(this.getTableau().getLibeEntete(), "", ";") + "\" />";
            temp += "<input type=\"hidden\" name=\"entetelibelle\" value=\"" + Utilitaire.tabToString(this.getTableau().getLibelleAffiche(), "", ";") + "\" />";
        }
        int sommeId = Utilitaire.estIlDedans("montant", getColSomme());
        if (sommeId > -1) {
            temp += "<input type=\"hidden\" name=\"nombreEncours\" value=\"" + Utilitaire.formaterSansVirgule(rs.getSommeEtNombre()[getColSomme().length]) + "\" />";
            double test = rs.getSommeEtNombre()[sommeId];
            temp += "<input type=\"hidden\" name=\"recap\" value=\"" + test + "\" />";
        }

        temp += "<input type='submit' value='" + RB.getString("exporter") + "' class='btn btn-default' />";
        temp += "<input type='hidden' name='titre' value='" + getTitre() + "' />";
        temp += "</td>";
        temp += "</tr>";
        temp += "</table>";
        temp += "</form>";
        temp += "</div>";
        temp += "</div>";
        temp += "</div>";
        temp += "</div>";
        return temp;
    }
    
    
    public String[] getTableauAffiche() {
        if (tableauAffiche == null || tableauAffiche.length == 0) {
            return tableauAfficheDefaut;
        }
        return tableauAffiche;
    }

    public String[] getTableauAfficheDefaut() {
        return tableauAfficheDefaut;
    }

    public void setTableauAfficheDefaut(String[] tableauAfficheDefaut) {
        this.tableauAfficheDefaut = tableauAfficheDefaut;
    }
    public PageRecherche(bean.ClassMAPTable o, HttpServletRequest req, String[] vrt, String[] listInterval, int nbRange, String[] tabAff) throws Exception {
        setBase(o);
        //setTitre(titre);
        setCritere((bean.ClassMAPTable) (Class.forName(o.getClassName()).newInstance()));
        setReq(req);
        if(getReq().getParameter("premier") != null && getReq().getParameter("premier").compareToIgnoreCase("") != 0){
            setPremier(Boolean.valueOf(getReq().getParameter("premier")).booleanValue());
        }
        formu = new Formulaire();
        formu.setObjet(getBase());
        formu.makeChampFormu(vrt, listInterval, nbRange);
        setNbTableauAffiche(tabAff.length);
        setTableauAfficheDefaut(tabAff);
        makeTableauAffiche();
        formu.makeChampTableauAffiche(getNbTableauAffiche(), tabAff);
    }
}
