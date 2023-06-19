

<%@ page import="mg.spat.*" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    AdditifJc a = new AdditifJc();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setTitre("Saisie additif");
    pi.setLien((String) session.getValue("lien"));
    if(request.getParameter("idjc")!=null) pi.getFormu().getChamp("idjc").setDefaut(request.getParameter("idjc"));

    //Modification des affichages
    pi.getFormu().getChamp("idjc").setAutre("readonly");
    pi.getFormu().getChamp("idjc").setLibelle("Journal");
    pi.getFormu().getChamp("etat").setVisible(false);

    //Variables de navigation
    String classe = "mg.spat.AdditifJc";
    String nomTable = "AdditifJc";
    //Generer les affichages
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center"><%=pi.getTitre()%></h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
        <%
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="treso/additifjc-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
} %>

