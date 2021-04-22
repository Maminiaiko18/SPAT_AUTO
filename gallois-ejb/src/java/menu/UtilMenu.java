
package menu;

import bean.CGenUtil;

/**
 *
 * @author ITU
 */
public class UtilMenu {
    
    
    
    public static MenuDynamique[] getSous_menu(String id) throws Exception{
        MenuDynamique[] elem = (MenuDynamique[]) CGenUtil.rechercher(new MenuDynamique(), null, null, " AND ID_PERE='"+id+"' ORDER BY niveau, rang");
        if(elem!=null && elem.length>0){
             return elem;
        }
        throw new Exception("ID NON VALIDE");         
    }
    public static MenuDynamique[] getSous_menu(MenuDynamique element) throws Exception{
        MenuDynamique[] elem = (MenuDynamique[]) CGenUtil.rechercher(new MenuDynamique(), null, null, " AND ID_PERE='"+element.getId_pere()+"' ORDER BY niveau, rang");
        if(elem!=null && elem.length>0){
             return elem;
        }
        throw new Exception("ID NON VALIDE");         
    }

    public static MenuDynamique[] getElem_principaux() throws Exception{
        MenuDynamique[] elem = (MenuDynamique[]) CGenUtil.rechercher(new MenuDynamique(), null, null, " AND niveau='"+0+"' ORDER BY niveau, rang");
         if(elem!=null && elem.length>0){
             return elem;
         }
        throw new Exception("ID NON VALIDE");  
    }
    
    public MenuDynamique getPereDe(MenuDynamique element) throws Exception{
        if(element.getId_pere()!=null){
            MenuDynamique[] elem = (MenuDynamique[]) CGenUtil.rechercher(new MenuDynamique(), null, null, " AND id='"+ element.getId_pere()+"' ORDER BY niveau, rang");
            if(elem!=null && elem.length>0){
                return elem[0];
            }
           throw new Exception("ID NON VALIDE");         
        }
        throw new Exception("ELEMENT PRINCIPALE");
    }
    
    public void add(MenuDynamique[] sous_menu, String id_elem, MenuD menu){
        MenuD menud= menu.rechercheBF(id_elem);
        
    }
    
}
