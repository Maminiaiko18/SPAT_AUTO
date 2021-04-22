<%@page import="mg.cnaps.utilisateur.CNAPSUser"%>
<%@page import="mg.cnaps.pension.PenPensionsNew"%>
<%@page import="mg.cnaps.accident.Numero"%>
<%@page import="mg.cnaps.accident.AtDsp"%>
<%@page import="mg.cnaps.sig.SigPersonnes"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    CNAPSUser pj = new CNAPSUser();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("code_dr").setLibelle("Code_dr");
    pi.getFormu().getChamp("user_init").setLibelle("User_init");
    pi.getFormu().getChamp("agent_mo").setLibelle("Agent_mo");
    pi.getFormu().getChamp("agent_disponible").setLibelle("Agent_disponible");
    pi.getFormu().getChamp("username").setLibelle("Username");
    pi.getFormu().getChamp("code_service").setLibelle("Code_service");
    pi.getFormu().getChamp("code_dr").setPageAppel(pi.getLien()+"?but=choix/code_drChoix.jsp");
    pi.preparerDataFormu();
    
%>
<div class="content-wrapper">
    <h1>numero</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="CNAPSUser" id="CNAPSUser" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="utilisateur/CNAPSUser-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.cnaps.accident.CNAPSUser">
    <input name="nomtable" type="hidden" id="nomtable" value="cnaps_user">
    </form>
</div>