<%-- 
    Document   : demandeformation
    Created on : 29 déc. 2016, 10:28:35
    Author     : Jetta
--%>

<%@page import="mg.cnaps.formation.FormDemande"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageRechercheChoix"%> 
<%
    FormDemande lv = new FormDemande();
    lv.setNomTable("FORM_DEMANDE_LIB_CREE");
    String champReturn = request.getParameter("champReturn");
    String listeCrt[] = {"id", "type_demandeur", "id_type", "form_domaine", "id_etablissement", "log_service", "id_direction", "date_debut", "date_fin"};
    String listeInt[] = {"date_debut", "date_fin"};
    String libEntete[] = {"id", "type_demandeur", "id_type", "form_domaine", "id_etablissement", "log_service", "id_direction", "date_debut", "date_fin"};
    PageRechercheChoix pr = new PageRechercheChoix(lv, request, listeCrt, listeInt, 3, libEntete, 9);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("date_debut1").setLibelle("Date d&eacute;but min");
    pr.getFormu().getChamp("date_debut2").setLibelle("Date d&eacute;but max");
    pr.getFormu().getChamp("date_fin1").setLibelle("Date fin min");
    pr.getFormu().getChamp("date_fin2").setLibelle("Date fin max");
    pr.getFormu().getChamp("type_demandeur").setLibelle("Type demande");
    pr.getFormu().getChamp("id_type").setLibelle("Type de formation");
    pr.getFormu().getChamp("form_domaine").setLibelle("Domaine");
    pr.getFormu().getChamp("id_etablissement").setLibelle("Etablissement");
    pr.getFormu().getChamp("log_service").setLibelle("Service");
    pr.getFormu().getChamp("id_direction").setLibelle("Direction");
    pr.setChampReturn(champReturn);
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
                <h1>Liste demande de formation</h1>
            </section>
            <section class="content">
                <form action="demandeformation.jsp?champReturn=<%=pr.getChampReturn()%>" method="post" name="chauffeur" id="chauffeur">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%

                    String libEnteteAffiche[] = {"id", "Type demande", "Type de formation", "Domaine", "Etablissement", "Service", "Direction", "Date d&eacute;but", "Date fin"};
                    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choixMultiple/apresChoixMultiple.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithMultipleCheckbox());%>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>