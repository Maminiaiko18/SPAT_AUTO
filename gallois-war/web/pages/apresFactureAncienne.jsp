<%@page import="facture.FactureMereAncienne"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try {
        String acte = request.getParameter("acte");
        String bute = request.getParameter("bute");
        String lien = (String) session.getValue("lien");
        String[] tabId = request.getParameterValues("id");
        UserEJB u = (user.UserEJB) session.getValue("u");
        String refUser = u.getUser().getRefuser()+"";
        if (acte.equals("integrer")) {
            FactureMereAncienne.genererFactureMultiple(null, Utilitaire.tabToString(tabId, "", ";"), refUser);
            bute = "facture/factureclient-liste-vaovao.jsp";
        }
%>
<script language="JavaScript">
    document.location.replace("<%=lien%>?but=<%=bute%>");
</script>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>