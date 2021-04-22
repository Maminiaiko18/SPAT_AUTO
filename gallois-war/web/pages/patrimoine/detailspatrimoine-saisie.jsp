<%-- 
    Document   : liaison-placement-saisie
    Created on : 22 nov. 2019, 15:17:36
    Author     : Asus
--%>


<%@page import="mg.spat.DetailsPatrimoine"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    DetailsPatrimoine lp = new DetailsPatrimoine();
    PageInsert pi = new PageInsert(lp, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

   
    pi.preparerDataFormu();
    
    pi.getFormu().getChamp("utilisateur").setAutre("readonly");
    pi.getFormu().getChamp("utilisateur").setPageAppel("choix/unionclientmattierspatChoix.jsp");
    pi.getFormu().getChamp("idPatrimoine").setLibelle("Patrimoine");
    pi.getFormu().getChamp("idPatrimoine").setPageAppel("choix/listePatrimoineChoix.jsp");
    pi.getFormu().getChamp("natureObjet").setLibelle("Nature de l'objet");
    pi.getFormu().getChamp("surfaceOccupe").setLibelle("Surface occupée (m²)");
    pi.getFormu().getChamp("surfaceDisponible").setVisible(false);
    pi.getFormu().getChamp("date_debut_contrat").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("date_fin_contrat").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("date_debut_contrat").setLibelle("Début contrat");
    pi.getFormu().getChamp("date_fin_contrat").setLibelle("Fin contrat");
%>
<div class="content-wrapper">
    <h1>Saisie d'un détails de patrimoine</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="patrimoine/detailspatrimoine-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.DetailsPatrimoine">
    </form>
</div>
