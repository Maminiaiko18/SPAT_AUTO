<%@page import="mg.spat.Engagement"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try {
        String acte = request.getParameter("acte");
        String bute = request.getParameter("bute");
        String lien = (String) session.getValue("lien");
        String  idmere = request.getParameter("idmere");
        String[] tabId = request.getParameterValues("id");
        UserEJB u = (user.UserEJB) session.getValue("u");
        String refUser = u.getUser().getRefuser()+"";
        if (acte.equals("paiementFille")) {
            Engagement eng = new Engagement();
            eng.setId(idmere);
            eng.payerEngagementFille(Utilitaire.tabToString(tabId, "", ";"), refUser, null);
            bute = "depense/engagement-fiche.jsp&id="+idmere;
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