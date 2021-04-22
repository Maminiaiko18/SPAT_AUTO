<%-- 
    Document   : apresChoixMultipleFkt
    Created on : 3 juil. 2016, 12:43:36
    Author     : Ignafah
--%>

<%@ page import="utilitaire.Utilitaire" %>
<%
    String[] choix = request.getParameterValues("choix");
    String strChoix = Utilitaire.tabToString(choix, "", ",");
    String chpRet = request.getParameter("champReturn");    
    String[] chpList = Utilitaire.stringToTab(chpRet, ";");
    String test = chpRet.substring(6, 18);
%>
<html>
    <script language="JavaScript">
    window.opener.document.getElementById("<%=test%>").value = "<%= strChoix %>";
    window.close();
    </script>
</html>
