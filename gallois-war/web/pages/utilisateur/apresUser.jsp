<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="historique.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
        String rep = null;
        String idUser = null;
    %>
    <%
        try {

            acte = request.getParameter("acte");
            lien = (String) session.getAttribute("lien");
            u = (UserEJB) session.getAttribute("u");
            idUser = request.getParameter("refuser");
            System.out.println("idUser=" + idUser);
            String rang = request.getParameter("rang");
            String role = request.getParameter("idrole");
            String descr = request.getParameter("descrole");
            if (acte.compareToIgnoreCase("insert") == 0) {

                MapRoles ic = new MapRoles(descr, role, Integer.valueOf(rang));
                ic.insertToTableWithHisto(u.getUser().getTuppleID());
                rep = u.updateUtilisateurs(idUser, request.getParameter("loginuser"), request.getParameter("pwduser"), request.getParameter("nomuser"), request.getParameter("adruser"), request.getParameter("teluser"), request.getParameter("idrole"));
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/role-ajout.jsp");</script>
    <%
        }
        if (acte.compareTo("update") == 0) {

            rep = u.updateUtilisateurs(idUser, request.getParameter("loginuser"), request.getParameter("pwduser"), request.getParameter("nomuser"), request.getParameter("adruser"), request.getParameter("teluser"), request.getParameter("idrole"));
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/utilisateur-liste.jsp");</script>
    <%
        }
    } catch (Exception e) {%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>");</script>
    <%
            return;
        }
    %>


