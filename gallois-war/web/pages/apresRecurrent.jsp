<%@page import="facture.FactureClient"%>
<%
try{
    String acte = request.getParameter("acte"),
        id = request.getParameter("id"),
        typefrequence = request.getParameter("id"),
        nombre = request.getParameter("id"),
        bute = request.getParameter("bute"),
        lien = (String) session.getValue("lien");
    
    if(acte != null && acte.equalsIgnoreCase("recurrent")){
        FactureClient fc = new FactureClient();
            fc.setId(id);
            //fc.recurrent(null, typefrequence, nombre);
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