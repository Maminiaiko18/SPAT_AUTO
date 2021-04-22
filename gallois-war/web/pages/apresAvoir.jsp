<%@page import="avoir.Avoir"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html; charset=iso-8859-1" pageEncoding="iso-8859-1"%>
<%!
        UserEJB u = null;
        String acte = null;
        String bute;
        String lien;
        String id;
%>
<%
try {
    lien = (String) session.getValue("lien");
    u = (UserEJB) session.getAttribute("u");
    acte = request.getParameter("acte");
    bute = request.getParameter("bute");
    id = request.getParameter("id");
    
    if (acte.compareToIgnoreCase("payer") == 0) {
        Avoir avoir = new Avoir();
        avoir.setId(id);
        avoir = avoir.payer(u.getUser().getTuppleID(), null);%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=avoir.getId()%>");</script>
    <%}
} catch(Exception exc){
    exc.printStackTrace();%>
    <script>
        alert("<%=exc.getMessage()%>");
        history.back();
    </script>
<% return; }%>
    