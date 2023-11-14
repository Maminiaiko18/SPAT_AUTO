

<%@page import="ordremission.RetourOM"%>
<%@ page import="ordremission.OrdreMission" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
   RetourOM a = new RetourOM();
   a.setNomTable("retour_om");
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    //Modification des affichages
    //pi.getFormu().getChamp("dureereelle").setVisible(false);
    pi.getFormu().getChamp("heurearrivee").setLibelle("Heure d'arrivée");
   // pi.getFormu().getChamp("idcategorieprofessionnel").setPageAppel("choix/categorie-professionnel-choix.jsp");
    //pi.getFormu().getChamp("idcategorieprofessionnel").setAutre("readonly");
    pi.getFormu().getChamp("datearrivee").setLibelle("Date arrivée");
    pi.getFormu().getChamp("nombres").setLibelle("Nombre");
    pi.getFormu().getChamp("prixunitaire").setLibelle("Prix Unitaire");
//    pi.getFormu().getChamp("fraisdeplacement").setLibelle("Frais de déplacement");
    pi.getFormu().getChamp("autres").setLibelle("Autres");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("dureereelle").setVisible(false);
    pi.getFormu().getChamp("idom").setLibelle("Ordre mission");
    pi.getFormu().getChamp("idom").setAutre("readonly");
    pi.getFormu().getChamp("idom").setDefaut(request.getParameter("idom"));
    //Variables de navigation
    String classe = "ordremission.RetourOM";
    String butApresPost = "ordre-mission/retourom-fiche.jsp";
    String nomTable = "retour_om";
    //Generer les affichages
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();

%>
<div class="content-wrapper">
    <h1 align="center">Saisie Retour Ordre de Mission</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
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
}
%>

