<%-- 
    Document   : listeTiersChoix
    Created on : 4 déc. 2019, 09:51:37
    Author     : rajao
--%>
<%@ page import="mg.spat.Tiers"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    String champReturn = request.getParameter("champReturn");
    Tiers navire = new Tiers();
    navire.setNomTable("TIERS");
    String listeCrt[] = {"id","nom","description","nif","stat","contact","responsable","adresse","type"};
    String listeInt[] = {};
    String libEntete[] = {"id","nom","description","nif","stat","contact","responsable","adresse","type"};
    PageRechercheChoix pr = new PageRechercheChoix(navire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeTiersChoix.jsp");
    pr.setOrdre(" order by id");
    //pr.getFormu().getChamp("reference").setLibelle("Référence");
    
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
                <h1>Choix Tiers</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <a  class="btn btn-success" style="margin: 0 47.5%;" href="<%="/spat/pages/globalnegoce.jsp?but=travaux/tiers-saisie.jsp"%>"> Nouveau </a>
                <br><br>
                <%
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    
                    <% 
                        String libEnteteAffiche[] = {"id","nom","description","nif","stat","contact","responsable","adresse","type"};
                        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
