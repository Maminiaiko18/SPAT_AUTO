<%@page import="user.UserEJBBean"%>
<%@page import="facture.AdminFactureClient"%>
<%@page import="affichage.PageInsert"%>
<%@page import="facture.TransitionPaiementVide"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try {
        String acte = request.getParameter("acte"),
                bute = request.getParameter("bute"),
                lien = (String) session.getValue("lien"),
                id = request.getParameter("id");
        UserEJB u = (user.UserEJB) session.getValue("u");

        if (acte != null && acte.equalsIgnoreCase("payerFC")) {
            TransitionPaiementVide t = new TransitionPaiementVide();
            PageInsert p = new PageInsert(t, request);
            t = (TransitionPaiementVide) p.getObjectAvecValeur();
                
            String[] listeId = Utilitaire.split(request.getParameter("listeId"), ";");
            
            u.payerFCMultiple(listeId, t);
            bute = "facture/factureclient-visa-multiple.jsp";
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