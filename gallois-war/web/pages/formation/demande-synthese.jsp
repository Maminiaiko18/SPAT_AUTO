<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="mg.cnaps.formation.FormFormation"%>
<%@page import="mg.cnaps.formation.FormDemande"%>
<%@page import="affichage.PageRecherche"%>
<%
     
    FormDemande lv = new FormDemande();
    lv.setNomTable("FORM_DEMANDE_LIB_CREE");
    String listeCrt[] = {"id", "type_demandeur", "id_type", "form_domaine", "id_etablissement", "log_service", "id_direction","statut_pro","categorie_pro", "date_debut","date_fin"};
    String listeInt[] = {"date_debut","date_fin"};
    String libEntete[] = {"id", "type_demandeur", "id_type", "form_domaine", "id_etablissement", "log_service", "id_direction","statut_pro","categorie_pro", "date_debut","date_fin"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 11);
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
    pr.getFormu().getChamp("statut_pro").setLibelle("Statut  ");
     pr.getFormu().getChamp("categorie_pro").setLibelle("Categorie  ");
    pr.setApres("formation/demande-synthese.jsp");
    String[] colSomme = {"cout_offre"};
   
    pr.creerObjetPage(libEntete, colSomme);%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Synthese des demandes de formations </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=formation/demande-synthese.jsp" method="post" name="demande" id="demande">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=formation/demande-fiche.jsp"};
	    String colonneLien[] = {"id"};
	    pr.getTableau().setLien(lienTableau);
	    pr.getTableau().setColonneLien(colonneLien);
	    out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <form action="<%=(String) session.getValue("lien")%>/../../SaisieFormation" method="post" name="incident" id="incident">
            <input type="hidden" name="bute" value="formation/formation-liste.jsp"/>
            <input type="hidden" name="classe" value="mg.cnaps.formation.FormFormation"/>
            <input type="hidden" name="acte" value="creer_formation"/>
            <%
		String libEnteteAffiche[] = {"id", "Demandeur", "Type", "Domaine", "Etablissement", "Service", "Direction","Statut","Categorie ", "Date debut","Date fin"};
		pr.getTableau().setLibelleAffiche(libEnteteAffiche);
		pr.getTableau().setNameActe("creer_formation");
		pr.getTableau().setNameBoutton("Créer Formation");
		out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
        </form>
        <%out.println(pr.getBasPage());%>
    </section>
</div>