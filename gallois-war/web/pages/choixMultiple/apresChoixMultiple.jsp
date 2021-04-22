<%@ page import="utilitaire.Utilitaire" %>
<%
    String[] choix = request.getParameterValues("choix");
    if(choix==null||choix.length==0)throw new Exception("Veillez cocher au moins un elements");
    String id = "";
    String libelle = "";
    for (int i = 0; i < choix.length; i++) {
        String[] temp = choix[i].split(";");
        id += temp[0] + ";";
        libelle += temp[1] + ";";
    }
    String champRet = (String) request.getParameter("champReturn");
    String[] champs = Utilitaire.split(champRet, ";");
    //String strChoix = Utilitaire.tabToString(choix, "", ",");
%>
<html>
    <script language="JavaScript">

        window.opener.document.all.<%=champs[0]%>.value = "<%=id%>";
        window.opener.document.all.<%=champs[1]%>.value = "<%=libelle%>";

        //window.opener.document.all.request.getParameter("champReturn")%>.value = "strChoix %>";
        //window.opener.document.all.<request.getParameter("champReturn")%>.value = "<strChoix %>";
        window.close();
    </script>
</html>