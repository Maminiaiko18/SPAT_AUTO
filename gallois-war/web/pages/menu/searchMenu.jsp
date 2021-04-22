<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.AdminGen"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mg.cnaps.utilisateur.CNAPSUser"%>
<%@page import="user.UserEJB"%>
<%@page import="menu.MenuDynamique"%>
<%
    String  requete =(String) request.getParameter("query");
    UserEJB u = (UserEJB) session.getAttribute("u");
    CNAPSUser cnapsUser = u.getCnapsUser();
    ArrayList<ArrayList<MenuDynamique>> arbre =null;
    if(session.getAttribute("MENU")==null){
        arbre = MenuDynamique.getElementMenu(request, u.getUser(), cnapsUser);
        session.setAttribute("MENU", arbre);
    }else{
        arbre = (ArrayList<ArrayList<MenuDynamique>>) session.getAttribute("MENU");
    }
    ArrayList<MenuDynamique> dynamMen = new ArrayList<MenuDynamique>();
    for(ArrayList<MenuDynamique> tempMen : arbre){
        for(MenuDynamique temp : tempMen){
            if(temp.getLibelle().toLowerCase().contains(requete.toLowerCase())) dynamMen.add(temp);
        }
    }
    MenuDynamique[] di = new MenuDynamique[dynamMen.size()];
    for(int co=0;co<di.length;co++){
        di[co] = dynamMen.get(co);
    }
    dynamMen = new ArrayList<MenuDynamique>();
    MenuDynamique[] tabMenu = null;
    if(request.getServletContext().getAttribute("tabMenu")!=null){
        tabMenu=(MenuDynamique[])request.getServletContext().getAttribute("tabMenu");
    }
    int co1=0;
    for(int i=0;i<tabMenu.length;i++){
        if(tabMenu[i].getId()==null) co1++;
    }
    MenuDynamique[] finale = MenuDynamique.orderMenuRecurs(dynamMen, di, tabMenu, true);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1><hr/></h1>
    </section>
    <section class="content">
        <div class="col-md-8 offset-col-md-2" style="overflow-y:scroll; max-height: 450px;">
            <ul style="list-style: none;">
                <% for(int co=0;co<finale.length;co++){ %>
                <li>
                    <h<%= finale[co].getNiveau()+1 %>>
                        <% for(int i=0;i<finale[co].getNiveau()-1;i++){ out.print("<span style='height: 5px;width: 10px'>&#9472;&#9472;</span>"); }  %>
                        <% if(Utilitaire.champNull(finale[co].getHref()).equals("")||Utilitaire.champNull(finale[co].getHref()).equals("#")){ %>
                            <%= finale[co].getLibelle() %>
                        <% } else{ %>
                        <a href="<% out.print(finale[co].getHref()+"&currentMenu="+finale[co].getId()); %>">
                            <%= finale[co].getLibelle() %>
                        </a>
                        <% } %>
                    </h<%= finale[co].getNiveau()+1 %>>
                </li>
                <% } %>
            </ul>
        </div>
    </section>
</div>