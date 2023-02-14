<%-- 
    Document   : additif-saisie
    Created on : 18 d�c. 2020, 09:27:13
    Author     : Sanda
--%>

<%@page import="facture.tr.FCTraite"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>
<%@page import="mg.spat.EngagementFille"%>
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="avoir.Avoir"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Utilitaire"%> 
<%@page import="mg.spat.Engagement"%> 
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        String id=request.getParameter("id");
        UserEJB u = (user.UserEJB) session.getValue("u");
        String mapping = FCTraite.class.getName(),
                nomtable = "engagement",
                mappingFille = FCTraite.class.getName(),
                colonneMere = request.getParameter("colonneMere"),
                apres = "treso/journalcaisse-fiche.jsp",
                titre = "Saisie des traites de facture client";

        FCTraite objet = new FCTraite();
        FCTraite objetFille = new FCTraite();
        int nbLigne = 10;

        PageInsertMultiple pi = new PageInsertMultiple(objet, objetFille, request, nbLigne, u);
        pi.setLien((String) session.getValue("lien"));
        
        pi.getFormu().getChamp("idTraite").setVisible(false);
        pi.getFormu().getChamp("idFC").setVisible(false);
        pi.getFormu().getChamp("idJc").setVisible(false);
        pi.getFormu().getChamp("daty").setVisible(false);
        pi.getFormu().getChamp("montant").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);
        String[] col = {"traite"};
        String[] val = {"true"};
        
        affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idTraite"), "choix/traiteChoix.jsp", "idTraite;idTraitelibelle;montant");
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("idTraite"), "readonly");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idFC"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idJc"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("etat"), false);
        for(int i = 0 ; i<nbLigne ; i++ ){
            pi.getFormufle().getChamp("daty_" + i).setVisible(false);
        }
        
        pi.getFormufle().getChamp("idTraite_0").setLibelle("Traite");
        pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
        
        pi.preparerDataFormu();
%>

<div class="content-wrapper">
    <h1> <%=titre%></h1>

    <form action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insertFille">
        <input name="bute" type="hidden" id="bute" value="<%=apres%>">
        <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
        <input name="classefille" type="hidden" id="classefille" value="<%= mappingFille%>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nbLigne%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere%>">
        <input name="idMere" type="hidden" id="idMere" value="<%= id%>">

    </form>
</div>
   
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript">
    alert('<%=e.getMessage()%>');
    history.back();</script>
    <% }%>
