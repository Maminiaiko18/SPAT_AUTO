<%-- 
    Document   : listeCodeEtablissementChoix.jsp
    Created on : 29 déc. 2020, 09:30:11
    Author     : Lenovo
--%>

<%@page import="mg.cnaps.formation.CodeEtablissement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    CodeEtablissement code = new CodeEtablissement();
    code.setNomTable("CODEETABLISSEMENT_LIB");
    String champReturn = request.getParameter("champReturn");
    
    String listeCrt[] = {"id","val","desce","departement","service"};
    String listeInt[] = {};
    String libEntete[] = {"id","val","desce","departement","service"};
    PageRechercheChoix pr = new PageRechercheChoix(code, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeCodeEtablissementChoix.jsp");
    pr.setChampReturn(champReturn);
    
    pr.getFormu().getChamp("val").setLibelle("Désignation");
    pr.getFormu().getChamp("desce").setLibelle("Déscription");
    pr.getFormu().getChamp("departement").setLibelle("Département");
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
            <section class="content-header">
                <h1>Choix Etablissement</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <a  class="btn btn-success" style="margin: 0 47%;" href="<%="/spat/pages/globalnegoce.jsp?but=configuration/idvaldesce.jsp&ciblename=codeetablissement"%>"> Nouveau </a>
                <br><br>
                
                <%
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">                    
                    <% 
                        String libEnteteAffiche[] = {"id", "Désignation", "Déscription", "Département", "Service"};
                        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); 
                    %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
