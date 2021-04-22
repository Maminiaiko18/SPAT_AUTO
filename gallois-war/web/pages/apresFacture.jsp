<%-- 
    Document   : apresFacture
    Created on : 15 janv. 2021, 11:38:49
    Author     : Tsiory
--%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="affichage.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <%!
        UserEJB u = null;
        String idfacture="";
        String lien=null;
        String apresLien=null;
    %>
     <%
        try {
            idfacture=(String) request.getParameter("id");
            u = (UserEJB) session.getAttribute("u");
             lien = (String) session.getValue("lien");
           apresLien=u.checkPageSelonUtilisateur(idfacture, null);
              
    %>
              <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%= apresLien%>");</script>
 <%

    } catch (Exception e) {
        e.printStackTrace();
    %>

    <script language="JavaScript"> alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
        history.back();</script>
        <%
                return;
            }
        %>
</html>
