<%@page import="mg.cnaps.commun.Sig_region"%>
<%@page import="mg.cnaps.commun.Sig_commune"%>
<%@page import="mg.cnaps.sig.SigPersonnes"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Sig_region pj = new Sig_region();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("val").setLibelle("Valeur");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("code_faritany").setLibelle("Code faritany");
    pi.getFormu().getChamp("code_faritany").setPageAppel(pi.getLien()+"?but=choix/code_faritanyChoix.jsp");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>region</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_region" id="sig_region" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="configuration/sig_region-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.cnaps.commun.Sig_region">
    <input name="nomtable" type="hidden" id="nomtable" value="sig_region">
    </form>
</div>