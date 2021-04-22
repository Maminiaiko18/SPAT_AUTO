
<%@page import="mg.spat.StatistiqueMICTSL"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String idClient=request.getParameter("idClient");
    String lien=(String)session.getValue("lien");
    if(idClient==null || idClient.compareTo("")==0){ %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=capitainerie/statistique-activite/choix-client-normal.jsp");</script> 
    <%}
        
    String autreparsley = "data-parsley-range='[8, 40]' required";
    StatistiqueMICTSL pj = new StatistiqueMICTSL();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
      
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour()); 
    pi.getFormu().getChamp("conteneursPleins").setLibelle("Conteneurs pleins");
    pi.getFormu().getChamp("conteneursVides").setLibelle("Conteneurs vides");
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
    
    
%>
<div class="content-wrapper">
    <h1>Saisie d'une statistique pour MICTSL</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="idClient" type="hidden" id="idClient" value="<%=idClient%>">
    <input name="acte" type="hidden" id="nature" value="insertStatistiqueMICTSL">
    <input name="bute" type="hidden" id="bute" value="capitainerie/statistique-activite/statistique-activite-liste.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.StatistiqueMICTSL">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>