<%@page import="mg.cnaps.commun.Sig_fokontany"%>
<%@page import="mg.cnaps.commun.Sig_commune"%>
<%@page import="mg.cnaps.sig.SigPersonnes"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Sig_fokontany pj = new Sig_fokontany();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("val").setLibelle("Valeur");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("code_commune").setLibelle("Code commune");
    pi.getFormu().getChamp("code_commune").setPageAppel(pi.getLien()+"?but=choix/code_communeChoix.jsp");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>fokotany</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_fokontany" id="sig_fokontany" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="configuration/sig_fokontany-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.cnaps.commun.Sig_fokontany">
    <input name="nomtable" type="hidden" id="nomtable" value="sig_fokontany">
    </form>
</div>