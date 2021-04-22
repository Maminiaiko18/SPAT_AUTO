
<%@page import="mg.spat.PrevisionStatistiqueActivite"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    PrevisionStatistiqueActivite pj = new PrevisionStatistiqueActivite();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    if(request.getParameter("cli")!=null){
        pi.getFormu().getChamp("idclient").setDefaut(request.getParameter("cli"));
    }
    pi.getFormu().getChamp("idclient").setAutre("readonly");
    pi.getFormu().getChamp("idclient").setPageAppel("choix/listeClientCategorieChoix.jsp");
    pi.getFormu().getChamp("daty").setAutre("Date");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());  
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'une prévision statistique activité</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="capitainerie/statistique-activite/prevision-statistique-activite-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.PrevisionStatistiqueActivite">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>