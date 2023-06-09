
<%@page import="ordremission.IndemniteMission"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    IndemniteMission a = new IndemniteMission();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    //Modification des affichages
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idcategorieprofessionnel").setLibelle("Catégorie Professionnel");
    pi.getFormu().getChamp("idcategorieprofessionnel").setPageAppel("choix/categorie-professionnel-choix.jsp");
    pi.getFormu().getChamp("idcategorieprofessionnel").setAutre("readonly");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("fraishebergement").setLibelle("Frais d'hébergement");
    pi.getFormu().getChamp("fraisrestauration").setLibelle("Frais de restauration");
    pi.getFormu().getChamp("fraisdeplacement").setLibelle("Frais de déplacement");
    pi.getFormu().getChamp("fraisforfaitaire").setLibelle("Frais forfaitaire");
    //Variables de navigation
    String classe = "ordremission.IndemniteMission";
    String butApresPost = "ordre-mission/indemnite-mission-fiche.jsp";
    String nomTable = "indemnite_mission";
    //Generer les affichages
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Saisie indemnite mission</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" data-parsley-validate>
        <%
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
} %>
