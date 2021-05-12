<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureClient"%>
<%
try{
    String acte = request.getParameter("acte"),
        id = request.getParameter("id"),
        typefrequence = request.getParameter("typefrequence"),
        nombre = request.getParameter("nombre"),
        bute = request.getParameter("bute"),
        lien = (String) session.getValue("lien");
    UserEJB u = (user.UserEJB) session.getValue("u");
    
    if(acte != null && acte.equalsIgnoreCase("recurrent")){
        FactureClient fc = new FactureClient();
            fc.setId(id);
            fc.recurrent(u, null, typefrequence, Utilitaire.stringToInt(nombre));
        %>
            <script language="JavaScript"> 
                document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=id%>");
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