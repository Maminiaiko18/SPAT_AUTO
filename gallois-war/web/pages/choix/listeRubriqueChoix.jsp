<%-- 
    Document   : piloteChoix
    Created on : 26 nov. 2020, 16:32:06
    Author     : Sanda
--%>
<%@ page import="user.*" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%@page import="mg.spat.exploitant.Rubrique"%>

<%
    String champReturn = request.getParameter("champReturn");
    Rubrique objet = new Rubrique();
    objet.setNomTable("RUBRIQUE_ACTIVITELIB");
    String listeCrt[] = {"id","designation","categorie","compte","direction","code"};
    String listeInt[] = {};
    String libEntete[] = {"id","designation","code","categorie","pu","devise", "compte", "unite","objet","tva","direction","condition"};

    PageRechercheChoix pr = new PageRechercheChoix(objet, request, listeCrt, listeInt, 3, libEntete,libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeRubriqueChoix.jsp");
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
                <h1>Liste des rubriques</h1>
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
                        String libEnteteAffiche[] =  {"id","designation","code","categorie","pu","devise", "compte", "unite","objet","tva","direction","condition"};
                        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); 
                    %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
