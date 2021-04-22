<%-- 
    Document   : regule-saisie
    Created on : 21 juil. 2020, 15:09:09
    Author     : pro
--%>

<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.spat.RegulBonProvisoire" %>
<%
    try {
        
        RegulBonProvisoire rbp = new RegulBonProvisoire();
        PageInsert pi = new PageInsert(rbp, request, (user.UserEJB) session.getValue("u"));
        if(request.getParameter("id") != null)
            pi.getFormu().getChamp("idBonProvisoire").setDefaut(request.getParameter("id"));
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("daty").setDefaut(""+Utilitaire.dateDuJourSql());
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("idBonProvisoire").setLibelle("Bon provisoire");
        pi.getFormu().getChamp("idBonProvisoire").setAutre("readonly");
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Regularisation Bon Provisoire</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insertWithAction">
        <input name="bute" type="hidden" id="bute" value="treso/bon-provisoire-liste.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.RegulBonProvisoire">
        <input name="action" type="hidden" id="classe" value="<%=request.getParameter("action")%>">
    </form>
</div>
<%} catch (Exception e) {
    e.printStackTrace();
}%>
