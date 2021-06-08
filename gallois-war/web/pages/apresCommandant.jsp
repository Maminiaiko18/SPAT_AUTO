<%@page import="utilitaire.Utilitaire"%>
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
        
        String redirect = lien + "?but=capitainerie/occupationMaterielNaval-saisie.jsp&estCommandant=1&idEscale="+request.getParameter("idEscale");
        
        if (acte != null && acte.compareToIgnoreCase("debut") == 0) {
            redirect += "&date_debut=" + Utilitaire.dateDuJour();
            redirect += "&heure_debut=" + Utilitaire.heureCouranteHMS();
%>
<script language="JavaScript"> document.location.replace("<%=redirect%>");</script>
<% }
    if (acte != null && acte.compareToIgnoreCase("fin") == 0) {
        redirect += "&date_fin=" + Utilitaire.dateDuJour();
        redirect += "&heure_fin=" + Utilitaire.heureCouranteHMS();
%>
<script language="JavaScript"> document.location.replace("<%=redirect%>");</script>
<% }
} catch (Exception exc) {
    exc.printStackTrace(); %>
<script>
    alert("<%=exc.getMessage()%>");
    history.back();
</script>
<% return;
    }%>
