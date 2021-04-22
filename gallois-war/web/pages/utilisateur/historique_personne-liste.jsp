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
    String listeCrt[] = {"idhisto", "datehistorique", "heure","idutilisateur"};
    String listeInt[] = {"datehistorique", "heure"};
    String libEntete[] = {"idhisto", "datehistorique", "heure", "idutilisateur"};
    PageRecherche pr = new PageRecherche(hv, request, listeCrt, listeInt, 3, libEntete, 4);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
   
    
    pr.getFormu().getChamp("datehistorique1").setLibelle("date Inf");
    pr.getFormu().getChamp("datehistorique2").setLibelle("date Sup");
    pr.getFormu().getChamp("heure1").setLibelle("Heure début");
    pr.getFormu().getChamp("heure2").setLibelle("Heure fin");
    
    
    String objet = "mg.cnaps.sig.SigPersonnes";
    String idpers = request.getParameter("idpers");
    String aWhere = " and refobjet='" + idpers + "' or TRIM(refobjet)='" + idpers + "'";
    pr.setAWhere(aWhere);
    
    
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("utilisateur/historique_personne-liste.jsp&idpers=" + idpers + "&dummy=dummy" );
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Historique Valeur</h1>
    </section>
    <section class="content">
	<form action="<%=pr.getLien()%>?but=utilisateur/historique_personne-liste.jsp" method="post" name="listehistorique" id="listeHistorique">
            <input type="hidden" name="idpers" value="<%= idpers %>">
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
	    String libEnteteAffiche[] = {"idhisto", "datehistorique", "heure", "id utilisateur"};
	    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
	    out.println(pr.getTableau().getHtml());
	    out.println(pr.getBasPage());
        %>
    </section>
</div>
