<%@page import="utilitaire.Utilitaire"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="affichage.Champ" %>
<%@ page import="affichage.Liste" %>
<%@ page import="affichage.PageInsert" %>
<%@ page import="lignecredit.Reamenagement" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";

        String nomtable = "REAMENAGEMENT";

        Reamenagement obj = new Reamenagement();
        obj.setNomTable(nomtable);
        PageInsert pi = new PageInsert(obj, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("montant").setLibelle("Montant");
        pi.getFormu().getChamp("idLigneDepart").setLibelle("Ligne D&eacute;part");
        pi.getFormu().getChamp("idLigneArrive").setLibelle("Ligne Arriv&eacute;");
        pi.getFormu().getChamp("idLigneDepart").setPageAppel("choix/listeBudgetDepenseChoix.jsp", "idLigneDepart;idLigneDepartlibelle;idLigneDepartlibelle;idLigneDepartlibelle");
        pi.getFormu().getChamp("idLigneArrive").setPageAppel("choix/listeBudgetDepenseChoix.jsp", "idLigneArrive;idLigneArrivelibelle;idLigneArrivelibelle;idLigneArrivelibelle");
        pi.getFormu().getChamp("idLigneDepart").setAutre("readonly");
        pi.getFormu().getChamp("idLigneArrive").setAutre("readonly");
        pi.getFormu().getChamp("etat").setVisible(false);
        
        pi.preparerDataFormu();
%>  
<div class="content-wrapper">
    <h1>Saisie R&eacute;am&eacute;nagement</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="reamenagement" id="reamenagement" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="ligneCredit/reamenagement-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="lignecredit.Reamenagement">
        <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
</div>
<%} catch (Exception e) {
        e.printStackTrace();
    }%>