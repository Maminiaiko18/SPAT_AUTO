<%-- 
    Document   : activites-saisie
    Created on : 18 mai 2021, 16:24:17
    Author     : nyamp
--%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="lignecredit.LigneCredit"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="affichage.Champ" %>
<%@ page import="affichage.Liste" %>
<%@ page import="affichage.PageInsert" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";

        String nomtable = "ligneCreditRecette";

        LigneCredit obj = new LigneCredit();
        obj.setNomTable(nomtable);
        PageInsert pi = new PageInsert(obj, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("designation").setLibelle("Désignation");
        pi.getFormu().getChamp("annee").setLibelle("Année");
        pi.getFormu().getChamp("quantite").setLibelle("Quantité");
        pi.getFormu().getChamp("annee").setDefaut(Utilitaire.getAnneeEnCours());

        pi.getFormu().getChamp("etat").setVisible(false);

        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie Activite</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="lignecredit" id="lignecredit" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="ligneCredit/fiche-ligneCreditRecette.jsp">
        <input name="classe" type="hidden" id="classe" value="lignecredit.LigneCredit">
        <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
</div>
<%} catch (Exception e) {
        e.printStackTrace();
    }%>