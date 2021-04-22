<%-- 
    Document   : test
    Created on : 30 nov. 2015, 11:09:24
    Author     : tahina
--%>


<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="menu_mazoto.Elem_menu"%>
<%@page import="menu_mazoto.MenuD"%>
<%@page import="menu_mazoto.UtilMenu"%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%  
    //RECUPERATION DES INFORMATIONS
    MenuD menus=null;                    //l'arbre du menus
    Set<String> emenus=new HashSet();      //les id des élémetns du menus pour éviter la recharche dans l'arbre( couteux)
    if(session.getAttribute("menus")!=null && session.getAttribute("emenus")!=null){
        menus=(MenuD) session.getAttribute("menus");
        emenus=(Set<String>) session.getAttribute("emenus");        
    }else{
        menus=new MenuD("CYN000000");        
        session.setAttribute("menus", menus);
        session.setAttribute("emenus", emenus);
        //out.print("SESSION MENUS ET EMENUS CREER <br/>");
    }
    String id_menu=null;
    if(request.getParameter("pere")!=null && request.getParameter("pere").compareTo("")!=0){
        id_menu=(String) request.getParameter("pere");
          
    }
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Menus Dynamiques!</h1>
<%    
        if(id_menu!=null){
            if(!emenus.contains(id_menu)){  //mbola tsy novisitena mitsi izy zay
                    MenuD md=menus.rechercheBF(id_menu);   
                    if(!md.estAvecHref()){
                        Elem_menu[] sous_menus=UtilMenu.getSous_menu(id_menu);
                        for(Elem_menu e: sous_menus){
                            md.getFils().add(new MenuD(e));
                        }
                    }
                    emenus.add(id_menu);
                    session.setAttribute("menus", menus);
                    session.setAttribute("emenus", emenus);
            }
        }
     
        //out.println(menus);
%>     
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu" id="menuslider">
        <%=menus %>

        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
    </body>
</html>
