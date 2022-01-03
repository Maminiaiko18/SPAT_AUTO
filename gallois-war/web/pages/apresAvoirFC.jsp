<%@page import="facture.FactureClient"%>
<%@page import="avoir.AvoirFC"%>
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
//    bute = request.getParameter("bute");
    bute = "facture/factureclient-modif.jsp"; 
    id = request.getParameter("id");
    
    if (acte.compareToIgnoreCase("insertFactRempl") == 0) {
        AvoirFC avoir = new AvoirFC();
        avoir = (AvoirFC)avoir.getById(id, "AvoirFC", null);
        FactureClient factureClient = avoir.creerFactureRempl(null, String.valueOf(u.getUser().getRefuser()));
//        Avoir avoir = new Avoir();
//        avoir.setId(id);
//        avoir = avoir.payer(u.getUser().getTuppleID(), null);
        %>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=factureClient.getId()%>");</script>
    <%}
} catch(Exception exc){
    exc.printStackTrace();%>
    <script>
        alert("<%=exc.getMessage()%>");
        history.back();
    </script>
<% return; }%>
    