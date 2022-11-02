<%-- 
    Document   : liaison-placement-saisie
    Created on : 22 nov. 2019, 15:17:36
    Author     : Asus
--%>


<%@page import="mg.spat.ClientQuit"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
    String autreparsley = "data-parsley-range='[8, 40]' required";
    ClientQuit cq = new ClientQuit();
    PageInsert pi = new PageInsert(cq, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    //pi.getFormu().getChamp("cdclt").setAutre("readonly");
    //pi.getFormu().getChamp("cdclt").setPageAppel("choix/listeClientDBspatChoix.jsp");
    //pi.getFormu().getChamp("cdclt").setLibelle("Id");
    pi.getFormu().getChamp("dtquit").setLibelle("Date");
    pi.getFormu().getChamp("dtquit").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("quit").setLibelle("Quittance");
    pi.getFormu().getChamp("valide").setVisible(false);
    //pi.getFormu().getChamp("nomclt").setVisible(false);
     pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie client quittance</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="facture/client-quit-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.ClientQuit">
    </form>
</div>
<%} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert("<%=e.getMessage()%>");
            history.back();</script>

<% }%>
