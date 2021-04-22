<%-- 
    Document   : listeChantierChoix
    Created on : 26 nov. 2020, 22:10:35
    Author     : Tsiory
--%>
<%@page import="elementchantier.ElementChantier"%>
<%@page import="mg.spat.Chantier"%>
<%@page import="mg.spat.Client"%>
<%@ page import="user.*" %>
<%@page import="mg.spat.Navire"%>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        String champReturn = request.getParameter("champReturn");
        ElementChantier ec = new ElementChantier();

        String listeCrt[] = {"id", "libelle", "caracteristique", "unite", "code"};
        String listeInt[] = {};
        String libEntete[] = {"id", "libelle", "caracteristique", "unite", "code"};
        PageRechercheChoix pr = new PageRechercheChoix(ec, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("listeElementChantierChoix.jsp");
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
                <h1>Choix chantier</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">

                    <%
                        
                        out.println(pr.getTableau().getHtmlWithRadioButton());
                    %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
