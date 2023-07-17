<%-- 
    Document   : listeRoleChoixMultiple
    Created on : 17 juil. 2023, 10:56:48
    Author     : bici
--%>
<%@page import="utilisateur.Role"%>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="user.*" %>
<%@ page import="menu.*" %>
<%
    String champReturn = request.getParameter("champReturn");
    Role role=new Role();
    role.setNomTable("Roles");
            
    String listeCtr[]={"idRole","descRole","Rang"};
    String listeInt[]={};
    String libEntete[]={"idRole","descRole","Rang"};
    PageRechercheChoix pr=new PageRechercheChoix(role,request,listeCtr,listeInt,3,libEntete,libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeUtilisateurChoixMultiple.jsp");
    pr.setChampReturn(champReturn);
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>SPAT</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1>Choix Role Multiple</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    String libEnteteAffiche[] = {"idRole","Description","Rang"};
                    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choixMultiple/apresChoixMultiple.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithMultipleCheckbox()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
