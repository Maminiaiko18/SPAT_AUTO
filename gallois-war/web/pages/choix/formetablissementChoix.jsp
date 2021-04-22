<%-- 
    Document   : formetablissementChoix
    Created on : 13 oct. 2015, 14:30:55
    Author     : user
--%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="mg.cnaps.formation.FormOffreFormation"%>
<%@page import="mg.cnaps.formation.FormEtablissement"%>
<%
    String champReturn = request.getParameter("champReturn");
    FormEtablissement e = new FormEtablissement();
    e.setNomTable("form_etablissement_libelle");
    String listeCrt[] = {"id", "nom", "specialisation", "date_anciennete", "adresse", "pays", "contact"};
    String listeInt[] = {"date_anciennete"};
    String libEntete[] = {"id", "nom", "specialisation", "date_anciennete", "adresse", "pays", "contact"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 3, libEntete, 7);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("formetablissementChoix.jsp");
    pr.setChampReturn(champReturn);
    pr.getFormu().getChamp("id").setLibelleAffiche("ID");
    pr.getFormu().getChamp("nom").setLibelleAffiche("Nom");
    pr.getFormu().getChamp("specialisation").setLibelleAffiche("Spécialisation");
    pr.getFormu().getChamp("date_anciennete1").setLibelleAffiche("Date ancienneté Min");
    pr.getFormu().getChamp("date_anciennete2").setLibelleAffiche("Date ancienneté Max");
    pr.getFormu().getChamp("adresse").setLibelleAffiche("Adresse");
    pr.getFormu().getChamp("pays").setLibelleAffiche("Pays");
    pr.getFormu().getChamp("contact").setLibelleAffiche("Contact");
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
                <h1>Etablissement</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="etab" id="etab">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
//                    String lienTableau[] = {pr.getLien() + "?but=employeur/employeur-fiche.jsp"};
//                    String colonneLien[] = {"id"};
                    String libelles[] = {"ID", "Nom", "Specialisation", "Date ancienneté", "Adresse", "Pays",  "Contact"};
//		    pr.getTableau().setLien(lienTableau);
//                    pr.getTableau().setColonneLien(colonneLien);
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
