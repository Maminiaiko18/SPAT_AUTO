<%-- 
    Document   : formPersonnelChoix
    Created on : 23 oct. 2015, 15:31:40
    Author     : user
--%>
<%@page import="mg.cnaps.formation.FormPersonnelChoix"%>
<%@page import="mg.cnaps.log.LogPersonnel"%>
<%@page import="mg.cnaps.log.LogDeplacement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%

    LogPersonnel e = new LogPersonnel();
    e.setNomTable("log_personnel_choix_matricule");
    String champReturn = request.getParameter("champReturn");
    String listeCrt[] = {"id", "nom", "prenom", "direction","service","id_pers"};
    String listeInt[] = {""};
    String libEntete[] = {"id", "nom", "prenom", "direction","service","id_pers"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 3, libEntete, 6);
    pr.setAWhere(" AND ID IN ( SELECT part.log_personnel from form_participant part )");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("formPersonnelChoix2.jsp");
    pr.setChampReturn(champReturn);
    pr.getFormu().getChamp("id").setLibelleAffiche("ID");
    pr.getFormu().getChamp("nom").setLibelleAffiche("Nom");
    pr.getFormu().getChamp("prenom").setLibelleAffiche("Prénom");
    pr.getFormu().getChamp("id_pers").setLibelleAffiche("Matricule");
    pr.getFormu().getChamp("direction").setLibelleAffiche("Direction");
    pr.getFormu().getChamp("service").setLibelleAffiche("Service");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cynthia 2.0 | CNaPS</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1>Liste des personnels rattachés à une formation</h1>
            </section>
            <section class="content">
                <form action="formPersonnelChoix2.jsp?champReturn=<%=pr.getChampReturn()%>" method="post" name="chauffeur" id="chauffeur">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    String lienTableau[] = {pr.getLien() + "?but=matieriel_roulant/chauffeur/personnel-fiche.jsp"};
                    String colonneLien[] = {"id"};
                    String libelles[] = {"ID", "Nom", "Prénom", "Direction","Service","Matricule"};
                    //pr.getTableau().setLien(lienTableau);
                    //pr.getTableau().setColonneLien(colonneLien);
                    pr.getTableau().setLibelleAffiche(libelles);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>