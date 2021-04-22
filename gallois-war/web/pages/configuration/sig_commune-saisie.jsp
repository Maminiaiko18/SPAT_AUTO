<%@page import="mg.cnaps.commun.Sig_commune"%>
<%@page import="mg.cnaps.sig.SigPersonnes"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Sig_commune pj = new Sig_commune();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("val").setLibelle("Valeur");
    pi.getFormu().getChamp("desce").setLibelle("Fokontany");
    pi.getFormu().getChamp("desce").setPageAppel("choix/code_fkt-choix.jsp");
    pi.getFormu().getChamp("code_region").setLibelle("Code region");
    pi.getFormu().getChamp("code_region").setPageAppel("choix/code_regionChoix.jsp");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>commune</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="configuration/sig_commune-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.cnaps.commun.Sig_commune">
    <input name="nomtable" type="hidden" id="nomtable" value="sig_commune">
    </form>
</div>