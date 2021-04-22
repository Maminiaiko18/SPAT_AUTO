
<%@page import="lc.Direction"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Direction  pj = new Direction();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    
    pi.setLien((String) session.getValue("lien"));
    
    

    pi.getFormu().getChamp("libelledir").setLibelle("Nom de la direction/Departement");
    pi.getFormu().getChamp("descdir").setLibelle("Decription");
    pi.getFormu().getChamp("iddirecteur").setLibelle("ID Directeur");
    pi.getFormu().getChamp("abbrevdir").setLibelle("Abreviation");
    pi.getFormu().getChamp("iddirecteur").setPageAppel("choix/directeurChoix.jsp");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Departement/Direction</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="AtDsp" id="AtDsp" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="utilisateur/direction-ajout.jsp">
    <input name="classe" type="hidden" id="classe" value="lc.Direction">
    <input name="nomtable" type="hidden" id="nomtable" value="direction">
    </form>
</div>


