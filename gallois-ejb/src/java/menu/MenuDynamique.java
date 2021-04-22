package menu;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import mg.cnaps.utilisateur.CNAPSUser;
import utilisateur.UserMenu;

/**
 *
 * @author ITU
 */
public class MenuDynamique extends ClassMAPTable {

    

    private String id;
    private String libelle;
    private String icone;
    private String href;
    private int rang;
    private int niveau;
    private String id_pere;            // peut �tre null =>fils direct du mod�le
    private Object element;
    private ArrayList<MenuDynamique> fils = new ArrayList<MenuDynamique>();

    public ArrayList<MenuDynamique> getFils() {
        return fils;
    }

    public void setFils(ArrayList<MenuDynamique> fils) {
        this.fils = fils;
    }

    /**
     * *******************************************************************
     */
    public void setRang(int value) {
        this.rang = value;
    }

    public int getRang() {
        return this.rang;
    }

    public void setNiveau(int value) {
        this.niveau = value;
    }

    public int getNiveau() {
        return this.niveau;
    }

    public void setId_pere(String value) {
        this.id_pere = value;
    }

    public String getId_pere() {
        return this.id_pere;
    }

    public void setIcone(String value) {
        this.icone = value;
    }

    public String getIcone() {
        return this.icone;
    }

    public void setId(String value) {
        this.id = value;
    }

    public String getId() {
        return this.id;
    }

    public void setLibelle(String value) {
        this.libelle = value;
    }

    public String getLibelle() {
        return this.libelle;
    }

    public void setHref(String value) {
        this.href = value;
    }

    public String getHref() {
        return this.href;
    }

    public boolean estFeuille() {
        return this.getHref() != null || this.getHref().compareTo("") == 0;
    }

    public MenuDynamique[] getElem_menu(int niveau) throws Exception {
        MenuDynamique[] elem = (MenuDynamique[]) CGenUtil.rechercher(this, null, null, " AND NIVEAU='" + niveau + "' ORDER BY rang");
        if (elem != null && elem.length > 0) {
            //System.out.println("IDDDDDDDDDDDDDDDDDD="+elem[0].getId());
            return elem;
        } else {
            throw new Exception("ID NON VALIDE");
        }
    }

    public String toString() {
        return "[" + id + ", " + libelle + ", " + niveau + ", " + rang + ", " + icone + ", " + id_pere + ", " + href + "]";
    }

    /**
     * *******************************************************************
     */
    public MenuDynamique() {
        this.setNomTable("MENUDYNAMIQUE");
    }

    public MenuDynamique(String id, String libelle, String href, String icone, String pere, int niveau, int rang) {
        this.setId(id);
        this.setLibelle(libelle);
        this.setHref(href);
        this.setIcone(icone);
        this.setId_pere(pere);
        this.setNiveau(niveau);
        this.setRang(rang);
        this.setNomTable("MENUDYNAMIQUE");
    }

    public MenuDynamique(String id) throws Exception {
        MenuDynamique[] elem = (MenuDynamique[]) CGenUtil.rechercher(new MenuDynamique(), null, null, " AND id='" + id + "'");
        if (elem != null && elem.length > 0) {
            MenuDynamique el = elem[0];
            this.setId(el.getId());
            this.setLibelle(el.getLibelle());
            this.setHref(el.getHref());
            this.setIcone(el.getIcone());
            this.setId_pere(el.getId_pere());
            this.setNiveau(el.getNiveau());
            this.setRang(el.getRang());
            this.setNomTable("MENUDYNAMIQUE");
        }
        throw new Exception("ID NON VALIDE");
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        super.setNomTable("MENUDYNAMIQUE");
        this.preparePk("MENU", "getSeqmenud");
        this.setId(makePK(c));
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 59 * hash + Objects.hashCode(this.id);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final MenuDynamique other = (MenuDynamique) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }

