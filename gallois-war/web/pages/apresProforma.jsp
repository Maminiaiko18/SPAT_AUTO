<%@page import="facture.FactureProforma"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureClient"%>
<%
try{
    String acte = request.getParameter("acte"),
        bute = request.getParameter("bute"),
        lien = (String) session.getValue("lien");
    UserEJB u = (user.UserEJB) session.getValue("u");
    
    if(acte != null && acte.equalsIgnoreCase("genererFacture")){
        FactureProforma fc = new FactureProforma();
//        fc = fc.proformaToFactureClient(u,null);
        
        %>
            <script language="JavaScript"> 
                document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=fc.getId()%>");
            </script>
        <%
    }
%>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>