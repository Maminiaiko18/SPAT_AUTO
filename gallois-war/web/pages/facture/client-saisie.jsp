<%-- 
    Document   : client-saisie
    Created on : 31 oct. 2022, 10:49:39
    Author     : Jacques
--%>
<%@page import="mg.spat.Client"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%  
    
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Client client = new Client();
    PageInsert pi = new PageInsert(client, request, (user.UserEJB) session.getValue("u"));
    pi.getFormu().getChamp("cdcat").setDefaut("000");
    pi.getFormu().getChamp("cdcat").setAutre("readonly");
    pi.getFormu().getChamp("nomclt").setLibelle("Nom");
    pi.getFormu().getChamp("adrclt").setLibelle("Adresse");
    pi.getFormu().getChamp("nmsttclt").setLibelle("STAT");
    pi.getFormu().getChamp("telclt").setLibelle("Telephone");
    pi.getFormu().getChamp("faxclt").setLibelle("Fax");
    pi.getFormu().getChamp("nmcin").setLibelle("CIN");
    pi.getFormu().getChamp("nif").setLibelle("NIF");
    pi.getFormu().getChamp("rc").setLibelle("RC");
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie client</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="facture/client-liste.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.Client">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>