<%@page import="facture.FactureProforma"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureClient"%>
<%
try{
    String acte = request.getParameter("acte"),
        bute = request.getParameter("bute"),
        lien = (String) session.getValue("lien"),
        id = request.getParameter("id");
    UserEJB u = (user.UserEJB) session.getValue("u");
    
    if(acte != null && acte.equalsIgnoreCase("genererFacture")){
        FactureProforma fact = new FactureProforma();
        fact.setId(id);
        FactureClient fc = fact.proformaToFactureClient(u,null);
        if(fc != null) id = fc.getId();
    }
%>
    <script language="JavaScript"> 
                document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=id%>");
            </script>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>