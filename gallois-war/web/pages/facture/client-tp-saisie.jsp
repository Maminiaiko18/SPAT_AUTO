<%-- 
    Document   : client-tp-saisie
    Created on : 31 oct. 2022, 10:33:17
    Author     : NAEPHA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mg.spat.ClientTP"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    ClientTP clt = new ClientTP();
    clt.setNomTable("client_tp");
    PageInsert pi = new PageInsert(clt, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

//    pi.getFormu().getChamp("cdclt").setLibelle("ID");
//    pi.getFormu().getChamp("cdclt").setAutre("readonly");
//    pi.getFormu().getChamp("cdclt").setPageAppel("choix/listeClientDBspatChoix.jsp","cdclt;cdcltlibelle");
    pi.getFormu().getChamp("dttp").setLibelle("Date");   
    pi.getFormu().getChamp("dttp").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("tp").setLibelle("TP");
    pi.getFormu().getChamp("valide").setVisible(false);
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un bon provisoire</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="facture/client-tp-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.ClientTP">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>