<%@page import="mg.cnaps.formation.FormFormation"%>
<%@page import="mg.cnaps.formation.FormDemande"%>
<%@page import="affichage.PageRecherche"%>
<% FormDemande lv = new FormDemande();
    lv.setNomTable("FORM_DEMANDE_ETAT_CREE");

    String listeCrt[] = {"id", "id_etablissement", "form_domaine", "log_service", "id_categorie", "id_type", "id_personnel", "date_debut", "date_fin", "lieu", "objett", "niveau_requis", "id_type_cout", "cout_offre", "idmatiere", "exercice"};
    String listeInt[] = {"date_debut", "date_fin", "cout_offre", "exercice"};
    String libEntete[] = {"id", "id_etablissement", "form_domaine", "log_service", "id_categorie", "id_type", "id_personnel", "date_debut", "date_fin", "lieu", "objett", "niveau_requis", "id_type_cout", "cout_offre", "idmatiere", "exercice"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 16);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("id_etablissement").setLibelle("Etablissement");
    pr.getFormu().getChamp("id_categorie").setLibelle("Catégorie");
    pr.getFormu().getChamp("id_type").setLibelle("Etablissement");
    pr.getFormu().getChamp("objett").setLibelle("Objet");
    pr.getFormu().getChamp("niveau_requis").setLibelle("Niveau requis");
    pr.getFormu().getChamp("id_type_cout").setLibelle("Type Coût");
    pr.getFormu().getChamp("cout_offre1").setLibelle("Coût Offre Min");
    pr.getFormu().getChamp("cout_offre2").setLibelle("Coût Offre Max");
    pr.getFormu().getChamp("idmatiere").setLibelle("Matière");
    pr.getFormu().getChamp("form_domaine").setLibelle("Domaine");
    pr.getFormu().getChamp("log_service").setLibelle("Service");
    pr.getFormu().getChamp("exercice1").setLibelle("Exercice Min");
    pr.getFormu().getChamp("exercice2").setLibelle("Exercice Max");
    pr.getFormu().getChamp("date_debut1").setLibelle("Date d&eacute;but min");
    pr.getFormu().getChamp("date_debut2").setLibelle("Date d&eacute;but max");
    pr.getFormu().getChamp("date_fin1").setLibelle("Date fin min");
    pr.getFormu().getChamp("date_fin2").setLibelle("Date fin max");
    pr.getFormu().getChamp("id_personnel").setLibelle("Personnel");
    pr.setApres("formation/demandeformation-visa.jsp");
    String[] colSomme = {"cout_offre"};
   
    pr.creerObjetPage(libEntete, colSomme);%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des demandes de formations à viser </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=formation/demandeformation-visa.jsp" method="post" name="demande" id="demande">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=formation/demande-fiche.jsp"};
	    String colonneLien[] = {"id"};
	    pr.getTableau().setLien(lienTableau);
	    pr.getTableau().setColonneLien(colonneLien);
	    out.println(pr.getTableauRecap().getHtml());%>
        <br>
         <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="incident" id="incident">
               <input type="hidden" name="bute" value="formation/demandeformation-visa.jsp"/>
            <input type="hidden" name="classe" value="mg.cnaps.formation.FormFormation"/>
            <input type="hidden" name="acte" value="viser"/>
            <%
		String libEnteteAffiche[] = {"id", "Etablissement", "Domaine", "Service", "Catégorie", "Type", "Personnel", "Date de début", "Date de fin", "Lieu", "Objet", "Niveau Requis", "Type Coût", "Coût", "Matière", "Exercice"};
		pr.getTableau().setLibelleAffiche(libEnteteAffiche);
		pr.getTableau().setNameActe("viser");
		pr.getTableau().setNameBoutton("Viser");
		out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
        </form>
        <%out.println(pr.getBasPage());%>
    </section>
</div>