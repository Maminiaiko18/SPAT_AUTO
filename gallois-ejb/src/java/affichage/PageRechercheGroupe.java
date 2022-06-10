package affichage;

import bean.AnalyseLien;
import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ResultatEtSomme;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.Date;
import java.util.Arrays;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import user.UserEJB;
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
public class PageRechercheGroupe extends Page {

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
    private String apresLienPage = "";
    private String[] colGroupe; // Tableau de chaine representant les valeurs des colonnes selectionnees.
    private String[] sommeGroupe;
    private String ordre = "";
    private int nbColGroupe = 2;
    private int nbSommeGrp = 2;
    private String[] colGroupeDefaut;
    private String[] sommeGroupeDefaut;
    private int npp = 0;
    private String[] listeColonneMoyenne;
    private String[] pourcentage;
    private double[][] pourc;
    private boolean premier = false;
    private Liste count;
    private PageInsert insertLienAnalyse;
    private String[] ligneGroupe; 
    
    private ClassMAPTable[] dataM1;
    
    private String colDateMoisMoins1 = null;

    public String getColDateMoisMoins1() {
        return colDateMoisMoins1;
    }

    public void setColDateMoisMoins1(String colDateMoisMoins1) {
        this.colDateMoisMoins1 = colDateMoisMoins1;
    }    

    public ClassMAPTable[] getDataM1() {
        return dataM1;
    }

    public void setDataM1(ClassMAPTable[] dataM1) {
        this.dataM1 = dataM1;
    }

    public PageInsert getInsertLienAnalyse() {
        return insertLienAnalyse;
    }

    public void setInsertLienAnalyse(PageInsert insertLienAnalyse) {
        this.insertLienAnalyse = insertLienAnalyse;
    }

    /*public void preparerDataList(Connection c) throws Exception
     {
     //if(critere.getNomTable()==null||critere.getNomTable().compareToIgnoreCase("")==0)
     critere.setNomTable(getBase().getNomTable());
     //System.out.println("table = "+critere.getNomTable()+"!!!!!!!");
     makeCritere();
     rs=getUtilisateur().getDataPageGroupe(critere,getColGroupe(),getSommeGroupe(),getColInt(),getValInt(),getNumPage(),getAWhere(),getColSomme(),getOrdre(),c,npp);
     setListe ((bean.ClassMAPTable[])rs.getResultat());
     }*/
    public void preparerDataList(Connection c) throws Exception {
        critere.setNomTable(getBase().getNomTable());
        makeCritere();
        if (premier == true) {
            rs = new bean.ResultatEtSomme();
            rs.initialise(getColSomme());
        } 
        else {
          //  System.out.println("DANS PREPARER DATALIST AVANT getDataPageGroupe "+Utilitaire.heureCouranteHMS());
            rs = getUtilisateur().getDataPageGroupe(critere, getColGroupe(), getSommeGroupe(), getColInt(), getValInt(), getNumPage(), getAWhere(), getColSomme(), getOrdre(), c, npp);
            dataMoisMoins1(c);
            //System.out.println("DANS PREPARER DATALIST APRES getDataPageGroupe "+Utilitaire.heureCouranteHMS());
        }
        
        bean.ClassMAPTable[] listeVal = (bean.ClassMAPTable[]) rs.getResultat();
        //calculPourcentage(rs, listeVal, c);
        setListe(listeVal);
    }

