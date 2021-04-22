<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="configuration.*" %>
<%
    int nombreLigne = 2;
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    Directionregionale  pj = new Directionregionale();
    pj.setNomTable("sig_dr");
    PageInsertTableau pi = new PageInsertTableau(pj, request, u, nombreLigne);
    
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("val").setLibelle("Libelle");
    pi.getFormu().getChamp("desce").setLibelle("Decription");
    pi.getFormu().getChamp("dr_abreviation").setLibelle("Abreviation");
    pi.getFormu().getChamp("numero_fixe").setLibelle("Numero fixe");
    pi.getFormu().getChamp("numero_mobile").setLibelle("Numero mobile");
    pi.getFormu().getChamp("dr_sigle").setLibelle("Sigle");
    //pi.getFormu().getChamp("numero_fixe").setPageAppel("test.jsp");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Test</h1>
    <form action="<%=pi.getLien()%>?but=apresTarifTableau.jsp" method="post" name="AtDsp" id="AtDsp" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTableauIndex();
            //System.out.println(pi.getFormu().getHtmlTableauInsert());
            out.println(pi.getFormu().getHtmlTableauInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="testTableau.jsp">
    <input name="classe" type="hidden" id="classe" value="configuration.Directionregionale">
    <input name="nombreLigne" type="hidden" id="nomtable" value="<%=nombreLigne%>">
    </form>
</div>
        

