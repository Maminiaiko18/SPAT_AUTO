<%-- 
    Document   : etablisssement-liste
    Created on : 13 oct. 2015, 10:03:41
    Author     : Jetta
--%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.cnaps.formation.FormEtablissement"%>
<% FormEtablissement lv = new FormEtablissement();
     lv.setNomTable("FORM_ETABLISSEMENT_LIBELLE");
    String listeCrt[] = {"id", "nom", "specialisation", "adresse",  "contact"};
    String listeInt[] = null;
    String libEntete[] = {"id", "nom", "specialisation", "adresse",  "contact"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 5);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("configuration/etablissement-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Etablissements</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=configuration/etablissement-liste.jsp" method="post" name="demande" id="demande">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=configuration/etablissement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"ID", "Nom", "Sp&eacute;cialisation", "Adresse",  "Contact"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>