    public static ArrayList<ArrayList<MenuDynamique>> getElementMenu(HttpServletRequest request, historique.MapUtilisateur user, CNAPSUser cnapsUser) {
        MenuDynamique[] interdit = null;
        MenuDynamique[] autorise = null;
        MenuDynamique[] tabMenu = null;
        ArrayList<ArrayList<MenuDynamique>> arbre = new ArrayList<>(); 
        
        try {         
            
            if(request.getServletContext().getAttribute("tabMenu")!=null){
                tabMenu=(MenuDynamique[])request.getServletContext().getAttribute("tabMenu");
            }else{
                tabMenu = (MenuDynamique[]) CGenUtil.rechercher(new MenuDynamique(), null, null, " order by niveau,rang asc");
                request.getServletContext().setAttribute("tabMenu", tabMenu);
            }
            String reketyInterdit = "select MENUDYNAMIQUE.* from MENUDYNAMIQUE inner join usermenu on usermenu.IDMENU=MENUDYNAMIQUE.ID  where interdit=1 and (refuser='*' or refuser='" + user.getRefuser() + "' OR idrole='" + user.getIdrole() + "' OR CODESERVICE='" + cnapsUser.getCode_service().trim() + "' OR CODEDIR='" + cnapsUser.getCode_dr().trim() + "'  ) order by MENUDYNAMIQUE.niveau,MENUDYNAMIQUE.rang asc";
            String reketyAutorise = "select MENUDYNAMIQUE.* from MENUDYNAMIQUE inner join usermenu on ( usermenu.IDMENU=MENUDYNAMIQUE.ID)  where (interdit=0 OR interdit is null) and (  refuser='*' or refuser='" + user.getRefuser() + "' OR idrole='" + user.getIdrole() + "' OR CODESERVICE='" + cnapsUser.getCode_service().trim() + "' OR CODEDIR='" + cnapsUser.getCode_dr().trim() + "'  ) order by MENUDYNAMIQUE.niveau,MENUDYNAMIQUE.rang asc";
            interdit = (MenuDynamique[]) CGenUtil.rechercher(new MenuDynamique(), reketyInterdit);
            autorise = (MenuDynamique[]) CGenUtil.rechercher(new MenuDynamique(), reketyAutorise);
            
            List<MenuDynamique> listInterdit = Arrays.asList(interdit);
            HashSet<MenuDynamique> listAutorise = getParentsAndFils(autorise, tabMenu);
            
            ArrayList<MenuDynamique> arbreNiveau = new ArrayList<>();
            for (MenuDynamique elt : tabMenu) {    
                if(listInterdit.contains(elt) || !listAutorise.contains(elt) ){
                    continue;
                }
                if (arbre.isEmpty()) {                             
                    arbreNiveau.add(elt);
                    arbre.add(arbreNiveau);
                } else {
                    if (arbre.size() >= elt.getNiveau()) {
                        arbre.get(elt.getNiveau()-1).add(elt);
                    } else {
                        arbreNiveau = new ArrayList<>();
                        arbreNiveau.add(elt);
                        arbre.add(arbreNiveau);
                    }
                }
            }            
        } catch (Exception ex) {
            Logger.getLogger(MenuDynamique.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return arbre;
    }
    
    
    public static MenuDynamique addFirstElement(ArrayList<ArrayList<MenuDynamique>> arbre, ArrayList<MenuDynamique> listAutorise, int niveau)throws Exception{
        try{
            MenuDynamique retour = null;
            if(arbre.size() != niveau){
                retour = addFirstElement(arbre, listAutorise, niveau-1);
            }
            else{
                for (MenuDynamique elt : listAutorise) {
                    if(elt.getNiveau() == niveau+1){
                        ArrayList<MenuDynamique> arbreNiveau = new ArrayList<>();
                        //System.out.println("A2 b "+elt.getId());
                        arbreNiveau.add(elt);
                        arbre.add(arbreNiveau);
                        return elt;
                    }
                }
            }
            return retour;
        }catch (Exception ex) {
            throw ex;
        }
    }
    
    public static void getParents(HashSet<MenuDynamique> set,MenuDynamique[] tab, MenuDynamique[] total){
            
        for(MenuDynamique elt:tab){
//            System.out.println("ALAINP1 "+elt.getId());
            set.add(elt);
            checkParent(set,elt,total);
        }        
    }
    private static void checkParent(HashSet<MenuDynamique> set,MenuDynamique elt,MenuDynamique[] total){
        for(MenuDynamique em:total){
            if(em.getId().equals(elt.getId_pere())){
//                System.out.println("ALAINP2 "+em.getId());
                set.add(em);
                checkParent(set,em,total);
            }
        }
    }
     public static void getFils(HashSet<MenuDynamique> set,MenuDynamique[] tab, MenuDynamique[] total){
        for(MenuDynamique elt:tab){
//            System.out.println("ALAINF1 "+elt.getId());
            set.add(elt);
            checkFils(set,elt,total);
        }
    }
    private static void checkFils(HashSet<MenuDynamique> set, MenuDynamique elt, MenuDynamique[] total) {
        for(MenuDynamique em:total){
            if(em.getId_pere()!=null && em.getId_pere().equals(elt.getId())){
//                System.out.println("ALAINF2 "+em.getId());
                set.add(em);
                checkFils(set,em,total);
            }
        }
    }
    
    public static HashSet<MenuDynamique> getParentsAndFils(MenuDynamique[] tab,MenuDynamique[] total){
        HashSet<MenuDynamique> set = new HashSet<MenuDynamique>();
        getParents(set, tab, total);
//        System.out.println("HSET1 = " + set);
        getFils(set, tab, total);
//        System.out.println("HSET2 = " + set);
        return set;
    }
   
    
    public static boolean containsParent(ArrayList<MenuDynamique> liste,String id){
        boolean ret=false;
        for(MenuDynamique elt: liste){
            if( elt.getId_pere()!=null && elt.getId_pere().equals(id)){
                ret= true;
                break;
            }
        }
        return ret;
    }

     /*public static String renderMenu(ArrayList<ArrayList<MenuDynamique>> arbre,String currentMenu, MenuDynamique[] tabMenu,ResourceBundle RB) {
        String ret = "";
        System.out.println("aaaaaaaaaa");
        if(arbre==null || arbre.size()==0)
            return ret;
        int index = 0;
        System.out.println("1");
        HashSet<MenuDynamique> set = new HashSet<MenuDynamique>();
        if(currentMenu!=null && !currentMenu.equalsIgnoreCase("")){
            try {
                System.out.println("2");
                MenuDynamique m = new MenuDynamique();
                m.setId(currentMenu);
                String[] attr={"id"};
                String[] val={currentMenu};
                Object[] tabobject =   AdminGen.find(tabMenu, attr, val);  
                System.out.println("3");
                MenuDynamique[] tab = new MenuDynamique[1];
                if(tabobject.length>0){
                    System.out.println("4");
                    tab[0]=(MenuDynamique) tabobject[0];
                    getParents(set,tab , tabMenu);
                }                                
            } catch (Exception ex) {
                //Logger.getLogger(MenuDynamique.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        System.out.println("5");
        ArrayList<MenuDynamique> arbreNiveau = arbre.get(0);
        System.out.println("6");
        for(MenuDynamique  elt : arbreNiveau){
            ret += renderMenuFils(elt,arbre, index,currentMenu,set,RB);      
        }
        System.out.println("7");
        return ret;
    }
    public static String renderMenuFils(MenuDynamique elt, ArrayList<ArrayList<MenuDynamique>> arbre, int niveau,String currentMenu, HashSet<MenuDynamique> tabMenuParent, ResourceBundle RB) {
        String ret = "";   
        ArrayList<MenuDynamique> fils = new ArrayList<>();        
        String classCurrent="";
        if(currentMenu!=null && currentMenu.equalsIgnoreCase(elt.getId())){
            classCurrent=" currentMenu ";
        }
        //for (Elem_menu elt : arbreNiveau) {            
            if (arbre.size() > niveau+1) {
                
                ArrayList<MenuDynamique> arbreNiveauPlusUn= arbre.get(niveau+1);
                for(MenuDynamique em:arbreNiveauPlusUn){
                    if(em.getId_pere()!=null && em.getId_pere().equals(elt.getId())){
                        fils.add(em);                        
                    }
                }
                if( containsParent(arbreNiveauPlusUn, elt.getId())){
                    String style="";
                    String classUl="";
                    if(tabMenuParent.contains(elt)){
                        style=" style=\"display: block;\" ";
                        classUl=" menu-open  ";
                    }
                    
                    String libtemp1 = elt.getLibelle();
                    if(RB.containsKey(libtemp1)){
                        libtemp1 = RB.getString(libtemp1);
                    }
                    ret+="<li><a href='"+getHref(elt)+"' class=' " +classCurrent+ "' onclick=\"window.location.href='"+getHref(elt)+"'\"><i class='fa "+elt.getIcone()+ "'></i> <span>"+libtemp1+"</span> <i class='fa fa-angle-left pull-right'></i></a>\n" +
                        "<ul class=\"treeview-menu "+classUl+" \" "+ style+"  >\n" +
                        "\n" ;
                    //ret+=renderMenuFils(arbre, niveau+1);
                    for(MenuDynamique ee : fils){
                        ret+= renderMenuFils(ee, arbre, niveau+1,currentMenu,tabMenuParent,RB);
                    }
                    ret+=    "</ul></li>";
                }else{
                    String libtemp2 = elt.getLibelle();
                    if(RB.containsKey(libtemp2)){
                        libtemp2 = RB.getString(libtemp2);
                    }
                    ret+="<li><a href=\""+getHref(elt)+"\" class='"+classCurrent+"' ><i class=\""+elt.getIcone()+"  \"></i>"+libtemp2+"</a></li>";
                }
            } else {
                String libtemp3 = elt.getLibelle();
                if(RB.containsKey(libtemp3)){
                    libtemp3 = RB.getString(libtemp3);
                }
                ret+="<li><a href=\""+getHref(elt)+"\" class='"+classCurrent+"'><i class=\""+elt.getIcone()+ "\"></i>"+libtemp3+"</a></li>";
            }
           // niveau++;
        //}

        System.out.println("Je teeeeeeeste="+ret+"fin");
        return ret;
    }*/
    public static String renderMenu(ArrayList<ArrayList<MenuDynamique>> arbre,String currentMenu, MenuDynamique[] tabMenu,ResourceBundle RB) {
        String ret = "";
        if(arbre==null || arbre.size()==0)
            return ret;
        int index = 0;
        
        HashSet<MenuDynamique> set = new HashSet<MenuDynamique>();
        if(currentMenu!=null && !currentMenu.equalsIgnoreCase("")){
            try {
                MenuDynamique m = new MenuDynamique();
                m.setId(currentMenu);
                String [] attr={"id"};
                String [] val={currentMenu};
                Object [] tabobject =   AdminGen.find(tabMenu, attr, val);  
                MenuDynamique[] tab = new MenuDynamique[1];
                if(tabobject.length>0){
                    tab[0]=(MenuDynamique) tabobject[0];
                    getParents(set,tab , tabMenu);
                }                                
            } catch (Exception ex) {
                //Logger.getLogger(MenuDynamique.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        ArrayList<MenuDynamique> arbreNiveau = arbre.get(0);
        for(MenuDynamique  elt : arbreNiveau){
            ret += renderMenuFils(elt,arbre, index,currentMenu,set,RB);      
        }
        
        return ret;
    }
    public static String renderMenuFils(MenuDynamique elt, ArrayList<ArrayList<MenuDynamique>> arbre, int niveau,String currentMenu, HashSet<MenuDynamique> tabMenuParent, ResourceBundle RB) {
        String ret = "";   
        ArrayList<MenuDynamique> fils = new ArrayList<>();        
        String classCurrent="";
        if(currentMenu!=null && currentMenu.equalsIgnoreCase(elt.getId())){
            classCurrent=" currentMenu ";
        }
        //for (Elem_menu elt : arbreNiveau) {            
            if (arbre.size() > niveau+1) {
                
                ArrayList<MenuDynamique> arbreNiveauPlusUn= arbre.get(niveau+1);
                for(MenuDynamique em:arbreNiveauPlusUn){
                    if(em.getId_pere()!=null && em.getId_pere().equals(elt.getId())){
                        fils.add(em);                        
                    }
                }
                if( containsParent(arbreNiveauPlusUn, elt.getId())){
                    String style="";
                    String classUl="";
                    if(tabMenuParent.contains(elt)){
                        style=" style=\"display: block;\" ";
                        classUl=" menu-open  ";
                    }
                    
                    String libtemp1 = elt.getLibelle();
                    if(RB.containsKey(libtemp1)){
                        libtemp1 = RB.getString(libtemp1);
                    }
                    /********************************
                     * Joh
                     * Miampy concaténation an redirection ao am variable ret
                     */
//                    String redirection = elt.getNiveau() == 2 ? "onclick=\"window.location.href='"+getHref(elt)+"'\"" : ""; 
                    String redirection = "onclick=\"window.location.href='"+getHref(elt)+"'\""; 
                    /*******************************/
                    ret+="<li><a href='"+getHref(elt)+"' class=' " +classCurrent+ "' "+redirection+" ><i class='fa "+elt.getIcone()+ "'></i> <span>"+libtemp1+"</span> <i class='fa fa-angle-left pull-right'></i></a>\n" +
                        "<ul class=\"treeview-menu "+classUl+" \" "+ style+"  >\n" +
                        "\n" ;
                    //ret+=renderMenuFils(arbre, niveau+1);
                    for(MenuDynamique ee : fils){
                        ret+= renderMenuFils(ee, arbre, niveau+1,currentMenu,tabMenuParent,RB);
                    }
                    ret+=    "</ul></li>";
                }else{
                    String libtemp2 = elt.getLibelle();
                    if(RB.containsKey(libtemp2)){
                        libtemp2 = RB.getString(libtemp2);
                    }
                    ret+="<li><a href=\""+getHref(elt)+"\" class='"+classCurrent+"' ><i class=\""+elt.getIcone()+"  \"></i>"+libtemp2+"</a></li>";
                }
            } else {
                String libtemp3 = elt.getLibelle();
                if(RB.containsKey(libtemp3)){
                    libtemp3 = RB.getString(libtemp3);
                }
                ret+="<li><a href=\""+getHref(elt)+"\" class='"+classCurrent+"'><i class=\""+elt.getIcone()+ "\"></i>"+libtemp3+"</a></li>";
            }
           // niveau++;
        //}

        return ret;
    }
    private static String getHref(MenuDynamique em){
        String unificateur = "?";
        if(em.getHref() != null && !em.getHref().isEmpty() && em.getHref().indexOf("?") >= 0){
            unificateur = "&";
        }
        String ret= em.getHref()!=null && !em.getHref().isEmpty() ? em.getHref()+ unificateur + "currentMenu="+em.getId() : "#"; 
        return ret;
    }
    
    public static String renderMenuEdition(ArrayList<ArrayList<MenuDynamique>> arbre){
        String ret = "";
        if(arbre == null || arbre.isEmpty()){
            return ret;
        }
            
        ArrayList<MenuDynamique> arbreNiveauZero = arbre.get(0);
        for(MenuDynamique  item : arbreNiveauZero){
            ret += renderMenuEditionFils(item, arbre,0);
        }
        
        return ret;
    }
    
    public static String renderMenuEditionFils(MenuDynamique elt, ArrayList<ArrayList<MenuDynamique>> arbre, int niveau){
        String ret = "";
        
        ArrayList<MenuDynamique> fils = new ArrayList<>(); 
        if(arbre.size() > niveau+1){
            ArrayList<MenuDynamique> arbreNiveauSuivant= arbre.get(niveau+1);
            for(MenuDynamique item : arbreNiveauSuivant){
                if(item.getId_pere()!=null && item.getId_pere().equals(elt.getId())){
                    fils.add(item);
                }
            }
            if(!fils.isEmpty()){
                ret += "<li>"+elt.getLibelle()+"<ul>";
                for(MenuDynamique itemFils : fils){
                    ret+= renderMenuEditionFils(itemFils, arbre, niveau+1);
                }
                ret += "</ul></li>";
            }
            else{
                ret += "<li>"+elt.getLibelle()+"</li>";
            }
        }
        else{
            ret += "<li>"+elt.getLibelle()+"</li>";
        }
        
        return ret;
    }
    
    public static MenuDynamique[] orderMenuRecurs(ArrayList<MenuDynamique> dynamMen, MenuDynamique[] di, MenuDynamique[] tabMenu,boolean follow) throws Exception{
        MenuDynamique[] rst = null; // asina ny menu efa milamina...
        for(int i=0;i<di.length;i++){
            if(!dynamMen.contains(di[i])) dynamMen.add(di[i]);
            String[] attr = {"id_pere"};
            String[] val = {di[i].getId()};
            ClassMAPTable[] cmta = AdminGen.find(tabMenu, attr, val);
            MenuDynamique[] tmpFils = new MenuDynamique[cmta.length];
            for(int co=0;co<tmpFils.length;co++){
                tmpFils[co] = (MenuDynamique) cmta[co];
            }
            if(tmpFils.length==0) continue;
            orderMenuRecurs(dynamMen,tmpFils,tabMenu,false);
        }
        if(follow){
            // eto efa azo ny arrayList an'ny menu tokony apoitra fa mbola mikorontana
            rst = new MenuDynamique[dynamMen.size()];
            int co = 0;
            // avadika tableau ny arrayList
            for(MenuDynamique tmp : dynamMen){
                rst[co] = tmp;
                co++;
            }
            /* arrangena ilay tableau
            for(int i=0;i<rst.length;i++){
                
            }
            */
            return rst;
        }
        return rst;
    }
}
