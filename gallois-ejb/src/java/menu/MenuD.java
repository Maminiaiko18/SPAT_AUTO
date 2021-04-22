
package menu;

/**
 *
 * @author ITU
 */



import bean.CGenUtil;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class MenuD
{
	private MenuDynamique element;
	private List<MenuD> fils;
	
        /**********************************************************/
        public MenuD() {
            
        }
	public MenuD(MenuDynamique element){
            this.setElement(element);
            this.setFils(new ArrayList<MenuD>());
	}
	
	public MenuD(MenuDynamique element, List<MenuD> fils){
            this.setElement(element);
            this.setFils(fils);
	}

        public MenuD(String id_element) throws Exception{
            MenuDynamique[] elem = (MenuDynamique[]) CGenUtil.rechercher(new MenuDynamique(), null, null, " AND ID='"+id_element+"'");
            if(elem!=null && elem.length>0){
                this.element=elem[0];
                this.fils=new ArrayList<MenuD>(20);
                /*Elem_menu[] elem_fils = (Elem_menu[]) CGenUtil.rechercher(new Elem_menu(), null, null, " AND ID_PERE='"+elem[0].getId()+"' ORDER BY NIVEAU, RANG");
                if(elem_fils!=null && elem_fils.length>0){
                    for(int i=0; i<elem_fils.length; i++){
                        this.fils.add(new MenuD(elem_fils[i].getId()));
                    }
                }*/
            }             
        }
        /***********************************************************/
        
        public MenuDynamique getPere() throws Exception{
            MenuDynamique[] pere = (MenuDynamique[]) CGenUtil.rechercher(new MenuDynamique(), null, null, " AND ID_PERE='"+this.element.getId_pere()+"'");
            if(pere!=null && pere.length>0){
                return pere[0];
            }else{
                throw new Exception("PAS DE PERE");
            }
        }
        
        public List<MenuD> getListeNiveau(int i) throws Exception{
            int k=element.getNiveau();
            if(i> k){
                if(i==k+1){
                    return this.fils;
                }else{
                    List<MenuD> liste=new ArrayList<MenuD>();
                    int n=this.fils.size();
                    for(MenuD m: this.getFils())
                        liste.addAll(m.getListeNiveau(i-1));
                    return liste;
                }
            }else{
                throw new Exception("NIVEAU INVALIDE");
            }
        }
        public MenuD[] getListeDeNiveau1() throws Exception{
            MenuDynamique[] elems = (MenuDynamique[]) CGenUtil.rechercher(new MenuDynamique(), null, null, " AND NIVEAU='"+1+"'ORDER BY RANG");
            int n=elems.length;
            MenuD[] menus=new MenuD[n];
            for(int i=0;i< n;i++)
                menus[i]= new MenuD(elems[i].getId());
            return menus;            
        }
        
        public void addMenu(MenuDynamique elem){
            this.fils.add(new MenuD(elem));
        }
        public void addMenu(MenuDynamique[] menus){
            for(int i=0; i<menus.length; i++)
                this.addMenu(menus[i]);
        }
        public void addSous_menu(MenuDynamique[] menus){
            MenuD md=rechercheBF(menus[0]);
            md.addMenu(menus);
        }        
        public MenuD rechercheBF(MenuDynamique element ){
            LinkedList<MenuD> file=new LinkedList();
            file.push(this);
            while(!file.isEmpty()){
                MenuD md=file.poll();
                if(md.getElement().equals(element)){
                    return md;
                }
                if(!md.estAvecHref()){
                    List<MenuD> filsDeMd=md.getFils();
                    for(MenuD m: filsDeMd){
                        file.push(m);                    
                    }
                }
            }
            return null;
        }
        public MenuD rechercheBF(String id_elem ){
            LinkedList<MenuD> file=new LinkedList();
            file.push(this);
            while(!file.isEmpty()){
                MenuD md=file.poll();
                System.out.println("AAAA:"+md.getElement());
                if(md.getElement().getId().equals(id_elem)){
                    return md;
                }
                if(!md.estAvecHref()){
                    List<MenuD> filsDeMd=md.getFils();
                    for(MenuD m: filsDeMd){
                        file.push(m);                    
                    }
                }
            }
            return null;
        }
        
	/**********************************************************/
	public void setFils(List<MenuD> fils){
            this.fils = fils;
	}	
	public List<MenuD> getFils(){
            return this.fils;
	}
	
	public void setElement(MenuDynamique element){
            this.element = element;
	}	
	public MenuDynamique getElement(){
            return this.element;
	}
	/**********************************************************/
	
	
        /******************** OP�rations ********************************/
	public void addFils(MenuD element){ // Ajouter un sous-element � ce element
            this.fils.add(element);
	}	
	public void removeFils(int i){
            this.fils.remove(i);
	}
	public void removeFils(String id){
            MenuD  menu_a_supprimer=null;
            int i=0;
            for(MenuD menu: this.fils){
                if(menu.getElement().getId().equals(id)){
                    menu_a_supprimer=menu;
                    break;
                }
                i+=1;
            }
            this.fils.remove(i);
	}
	
	public int nbFils(){
            return this.fils.size();
	}
	
	public boolean estFeuille(){			// MenuD sans sous-element
            return fils==null || this.fils.isEmpty();
	}
        public boolean estAvecHref(){
            return this.element.getHref()!=null && this.element.getHref().compareTo("")!=0;
        }
	
	public String toString(){		
		if(estAvecHref()){
			return "<li><a href='${pageContext.request.contextPath}"+element.getHref()+"'><i class='"+element.getIcone()+"'></i><span>"+element.getLibelle()+"</span></a><i class='fa fa-angle-left pull-right'></i></li>";	
		}else{
			String html="<li class='treeview'> "
                                + "<a href='test.jsp?pere="+element.getId()+"'>\n"
                                +"\t <i class='"+element.getIcone()+"'></i>"+element.getLibelle()+"<i class='fa fa-angle-left pull-right'></i>\n"
                                +"</a>\n"
                                + "<ul class='treeview-element'>\n";
                                for(MenuD element: this.fils){
                                    html+=element.toString();
                                }
                            html+="</ul>\n</li>";
			return html;
		}
	}
	
	public static void main(String[] args) throws Exception{
		MenuD menu_dyn=new MenuD("ELE000001");
                System.out.println(menu_dyn.toString());
	}

        
        
      
        
}
