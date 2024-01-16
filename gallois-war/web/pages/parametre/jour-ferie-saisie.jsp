

<%@ page import="mg.spat.JourFerie" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    JourFerie a = new JourFerie();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    //Modification des affichages
    //pi.getFormu().getChamp("id").setVisible(false);
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("designation").setLibelle("Designation");;
    pi.getFormu().getChamp("heureDebut").setVisible(false);
    
    //Variables de navigation
    String classe = "mg.spat.JourFerie";
    String butApresPost = "parametre/jour-ferie-fiche.jsp";
    String nomTable = "jour_ferie";
    //Generer les affichages
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Saisie jour f&eacuteri&eacute</h1>
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
} %>

