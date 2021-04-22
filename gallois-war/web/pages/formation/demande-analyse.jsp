<%-- 
    Document   : demande-analyse
    Created on : 29 déc. 2016, 11:19:59
    Author     : Jetta
--%>
 
<%@page import="affichage.PageRechercheGroupe"%>
<%@page import="mg.cnaps.formation.FormDemande"%>
<%!
     FormDemande  formation;
%>
<%
    formation = new FormDemande();
    formation.setNomTable("analyse_formation");
    String listeCrt[] = {"domaine", "service", "date_debut", "date_fin", "lieu", "cout"};
	String listeInt[] = {"date_debut", "date_fin", "cout"};
    String[] pourcentage = {"nombrepargroupe"};
    String colDefaut[] = {"domaine", "service", "date_debut", "date_fin", "lieu"};
    String somDefaut[] = {"cout"};
    PageRechercheGroupe pr = new PageRechercheGroupe(formation, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 6, 1);

	
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("date_debut1").setLibelle("Date d&eacute;but min");
    pr.getFormu().getChamp("date_debut2").setLibelle("Date d&eacute;but max");
    pr.getFormu().getChamp("date_fin1").setLibelle("Date fin min");
    pr.getFormu().getChamp("date_fin2").setLibelle("Date fin max");
    pr.getFormu().getChamp("cout1").setLibelle("Co&ucirc;t min");
    pr.getFormu().getChamp("cout2").setLibelle("Co&ucirc;t max");
    pr.setApres("formation/formation-analyse.jsp");
    pr.creerObjetPagePourc();
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=formation/formation-analyse.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
		
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
			String libEnteteAffiche[] = { "Domaine", "Service", "Date début", "Date fin", "Lieu", "Somme"};
                       // pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<script>
//    $(document).ready(function () {
//        var values = [6, 4, 8];
//        $('#sparkline').sparkline('html', values);
//        $('#sparkline').sparkline('html', $this.data());
//    });
    $(".sparkline").each(function () {
        var $this = $(this);
        $(this).sparkline('html', $(this).data());
    });
</script>