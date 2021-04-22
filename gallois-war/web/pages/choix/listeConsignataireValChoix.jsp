<%-- 
    Document   : listeConsignataireValChoix
    Created on : 11 déc. 2020, 09:29:45
    Author     : Sanda
--%>

<%@page import="mg.spat.Client"%>
<%@ page import="bean.TypeObjet" %>
<%@ page import="affichage.PageRechercheChoix" %>

<%
    String champReturn = request.getParameter("champReturn");
    TypeObjet client = new TypeObjet();
    client.setNomTable("consignataireTab");
    String listeCrt[] = { "val", "desce"};
    String listeInt[] = {};
    String libEntete[] = { "val", "desce"};
    PageRechercheChoix pr = new PageRechercheChoix(client, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeConsignataireValChoix.jsp");
    pr.setChampReturn(champReturn);
    String[] colSomme = null;
    pr.getFormu().getChamp("val").setLibelle("Val");
    pr.getFormu().getChamp("desce").setLibelle("Déscription");
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
                <h1>Choix d'un consignataire</h1>
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
                        String libelles[] = { "Valeur", "Déscription"};
                        pr.getTableau().setLibelleAffiche(libelles);
                        out.println(pr.getTableau().getHtmlWithRadioButton());
                    %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>

