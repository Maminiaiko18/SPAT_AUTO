<%@page import="facture.FactureClient"%>
<%@page import="mg.spat.exploitant.AdminActivite"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try {
        String acte = request.getParameter("acte"),
                bute = request.getParameter("bute"),
                lien = (String) session.getValue("lien"),
                id = request.getParameter("id");
        UserEJB u = (user.UserEJB) session.getValue("u");

        if (acte != null && acte.equalsIgnoreCase("factureractivite")) {
            AdminActivite act = new AdminActivite();
            act.findactivite(request.getParameter("client"), request.getParameter("categorie"), Utilitaire.stringToInt(request.getParameter("mois")), Utilitaire.stringToInt(request.getParameter("annee")), request.getParameter("redevance"));
            FactureClient fc = act.facturer(u.getUser().getTuppleID());
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