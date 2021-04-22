<%@page import="mg.cnaps.formation.FormFormation"%>
<%@page import="mg.cnaps.formation.FormDemande"%>
<%@page import="affichage.PageRecherche"%>
<% FormFormation lv = new FormFormation();
    lv.setNomTable("FORM_FORMATION_LIBELLE4");

    String listeCrt[] = {"id", "form_domaine", "log_service", "form_formateur", "date_debut", "date_fin", "lieu", "cout_offre"};
    String listeInt[] = {"date_debut", "date_fin"};
    String libEntete[] = {"id", "form_domaine", "log_service", "form_formateur", "date_debut", "date_fin", "lieu", "cout_offre"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 7);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("form_domaine").setLibelle("Domaine");
    pr.getFormu().getChamp("log_service").setLibelle("Service");
    pr.getFormu().getChamp("date_debut1").setLibelle("Date d&eacute;but min");
    pr.getFormu().getChamp("date_debut2").setLibelle("Date d&eacute;but max");
    pr.getFormu().getChamp("date_fin1").setLibelle("Date fin min");
    pr.getFormu().getChamp("date_fin2").setLibelle("Date fin max");
    pr.getFormu().getChamp("form_formateur").setLibelle("Formateur");
    pr.getFormu().getChamp("cout_offre").setLibelle("Co&ucirc;t");
    pr.setApres("formation/formation-visa.jsp");
    String[] colSomme = {"cout_offre"};
    pr.setAWhere(" and etat < 10 ");
    pr.creerObjetPage(libEntete, colSomme);%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des formations </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=formation/formation-visa.jsp" method="post" name="demande" id="demande">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=formation/formation-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="incident" id="incident">
            <input type="hidden" name="bute" value="formation/formation-visa.jsp"/>
            <input type="hidden" name="classe" value="mg.cnaps.formation.FormFormation"/>
            <input type="hidden" name="acte" value="viser"/>
            <%
                String libEnteteAffiche[] = {"id", "Domaine", "Service", "Formateur", "Date D&eacute;but", "Date Fin", "Lieu", "Co&ucirc;t"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameActe("viser");
                pr.getTableau().setNameBoutton("Viser");
                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
        </form>
        <%out.println(pr.getBasPage());%>
    </section>
</div>