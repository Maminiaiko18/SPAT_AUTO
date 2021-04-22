<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="configuration.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    Directionregionale  pj = new Directionregionale();
    pj.setNomTable("sig_dr");
    PageInsert pi = new PageInsert(pj, request, u);
    
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("val").setLibelle("Libelle");
    pi.getFormu().getChamp("desce").setLibelle("Decription");
    pi.getFormu().getChamp("dr_abreviation").setLibelle("Abreviation");
    pi.getFormu().getChamp("numero_fixe").setLibelle("Numero fixe");
    pi.getFormu().getChamp("numero_mobile").setLibelle("Numero mobile");
    pi.getFormu().getChamp("dr_sigle").setLibelle("Sigle");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Direction Regionale</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="AtDsp" id="AtDsp" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="configuration/directionregionale-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="configuration.Directionregionale">
    <input name="nomtable" type="hidden" id="nomtable" value="sig_dr">
    </form>
</div>
        

