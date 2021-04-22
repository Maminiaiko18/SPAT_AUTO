<%-- 
    Document   : listeDetailsChantierChoix
    Created on : 26 nov. 2020, 10:32:40
    Author     : Sanda
--%>

<%@page import="detailschantier.DetailChantier"%>
<%@ page import="affichage.PageRechercheChoix"%>

<%
    try {
        String champReturn = request.getParameter("champReturn");
        DetailChantier ec = new DetailChantier();
        ec.setNomTable("DETAILCHANTIER_LIB");

        String listeCrt[] = {"id", "mere", "idelement", "qte", "pu"};
        String listeInt[] = {};
        String libEntete[] = {"id", "mere", "idelement", "qte", "pu"};
        PageRechercheChoix pr = new PageRechercheChoix(ec, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("listeDetailsChantierChoix.jsp");
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
                <h1>Choix details chantier</h1>
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
