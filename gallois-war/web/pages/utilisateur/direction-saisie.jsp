
<%@page import="lc.Direction"%>
<%@page import="utilisateur.Role"%>
<%@page import="historique.MapUtilisateur"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Direction pj = new Direction();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.getFormu().getChamp("libelledir").setLibelle("Nom direction");
    pi.getFormu().getChamp("descdir").setLibelle("Description");
    pi.getFormu().getChamp("idDirecteur").setVisible(false);
    pi.getFormu().getChamp("abbrevDir").setLibelle("Abreviation");
    
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'une direction</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="utilisateur/direction-liste.jsp">
    <input name="classe" type="hidden" id="classe" value="lc.Direction">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>