    public void calculPourcentage(bean.ResultatEtSomme rs, bean.ClassMAPTable[] listeVal, Connection c) throws Exception {
        bean.ClassMAPTable[] liste = (bean.ClassMAPTable[]) CGenUtil.rechercher(getBase(), null, null, c, "");
        pourc = new double[getPourcentage().length][listeVal.length];
        for (int iCol = 0; iCol < getPourcentage().length; iCol++) {
            for (int iLigne = 0; iLigne < listeVal.length; iLigne++) {
                double valeur = Double.parseDouble(CGenUtil.getValeurFieldByMethod(listeVal[iLigne], getPourcentage()[iCol]).toString());
                if (getSommeGroupe().length != 0 && getPourcentage()[iCol].compareToIgnoreCase("nombrepargroupe") != 0) {
                    int k = 0;
                    for (k = 0; k < getSommeGroupe().length; k++) {
                        if (getSommeGroupe()[k].compareTo(getPourcentage()[iCol]) == 0) {
                            break;
                        }
                    }
                    pourc[iCol][iLigne] = (valeur * 100 / rs.getSommeEtNombre()[k]);
                } else {
                    pourc[iCol][iLigne] = (valeur * 100 / liste.length);
                }
            }
        }
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
        for (int i = 0; i < tempChamp.length; i++) {
            Field f = bean.CGenUtil.getField(getBase(), tempChamp[i].getNom());
            if (tempChamp[i].getEstIntervalle() == 1) {
                colIntv.add(tempChamp[i].getNom());
                valIntv.add(getParamSansNull(tempChamp[i].getNom() + "1"));
                valIntv.add(getParamSansNull(tempChamp[i].getNom() + "2"));
            } else if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0) {
                bean.CGenUtil.setValChamp(getCritere(), f, getParamSansNull(tempChamp[i].getNom()));
            } else {
                //aWhere+=" and "+f.getName() +" like '"+ Utilitaire.getValeurNonNull(formu.getListeChamp()[i].getValeur()) +"'";
                aWhere += " and " + f.getName() + " like '" + Utilitaire.getValeurNonNull(getParamSansNull(tempChamp[i].getNom())) + "'";
            }
        }
        //System.out.println("AWHERE = "+aWhere);
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
        } else if (formu.getChamp("colonne").getValeur() != null && formu.getChamp("ordre").getValeur().compareToIgnoreCase("-") != 0 && formu.getChamp("colonne").getValeur().compareToIgnoreCase("") != 0) {
            if (Utilitaire.estIlDedans(formu.getChamp("colonne").getValeur(), Utilitaire.concatener(getColGroupe(), getColSomme())) != -1) {
                setOrdre(" order by " + formu.getChamp("colonne").getValeur() + " " + formu.getChamp("ordre").getValeur());
            }
        }
    }

    public void makeCritereMultiple() throws Exception {
        Vector colIntv = new Vector();
        Vector valIntv = new Vector();
        Champ[] tempChamp = formu.getCrtFormu();
        for (int i = 0; i < tempChamp.length; i++) {
            Field f = bean.CGenUtil.getField(getBase(), tempChamp[i].getNom());
            if (tempChamp[i].getEstIntervalle() == 1) {
                colIntv.add(tempChamp[i].getNom());
                valIntv.add(getParamSansNull(tempChamp[i].getNom() + "1"));
                valIntv.add(getParamSansNull(tempChamp[i].getNom() + "2"));
            } else if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0) {
                String temp = getReq().getParameter(utilitaire.Utilitaire.remplacerUnderscore(tempChamp[i].getNom()));
                if (temp != null && temp.compareToIgnoreCase("") != 0) {
                    bean.CGenUtil.setValChamp(getCritere(), f, getParamSansNullMultiple(tempChamp[i].getNom()));
                }
            } else {
                //aWhere+=" and "+f.getName() +" like '"+ Utilitaire.getValeurNonNull(formu.getListeChamp() [i].getValeur()) +"'";
                aWhere += " and " + f.getName() + " like '" + Utilitaire.getValeurNonNull(getParamSansNullMultiple(tempChamp[i].getNom())) + "'";
            }
        }
        colInt = new String[colIntv.size()];
        colIntv.copyInto(colInt);
        valInt = new String[valIntv.size()];
        valIntv.copyInto(valInt);
        if (formu.getChamp("colonne").getValeur() != null && formu.getChamp("colonne").getValeur().compareToIgnoreCase("") != 0) {
            ordre += " order by " + formu.getChamp("colonne").getValeur() + " " + formu.getChamp("ordre").getValeur();
        }
    }

    private void setAnalyseLien() throws Exception {
        AnalyseLien crit = new AnalyseLien();
        crit.setNomTable("analyselien");
        int idUser = this.getUtilisateur().getUser().getRefuser();
        crit.setIdUtilisateur(idUser);
        crit.setPage(this.getPathPage());
        AnalyseLien[] liens = (AnalyseLien[]) CGenUtil.rechercher(crit, null, null, " and idutilisateur="+idUser);
        this.getFormu().setLiens(liens);
    }
    
    private void saveAnalyseLien() {
        System.out.println("ENREGISTRER ANALYSE LIEN");
    }
    
    public void creerObjetPage() throws Exception {
        this.setAnalyseLien();
        
        getValeurFormulaire(); //Recuperation des valeurs choisi

        preparerData(); // Recuperation des donnees de la base

        makeTableauRecap();
        
        makeInsertLienModal();

        String[] enteteAuto = Utilitaire.ajouterTableauString(getColGroupe(), getSommeGroupe());
        String critereLienTab = "<a href=" + getLien() + "?but=" + getApres() + "&numPag=1" + getApresLienPage() + formu.getListeCritereString();

        ClassMAPTable crt = getCritere();
        Field[] listF = crt.getClass().getDeclaredFields();
        this.setTableau(new TableauRecherche(getListe(), enteteAuto, critereLienTab, listF)); // Formation du tableau de resultat

    }
    
    public void makeInsertLienModal() throws Exception {
        try{
        AnalyseLien analyselien=new AnalyseLien();
        analyselien.setNomTable("analyselien");
        String lienAnalyse = this.getLien() +"?"+getReq().getQueryString();
        //analyselien.setLien(lienAnalyse);
        PageInsert pageinsertModal=new PageInsert(analyselien,getReq(),this.getUtilisateur());
        pageinsertModal.setLien(this.getLien());
        pageinsertModal.getFormu().getChamp("lien").setDefaut(lienAnalyse);
        pageinsertModal.getFormu().getChamp("lien").setAutre("readonly");
        pageinsertModal.getFormu().getChamp("idUtilisateur").setDefaut(""+this.getUtilisateur().getUser().getRefuser());
        pageinsertModal.getFormu().getChamp("idUtilisateur").setAutre("readonly");
        pageinsertModal.getFormu().getChamp("idUtilisateur").setLibelle("Reference");
        pageinsertModal.getFormu().getChamp("page").setDefaut(this.getPathPage()); 
        pageinsertModal.getFormu().getChamp("page").setAutre("readonly");
        pageinsertModal.getFormu().getChamp("page").setLibelle("lien de la page");
      
        this.setInsertLienAnalyse(pageinsertModal);
        }
        catch(Exception e){
            
            e.printStackTrace();
            
        }
    }
    
    public String getInsertLienModal()throws Exception {
        PageInsert analyselien=this.getInsertLienAnalyse();
        
        String ret = "<div class='modal fade' id='saveLienModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>";
           ret+="<div class='modal-dialog'>";
             ret+=" <div class='modal-content'>";
                ret+=" <div class='modal-header'>";
                    ret+=" <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>";
                    ret+=" <h4 class='modal-title' id='myModalLabel'>Analyse Lien insertion</h4>";
                ret+="</div>";
                ret+="<div class='modal-body'>";
                ret+="<form action='"+analyselien.getLien()+"?but=apresTarif.jsp' method='post'  name='diplome' id='diplome'  data-parsley-validate>";
                analyselien.getFormu().makeHtmlInsertTabIndex();
                ret+=analyselien.getFormu().getHtmlInsert();
                ret+="<input name='acte' type='hidden' id='nature' value='insert'>";
                ret+="<input name='bute' type='hidden' id='bute' value='"+this.getPathPage()+"'>";
                ret+="<input name='classe' type='hidden' id='classe' value='bean.AnalyseLien'>";
                ret+="</form>";
                ret+="</div>";
            ret+="</div>";
         ret+="</div>";
        ret+="</div>";
        return ret;
    }

    public void creerObjetPage(ClassMAPTable[] liste) throws Exception {
        setListe(liste);
        creerObjetPage();
    }

    public void creerObjetPage(String colGroupe[]) throws Exception {
        /*getValeurFormulaire();
         preparerData();
         makeTableauRecap();
         String[]enteteAuto=Utilitaire.ajouterTableauString(getColGroupe(),getSommeGroupe());
         setTableau(new TableauRecherche(getListe(),enteteAuto));*/
        creerObjetPage();
    }

    public void creerObjetPagePourc() throws Exception {
        System.out.println("creerObjetPagePourccreerObjetPagePourc");
        getValeurFormulaire(); //Recuperation des valeurs choisi

        preparerData(); // Recuperation des donnees de la base

        makeTableauRecap();
        String critereLienTab = "<a href=" + getLien() + "?but=" + getApres() + "&numPag=1" + getApresLienPage() + formu.getListeCritereString();

        String[] enteteAuto = Utilitaire.ajouterTableauString(getColGroupe(), getSommeGroupe());
        String[] enteteNombre = {"nombrepargroupe"};
        enteteAuto = Utilitaire.ajouterTableauString(enteteAuto, enteteNombre);
        ClassMAPTable crt = getCritere();
        Field[] listF = crt.getClass().getDeclaredFields();
        
        this.setTableau(new TableauRecherche(getListe(), enteteAuto, getPourcentage(), getPourc(), critereLienTab, listF)); // Formation du tableau de resultat
       

    }

    public void preparerDataListMultiple(Connection c) throws Exception {
        critere.setNomTable(getBase().getNomTable());
        makeCritereMultiple();
        if (premier == true) {
            rs = new bean.ResultatEtSomme();
            rs.initialise(getColSomme());
        } else {
            rs = getUtilisateur().getDataPageGroupeMultiple(critere, getColGroupe(), getSommeGroupe(), getColInt(), getValInt(), getNumPage(), getAWhere(), getColSomme(), getOrdre(), c, npp);
            /// Mois - 1
            dataMoisMoins1(c);
        }
           
        setListe((bean.ClassMAPTable[]) rs.getResultat());
    }

    public void preparerDataListMultiple(String count, Connection c) throws Exception {
        critere.setNomTable(getBase().getNomTable());
        makeCritereMultiple();
        if (premier == true) {
            rs = new bean.ResultatEtSomme();
            rs.initialise(getColSomme());
        } else {
            rs = getUtilisateur().getDataPageGroupeMultiple(critere, getColGroupe(), getSommeGroupe(), getColInt(), getValInt(), getNumPage(), getAWhere(), getColSomme(), getOrdre(), c, npp, count);
            /// Mois - 1
            dataMoisMoins1(c);
        }

        setListe((bean.ClassMAPTable[]) rs.getResultat());
    }
    
    private void dataMoisMoins1(Connection c) throws Exception {
        /*ClassMAPTable cls = critere.getClass().getConstructor(null).newInstance(null);
        cls.setNomTable(critere.getNomTable());
        String[] cols = getColInt();
        String[] vals = getValInt();
        for(int i = 0; i < getColInt().length; i++) {
            System.out.println("cols[i] = " + cols[i]);
            System.out.println("this.getColDateMoisMoins1() = " + this.getColDateMoisMoins1());
            if(cols[i].equals(this.getColDateMoisMoins1()) && vals[i*2] != null && !vals[i*2].isEmpty()) {
                Date dateM1 = Utilitaire.ajoutMoisDate(Utilitaire.stringDate(vals[i*2]), -1);
                vals[i*2] = Utilitaire.datetostring(dateM1);
                setValInt(vals);
                break;
            }
        }
        System.out.println("cls.getNomTable = " + cls.getNomTable());
        ClassMAPTable[] clss = (ClassMAPTable[]) CGenUtil.rechercher(cls, getColInt(), getValInt(), c, "");
        System.out.println("clss.length = " + clss.length);
        setDataM1(clss);*/
    }

    public void preparerDataMultiple() throws Exception {
        Connection c = null;
        try {
            c = new utilitaire.UtilDB().GetConn();
            preparerDataListMultiple(c);
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

    public void preparerDataMultiple(String count) throws Exception {
        Connection c = null;
        try {
            c = new utilitaire.UtilDB().GetConn();
            preparerDataListMultiple(count, c);
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

    public void creerObjetPagePourcMultiple() throws Exception {

        getValeurFormulaireMultiple(); //Recuperation des valeurs choisi

        preparerDataMultiple(); // Recuperation des donnees de la base

        makeTableauRecap();
        String critereLienTab = "<a href=" + getLien() + "?but=" + getApres() + "&numPag=1" + getApresLienPage() + formu.getListeCritereString();

        String[] enteteAuto = Utilitaire.ajouterTableauString(getColGroupe(), getSommeGroupe());
        String[] enteteNombre = {"nombrepargroupe"};
        enteteAuto = Utilitaire.ajouterTableauString(enteteAuto, enteteNombre);
        ClassMAPTable crt = getCritere();
        Field[] listF = crt.getClass().getDeclaredFields();
        this.setTableau(new TableauRecherche(getListe(), enteteAuto, getPourcentage(), getPourc(), critereLienTab, listF)); // Formation du tableau de resultat

    }

    public void creerObjetPagePourcMultiple(String count) throws Exception {

        getValeurFormulaireMultiple(); //Recuperation des valeurs choisi

        preparerDataMultiple(count); // Recuperation des donnees de la base

        makeTableauRecap();
        String critereLienTab = "<a href=" + getLien() + "?but=" + getApres() + "&numPag=1" + getApresLienPage() + formu.getListeCritereString();

        String[] enteteAuto = Utilitaire.ajouterTableauString(getColGroupe(), getSommeGroupe());
        String[] enteteNombre = {"nombrepargroupe"};
        enteteAuto = Utilitaire.ajouterTableauString(enteteAuto, enteteNombre);
        ClassMAPTable crt = getCritere();
        Field[] listF = crt.getClass().getDeclaredFields();
        this.setTableau(new TableauRecherche(getListe(), enteteAuto, getPourcentage(), getPourc(), critereLienTab, listF)); // Formation du tableau de resultat

    }

    public PageRechercheGroupe(bean.ClassMAPTable o, HttpServletRequest req, String[] vrt, String[] listInterval, int nbRange, String[] colGr, String[] sommGr, int nbCol, int somGr) throws Exception {
        setBase(o);
        o.setMode("groupe");
        o.setGroupe(true);
        //setTitre(titre);
        setCritere((bean.ClassMAPTable) (Class.forName(o.getClassName()).newInstance()));
        getCritere().setMode("groupe");
        setReq(req);
        if (getReq().getParameter("premier") != null && getReq().getParameter("premier").compareToIgnoreCase("") != 0) {
            setPremier(Boolean.valueOf(getReq().getParameter("premier")).booleanValue());
        }
        formu = new Formulaire();
        formu.setObjet(getBase());
        formu.makeChampFormu(vrt, listInterval, nbRange);
        setColGroupeDefaut(colGr);
        setSommeGroupeDefaut(sommGr);
        setNbColGroupe(nbCol);
        setNbSommeGrp(somGr);
        makeGroupe();
        formu.makeChampGroupe(getNbColGroupe(), getNbSommeGrp());
    }

    public PageRechercheGroupe(bean.ClassMAPTable o, HttpServletRequest req, String[] vrt, String[] listInterval, int nbRange, String[] colGr, String[] sommGr, String[] pourc, int nbCol, int somGr) throws Exception {
        setBase(o);
        o.setGroupe(true);
        o.setMode("groupe");
        //setTitre(titre);
        setCritere((bean.ClassMAPTable) (Class.forName(o.getClassName()).newInstance()));
        getCritere().setMode("groupe");
        setReq(req);
        if (getReq().getParameter("premier") != null && getReq().getParameter("premier").compareToIgnoreCase("") != 0) {
            setPremier(Boolean.valueOf(getReq().getParameter("premier")).booleanValue());
        }
        formu = new Formulaire();
        formu.setObjet(getBase());
        setColGroupeDefaut(colGr);
        setSommeGroupeDefaut(sommGr);
        setNbColGroupe(nbCol);
        setNbSommeGrp(somGr);
        setPourcentage(pourc);
        formu.makeChampFormu(vrt, listInterval, nbRange);

        makeGroupe();
        formu.makeChampGroupe(getNbColGroupe(), getNbSommeGrp());
    }

    public PageRechercheGroupe(bean.ClassMAPTable o, HttpServletRequest req, String[] vrt, String[] listInterval, int nbRange, String[] colGr, String[] sommGr, String[] pourc, int nbCol, int somGr, Liste count) throws Exception {
        this(o, req, vrt, listInterval, nbRange, colGr, sommGr, pourc, nbCol, somGr);
        this.setCount(count);
    }
    
//    public PageRechercheGroupe(bean.ClassMAPTable o, HttpServletRequest req, String[] vrt, String[] listInterval, int nbRange, String[] colGr, String[] sommGr, String[] pourc, int nbCol, int somGr, HttpServletResponse resp, HttpSession session) throws Exception {
//        this(o, req, vrt, listInterval, nbRange, colGr, sommGr, pourc, nbCol, somGr);
//        this.setUtilisateur((user.UserEJB) session.getValue("u"));
//        this.setLien((String) session.getValue("lien"));
//        if(this.getReq().getParameter("enregistrer")!=null) {
//            String lienAnalyse = this.getLien() + req.getQueryString();
//            saveAnalyseLien();
//            resp.sendRedirect(this.getLien());
//        }
//    }

    public void makeGroupe() throws Exception {
        String temp[] = new String[getNbColGroupe()];
        String ligneReq[]=new String[getNbColGroupe()];
        for (int i = 0; i < temp.length*2; i++) {
            if(i<getNbColGroupe())
            temp[i] = getReq().getParameter("colGroupe" + (i + 1));
            if(i>=getNbColGroupe()&&i<getNbColGroupe()*2)
            ligneReq[i-getNbColGroupe()]=getReq().getParameter("ligneGroupe" + (i + 1));
            
        }
        setColGroupe(Utilitaire.formerTableauGroupe(temp));
        
        setLigneGroupe(Utilitaire.formerTableauGroupe(ligneReq));
        
        
        String temp2[] = new String[getNbSommeGrp()];
        for (int i = 0; i < temp2.length; i++) {
            temp2[i] = getReq().getParameter("colSomme" + (getNbColGroupe() + i + 1));
        }
        setSommeGroupe(Utilitaire.formerTableauGroupe(temp2));
        //String st1[]={request.getParameter("colGroupe1"),request.getParameter("colGroupe2")};
    }

    public Liste getCount() {
        return count;
    }

    public void setCount(Liste count) {
        this.count = count;
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
        String[][] data = null;
        String[] entete = null;
        int nbColSomme = 0;
        if (getColSomme() != null) {
            nbColSomme = getColSomme().length;
        }
        entete = new String[nbColSomme + 2];
        data = new String[1][entete.length];
        entete[0] = "";
        data[0][0] = "Total";
        entete[1] = "Nombre";
        data[0][1] = utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[nbColSomme]));
        for (int i = 0; i < nbColSomme; i++) {
            data[0][i + 2] = utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[i]));
            entete[i + 2] = "Somme de " + String.valueOf(getColSomme()[i]);
        }
        TableauRecherche t = new TableauRecherche(data, entete);
        t.setTitre("RECAP");
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

    /*public String getBasPage() {
        String retour = "";
        retour += "<table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>";
        retour += "<tr><td height=25><b>Nombre de r&eacute;sultat :</b> " + utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[getNombreColonneSomme()])) + "</td><td align='right'><strong>page</strong> " + getNumPage() + " <b>sur</b>" + getNombrePage() + "</td>";
        retour += "</tr>";
        retour += "<tr>";
        retour += "<td width=50% valign='top' height=25>";
        String avantLien = getLien() + "?but=";
        String premierParam = "";
        if (getLien() == null || getLien().compareToIgnoreCase("") == 0) {
            avantLien = "";
            premierParam = "?1=2";
        }
        if (getNumPage() > 1) {
            retour += "<a href=" + avantLien + getApres() + premierParam + formu.getListeCritereString() + "&premier=" + getPremier() + "&numPag=" + String.valueOf(getNumPage() - 1) + getApresLienPage() + ">&lt;&lt;Page pr&eacute;c&eacute;dente</a>";
        }
        retour += "</td>";
        retour += "<td width=50% align=right>";
        if (getNumPage() < getNombrePage()) {
            retour += "<a href=" + avantLien + getApres() + premierParam + formu.getListeCritereString() + "&premier=" + getPremier() + "&numPag=" + String.valueOf(getNumPage() + 1) + getApresLienPage() + ">Page suivante&gt;&gt;</a>";
        }
        retour += "</td>";
        retour += "</tr>";
        retour += "</table>";
        retour += getDownloadForm();
        return retour;
    }*/
    public String getBasPage() throws Exception {
        String retour = "";
        retour += "<table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>";
        retour += "<tr><td height=25><b>Nombre de r&eacute;sultat :</b> " + utilitaire.Utilitaire.formaterAr(String.valueOf(rs.getSommeEtNombre()[getNombreColonneSomme()])) + "</td><td align='right'><strong>page</strong> " + getNumPage() + " <b>sur</b>" + getNombrePage() + "</td>";
        retour += "</tr>";
        retour += "<tr>";
        retour += "<td width=50% valign='top' height=25>";
        if (getNumPage() > 1) {
            retour += "<a href=" + getLien() + "?but=" + getApres() + "&premier="+ getPremier() +"&numPag=" + String.valueOf(getNumPage() - 1) + getApresLienPage() + formu.getListeCritereString() + ">&lt;&lt;Page pr&eacute;c&eacute;dente</a>";
        }
        retour += "</td>";
        retour += "<td width=50% align=right>";
        if (getNumPage() < getNombrePage()) {
            retour += "<a href=" + getLien() + "?but=" + getApres() + "&premier="+ getPremier()+"&numPag=" + String.valueOf(getNumPage() + 1) + getApresLienPage() + formu.getListeCritereString() + ">Page suivante&gt;&gt;</a>";
        }
        retour += "</td>";
        retour += "</tr>";
        retour += "</table>";
        retour += getDownloadForm();
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

    public void setColGroupe(String[] colGroupe) {
        this.colGroupe = colGroupe;
    }

    public String[] getColGroupe() {
        if (colGroupe == null || colGroupe.length == 0) {
            return getColGroupeDefaut();
        }
        return colGroupe;
    }

    public void setSommeGroupe(String[] sommeGroupe) {
        this.sommeGroupe = sommeGroupe;
        setColSomme(getSommeGroupe());
    }

    public String[] getSommeGroupe() {
        if (sommeGroupe == null || sommeGroupe.length == 0) {
            return sommeGroupeDefaut;
        }
        return sommeGroupe;
    }

    public void setOrdre(String ordre) {
        this.ordre = ordre;
    }

    public String getOrdre() {
        return ordre;
    }

    public void setNbColGroupe(int nbColGroupe) {
        this.nbColGroupe = nbColGroupe;
    }

    public int getNbColGroupe() {
        return nbColGroupe;
    }

    public void setNbSommeGrp(int nbSommeGrp) {
        this.nbSommeGrp = nbSommeGrp;
    }

    public int getNbSommeGrp() {
        return nbSommeGrp;
    }

    public void setColGroupeDefaut(String[] colGroupeDefaut) {
        this.colGroupeDefaut = colGroupeDefaut;       
    }

    @Override
     public void setTableau(TableauRecherche tableau) {
        super.setTableau(tableau);
        if (this.getTableau() != null) {
            this.getTableau().setGroupe(true);
            this.getTableau().setLienFormulaire(generateUrlFormulaire());
        }
        if(this.getColDateMoisMoins1() != null) {
            this.getTableau().setColGroupe(Arrays.asList(this.getSommeGroupeDefaut()));
            this.getTableau().setColMoisMoins1(this.getColDateMoisMoins1());
//            this.getTableau().setNomTable(critere.getNomTable());
            this.getTableau().setDataM1(this.getDataM1());
        }
    }
    
    public String[] getColGroupeDefaut() {
        return colGroupeDefaut;
    }

    public void setSommeGroupeDefaut(String[] sommeGroupeDefaut) {
        this.sommeGroupeDefaut = sommeGroupeDefaut;
        setColSomme(sommeGroupeDefaut);
    }

    public String[] getSommeGroupeDefaut() {
        return sommeGroupeDefaut;
    }

    public void setNpp(int npp) {
        this.npp = npp;
    }

    public int getNpp() {
        return npp;
    }

    public void setListeColonneMoyenne(String[] listeColonneMoyenne) {
        this.listeColonneMoyenne = listeColonneMoyenne;
    }

    public String[] getListeColonneMoyenne() {
        return listeColonneMoyenne;
    }

   public String getDownloadForm() {
        String tab = "";
        String[] somDefaut = this.getSommeGroupe();
        String[] colDefaut = this.getColGroupe();
        String sD = "";
        if (somDefaut != null && somDefaut.length > 0) {
            sD = somDefaut[0];
        }
        String cD = "";
        if (colDefaut != null) {
            cD = colDefaut[0];
        }
        String cI = "";
        if (colInt != null) {
            cI = colInt[0];
        }
        String vI = "";
        if (valInt != null) {
            vI = valInt[0];
        }
        try {

            tab = this.getTableau().getHtml();

            if (somDefaut != null) {
                for (int i = 1; i < somDefaut.length; i++) {
                    sD = sD + "," + somDefaut[i];
                }
            }
            if (colDefaut != null) {
                for (int j = 1; j < colDefaut.length; j++) {
                    cD = cD + "," + colDefaut[j];
                }
            }
            if (colInt != null) {
                for (int j = 1; j < colInt.length; j++) {
                    cI = cI + "," + colInt[j];
                }
            }
            if (valInt != null) {
                for (int j = 1; j < valInt.length; j++) {
                    vI = vI + "," + valInt[j];
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        String temp = "";
        temp += "<div class='row'>";
        temp += "<div class='row col-md-12'>";
        temp += "<div class='box box-primary box-solid collapsed-box'>";
        temp += "<div style='background:#0E6D36; color:white;'class='box-header with-border'>";
        temp += "<h3 class='box-title'>Exporter</h3>";
        temp += "<div class='box-tools pull-right'><button data-original-title='Collapse' class='btn btn-box-tool' data-widget='collapse' data-toggle='tooltip' title=''><i class='fa fa-plus'></i></button> </div>";
        temp += "</div>";
        temp += "<div class='box-body'>";
        temp += "<form action=\"../downloadGroupe\" method=\"post\">";
        temp += "<table id='export'>";
        temp += "<tr>";
        temp += "<th colspan='4'><h3 class='box-title'>Format</h3></th>";
        temp += "<th colspan='2'><h3 class='box-title'>Donne&eacute;es &agrave; exporter</h3></th>";
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
        temp += "<label for='donnee'>Page En Cours</label>";
        temp += "<input type='radio' name='donnee' value=\"" + 0 + "\" checked='checked' />";
        temp += "</td>";
        temp += "<td>";
        temp += "<label for='donnee'>Toutes</label>";
        temp += "<input type='radio' name='donnee' value=\"" + 1 + "\" />";
        temp += "</td>";
        temp += "<td>";
        if (this.getTableau().getExpxml() != null) {
            temp += "<input type=\"hidden\" name=\"xml\" value=\"" + this.getTableau().getExpxml().replace('"', '*') + "\" />";
            temp += "<input type=\"hidden\" name=\"csv\" value=\"" + this.getTableau().getExpcsv().replace('"', '*') + "\" />";
            temp += "<input type=\"hidden\" name=\"awhere\" value=\"" + this.getAWhere().replace('"', '\'') + "\" />";
            temp += "<input type=\"hidden\" name=\"table\" value=\"" + tab.replace('"', '*') + "\" />";
            temp += "<input type=\"hidden\" name=\"colDefaut\" value=\"" + cD + "\" />";
            temp += "<input type=\"hidden\" name=\"somDefaut\" value=\"" + sD + "\" />";
            temp += "<input type=\"hidden\" name=\"colInt\" value=\"" + cI + "\" />";
            temp += "<input type=\"hidden\" name=\"valInt\" value=\"" + vI + "\" />";
            temp += "<input type=\"hidden\" name=\"ordre\" value=\"" + this.getOrdre() + "\" />";
            temp += "<input type=\"hidden\" name=\"entete\" value=\"" + Utilitaire.tabToString(this.getTableau().getLibeEntete(), "", ";") + "\" />";
            temp += "<input type=\"hidden\" name=\"entetelibelle\" value=\"" + Utilitaire.tabToString(this.getTableau().getLibelleAffiche(), "", ";") + "\" />";
        }
        int sommeId = Utilitaire.estIlDedans("ttc", getColSomme());
        if (sommeId > -1) {
            temp += "<input type=\"hidden\" name=\"nombreEncours\" value=\"" + Utilitaire.formaterSansVirgule(rs.getSommeEtNombre()[getColSomme().length]) + "\" />";
            double test = rs.getSommeEtNombre()[sommeId];
            temp += "<input type=\"hidden\" name=\"recap\" value=\"" + test + "\" />";
        }
        temp += "<input type='hidden' name='titre' value='" + getTitre() + "' />";
        temp += "<input type='submit' value='Exporter' class='btn btn-default' />";
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

    public void setPourcentage(String[] pourcentage) {
        this.pourcentage = pourcentage;
    }

    public String[] getPourcentage() {
        return pourcentage;
    }

    public void setPourc(double[][] pourc) {
        this.pourc = pourc;
    }

    public double[][] getPourc() {
        return pourc;
    }

    public String getCamembertChart() {
        String ret = "";
        return ret;
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
    
    public String generateUrlFormulaire(){
        String retour = "";
        Champ[] c = formu.getListeChamp(); 
        for (int i = 0; i < c.length; i++) {
            String valeurRecup = getParamSansNull(c[i].getNom());
            if(valeurRecup!=null && !valeurRecup.isEmpty() && !valeurRecup.equals("%")){
                 retour+=c[i].getNom()+"="+valeurRecup+"&";
            }                                      
        }        
        return retour;
    }
    
    public static double[][] cumul(ResultatEtSomme rs, String[] col) throws Exception {
        ClassMAPTable[] os = (ClassMAPTable[]) rs.getResultat();
        double[][] ret = new double[os.length][col.length];
        for(int j=0; j<col.length; j++) {
            double cumul = 0;
            for(int i=0; i<os.length; i++) {
                cumul += (double) CGenUtil.getValeurFieldByMethod(os[i], col[j]);
                ret[i][j] += cumul;
            }
            System.out.println("");
        }
        return ret;
    }
    
    public String[] getLigneGroupe() {
        return ligneGroupe;
    }

    public void setLigneGroupe(String[] ligneGroupe) {
        this.ligneGroupe = ligneGroupe;
    }
    
    
    public void creerObjetPageCroise(String lien) throws Exception
    {
        getValeurFormulaire(); //Recuperation des valeurs choisi

        preparerData(); // Recuperation des donnees de la base

        makeTableauRecap();
        //String[] enteteAuto = Utilitaire.ajouterTableauString(getColGroupe(), getSommeGroupe());
        
        setTableau(new TableauRechercheGroupe(getListe(), this.getColGroupe(),getSommeGroupeDefaut(),lien) ); // Formation du tableau de resultat   
    }
    public void creerObjetPageCroise(String []colon,String lien) throws Exception
    {
        if(this.getLigneGroupe()!=null&&this.getLigneGroupe().length>0)colon=this.getLigneGroupe();
        this.setColGroupe(Utilitaire.ajouterTableauString(getColGroupe(), colon));
        getValeurFormulaire(); //Recuperation des valeurs choisi

        preparerData(); // Recuperation des donnees de la base

        makeTableauRecap();
        //String[] enteteAuto = Utilitaire.ajouterTableauString(getColGroupe(), getSommeGroupe());
        
        setTableau(new TableauRechercheGroupe(getListe(), this.getColGroupe(),colon,getSommeGroupe(),lien) ); // Formation du tableau de resultat   
        
    }

}
