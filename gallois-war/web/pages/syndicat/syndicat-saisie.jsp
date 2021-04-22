
<%@page import="mg.spat.Syndicat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Syndicat pj = new Syndicat();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    
    pi.getFormu().getChamp("etat").setVisible(false);
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un syndicat</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="syndicat/syndicat-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.Syndicat">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>