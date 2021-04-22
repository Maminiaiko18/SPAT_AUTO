<%--
    Document   : historique-liste
    Created on : 15 févr. 2016, 20:49:29
    Author     : Ntsou
--%>

<%@page import="affichage.PageRecherche"%>
<%@page import="historique.VueHistoriqueValeur"%>
<%@page import="historique.Historique_valeur"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%
    VueHistoriqueValeur hv = new VueHistoriqueValeur();
    String listeCrt[] = {"idhisto", "datehistorique", "heure", "objet"};
    String listeInt[] = {"datehistorique"};
    String libEntete[] = {"idhisto", "datehistorique", "heure", "objet"};
    PageRecherche pr = new PageRecherche(hv, request, listeCrt, listeInt, 3, libEntete, 4);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("datehistorique1").setLibelleAffiche("Date min");
    pr.getFormu().getChamp("datehistorique2").setLibelleAffiche("Date max");
    pr.setApres("utilisateur/historique-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Historique Valeur</h1>
    </section>
    <section class="content">
	<form action="<%=pr.getLien()%>?but=utilisateur/historique-liste.jsp" method="post" name="listehistorique" id="listeHistorique">
	    <%

		out.println(pr.getFormu().getHtmlEnsemble());
	    %>
	</form>
	<%
	    String lienTableau[] = {pr.getLien() + "?but=utilisateur/historique-fiche.jsp"};
	    String colonneLien[] = {"idhisto"};
	    pr.getTableau().setLien(lienTableau);
	    pr.getTableau().setColonneLien(colonneLien);
	    out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
	    String libEnteteAffiche[] = {"ID ", "Date ", "heure", "objet"};
	    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
	    out.println(pr.getTableau().getHtml());
	    out.println(pr.getBasPage());
        %>
    </section>
</div>
